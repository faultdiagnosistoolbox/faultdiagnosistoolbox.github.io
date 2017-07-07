%% DAE formulation of model, 4 sensors
modelDef.type = 'Symbolic';
modelDef.x = {'h1','h2','Win', 'W1', 'W2','W3','dh1','dh2'};
modelDef.f = {'fh1', 'fh2','ff1','fc1','fl2','fl3','fa'};
modelDef.z = {'y1','y2','y3','y4', 'u'};
modelDef.parameters = {'A1', 'A2', 'c1', 'c2', 'c3'};

syms(modelDef.x{:})
syms(modelDef.f{:})
syms(modelDef.z{:})
syms(modelDef.parameters{:})

modelDef.rels = {...
  A1*dh1 == Win - W1, ...
  A2*dh2 == (1-fl2)*W1 - W2, ...
  Win == c3*u + fa, ...
  W1 == (1-fc1)*c1*sqrt(h1), ...
  W2 == c2*sqrt(h2), ...
  W3 == (1-fl3)*W2, ...
  y1 == h1 + fh1,...
  y2 == h2 + fh2,...
  y3 == W1 + ff1,...
  y4 == W3,...
  DiffConstraint('dh1','h1'),... % e10
  DiffConstraint('dh2','h2'),... % e11
};

model_dae4 = DiagnosisModel( modelDef );

model_dae4.name = 'Water Tank Model';

% clear temporary variables from workspace
clear( modelDef.x{:} )
clear( modelDef.f{:} )
clear( modelDef.z{:} )
clear( modelDef.parameters{:} )

clear modelDef

%% State-space formulation, 4 sensors
modelDef.type = 'Symbolic';
modelDef.x = {'h1','h2','dh1','dh2'};
modelDef.f = {};
modelDef.z = {'y2','y3','y4', 'u'};
modelDef.parameters = {'A1', 'A2', 'c1', 'c2', 'c3'};

syms(modelDef.x{:})
%syms(modelDef.f{:})
syms(modelDef.z{:})
syms(modelDef.parameters{:})

modelDef.rels = {...
  A1*dh1 == c3*u - c1*sqrt(h1), ...
  A2*dh2 == c1*sqrt(h1) - c2*sqrt(h2), ...
  y2 == h2,...
  y3 == c1*sqrt(h1),...
  y4 == c2*sqrt(h2),...
  DiffConstraint('dh1','h1'),... 
  DiffConstraint('dh2','h2'),...
};

model_statespace = DiagnosisModel( modelDef );
model_statespace.name = 'Water Tank Model, state-space';
model_statespace.CompiledMSO(false);

% clear temporary variables from workspace
clear( modelDef.x{:} )
%clear( modelDef.f{:} )
clear( modelDef.z{:} )
clear( modelDef.parameters{:} )

clear modelDef

%%
model = model_dae4.SubModel(7,[],'remove', true); % remove sensor h1
model.CompiledMSO(false);

model_no_y3 = model_dae4.SubModel(9,[],'remove', true); % remove sensor y3
model_no_y3.CompiledMSO(false);

model_nosens = model_dae4.SubModel(7:10,[],'remove', true); % remove sensors

clear model_dae4

