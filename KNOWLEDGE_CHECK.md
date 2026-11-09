# Lab 08: Knowledge check

**Answer each question below it, in your own words, in one to three sentences.** Replace the `...` below **Your answer:** with your text. Questions 1 and 3 also ask for saved output, which goes into the directory `results/`.

## 1. Slurm: what jobs have I submitted?

**Your task:** print a history of all your Slurm job submissions *since November 4, 2026*. Format the output to include the job ID, job name, node list, partition, account, user, state, start time, and elapsed time. See the job accounting fields in the [sacct documentation](https://slurm.schedmd.com/sacct.html). You may also ask Claude Code or another LLM for the exact command. 

Redirect the command's output to `results/job-history.txt` and include the file in your submission. Do not worry if some earlier jobs failed or were canceled. The complete history should show your process, including trial and error.

*Hint:* See [Part 1, Step 6](README.md#step-6-check-how-the-tasks-ended) in the README.

**Your answer:** Provide the entire command you used, including all CLI options.
I used the following command to print my Slurm job history and save it to the results directory:

`sacct -u "$USER" --format=JobID,JobName,Partition,State,ExitCode,Start,Elapsed > results/job-history.txt`

My job history shows four top-level submissions: 22704454 (FAILED), 22704584 (COMPLETED), 22706352 (COMPLETED), and 22706707 (the 101-task array, COMPLETED). All 101 tasks in the final array completed successfully with exit code 0.

## 2. Slurm: did every array task run at the same time?

You submitted your entire job array with one `sbatch` command, but Slurm scheduled each task separately.

**Your task:** in the job history from Question 1, find the tasks from your most recent completed array run. Compare their start times and elapsed times.

*Hint:* See [Part 1, Step 5](README.md#step-5-watch-the-job-array) in the README.

**Your answer:** Did all tasks in the array start at the same time? Was the elapsed time identical for every task? Explain why or why not.
No, all 101 tasks did not start at the same time. Slurm scheduled them in groups based on available resources. For example, tasks 1–10 started at 12:52:06, while tasks 11–20 started at 12:52:43. The elapsed times were also not identical, ranging mostly from 16–19 seconds, with task 101 taking 11 seconds. This shows that Slurm managed the workload based on available resources rather than running every task simultaneously.

## 3. Slurm: did my job use what it asked for?

Suppose your next job array has 1,000 books instead of 101. Before you submit it, you want to know whether your script asks for too much or too little memory and time.

**Your task:** run `seff` for **one** task of your finished job array, and save its output as `results/seff.txt`.

*Hint:* `seff` takes the ID of one task, such as `4211873_1`. Compare its **Memory Utilized** and **Job Wall-clock time** with `--mem` and `--time` in your `summarize.slurm`.

**Your answer:** How much memory and time did the task use, compared with what your script asked for? What would you change in your script, and why?

My job requested 1 GPU, 2 CPU cores, 16 GB of memory, and a 5-minute time limit. It actually used 1.37 GB of memory (8.58% of the allocation) and ran for 16 seconds. This means the task used significantly less memory and time than requested. For the next 1,000-book array, I would consider reducing the memory request to 4 GB and the time limit to 1 minute while keeping the GPU allocation. Since each task processes one book, these smaller requests should provide sufficient resources while reducing unnecessary resource allocation. I would monitor the jobs to make sure they still complete successfully.

