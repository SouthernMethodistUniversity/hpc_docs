/**
 * @file timer.cpp
 * @brief Implements a simple timer class
 * 
 * This file contains all of the function implentations.
 *
 * This creates a simple timer class.
 * It allows starting multiple named timers that can be accessed
 * individually and/or the collective stats from all of the timers
 * can be printed.
 *
 * In addition to manually starting and stopping a timer,
 * this also takes advantage of the fact that C++ classes call
 * a destructor when they go out of scope to automatically stop
 * any active timer.
 */

// include our class definitions
#include "timer.hpp"

#include <algorithm>
#include <iomanip>
#include <iostream>

// Enter the Timer namespace we created
namespace Timer
{

    // init static variables
    // This needs to happen only once.
    std::vector<std::string> Timer::m_timer_names;
    std::vector<double> Timer::m_accumulated_times;
    std::vector<std::size_t> Timer::m_accumulated_call_counts;
    std::vector<bool> Timer::m_running_timers;
    std::vector<std::size_t> Timer::m_parent_level;
    std::vector<std::size_t> Timer::m_parent_ids;
    std::vector<std::thread::id> Timer::m_thread_ids;

    // Implement the contructor that may have default arguments.
    // Note that start=True from the header if it is not provided.
    // This just calls the contructor of the form 
    //   Timer(const std::string &name, const bool &start)
    // with by naming the timer "Unnamed Timer"
    Timer::Timer(const bool &start) : Timer(std::string("Unnamed Timer"), start) {}

    // Implement the constructor. This is the constructor we will use to 
    // initalize everything and other versions of the constructor will 
    // use this with some default values 
    Timer::Timer(const std::string &name, const bool &start)
    {
        // Set the name of this timer to the constructor input
        m_name = name;

        // Try to find the index(es) of this timer if it already exists
        // if it doesn't, we'll add a new entry below.
        // We're checking existance based on the timer names
        m_indexes = findNameIndexes(name);

        // set the level of this timer to 0 by default until we
        // know otherwise.
        // Level 0 means there are no other timers running at a higher level
        // Level 1 means this timers is nested inside 1 other timer.
        // Level 2 means that this timer is nested insides a timer and that
        //         timer is also nested inside a timer.
        // etc.
        m_level = 0;

        // get the thread id for the current thread.
        // We'll use this to try to avoid some race conditions
        // and check for uniqueness
        m_thread_id = std::this_thread::get_id();

        // make sure entries exist
        // If we didn't find any existing candidates for this timer
        // we'll add it
        if (m_indexes.size() == 0)
        {
            // create a mutex lock to make sure no other threads
            // can change the shared static variables at the same 
            // time, which might result in corrupt data
            std::unique_lock<std::mutex> lock(m_mutex);

            // set the index of this timer to the next entry in the vectors
            m_index = m_timer_names.size();

            // add the name of this timer
            m_timer_names.push_back(m_name);

            // add the total accumulated time (m_total_time = 0, from header)
            m_accumulated_times.push_back(m_total_time);

            // add the total accumated call count (m_call_count = 0 from header)
            m_accumulated_call_counts.push_back(m_call_count);

            // set whether or not this timer is running (m_is_running = false from header)
            m_running_timers.push_back(m_is_running);

            // set the current level. Will be zero until we check later
            m_parent_level.push_back(m_level);

            // set the parent id. Will be zero until we check later
            m_parent_ids.push_back(m_parent_id);

            // set the thread id
            m_thread_ids.push_back(m_thread_id);
        }

        // if requested. Start the timer
        if (start)
        {
            this->start();
        }
    }

    // Implement the constructor. Just converts a char* name
    // to a string and uses the above constructor 
    Timer::Timer(const char *name, const bool &start)
        : Timer(std::string(name), start) {}

    // Implement the destructor. 
    // NOTE: there is no memory management
    Timer::~Timer()
    {
        // If the timer is running, stop it.
        // Otherwise do nothing
        if (m_is_running)
        {
            stop();
        }
    }

