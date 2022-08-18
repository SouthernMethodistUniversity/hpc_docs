function [Yr,bars,L,N,H]=trussCantilever(N,Aval)
% Yr = trussCantilever(N,Aval);
%
% Usage:
%    Y=trussCantilever(N,Aval)
%    [Yr,bars,L,N,H]=trussCantilever(N,Aval)
% 
% Inputs:
%
%    N: number of horizontal elements (recommend range of [1,400])
%
%    Aval: cross section area for each rod (recommend range of [10 1000])
%
% Outputs:
%
%    Yr: 
%
%

% Copyright 2014 The MathWorks, Inc

%% Defaults

if nargin < 2
    % Ten horizontal truss elements in bottom cord 
    N = 10;
    
    % Cross sectional area of 100
    Aval = 100;
end


%% Truss Parameters
% Physical parameters of the material and truss

% Horizontal Length of the truss
L = 1;

% Vertical Height of the truss
H = 0.025;

% Density of truss bar material
rho = 1;

% Modulus of Elasticity of truss bar material
Eval = 1e-1;

% Rayleigh, "alpha,beta" damping coefficients
dampingCoeffAlpha = 0.01;
dampingCoeffBeta = 0.01;


%% Force Parameters
%
% The following downward force is applied to the truss
%
%      max(0,(applyTime-t)*downwardForceMag/applyTime)*sin(2*pi*freq*t)
% 
% The frequency of the force is 1. The magnitude is linearly lowered from
% _downwardForceMag_ to zero over the interval |[0,applyTime]|. The
% simulation time is simTime. Because of the damping the vibration will die
% out.

downwardForceMag = 0.02;
freq = 1;
applyTime = 20;
simTime = 100;


%% Map reduced Dofs to actual Dofs
% The truss is fixed to the wall on the left hand side. Therefore the two
% nodes there are not mobile and can be eliminated. Create a map between
% the "reduced" degrees of freedom and the actual degrees of freedom

numDofs = 2*2*(N+1)-2; % -2 because the cantilever is pointed upwards at the end
groundDofs = [1,2,2*(N+1)+1,2*(N+1)+2]; % Degrees of Freedom that will be eliminated

%% Add bars along with geometry
% bars are #of Bars X [Area,E,length of bar,angle of bar w.r.t. horizontal
% axis, node1 (from node), node2 (to node)]
bars = zeros(2*N+2*(N-1),6);
for n = 1:N
    % upper bars
    lelem = L/N;
    bars(n,:) = [Aval,Eval,lelem,0,n,n+1];
    % diagonal bars
    lelem = sqrt((L/N)^2+H^2);
    bars(N+n,:) = [Aval,Eval,lelem,pi/4,N+1+n,n+1];
end
for n = 1:N-1
    % lower bars
    lelem = L/N;
    bars(2*N+n,:) = [Aval,Eval,lelem,0,N+1+n,N+1+n+1];
    % vertical bars
    lelem = H;
    bars(2*N+N-1+n,:) = [Aval,Eval,lelem,pi/2,N+1+n+1,n+1];
end

%% Assemble all bars into global stiffness and mass matrices

% Use a dense matrix for insertion efficiency
K = zeros(numDofs);
M = zeros(numDofs);

% Mass element matrix
% the mass matrix is a lumped matrix with half the mass going to one
% node and half to the other node
unitMassMatrix = diag([1/2 1/2 1/2 1/2]);
melem = rho*lelem*unitMassMatrix; 

for ii=1:size(bars,1)
    % extract parameters for stiffness and mass matrices
    Aelem = bars(ii,1);
    Eelem = bars(ii,2);
    lelem = bars(ii,3); 
    telem = bars(ii,4);
    kelem = localStiffness(Aelem,Eelem,lelem,telem); % stiffness matrix
    n1 = bars(ii,5); 
    n2 = bars(ii,6);
    % convert to reduced dofs
    ix = [n1*2-1,2*n1,n2*2-1,n2*2];
    % element "stamping"
    K(ix,ix) = K(ix,ix) + kelem; % Add in element's contribution to K
    M(ix,ix) = M(ix,ix) + melem; % Add in element's contribution to M
end

% Zero out rows and columns of ground DOFs in stiffness and mass matrix
K(groundDofs,:) = 0;
K(:,groundDofs) = 0;
M(groundDofs,:) = 0;
M(:,groundDofs) = 0;

% Add ones to diagonal of ground DOFs to freeze them
groundDofDiag = sub2ind(size(M),groundDofs,groundDofs);
K(groundDofDiag) = 1;
M(groundDofDiag) = 1;

% convert stiffness and mass matrices to sparse
Kr = sparse(K);
Mr = sparse(M);

% Force vector iz zeros with magnitude on end Y Dof in Y
F = zeros(size(Kr,1),1);
F(2*(N+1)) = downwardForceMag;

%% Solve the system
% Transform M*d2x/dt2 + damping*dx/dt + K*x = F into dydt = A*y + f form
% Convert 2nd order ODE to first order ODE with y = dx/dt transformation.
% The state space is therefore [position,velocity] and in that order

[LM,UM] = lu(Mr);
A = [-UM\(LM\Kr),-UM\(LM\(dampingCoeffAlpha*Kr+dampingCoeffBeta*Mr));sparse(numDofs,numDofs),speye(numDofs)];
f = [UM\(LM\F);zeros(numDofs,1)];
myEvaluator = @(t,y) A*y + max(0,(applyTime-t)*f/applyTime)*sin(2*pi*freq*t);
initialCondition = zeros(numDofs*2,1); % initial conditions for ode23t

% Yr is #Time points X [position, velocity]
[~,Yr] = ode23t(myEvaluator,[0 simTime],initialCondition);

% Remove the velocity components from Yr
Yr = Yr(:,1:numDofs);

end