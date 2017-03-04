%% Simple electric motor example, structure only
clear
close all

%% Define model using symbolic expressions
modelDef.type = 'VarStruc';
modelDef.x = {'I','w','theta','alpha','T','Tm','Tl'};
modelDef.f = {'fR','fi','fw','fT'};
modelDef.z = {'V','yi','yw','yd'};

modelDef.rels = {...
  {'V', 'fR', 'I', 'w'}, ... % e1
  {'Tm', 'I'}, ...           % e2
  {'w', 'T'}, ...            % e3
  {'T', 'Tm', 'Tl'}, ...     % e4
  {'theta', 'w'}, ...        % e5
  {'w', 'alpha'}, ...        % e6
  {'yi', 'I', 'fi'}, ...     % e7
  {'yw', 'w', 'fw'}, ...     % e8
  {'yd', 'T', 'fT'}};        % e9

model = DiagnosisModel( modelDef );
model.name = 'Electric motor';

clear modelDef

%% Explore model
model.Lint()

%% Plot model
figure(10)
model.PlotModel();

