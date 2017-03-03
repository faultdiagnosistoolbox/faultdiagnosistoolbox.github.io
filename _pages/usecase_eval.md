---
layout: single
title: Use case -- Fault Diagnosis Toolbox
---
<div style="text-align: left; font-size: 12pt;">« <a href="/_pages/usecase_resgen">Previous Page</a> »</div>
## Evaluation on Test Cell Measurements

To illustrate performance on measurement data we consider only 4 of
the 11 faults; faults in the air-flow sensor `fy_waf`, the intake
manifold pressure sensor `fyp_im`, the intercooler pressure
sensor `fyp_ic`, and the intercooler temperature sensor
`fyT_ic`. Measurement data were collected for the fault free and
4 faulty cases, then in total 5 data sets, during a 12 minute long EPA highway
fuel economy test cycle. Sample measurements from the fault free case are

<img src="/assets/images/engine/engine_NF_data.png" width="90%"/>

Out of the 728 residuals only a few is needed for isolating between
the 4 faults and using a data-driven test selection procedure not
described here, 7 residuals were in the end chosen for this
illustration. Using class methods `FSM` and
`IsolabilityAnalysisArrs`, the fault signature matrix and the
isolability matrix of the selected 7 residuals are
<img src="/assets/images/engine/engine_ts_FSM_isol.png" width="60%" align="right"  hspace="10" vspace="5"/>
As can be seen, all single faults are structurally isolable.

#### Running residual generators
The generated code for the 7 residuals are run on the 5 data sets and
the residuals in the fault free case are shown in the plot below where the dashed
lines correspond to thresholds selected to achieve a 1% false alarm probability.

<img src="/assets/images/engine/engine_res_NF.png" width="90%"/>

The generated code from last section is run using the single Matlab call
{% highlight matlab %}
r = ResGen_1650_74(z, state_init, params, Ts );  
{% endhighlight %}
where `z` is a matrix with the measurements, the struct `state_init`
gives the initial state, `params` the model parameters, and
`Ts` the sampling time. It takes about 0.55 seconds to evaluate a
residual for 12 minutes of 1kHz sampled data on a 2016 Macbook Pro
which corresponds to about 1500 times faster than real-time.

The residuals for data with a fault in the air-flow sensor are

<img src="/assets/images/engine/engine_res_fywaf.png" width="90%"/>

According to the fault signature matrix above, the
red colored residuals should be sensitive to the air-flow sensor fault
but not the blue colored residuals. The fault is present during the
gray shaded intervals, i.e., the fault is injected intermittently. The
blue colored residuals are not sensitive to the fault as expected and
residuals 1, 2, and 5 are above the dashed thresholds when the fault is
present. Residual 3 should be sensitive to this fault but the fault to
noise ratio is apparently too low for this fault, but is selected for
its ability to detect fault `fyp_ic`.

The figure below  shows in blue the distributions of the
residuals in the fault free case and in red the distributions of the
residuals for an air-flow sensor fault. It is clear that residuals 1,
2, and 5 are good at detecting this fault since the residual
distributions change significantly.

<img src="/assets/images/engine/engine_res_pdf_fywaf.png" width="90%"/>

Given the residuals and thresholds, the consistency based diagnosis candidates
as a function of time, in the case of an air mass-flow sensor fault, are

<img src="/assets/images/engine/engine_res_isol_fywaf.png" width="90%"/>

In the figure, a 1 means that the fault is a diagnosis and a
0 that it is not. The percentage of time where there is an isolation
error is shown above each plot. Here, no post-processing is performed,
and the error can be improved by post-filtering or applying adaptive
thresholds, maybe at the cost of a delayed detection.
It is clear that the fault isolation reliably indicates the correct
fault `fyw_af` and isolates reliably from `fyp_ic` and
`fyT_ic` but has a little more difficulty isolating from fault
`fyp_im`.

To summarize the performance of the generated diagnosis system, the
confusion matrix is illustrated using a 3D-plot

<img src="/assets/images/engine/engine_res_isol_confusion_3d.png" width="90%"/>

Here, the probability of correct isolation is plotted, and a perfect system
would correspond to a diagonal with probability 1. It is clear from the figure
that faults `fyw_af`, `fyp_ic`, and `fyT_ic` can be reliably isolated. Fault `fyp_im`
however can be reliably detected but is sometimes difficult to isolate from `fyw_af`.

<div style="text-align: right; font-size: 12pt;">« <a href="/_pages/usecase_resgen">Previous Page</a> »</div>
