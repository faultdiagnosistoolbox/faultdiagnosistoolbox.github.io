---
layout: single
---
<div style="text-align: left; font-size: 12pt;">« <a href="/_pages/usecase_diaganalysis">Previous Page</a>
 — <a href="/_pages/usecase_eval">Next Page</a> »</div>
## Residual Generator Analysis and Design

One successful approach to residual generation is to find testable
sub-models and then, based on such sub-models, design residual
generators. The first step is then to make a complete search for
testable sub-models, here [Minimally Structurally Overdetermined (MSO)](https://doi.org/10.1109/TSMCA.2007.909555)
set of equations. This step is based only on the
structure of the model and in the engine model there are 4496 MSO
sets. This means that, even with redundancy degree of only 4, there
are several thousand different sub-models that can be tested
independently. In the software, to compute the set of MSO sets use the
`MSO` class method as
{% highlight matlab %}
msos = model.MSO();
{% endhighlight %}
The output `msos` is a cell array of index vectors to equations in the model.
It is possible to compute the isolability of all MSO sets as
{% highlight matlab %}
model.IsolabilityAnalysisArrs( msos )
{% endhighlight %}
that is equal to the isolability matrix computed earlier.

### Low-index and observability properties of sub-models

The toolbox supports sequential residual generator design and for models
with high differential-index such direct residual design is not always
appropriate since numerical differentiation of measurement
signals are needed. The structural differential-index can be
determined by efficient structural algorithms and the MSO sets with
low-index can be found using the `IsLowIndex` class method as
{% highlight matlab %}
lowidx=cellfun( @(m) model.IsLowIndex(m), msos )
{% endhighlight %}

For the engine model there are 206 low-index MSO sets out of the 4496.
Performing the call
{% highlight matlab %}
model.IsolabilityAnalysisArrs( msos(lowidx) )
{% endhighlight %}
will give the isolability properties of the low-index MSO sets previously
computed; the isolability matrix with integral causality.

If a state-observer technique is to be used, observability of the
sub-models is of importance. Structural observability can easily be
checked, for all MSO sets, with the class method `IsObservable` as
{% highlight matlab %}
obs=cellfun( @(m) model.IsObservable(m), msos )
{% endhighlight %}
In the engine model, all MSO sets are structurally observable.

### Sequential residual generation

There are many ways to design a residual generator based on a model
with redundancy. Sequential residual generation is one direct and
simple way, especially if the model is of low differential index. An
MSO set have exactly one more equation than the number of unknown
variables and this means that if one equation is used as the residual
equation, the remaining equations will form an exactly determined
system of equations. Then, the exactly determined set of equations is
solved for all unknown variables numerically on-line and insertion of
all computed variables in the residual equation then produces a
residual. For the engine model there were 4496 different MSO sets and
previous analysis gives that there exists 206 low-index
sub-models. From these 206 sub-models the toolbox can automatically
generate a large number, here 728, of candidate residual generators
with integral causality. Using the `IsLowIndex` class method, it
is concluded that MSO number 1650 with its 74:th equation as a
residual equation constitute a low-index problem. A matching, i.e.,
computational path for the exactly determined model is found using the
class method `Matching` and then the method `SeqResGen`
can be used to generate Matlab or C-code.
{% highlight matlab %}
M = msos{1650}; % Set of equations
r = M(74); % Redundant equation
M0 = setdiff(M,r); % Exactly determined part
Gamma = model.Matching(M0); % Compute matching
model.SeqResGen( Gamma, r, 'ResGen_1650_74', 'language', 'C'); % Generate code
mex ResGen_1650_74.cc % Compile
{% endhighlight %}
This generates an object code that can be called directly from Matlab
with measurement data and model parameters as inputs and the residual
as output. Next step is to evaluate generated code for a set of such residuals
on measurement data.

<div style="text-align: right; font-size: 12pt;">« <a href="/_pages/usecase_diaganalysis">Previous Page</a>
 — <a href="/_pages/usecase_eval">Next Page</a> »</div>