    /**
     * @brief Start the timer
     * 
     * Implements the function that starts the timer
     *
     * @return std::chrono::time_point<std::chrono::steady_clock>
     */
    std::chrono::time_point<std::chrono::steady_clock> Timer::start()
    {
        // Check to see if this timer is running. We shouldn't start
        // and already running timer.
        //
        // NOTE: you may want different behavior here. For instance,
        // maybe a lap functionality
        if (!m_is_running)
        {
            // get the current time and say the timer is started
            m_start_time = std::chrono::steady_clock::now();
            m_is_running = true;

            // Find any other timers that are currently running
            // We'll use these to ID parents and levels of nesting
            findRunningTimers(m_timers_running_at_start);

            // Make sure we have an index for this timer. If not, add one.
            // NOTE: the constructor will either have done this already OR
            // it will have provided a list of potential candidates for this
            // timer, but didn't check to see if any were correct
            if (m_index < 0)
            {
                std::unique_lock<std::mutex> lock(m_mutex);

                // loop over the candidate timers that may be this timer.
                // These timers have the correct name, but may not be the
                // timer we want
                for (const auto &i : m_indexes)
                {
                    // i is the index of the candidate timer.
                    // Check to see if the parent of the candidate timer 
                    // is running currently running. If it is, accept
                    // that the candidate timer is the same as the current
                    // timer. If not continue looking (if a parent timer isn't
                    // running this can't be the same timer).
                    //
                    // FIXME: Make this check more robust? If multiple timers
                    // are named the same, this could result in incorrect 
                    // results because there may be multiple valid and nested
                    // timers. If that's the case, it's not clear how to make
                    // a better choice. (More unique timer names would help,
                    // but functions could be called at different places in the
                    // code leading to multiple nesting scenarios)
                    if (m_running_timers[m_parent_ids[i]])
                    {
                        m_index = i;
                        break;
                    }
                }

                // If we didn't find an acceptable timer in the list of candidates,
                // add a new timer
                // TODO: should this be a function -- it is used here and in the constructor
                if (m_index < 0)
                {
                    m_index = m_timer_names.size();
                    m_timer_names.push_back(m_name);
                    m_accumulated_times.push_back(m_total_time);
                    m_accumulated_call_counts.push_back(m_call_count);
                    m_running_timers.push_back(m_is_running);
                    m_parent_level.push_back(m_level);
                    m_parent_ids.push_back(m_parent_id);
                    m_thread_ids.push_back(m_thread_id);
                }
            }

            // set this timer as on of the currently running timers.
            {
                std::unique_lock<std::mutex> lock(m_mutex);
                m_running_timers[m_index] = m_is_running;
            }
            findRunningTimers(m_timers_running_at_start);
        }

        return m_start_time;
    }

    /**
     * @brief Stop the timer
     *
     * @return std::chrono::time_point<std::chrono::steady_clock>
     */
    std::chrono::time_point<std::chrono::steady_clock> Timer::stop()
    {

        // Check to see if the timer is running. There's no need to 
        // stop an already stopped timer
        if (m_is_running)
        {
            // get the current time so we can calculate the time
            // elapsed from startign
            m_stop_time = std::chrono::steady_clock::now();

            // set that this timer is not running
            m_is_running = false;
            {
                std::unique_lock<std::mutex> lock(m_mutex);
                m_running_timers[m_index] = m_is_running;
            }

            // if this is the first time the counter has been
            // stopped, try to identify some properties.
            if (m_call_count == 0)
            {
                // Figure out how many levels this timer
                // is nested inside other timers
                m_level = findParentLevel();

                // Find the timer that this timer is nested
                // inside of (if it exists)
                m_parent_id = findParentID();

                // save the results to the shared static variables
                {
                    std::unique_lock<std::mutex> lock(m_mutex);
                    m_parent_level[m_index] = m_level;
                    m_parent_ids[m_index] = m_parent_id;
                }
            }

            // increment the number of calls to this timer
            m_call_count++;
            {
                std::unique_lock<std::mutex> lock(m_mutex);
                m_accumulated_call_counts[m_index]++;
            }

            // compute the time between start and stop
            std::chrono::duration<double> time_diff = m_stop_time - m_start_time;

            // increment the total time for this timer
            // .count() gives the number of clock "ticks"
            // We'll compute the time in more useful units later.
            m_total_time += time_diff.count();
            {
                std::unique_lock<std::mutex> lock(m_mutex);
                m_accumulated_times[m_index] += time_diff.count();
            }
        }

        return m_stop_time;
    }

    /**
     * @brief Get the time recorded so far for this timer
     *
     * @return double
     */
    double Timer::getCurrentTime() const { return m_total_time; }

    /**
     * @brief Get the accumulated time across all instances of timers with the same
     * name as this timer
     *
     * @return double
     */
    double Timer::getAccumulatedTime() const { return m_accumulated_times[m_index]; }

