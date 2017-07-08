clear
close all

%% For help on methods
help DiagnosisModel.PlotDM
help DiagnosisModel

%% Exercise 1
% Useful methods: Lint, Redundancy, PlotModel, PlotDM, IsolabilityAnalysis
% a
fprintf('Defining model equations...\n')
WaterTankModel;
fprintf('Done!\n')

% b
% YOUR CODE HERE

% c
% YOUR CODE HERE

% c
% YOUR CODE HERE

% d
% YOUR CODE HERE

%% Exercise 2

% a 
% Update WaterTankModel.h

% b
% YOUR CODE HERE

%% Exercise 3
% a
% msos = YOUR CODE HERE
% mtes = YOUR CODE HERE


% b
% YOUR CODE HERE

% c
% ts = YOUR CODE HERE

% d
% FSM = YOUR CODE HERE


%% Exercise 4 - 
% a - Generate code for selected mso sets

% r1 -- Sample residual generator design, replace with own design
mso1 = [2, 5, 6, 8, 9, 11]; % MSO foubnd
model.MSOCausalitySweep( mso1 ) % Examine causality for redundant equations
red1 = mso1(5); % Choose fifth as redundant equation
M01 = setdiff(mso1,red1); % Exactly determined part
Gamma1 = model.Matching( M01 ); % Compute mathcing
model.SeqResGen( Gamma1, red1, 'ResGen1' ); %  Generate code

% Collect all residual generators in a cell-array
% Example: If you have designed four residual generators with filenames
% ResGen1.m, ResGen2.m, ResGen3.m, ResGen4.m, collect them as
% R = {@ResGen1, @ResGen2, @ResGen3, @ResGen4};
R = {@ResGen1};

%% b

%% Define simulation parameters, fault cases, and do simulations
% Do not change this part

% Initialize parameters for simulation
params.Ts = 0.01; % Sample time
params.c1 = 1.4;
params.c2 = 2.1;
params.c3 = 1;
params.A1 = 22;
params.A2 = 24;

% Controller parameters
params.Kp = 10;
params.Ki = 4;

% Reference trajectory (h1)
params.ref.t  = [0 1 5 15 30];
params.ref.h1 = [3 5 5 6 6];

% Inital values for h1/h2
initialState.h1 = params.ref.h1(1);
initialState.h2 = (params.c1/params.c2)^2*params.ref.h1(1);

% Options for fault modes
optsNF.tf  = 10; % Fault injection time
optsNF.DT  = 2;  % Fault ramp time
optsNF.fc1 = 0;  % Fault size
optsNF.fa  = 0;  %    -''-
optsNF.fh1 = 0;  %    -''-
optsNF.fh2 = 0;  %    -''-
optsNF.ff1 = 0;  %    -''-
optsNF.fl2 = 0;  %    -''-
optsNF.fl3 = 0;  %    -''-

optsFc1 = optsNF; optsFc1.fc1 = 0.1;
optsFa = optsNF; optsFa.fa = 5;
optsFh2 = optsNF; optsFh2.fh2 = 1;

% Simulate different cases
simNF  = SimulateWaterTank( optsNF, params );
simFc1 = SimulateWaterTank( optsFc1, params );
simFa  = SimulateWaterTank( optsFa, params );
simFh2 = SimulateWaterTank( optsFh2, params );

%% Run residual generators
% Will run all residual generators in R, do not change this part
% Result will be collected in cell-array r
FM = {'NF', 'Fc1', 'Fa', 'Fh2'};
r = cell(1,numel(R));

for fi=1:numel(FM)
  data = eval(['sim' FM{fi}]);
  N = numel(data.t);
  Ts = data.Ts;
  for l=1:numel(R)
    state = initialState;
    resgen = R{l};
    r{l}.(FM{fi}) = zeros(N,1);
    for k=1:N
      [r{l}.(FM{fi})(k), state] = resgen( data.z(k,:), state, params, Ts );      
    end    
  end
end

%% Plot residual results
t = simNF.t;

figure(40)
plot( t, [r{1}.NF], 'linewidth', 2 );
xlabel('t')
title('Fault case: No-fault case')
legend({'r1'})
box off


%% Exercise 5

% a
% YOUR CODE HERE

% b
% YOUR CODE HERE

% c
% YOUR CODE HERE

% d
% YOUR CODE HERE

% e
% YOUR CODE HERE

%% Exercise 6
% a
% YOUR CODE HERE

% b
% YOUR CODE HERE

% c
% YOUR CODE HERE

% d
% YOUR CODE HERE
