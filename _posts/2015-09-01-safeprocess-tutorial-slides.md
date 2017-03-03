---
title:  "Slides from our Safeprocess'2015 pre-symposium tutorial"
date:   2015-09-01 16:16:00 -0600
---
On September 1, me and Mattias Krysander held a pre-symposium tutorial
at Safeprocess'2015 in Paris, France.


The title of the tutorial was "Structural Methods for Analysis and Design of
Large-Scale Diagnosis Systems" and slides is found here
([4 slides/page](/assets/pdfs/safe15_tutorial_4.pdf),
[1 slide/page](/assets/pdfs/safe15_tutorial_1.pdf))

## Abstract
Real applications are often complex and model-based techniques for diagnosis
are therefore often faced with a general, large-scale, and non-linear
differential-algebraic model, possibly in high level languages like Simulink
or Modelica consisting of hundreds or thousands of equations. Such complex
models often require specialized techniques for specific classes of systems.
One successful way to manage the complexity, and to provide a generally
applicable approach, is to utilize the model structure using graph based
algorithms. Structural analysis has proven to be a powerful tool for
generating fault detection signals/residuals and early determination of fault
isolability properties.  

There are three main objectives of this tutorial workshop:

1. Formally introduce structural models and fundamental diagnosis definitions
2. Derive algorithms for analysis of models and diagnosis systems
- Introduction of fundamental graph-theoretical tools, e.g., Dulmage-Mendelsohn decomposition of bi-partite graphs
- Determination of fault isolability properties of a model
- Determination of fault isolability properties of a diagnosis system
- Finding sensor locations for fault diagnosis
3. Derive algorithms for design of residual generators
- Finding all minimal submodels with redundancy
- Generating residuals based on submodels with redundancy

The above techniques will be illustrated on industrial sized examples in Matlab.
Also, relations to other research fields, challenges, and future research topics will be discussed.
