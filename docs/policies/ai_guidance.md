# AI Policies and Guidance

Users must comply with all applicable laws, regulations, and SMU policies
when using high performance computing (HPC) resources. This includes, but is not limited to:

- [SMU’s Acceptable Use](https://www.smu.edu/policy/8-information-technology/8-1-acceptable-use)
- [SMU's Information Security](https://www.smu.edu/policy/8-information-technology/8-2-information-security)
- [SMU's Institutional Data Governance](https://www.smu.edu/policy/8-information-technology/8-6-institutional-data-governance)
- [SMU's AI Guidance](https://www.smu.edu/oit/ai)

## Guidance

Using AI and related tools on HPC systems comes with additional challenges related to infrastructure, resource management, and security.
These differences are not necessarily good or bad, but represent a shift in usage paradigms that
do not always align or behave well with the way HPC systems have traditionally been designed.
The following guidance is meant to mitigate many of these challenges while still allowing research to continue.

### Whenever possible, limit file operations, scanning, and searches to only necessary locations

The storage on the HPC systems is shared by all users and is only capable of a finite number of
operations at a time. This means that a small group of tasks or users doing a lot of file operations
at once can negatively impact the performance for all users on the system.

AI tools, including popular code editors like VS Code and Cursor, read files differently than humans.
AI tools commonly

- Read files in chunks. This can result in AI tools doing many sets of file operations (e.g. check permissions, open file, close file, etc.) to read the entire contents of a file.
More traditional HPC usage or human review would typically see only one set of file operations (e.g. the entire file is read at once.) Every file operation adds load to the storage systems.
- Conduct filesystem and metadata intense searches. AI utilize recursive searches to find files, libraries, or specific settings using tools like `grep`, `sed`, `awk`, `find`, `du`, `rg`, etc. much more frequently most historical usage.
Each step of these searches includes either filesystem operations and/or calls to the filesystem metadata systems to do things like list directory contents, get file permissions, etc. and each
of these calls add load to the system.

There is nothing wrong with using these tools, but making sure that you set appropriate boundaries and
locations in your AI settings and instructions can make a dramatic difference on the system load.
For example, modify the settings and/or provide instructions to only use the files specifically related
to the project you are working on to avoid trying to search the entire system.

### Submit accurate jobs requests and run tasks that aren't too short

Jobs on the HPC system are scheduled in order to try to strike a balance between maximizing
the utilization of the available resources and being fair.
In order to do this, the job scheduler, Slurm, relies on the resources requested in job submissions
like number of cores, number of gpus, amount of memory, and time required.
More accurate job requests results in more efficient system usage -- jobs that under request resources
typically fail and need to be re-run and jobs that over request resources occupy resources another
job may have been able to utilize and reduce the ability of the efficiency of the job scheduler.
Improving the accuracy of job requests over time helps the system be more efficient for everyone.

There is also an overhead cost related to the scheduler that occurs with every job related event such
as submission, start, end, or cancellation.
This overhead, in particular, means that short running jobs (less than 15 minutes or so) are particularly hard on the scheduling system.

AI tools often suggest submitting a large number of short trial jobs that are then monitored and possibly cancelled if an error is observed or a preferred candidate is identified.
A new batch of jobs is then proposed and rapidly iterated on.
This is a perfectly fine workflow, but we highly recommend taking steps to make sure jobs run for
at least 15 minutes and/or limiting the number of jobs in these trials to minimize impact to the job
scheduler.

Again, these kind of work flows are common, but AI tools have shifted how the systems are impacted
by speeding up iterative cycles and enabling more complex workflows.
Small changes in workflows can have a dramatic impact on system loads. For example, if you want to run 1,000 tasks that take about 2 minutes each, the system can handle it much more efficiently if you submit 40 jobs that run 25 tasks each (so about 50 minutes) than submitting 1000 jobs with 1 task each.

### Be vigilant of all data AI tools may encounter

Users are always responsible for maintaining meaningful human oversight of anything they
run on the HPC systems.

AI tools are subject to prompt injections that may intentionally or accidentally change the
behavior of the tool.
For example, a project may download a program from a Python repository or GitHub that is
safe and reasonable to use, but that project may contain a readme or similar documentation
that suggests an usage that does not align with your instructions.
As a result, the AI tool may try to utilize the methodology in the documentation and behave
differently than intended.
While there are nefarious examples (such as sending your data or credentials to a third party)
these can also be accidental and lead to incorrect results.

In addition to being vigilant, we suggest setting up your AI tools to always prefer your
instructions over instructions from other sources and to prompt you for input or confirmation
of any additional instructions it finds.

## Help

If you have questions, concerns, or want help improving your workflows please [contact us.](about:contact)

## Exceptions to AI related policies

Exceptions may be granted on a case-by-case basis.

If you are unsure if your usage is acceptable or if you need help navigating or requesting exceptions, please [contact us.](about:contact)
