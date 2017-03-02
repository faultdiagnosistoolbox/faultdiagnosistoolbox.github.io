---
permalink: /usecase/
layout: single
---
# Use-case -- Diagnosing an automotive engine
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

The measurements/control outputs used, in total 10, are:
* pressure senors (throttle, intake manifold, ambient)
* temperature sensors (throttle, ambient)
* intake air mass flow
* engine speed
* throttle position
* waste-gate position
* commanded amount of injected fuel

And the considered faults, in total 11, are:

* Clogging air filter
* Leakage
  * before compressor
  * after throttle
  * before intercooler
* Stuck intake valve
* Increase turbine friction
* Throttle position sensor
* Sensor faults
  * air mass flow
  * intake manifold pressure
  * pressure before throttle
  * temperature before throttle

<img src="/assets/images/engine/engine_cycle.png" width="55%" align="left" hspace="10" vspace="5"/>
Measurement data, obtained from a standard production engine and used
in the evaluation is measured at a sampling frequency of 1 kHz for an engine
with load conditions corresponding to a car driving the EPA
Highway Fuel Economy Test Cycle.


<div style="text-align: right; font-size: 12pt;">« <a href="/_pages/usecase_modelling">Next Page</a> »</div>
