function visualizeParamSweep(varargin)
% Visualize Parameter Sweep Output 
%
% Usage:
%   visualizeParamSweep(nVals, aVals, peakVals)
%   visualizeParamSweep(jobOutput)
%
%
% Inputs:
%   nVals: vector or matrix of number of segements
%
%   aVals: vector or matrix of areas
%
%   peakVals: matrix that represents the peak deflection at each
%             corresponding point of nVals and aVals
%
%   jobOutput: cell array containing the outputs fetched from a batch job
%              with paramSweepParallel or clusterBatch
%
% Plotter for ODE parameter sweep example
%
% Copyright 2014 The MathWorks, Inc.

if nargin == 3
    % Three input
    nVals = varargin{1};
    aVals = varargin{2};
    peakVals = varargin{3};
    
elseif nargin == 1    
    % Job output as a cell array
    jobOutput = varargin{1}; % extract job
    assert(iscell(jobOutput),'jobOutput is expected to be a cell');
    
    % Extract pieces from job
    nVals = jobOutput{1};
    aVals = jobOutput{2};
    peakVals = jobOutput{3};
    
else
    error('One or Three inputs expected');
end

% Build figure and surface of peakVals
figure
surf(nVals, aVals, peakVals)

% Label it and set viewing angle
xlabel('Number of horizontal Segments')
ylabel('Area of Cross Section')
zlabel('Maximum Y deflection')
title('Peak Value of Cantilever Deflection', ...
      'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'Bold')
view(50, 30)

end

