---
layout: single
---
<div style="text-align: left; font-size: 12pt;">« <a href="/_pages/usecase_modelling">Previous Page</a>
 — <a href="/_pages/usecase_resgen">Next Page</a> »</div>
## Diagnosability Analysis

Now, with a defined model there are many diagnosis analyses that can be performed
on the model structure only. For example, it is possible to find out if the model
contains enough redundancy to detect and isolate faults, i.e., answer diagnosability
questions like
> Can I detect this fault?

or

> Can I isolate this fault from that fault?

or

> What isolation performance is possible using only direct application of state-observers?

Such non-trivial questions can be answered using structural techniques giving best-case
results.

### Canonical decomposition

A key tool in structural analysis for fault diagnosis is the
[Dulmage-Mendelsohn decomposition](http://cms.math.ca/10.4153/CJM-1958-052-0).
To plot the decomposition, extended with fault variables and equivalence classes
as described in [(Krysander and Frisk, 2008)](https://doi.org/10.1109/TSMCA.2008.2003968),
is computed using the `PlotDM` class method
{% highlight matlab %}
  model.PlotDM('eqclass', true, 'fault', true)
{% endhighlight %}
which results in the plot

<img src="/assets/images/engine/engine_dm_canonical.png" width="75%" align="centering"/>

It is a Dulmage-Mendelsohn decomposition with
an additional canonical decomposition of the overdetermined part. The
overdetermined part is marked with a blue rectangle and faults
entering in equations contained in the overdetermined part are
structurally detectable. The set of equations in the overdetermined
part is partitioned into equivalence classes,
indicated by gray shaded rectangles in the figure, with the property
that all faults appearing in the same equivalence class is not
structurally isolable from each other.

### Fault Isolability Matrices

Although the canonical form is informative, it contains
a lot of details. Another form of illustrating single fault
isolability performance is the _isolability matrix_ computed using
the class method `IsolabilityAnalysis` as
{% highlight matlab %}
model.IsolabilityAnalysis()
{% endhighlight %}
<img src="/assets/images/engine/engine_isol.png" width="50%" align="right"  hspace="10" vspace="5"/>
A dot in position _(i,j)_ indicates fault _j_ will be a diagnosis if
fault _i_ is the present fault. Thus a diagonal matrix represents full
single fault isolability, i.e., all single faults are uniquely
structurally isolable in the engine model.

Low structural index is an interesting class of models since, for
example, for low-index models established techniques like
state-observers and Extended Kalman Filters can be directly applied
while this is not true for high-index models.
The isolability of faults when only using low-index approaches can be computed by
{% highlight matlab %}
model.IsolabilityAnalysis('causality','int')
{% endhighlight %}

<img src="/assets/images/engine/engine_isol_int.png" width="50%" align="left"  hspace="10" vspace="5"/>
The isolability matrix shows how the fault isolability performance
degrades, which is expected, if the residual generation techniques are
limited to pure integration based methods. These isolability matrices gives a
direct way to early evaluate possible isolation performance of the model
and with the given measurements. Of course, these are structural results meaning
that even if the isolability matrix indicate that all faults are uniquely
isolable, it is not certain that this is realizable in the real application with
a required detection and false-alarm probabilities. But is gives an important
first indication on what is possible.


<div style="text-align: right; font-size: 12pt;">« <a href="/_pages/usecase_modelling">Previous Page</a>
 — <a href="/_pages/usecase_resgen">Next Page</a> »</div>
