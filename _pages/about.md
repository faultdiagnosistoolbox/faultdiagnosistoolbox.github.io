---
permalink: /about/
layout: single
title: About -- Fault Diagnosis Toolbox
---
<h1>A Fault Diagnosis Toolbox for Dynamic Systems in Matlab</h1>
Fault Diagnosis Toolbox is a Matlab toolbox for analysis and design of
fault diagnosis systems for dynamic systems, primarily described by
differential equations.  In particular, the toolbox is focused on
techniques that utilize structural analysis, i.e., methods that
analyze and utilize the model structure. The model structure is the
interconnections of model variables and is often described as a
bi-partite graph or an incidence matrix.

Contributors:
* [Erik Frisk](http://users.isy.liu.se/en/fs/frisk/) (<erik.frisk@liu.se>) -- main designer
* [Mattias Krysander](http://users.isy.liu.se/en/fs/matkr/) (<mattias.krysander@liu.se>)
* [Daniel Jung](http://users.isy.liu.se/en/fs/daner/) (<daniel.jung@liu.se>)

Key features of the toolbox are:
*  Finding overdetermined sets of equations (MSO sets), which are minimal
    submodels that can be used to design fault detectors
*  Diagnosability analysis - analyze a given model to determine which
    faults that can be detected and which faults that can be isolated
*  Sensor placement - determine minimal sets of sensors needed to be able
    to detect and isolate faults
*  Code generation (C++ and Matlab) for residual generators. Two different
    types of residual generators are supported, sequential residual generators
    based on a matching in the model structure graph, and observer based
    residual generators.

The toolbox relies on the object-oriented functionality in the Matlab
language and is freely available under a MIT license. The latest version of the
software can always be downloaded from <https://faultdiagnosistoolbox.github.io/>.
