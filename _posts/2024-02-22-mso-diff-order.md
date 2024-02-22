---
title:  "Differentiation orders in MSO"
date:   2024-02-22 07:00:00 +0100
---
New functionality has been added to compute, using structural methods, orders of derivatives of known signals, equations, and faults in an ARR based on an MSO. The new method is named ```MSOdifferentialOrder``` and is available in both Matlab and Python.

A small example. Consider the MSO
{% highlight math %}
  x1' = -x1 + x2
  x2' = -x2 + x3
  x3 = u
  y = x1 + f
{% endhighlight %}
Generating an ARR from this model would result in
{% highlight math %}
y'' + 2 y' + y - u = 0
{% endhighlight %}
meaning that the known signal ```y``` is differentiated twice and ```u``` not differentiated. This can be relevant information when implementing residual generators.

In the toolbox, this can be modeled as
{% highlight python %}
x1, x2, x3, dx1, dx2, u, y, f = sym.symbols(["x1", "x2", "x3", "dx1", "dx2", "u", "y", "f"])
model_def = {"type": "Symbolic", "x": ["x1", "x2", "x3", "dx1", "dx2"], "f": ["f"], "z": ["y", "u"]}
model_def["rels"] = [
    -dx1 + -x1 + x2,  # e1
    -dx2 + -x2 + x3,  # e2
    -x3 + u,  # e3
    -y + x1 + f,  #e4
    fdt.DiffConstraint("dx1", "x1"),  # e5
    fdt.DiffConstraint("dx2", "x2"),  # e6
]

model = fdt.DiagnosisModel(model_def, name="Small model")
{% endhighlight %}
and the calls
{% highlight python %}
    mso = model.MSO()[0]  # Take the first MSO
    eqorder, zidx, zorder, fidx, forder = model.MSOdifferentialOrder(mso)
{% endhighlight %}
computes
{% highlight python %}
>> print(zorder)
[2 0]
{% endhighlight %}
which represents that the first known signal, ```y```, is differentiated twice and the second, ```u```, zero times as expected.
You also get, for example, 
{% highlight python %}
>> print(eqorder)
[0, 1, 2, 0, 0, 1]
{% endhighlight %}
which states how many times each of the 6 MSO equations has to be differentiated to be able to derive the ARR.