    /**
     * @brief Get the number of calls so far for this timer
     *
     * @return std::size_t
     */
    std::size_t Timer::getCurrentCallCount() const { return m_call_count; }

    /**
     * @brief Get the accumulated number of calls across all instances of timers
     * with the same name as this timer
     *
     * @return std::size_t
     */
    std::size_t Timer::getAccumulatedCallCount() const
    {
        return m_accumulated_call_counts[m_index];
    };

    /**
     * @brief Print out info about all of the timers
     * 
     * NOTE: This uses standard IO routines. It would be much
     * cleaner to use an IO library like fmt
     *
     */
    void Timer::printStats()
    {

        // make sure nothing modifies shared static variables while
        // we're using them
        std::unique_lock<std::mutex> lock(m_mutex);

        // figure out the longest name, time, and nesting level.
        // We need these to pad output to get things to line up nicely.
        std::size_t max_name_length = 0;
        std::size_t max_level = 0;
        double max_time = 0;
        for (std::size_t i = 0; i < m_timer_names.size(); ++i)
        {
            max_name_length = (max_name_length > m_timer_names[i].length())
                                  ? max_name_length
                                  : m_timer_names[i].length();
            max_level = (max_level > m_parent_level[i]) ? max_level : m_parent_level[i];
            max_time =
                (max_time > m_accumulated_times[i]) ? max_time : m_accumulated_times[i];
        }

        // print a header
        // setw sets the number of characters that should be used printed
        // std::left sets the alignment to left
        // std::right sets the alignment to right
        // std::endl makes a new line
        //
        // This prints headers for the following columns:
        //
        // "Timer Name" (aligned left, using max_name_length + 3 * max_level + 4 chars)
        // "Elapsed Time" (aligned right, using 16 chars)
        // "Total Percent" (aligned right, using 16 chars)
        // "Parent Percent" (aligned right, using 16 chars)
        // "Call Count" (aligned right, using 16 chars)
        std::cout << std::endl
                  << std::left << std::setw(max_name_length + 3 * max_level + 4)
                  << "Timer Name" << std::right << std::setw(16) << "Elapsed Time"
                  << std::setw(16) << "Total Percent" << std::setw(16)
                  << "Parent Percent" << std::setw(16) << "Call Count" << std::endl;

        // print "=" to underline entire header
        for (std::size_t i = 0; i < max_name_length + 3 * max_level + 68; ++i)
        {
            std::cout << "=";
        }
        std::cout << std::endl;

        // sort and get unique thread ids
        // TODO: explain what this does better
        auto tmp_ids = m_thread_ids;
        std::sort(tmp_ids.begin(), tmp_ids.end());
        auto last = std::unique(tmp_ids.begin(), tmp_ids.end());
        // v now holds {1 2 3 4 5 x x}, where 'x' is indeterminate
        tmp_ids.erase(last, tmp_ids.end());

        // loop over thread ids
        for (const auto &thread : tmp_ids)
        {
            // loop over the Timers
            for (std::size_t i = 0; i < m_timer_names.size(); ++i)
            {
                // skip timers not on the current thread
                if (m_thread_ids[i] != thread)
                {
                    continue;
                }

                // prepend "|--" to the current line to indicate
                // nesting level so we can display like
                // timer1
                // |--timer2
                // |--|--timer3
                // etc.
                for (int j = 0; j < m_parent_level[i]; ++j)
                {
                    std::cout << "|--";
                }

                int p_id = i;
                if (m_parent_level[i] > 0)
                {
                    while (m_parent_level[p_id] >= m_parent_level[i] ||
                           m_thread_ids[p_id] != m_thread_id)
                    {
                        p_id--;
                    }
                }

                // Print the timer name, accumulated time, and percentage
                // std::fixed + std::setprecision controlls how many decimal places to print
                std::cout << std::left
                          << std::setw(max_name_length +
                                       3 * (max_level - m_parent_level[i]) + 4)
                          << m_timer_names[i] << std::right << std::setw(16) << std::fixed
                          << std::setprecision(3) << m_accumulated_times[i]
                          << std::setw(14) << m_accumulated_times[i] / max_time * 100
                          << " %";
                if (m_parent_level[i] > 0)
                {
                    // if this timer is nested also print the percentage relative to 
                    // its parent timer
                    std::cout << std::setw(14) << std::fixed << std::setprecision(3)
                              << m_accumulated_times[i] / m_accumulated_times[p_id] * 100
                              << " %";
                }
                else
                {
                    // if this timer isn't nested print ---- to indicate this measurement
                    // isn't valid (percentage of parent time)
                    std::cout << std::setw(16) << "----";
                }

                // print call counts
                std::cout << std::setw(16) << m_accumulated_call_counts[i];

                std::cout << " " << p_id << " " << m_parent_id;

                // end line
                std::cout << std::endl;
            }
        }

        // print "=" to underline entire table
        for (std::size_t i = 0; i < max_name_length + 3 * max_level + 68; ++i)
        {
            std::cout << "=";
        }

        // skip a line
        std::cout << std::endl
                  << std::endl;
    }

