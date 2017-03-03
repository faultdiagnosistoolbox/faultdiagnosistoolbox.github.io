---
layout: single
title: Use case -- Fault Diagnosis Toolbox
---
<div style="text-align: left; font-size: 12pt;">« <a href="/usecase">Previous Page</a>
— <a href="/_pages/usecase_diaganalysis">Next Page</a> »</div>
## Modelling the Engine

The model is a differential-algebraic (DAE) model, based on the model
developed in Eriksson, L. (2007). _[Modeling and control of turbocharged SI and
DI engines](https://doi.org/10.2516/ogst:2007042)_. Oil & Gas Science and
Technology - Rev. IFP, 62(4), 523–538.

The model-object is created by a statement
{% highlight matlab %}
  m = DiagnosisModel( modelDef )
{% endhighlight %}
where the struct modelDef is a model definition containing the fields

* `modelDef.x` - cell array of names of unknown variables
* `modelDef.f` - cell array of names of fault variables
* `modelDef.z` - cell array of names of known variables
* `modelDef.parameters` - cell array of parameter names
* `modelDef.rels` - cell array with model equations

In addition, the model relations/equations are written directly as
symbolic expressions. For example, a restriction model using an
external function `W_af_fun`, a control volume with a mass
state `m_im` and a temperature state `T_im`, and a
measurement equation for the air mass flow `W_af` can be written
as
{% highlight matlab %}
%% Declare model equations
modelDef.rels = {
   ...
   % Air filter restriction:                                                
   W_af == W_af_fun(p_amb,p_af,plin_af,
      H_af,T_amb)+fp_af

   % Control volume intake manifold:
   p_im == m_im*R_air*T_im/V_im                                     
   dmdt_im == (W_th - W_ac) + fw_th
   dTdt_im == (W_th*cv_air*(T_imcr-T_im)+R_air*
      (T_imcr*W_th-T_im*W_ac))/(m_im*cv_air)

   % Measurement signals:
   y_W_af == W_af + fyw_af % Air mass flow
   ...
}
{% endhighlight %}
The toolbox supports only structural models, but here models with symbolic
model equations is used since the objective of the use case is to go
from model to generating code for residual generators and then expressions
for the model equations are needed. When the `modelDef` structure has been defined and
the `model` object has been created it is time to explore the
model. Basic model information is obtained using the `Lint` class method
{% highlight matlab %}
>> model.Lint()
Model: Engine model

  Type: Symbolic, dynamic

  Variables and equations
    90 unknown variables
    10 known variables
    11 fault variables
    94 equations, including 14 differential
      constraints

  Degree of redundancy: 4
  Degree of redundancy of MTES set: 1

  Model validation finished with 0 errors and
  0 warnings.
{% endhighlight %}

<img src="/assets/images/engine/engine_model.png" width="65%" align="right" hspace="10" vspace="5"/>
The model structure, i.e., which variables that appear in which constraints, are
extensively used by the methods implemented in the toolbox. This model structure
is automatically inferred from the model equations and the `PlotModel` class method can
be used to visualize the model structure. It shows the equations on the vertical axis
and the variables on the horizontal axis. A dot represent that a
variable appears in the corresponding equation. Blue, red, and black
dots represent unknown, fault, and known variables respectively.

{% highlight matlab %}
>> model.PlotModel()
{% endhighlight %}


<div style="text-align: right; font-size: 12pt;">« <a href="/usecase">Previous Page</a>
— <a href="/_pages/usecase_diaganalysis">Next Page</a> »</div>
