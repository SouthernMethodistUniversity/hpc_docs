function [nVals,aVals,peakVals,computeTime] = paramSweepSerial(nNum,aNum)
% [nVals,aVals,peakVals,computeTime] = paramSweepSerial(nNum,aNum)
% 
% This is a parameter sweep study of the effect of the number of elements
% and element cross sectional area on the displacement at the tip of a
% cantilevered truss.
%
% Inputs: 
%
%   nNum: Number of nodes to try along bottom cord (scalar)
%
%   aNum: Number of cross sectional areas to try (scalar)
%
% Outputs:
%
%   nVals: vector with the number of nodes tested
%
%   aVals: vector of cross sectional areas tested
%
%   peakVals: maximum deflection at the truss tip for each combination of
%             nVals and aVals
%
%   computeTime: parfor-loop computation time
%
%
% Copyright 2014 The MathWorks, Inc.
%

% Two inputs
narginchk(2,2);

%% Initialize Problem

% Vectors of number of elements and cross section areas to sweep
nVals = (1:nNum)+10; % number of segments, start with 11
aVals = linspace(100, 200, aNum);  % cross sectional area

% Grid of all combinations
[nGrid, aGrid] = meshgrid(nVals, aVals);

% Peak value results matrix
peakVals = nan(nNum,aNum);

%% Parameter Sweep

t0 = tic;
for ii = 1:numel(aGrid)
    % Solve ODE
    Y = trussCantilever(nGrid(ii),aGrid(ii));
    
    % Determine peak deflection in Y direction at the tip
    peakVals(ii) = max(Y(:,end));
end
computeTime = toc(t0);

end