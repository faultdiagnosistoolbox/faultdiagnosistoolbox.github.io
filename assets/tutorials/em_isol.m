%% Simple electric motor example - isolability analysis and sensor placement
clear
close all

%% Define model using symbolic expressions
modelDef.type = 'Symbolic';
modelDef.x = {'dI','dw','dtheta', 'I','w','theta','alpha','T','Tm','Tl'};
modelDef.f = {'fR','fi','fw','fT'};
modelDef.z = {'V','yi','yw','yd'};
modelDef.parameters = {'Ka','b','R','J','L'};

syms(modelDef.x{:})
syms(modelDef.f{:})
syms(modelDef.z{:})
syms(modelDef.parameters{:})

modelDef.rels = {...
  V == I*(R+fR) + L*dI + Ka*I*w,...  % e1
  Tm == Ka*I^2, ...                  % e2
  J*dw == T-b*w, ...                 % e3
  T == Tm-Tl, ...                    % e4
  dtheta == w, ...                   % e5
  dw == alpha, ...                   % e6
  yi == I + fi, ...                  % e7
  yw == w + fw, ...                  % e8
  yd == T + fT, ...                  % e9
  DiffConstraint('dI','I'),...       % e10
  DiffConstraint('dw','w'),...       % e11
  DiffConstraint('dtheta','theta')}; % e12

model = DiagnosisModel( modelDef );
model.name = 'Electric motor';

% clear temporary variables from workspace
clear( modelDef.x{:} )
clear( modelDef.f{:} )
clear( modelDef.z{:} )
clear( modelDef.parameters{:} )

clear modelDef

%% Explore model
model.Lint()

%% Plot model
figure(10)
model.PlotModel();

%% Isolability analysis
figure(20)
model.IsolabilityAnalysis()

%% Sensor placement analysis for full isolability
model.PossibleSensorLocations({'I', 'w', 'theta', 'alpha', 'T', 'Tm', 'Tl'});
model.SensorLocationsWithFaults([]); % No new sensors may become faulty

sens = model.SensorPlacementIsolability();

%% Add sensor to model and see that full isolability is achieved
model2 = model.AddSensors( sens{1} );
model2.name = 'Electric motor with additional sensor';
model2.Lint()

figure(30)
model2.IsolabilityAnalysis()

%% Sensor placement analysis for full isolability, faulty sensors
model.PossibleSensorLocations({'I', 'w', 'theta', 'alpha', 'T', 'Tm', 'Tl'});
model.SensorLocationsWithFaults({'I', 'w', 'theta', 'alpha', 'T', 'Tm', 'Tl'});

sens = model.SensorPlacementIsolability();

model3 = model.AddSensors( sens{1} );
model3.name = 'Electric motor with additional sensor';
model3.Lint()

figure(40)
model3.IsolabilityAnalysis()

