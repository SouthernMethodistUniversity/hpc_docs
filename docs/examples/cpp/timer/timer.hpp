/**
 * @file timer.hpp
 * @brief A simple timer class
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

// This is a header file, so we want to enure if only gets
// included once in the code so we don't end up with multiple
// redefinitions of the same functions in a project.
// On way to do this is to define a uniquely named variable
// using the prepocessor. Here, we name a variable "_Timer_H_"
// if that variable is already defined, then nothing happens.
// Otherwise, we define it and the code defining the class is
// used.
#ifndef _Timer_H_
#define _Timer_H_

#include <chrono> // We need a clock for timing
#include <mutex>  // We want to try to enforce some thread safety
#include <string> // STL strings for printing and timer names
#include <thread> // For STL threads, we'll attempt to match timers
#include <vector> // STL vectors for arays

//  NOTE: We will use "steady_clock." Based on the names of the
//        clocks available in std::chrono, it might seem like a good idea
//        to use high_resolution_clock. Afterall, we'd want our timer
//        to be as accurate as possible. However, high_resolution_clock
//        is system dependent and may either be the same as steady_clock,
//        system_clock, or something else entireley. We want our clock
//        to be monotonic, which means time cannot go backwards, and
//        steady_clock guarantees this. (system_clocks can go "backwards"
//        because the time can be updated outside of our code, e.g. if the
//        system syncs time with an NTP server.)

// Since it's likely other libraries may have a timer function of
// class, we'll define all of our functions in a namespace. This
// is a way C++ provides to limit the scope where things are defined
// so we can avoid naming conflicts functions, variables, classess,
// etc. that may be defined by other sources. Here we just call this
// namespace "Timer" because it's an apt description; however, one
// might want to use more unique names related to your project name.
namespace Timer
{

    // Define the Timer class
    class Timer
    {

        // In classes, you can control where functions and variables
        // can be accessed. Public functions can be accessed outside
        // of the class, in particular, you can call these functions
        // if you have an object of this class type.
        //
        // Some functions always need to be public:
        //
        // - contructors: These are the functions that create an instance
        //                of this class. They are the functions that share
        //                the name of the class ("Timer" in this case.)
        //
        // - destructor: This is the function that defines how to delete an
        //               object of this class type. Always the class name
        //               with a tilde in front of it ("~Timer" in this case.)
        //
        // - copy and move constructors:
        //
        // Note, some or all of these operators may not need to be defined
        // because the default operator created will work as expected. In
        // general, if you define one of the following, you probably need
        // to define all of them (Rule of three):
        //
        // - destructor (~Timer)
        // - copy constructor (Timer(const Timer& other_timer))
        // - copy assignment constructor (Timer& operator=(const Timer& other_timer))
        //
        // It is often additionally a good idea / necessary to define the move operators (if needed)
        // (Rule of five)
        //
        // - move constructor (Timer(Timer&& other_timer))
        // - move assignment (Timer& operator=(Timer&& other_timer))
    public:
        /**
         * @brief Construct a new Timer object
         *
         * @param start If start is true, start the timer on creating
         */
        Timer(const bool &start = true);

        /**
         * @brief Construct a new Timer object
         *
         * @param name Provide a name for the timer, if provided this will look for an
         * existing timer of that name
         * @param start If start is true, start the timer on creating
         */
        Timer(const std::string &name, const bool &start = true);

        /**
         * @brief Construct a new Timer object
         *
         * @param name Provide a name for the timer, if provided this will look for an
         * existing timer of that name
         * @param start If start is true, start the timer on creating
         */
        Timer(const char *name, const bool &start = true);

        /**
         * @brief Destroy the Timer object
         *
         * NOTE: this should almost always be a virtual function.
         * This means another class, which inherits this class may
         * redefine the behavior of this function.
         *
         * NOTE: We are not using this to manage dynamically allocated
         *       memory. Only to stop any timer that may be running.
         *       In this case, it is not necessary to implement
         */
        virtual ~Timer();

        /**
         * @brief Start the timer
         *
         * @return std::chrono::time_point<std::chrono::steady_clock>
         *
         */
        std::chrono::time_point<std::chrono::steady_clock> start();

        /**
         * @brief Stop the timer
         *
         * @return std::chrono::time_point<std::chrono::steady_clock>
         */
        std::chrono::time_point<std::chrono::steady_clock> stop();

        /**
         * @brief Get the time recorded so far for this timer
         *
         * @return double
         * 
         * const because this function does not change values in class
         */
        double getCurrentTime() const;

        /**
         * @brief Get the accumulated time across all instances of timers with the
         * same name as this timer
         *
         * @return double
         *
         * const because this function does not change values in class
         */
        double getAccumulatedTime() const;

        /**
         * @brief Get the number of calls so far for this timer
         *
         * @return std::size_t
         *
         * const because this function does not change values in class
         */
        std::size_t getCurrentCallCount() const;

        /**
         * @brief Get the accumulated number of calls across all instances of timers
         * with the same name as this timer
         *
         * @return std::size_t
         *
         * const because this function does not change values in class
         */
        std::size_t getAccumulatedCallCount() const;

        /**
         * @brief Print out info about all of the timers
         *
         */
        void printStats();

        /**
         * @brief Print out all the static variables for debugging
         * 
         */
        void printDebugVariables();

    private:
        // In classes, you can control where functions and variables
        // can be accessed. Private functions and variables can be accessed
        // only from other functions that are also members of the class.

        // NOTE: it is a matter of style preference, but it is common
        // to prefix variable names in classes with "m_" to indicate
        // that they are a member variable.

        // These are all static variables. That means that these
        // variables are the same and shared by all instances of this
        // class.
        static std::vector<std::string> m_timer_names;
        static std::vector<double> m_accumulated_times;
        static std::vector<std::size_t> m_accumulated_call_counts;
        static std::vector<bool> m_running_timers;
        static std::vector<std::size_t> m_levels;
        static std::vector<std::size_t> m_parent_ids;
        static std::vector<std::thread::id> m_thread_ids;

        // The remaining variables below are NOT static, so
        // each instance of this class has it's own copy of
        // these variables.

        // We'll use a mutex to try to prevent some race conditions with threads
        std::mutex m_mutex;

        // To act as a timer, we'll need a start and stop timer
        std::chrono::time_point<std::chrono::steady_clock> m_start_time;
        std::chrono::time_point<std::chrono::steady_clock> m_stop_time;

        std::string m_name;
        double m_total_time = 0.0;
        std::size_t m_call_count = 0;
        int m_index = -1;
        std::vector<std::size_t> m_indexes;
        std::size_t m_level;
        bool m_is_running = false;
        std::vector<std::size_t> m_timers_running_at_start;
        std::size_t m_parent_id = 0;
        std::thread::id m_thread_id;

    private:
        /**
         * @brief Attempt to find the level of nesting for current timer based on which
         * timers are currently running and when they started
         *
         * @return std::size_t
         */
        std::size_t findLevel();

        /**
         * @brief Attempt to find the parent ID of the current timer based on which
         * timers are currently running and when they started
         *
         * @return std::size_t
         */
        std::size_t findParentID();

        /**
         * @brief Find the index(es) of the timer if the name already exists
         *
         * @return std::vector<std::size_t>
         */
        std::vector<std::size_t> findNameIndexes();

        /**
         * @brief Find the index(es) of the timer if the name already exists with the
         * given name
         *
         * @return std::vector<std::size_t>
         */
        std::vector<std::size_t> findNameIndexes(const std::string &name);

        /**
         * @brief find the currently running timers
         *
         */
        void findRunningTimers(std::vector<std::size_t> &running_timers);
    };

} // namespace Timer

#endif // Timer_H_