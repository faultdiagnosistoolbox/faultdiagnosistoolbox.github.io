%% Simple electric motor example
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

