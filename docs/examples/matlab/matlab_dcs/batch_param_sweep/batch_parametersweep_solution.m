%% Batch processing of a function
% Copyright 2016 The MathWorks, Inc.

%% Close any open pool of workers 

% Delete the current pool and don't open if there isn't one.
delete(gcp('nocreate'));


%% Submit job.  
%
% Submit paramSweepSerial to run on one worker with inputs 10, 10
%
% To submit to a cluster, we would change profile from 'local' and adjust
% pool size if a cluster is available

job1=batch('paramSweepSerial',4,{10,10});


%% Check status
% We can check the status of the job by querying its state

job1.State

%% Display
% Look at job1.  Notice how it auto-attached all of the files required for
% the parameter sweep.  This is a setting that can be adjusted in the
% profile.  Additionally, you can manually attach data files or additional
% paths if those needed to be reflected on a cluster.
%
% Also notice how the command line is available to continue your work.
% This job is no longer blocking your client MATLAB session.
%

disp(job1)


%% Wait for completion 
% If depending on outputs to proceed, force command prompt to wait

wait(job1) % optional


%% Plot data when job is finished

% Retrieve outputs from the function we called.
jobOut=fetchOutputs(job1);

% View it
visualizeParamSweep(jobOut);
computationTime=jobOut{4};
disp(['Computation time: ' num2str(computationTime)])

%% Repeat with a pool and parallel function
% Submit paramSweepParallel to run on as many workers as possible with
% inputs 10, 10.  Call this job2.

cluster = parcluster;
N = cluster.NumWorkers-1; % Subtract one for the worker running the job
job2=batch('paramSweepParallel',4,{10,10},'Pool',N);  

%% Clear Everything
% This is analagous to closing MATLAB or turning off the computer.
clear

%% Retrieve Job2's Output
% Either do this interactively with the job monitor or programmatically
% like below.

cluster = parcluster;
jobs = findJob(cluster);
% Identify the index of the job you want to retrieve
fetchOutputs(jobs(idx))
