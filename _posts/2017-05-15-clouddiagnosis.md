---
title:  "Combined model based and data-driven diagnosis in a cloud"
date:   2017-05-15 15:00:00 +0100
---

A short video and demo of a conceptual, proof of concept, implementation
combining model based and data-driven techniques in a cloud setting.
The on-board system code is generated using the toolbox.

The use-case is diagnosis of an automotive engine and
experimental data from an automotive engine is used in the evaluation. For more
details, see the [use-case](/usecase).

<img src="/assets/images/cloudsystem_overview.png" width="60%" align="right"  hspace="10" vspace="5"/>
The implementation of the system consists of three main parts:
1. An on-board diagnosis system; A model-based diagnosis system written in C++.
The core diagnosis code is automatically generated using the fault diagnosis
toolbox at [faultdiagnosistoolbox.github.io](https://faultdiagnosistoolbox.github.io).

2. A cloud system based on [Django](https://www.djangoproject.com),
Machine-learning in Python/[scikit-learn](http://scikit-learn.org/stable/),
a Postgres database, and an NGINX web server

3. A web interface written in Javascript

An overview of the cloud system module is showed by the figure below.
<center>
<img src="/assets/images/cloudsystem_cs.png" width="60%" align="center"  hspace="10" vspace="5"/>
</center>
<p>
Below is a video with a description of the system in operation, illustrated using two use-cases
</p>
<p>
<iframe id="ytplayer" type="text/html" width="640" height="360"
  src="https://www.youtube.com/embed/MGB6E5KZgKc"
  frameborder="0"></iframe>
</p>
Project responsible Erik Frisk (erik.frisk@liu.se)

Implementation by students @ Linköping University

* Linus Ahlénius (Electrical Engineering)
* Fredrik Björklund (Mechanical Engineering)
* Sven Engström (Electrical Engineering)
* Daniel Fahlén (Electrical Engineering)
* Elina Fantenberg (Electrical Engineering)
* Nils Larsén (Mechanical Engineering)
* Oskar Lindahl (Electrical Engineering)
* Lage Ragnarsson (Electrical Engineering)