    /**
     * @brief Attempt to find the parent of the current timer based on which
     * timers are currently running and when they started
     *
     * @return std::size_t
     */
    std::size_t Timer::findParentLevel()
    {  
        // get the timers that are currently running
        std::size_t level = 0;
        std::vector<std::size_t> running_timers;
        findRunningTimers(running_timers);

        // make sure nothing modifies shared static variables while
        // we're using them
        std::unique_lock<std::mutex> lock(m_mutex);

        // add the timers that where running at start to the 
        // list of currently running timers
        for (const auto &timer_id : m_timers_running_at_start)
        {
            running_timers.push_back(timer_id);
        }

        // count duplicates. The timer is nested if the same timer was running before
        // this one and was still running afterwards. This does not account for edge
        // cases where a timer may be on in both those cases, but was turned off
        // somewhere in the middle.
        std::sort(running_timers.begin(), running_timers.end());

        // Since the vector of timers is sorted, if successive
        // entries are the same, then the timer is runnning and 
        // was also running at start, so increment the nested level
        for (std::size_t i = 1; i < running_timers.size(); ++i)
        {
            if (running_timers[i - 1] == running_timers[i])
            {
                level++;
            }
        }
        return level;
    }

    /**
     * @brief Attempt to find the parent ID of the current timer based on which
     * timers are currently running and when they started
     *
     * @return std::size_t
     */
    std::size_t Timer::findParentID()
    {
        std::size_t id = 0;
        std::vector<std::size_t> running_timers;
        findRunningTimers(running_timers);

        // make sure nothing modifies shared static variables while
        // we're using them
        std::unique_lock<std::mutex> lock(m_mutex);

        for (const auto &timer_id : m_timers_running_at_start)
        {
            running_timers.push_back(timer_id);
        }

        // count duplicates. The timer is nested if the same timer was running before
        // this one and was still running afterwards. This does not account for edge
        // cases where a timer may be on in both those cases, but was turned off
        // somewhere in the middle.
        std::sort(running_timers.begin(), running_timers.end());

        for (std::size_t i = 1; i < running_timers.size(); ++i)
        {
            if (running_timers[i - 1] == running_timers[i] &&
                m_parent_level[running_timers[i]] < m_level)
            {
                id = running_timers[i];
            }
        }
        return id;
    }

    // helper function to call findNameIndexes with the current
    // timer's name
    std::vector<std::size_t> Timer::findNameIndexes()
    {
        return findNameIndexes(m_name);
    }

    /**
     * @brief Find the index(es) of the timer if the name already exists
     *
     * @return std::vector<std::size_t>
     */
    std::vector<std::size_t> Timer::findNameIndexes(const std::string &name)
    {
        // make sure nothing modifies shared static variables while
        // we're using them
        std::unique_lock<std::mutex> lock(m_mutex);

        // get all the timer ids that match the given name
        std::vector<std::size_t> return_vals;
        for (std::size_t i = 0; i < m_timer_names.size(); ++i)
        {
            if (m_timer_names[i] == name)
            {
                return_vals.push_back(i);
            }
        }

        // return the size of the name vector if we didn't find a name
        return return_vals;
    }

    /**
     * @brief find the currently running timers
     *
     */
    void Timer::findRunningTimers(std::vector<std::size_t> &running_timers)
    {
        // make sure nothing modifies shared static variables while
        // we're using them
        std::unique_lock<std::mutex> lock(m_mutex);
        running_timers.clear();
        for (std::size_t i = 0; i < m_running_timers.size(); ++i)
        {
            if (m_running_timers[i] && (m_thread_id == m_thread_ids[i]))
            {
                running_timers.push_back(i);
            }
        }
    }
} // namespace Timer