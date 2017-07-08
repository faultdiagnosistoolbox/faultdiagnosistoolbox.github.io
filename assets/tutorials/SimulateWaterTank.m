function r = SimulateWaterTank(opts,params)

  % Define ramp function for fault injection
  ramp = @(t, t1, t2, y) (t>=t1 & t<t2).*(t-t1)*y/max(eps,t2-t1) + (t>=t2)*y;

  tf = opts.tf;
  DT = opts.DT;
  
  % Define autonomous simulation function x' = fWT(t, x)
  % x = (h1, h2, uint)
  fWT = @(t,x) WaterTankSim(t, x, interp1(params.ref.t, params.ref.h1, t), ...
    [ramp(t,tf, tf+DT,opts.fc1);...
     ramp(t,tf, tf+DT,opts.fl2);...
     ramp(t,tf, tf+DT,opts.fa)], params);

  h1Init=params.ref.h1(1);
  h2Init=(params.c1/params.c2)^2*h1Init;
  x0 = [h1Init;h2Init;0];

  Ts = params.Ts;
  [t,x] = ode45(fWT,[0:Ts:30],x0);

  ref = interp1(params.ref.t, params.ref.h1, t);
  u = params.Kp*(ref-x(:,1)) + params.Ki*x(:,3);
  
  fh1 = ramp(t, tf, tf+DT, opts.fh1);
  fh2 = ramp(t, tf, tf+DT, opts.fh2);
  fc1 = ramp(t, tf, tf+DT, opts.fc1);
  ff1 = ramp(t, tf, tf+DT, opts.ff1);
  fl3 = ramp(t, tf, tf+DT, opts.fl3);
  fl2 = ramp(t,tf, tf+DT,opts.fl2);
  fa  = ramp(t,tf, tf+DT,opts.fa);
  
  yh2 = x(:,2) + fh2;
  yf1 = (1-fc1).*params.c1.*sqrt(x(:,1)) + ff1;
  yf2 = (1-fl3).*params.c2.*sqrt(x(:,2));
  yh1 = x(:,1) + fh1;
  
  r.t = t;
  r.Ts = Ts;
  
  r.z = [yh2 yf1 yf2 u];
  
  r.fault.fh2 = fh2;
  r.fault.ff1 = ff1;
  r.fault.fc1 = fc1;
  r.fault.fl2 = fl2;
  r.fault.fl3 = fl3; 
  r.fault.fa = fa;
end

function dx = WaterTankSim(t, x, ref, f, params)
  % x = [h1, h2, ui]
  % f = ['fc1','fl2','fa']
  % params.{Kp, Ki}
  
  Kp = params.Kp;
  Ki = params.Ki;
  
  c1 = params.c1;
  c2 = params.c2;
  c3 = params.c3;
  A1 = params.A1;
  A2 = params.A2;
    
  fc1 = f(1);
  fl2 = f(2);
  fa = f(3);
  
  h1 = x(1);
  h2 = x(2);
  ui = x(3);
  
  u = Kp*(ref-h1) + Ki*ui;
  
  dh1 = 1/A1*(c3*(u+fa)-c1*(1-fc1)*sqrt(h1));
  dh2 = 1/A2*((1-fl2)*c1*(1-fc1)*sqrt(h1) - c2*sqrt(h2));
  dui = ref-h1;

  dx = [dh1;dh2;dui];
end
