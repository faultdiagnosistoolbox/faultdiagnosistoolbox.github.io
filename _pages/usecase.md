---
permalink: /usecase/
layout: single
title: Use case -- Fault Diagnosis Toolbox
---
# Use-case -- Diagnosing an automotive engine
This use-case is taken from the conference paper
> E. Frisk, M. Krysander, and D. Jung "_A Toolbox for Analysis and Design of
> Model Based Diagnosis Systems for Large Scale Models_", IFAC World Congress,
> Toulouse, France, 2017.

where the interested reader can find more complete explanations and a full set of references
to explained used concepts and methods.

<img src="/assets/images/engine/engine.jpg" width="45%" align="right" hspace="10" vspace="5"/>
The air-path of an automotive gasoline engine is important for
understanding how much fuel to inject, how to keep combustion emissions low,
protect exhaust catalysts, and optimize efficiency. This system is not only
industrially relevant, it is also an interesting system for academic basic
research due to its complexity, its highly interconnected subsystems due to turbocharging, and
challenging to model accurately. The model used here is based on a control oriented model of the air-path
consisting of pressure dynamics that describe flows and thermodynamic relations to
describe temperatures and heat flows. The model has 94 equations and
14 states. The model is highly non-linear, has
external, mapped, functions implemented as lookup-tables, and hybrid
mode-switching statements (if-statements).

The measurements/control outputs used, in total 10, are: pressure sensors
(throttle, intake manifold, ambient), temperature sensors (throttle, ambient),
intake air mass flow, engine speed, throttle position, waste-gate position, and
commanded amount of injected fuel. The considered faults, in total 11, are:
Clogging of the air filter, leakages (before compressor, after throttle,
before intercooler), stuck intake valve, increased turbine friction,
sensors (throttle position, air mass flow, intake manifold pressure,
pressure before throttle, temperature before throttle)

<img src="/assets/images/engine/engine_cycle.png" width="55%" align="left" hspace="10" vspace="5"/>
Measurement data is obtained in an engine test cell at [Vehicular Systems](http://www.fs.isy.liu.se/).
The engine, a standard production engine, is equipped with a development control system
and subjected to load conditions corresponding to a car driving the EPA Highway Fuel Economy Test Cycle.
Engine operation is thus transient, although not violently so, and correct handling
of dynamic engine behavior in the diagnosis system is essential. The objective is then to,
during normal operation, detect and isolate the faults with a given false alarm probability and
optimize detection performance.

<div style="text-align: right; font-size: 12pt;">« <a href="/_pages/usecase_modelling">Next Page</a> »</div>
