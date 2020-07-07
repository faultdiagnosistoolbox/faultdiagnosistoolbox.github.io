---
title: "Basic usage and introduction to the Python package"
date:   2020-07-07 12:00:00 +0100
category: tutorial
level: 1
---
This tutorial illustrates basic usage of the python package, gives pointer to some examples, and shows how to install everything on a Linux/MacOS/Windows system.

## Outline
1. Induction motor example
    * [Modelling](#modelling)
    * [Model information, basic plotting, and MSO/MTES](#msomtes)
    * [Isolability analysis](#isolabilityanalysis)
    * [Code generation and residual generation](#resgen)
2. Some more [examples](#examples)
3. [Installation](#installation)



## Induction motor example

To illustrate the functionality, a small induction motor example will be used where the model equations are borrowed from the paper Aguilera, F., et al. "[_Current-sensor fault detection and isolation for induction-motor drives using a geometric approach_](https://doi.org/10.1016/j.conengprac.2016.04.014)", Control Engineering Practice 53 (2016): 35-46. 

<a name="modelling"/>
### Modelling
For reference, the equations are given below
<p>
<!---
  0 &= -q_a + w \lambda_a &   \frac{d}{dt} i_a &= i_a'\\
  0 &= -q_b + w \lambda_b & \frac{d}{dt} i_b &= i_b'\\
  0 &= -i_a' -a i_a + b c \lambda_a + b q_b + d u_a & \frac{d}{dt} \lambda_a &= \lambda_a'\\
  0 &= -i_b' -a i_b + b c \lambda_b + b q_a + d u_b & \frac{d}{dt} \lambda_b &= \lambda_b'\\
  0 &= -\lambda_a' + L_M c i_a - c \lambda_a - q_b\\
  0 &= -\lambda_b' + L_M c i_b - c \lambda_b - q_a\\
  0 &= -w' -k c_f w + k c_t (i_a \lambda_b - i_b \lambda_a) - k T_l\\

  y_1 &= i_a + f_a\\
  y_2 &= i_b + f_b\\
  y_3 &= w  
-->
<img src="/assets/tutorials/induction_motor_model.png" width="80%" align="centering"/>
</p>
There are also three measurement equations, where the two current sensors have modeled faults as
<p>
<img src="/assets/tutorials/induction_motor_model_y.png" width="20%" align="centering"/>
</p>
```python
import faultdiagnosistoolbox as fdt
```

The modeling part is where the main differences between Python and Matlab versions are. This is due to that [SymPy](https://www.sympy.org/) is used instead of the symbolic toolbox in Matlab. Therefore, let's import the toolbox and sympy (and matplotlib since we want to plot)
```python
import matplotlib.pyplot as plt
import faultdiagnosistoolbox as fdt
import sympy as sym
```
Now, we define the model as a python dictionary with keys 
* `type` - type of model, here we are definic a model using symbolic expressions
* `x` - list of unknown variables in the model
* `f` -  list of fault variables
* `z`- list of known variables
* `rels` - list of model equations
* `parameters` - list of parameters (optional)
For the induction motor model, this corresponds to

```python
model_def = {'type': 'Symbolic',
             'x': ['i_a', 'i_b', 'lambda_a', 'lambda_b', 
                   'w', 'di_a', 'di_b', 'dlambda_a', 
                   'dlambda_b', 'dw', 'q_a', 'q_b'],
             'f': ['f_a', 'f_b'], 
             'z': ['u_a', 'u_b', 'y1', 'y2', 'y3', 'Tl'],
             'parameters': ['a', 'b', 'c', 'd', 'L_M',
                            'k', 'c_f', 'c_t']}

# Make symbolic objects of all variables/parameters before writing down equations.
sym.var(model_def['x'])
sym.var(model_def['f'])
sym.var(model_def['z'])
sym.var(model_def['parameters'])

model_def['rels'] = [
  -q_a + w*lambda_a,
  -q_b + w*lambda_b, 
  -di_a + -a*i_a + b*c*lambda_a + b*q_b+d*u_a,
  -di_b + -a*i_b + b*c*lambda_b + b*q_a+d*u_b,
  -dlambda_a + L_M*c*i_a - c*lambda_a-q_b, 
  -dlambda_b + L_M*c*i_b - c*lambda_b-q_a, 
  -dw + -k*c_f*w + k*c_t*(i_a*lambda_b - i_b*lambda_a) - k*Tl,
  fdt.DiffConstraint('di_a','i_a'),
  fdt.DiffConstraint('di_b','i_b'),
  fdt.DiffConstraint('dlambda_a','lambda_a'),
  fdt.DiffConstraint('dlambda_b','lambda_b'),
  -y1 + i_a + f_a,
  -y2 + i_b + f_b,
  -y3 + w]
```
Now, the `DiagnosisModel` object can be created as
```python
model = fdt.DiagnosisModel(model_def, name ='Induction motor')
```
and the API is very close to the Matlab version as described in the documentation. For example, to plot the model structure

<a name="msomtes"/>
### Model information, basic plotting, and MSO/MTES
As before, to display model information and plot model structure, use `Lint` and `PlotModel` class methods
```python
model.Lint()

# Plot model
plt.figure(10)
model.PlotModel()
```
which gives the figure
<p>
<img src="/assets/tutorials/induction_model_struc.png" width="75%" align="centering"/>
</p>
Computing the set of MSO and MTES sets is done as below
```python
# Find set of MSOS
msos = model.MSO()
mtes = model.MTES()

# Check observability and low index for MTES sets
oi = [model.IsObservable(mtes_i) for mtes_i in mtes]
li = [model.IsLowIndex(mtes_i) for mtes_i in mtes]
print(f'Out of {len(mtes)} MTES sets, {sum(oi)} observable, {sum(li)} low (structural) differential index')
```
and the code outputs
```python
Out of 2 MTES sets, 2 observable, 2 low (structural) differential index
```
<a name="isolabilityanalysis"/>
### Isolability analysis
To plot the isolability properties of the model under mixed casaliyu asssumption
```python
# Isolability analysis
model.IsolabilityAnalysis(plot=True, causality='mixed)
```
and to examine in more detail, the Dulmage-Mendelsohn decomposition with a canonical form of the overdetermined subsystem is plotted by
```python
model.PlotDM(fault=True, eqclass=True)
```
which gives the figure
<p>
<img src="/assets/tutorials/induction_dmplot.png" width="85%" align="centering"/>
</p>
For more details, see Mattias Krysander, Jan Åslund, and Mattias Nyberg, "[_An Efficient Algorithm for Finding Minimal Over-constrained Sub-systems
for Model-based Diagnosis_](http://dx.doi.org/10.1109/TSMCA.2007.909555)".
IEEE Transactions on Systems, Man, and Cybernetics -- Part A: Systems and Humans, 38(1), 2008.

<a name="resgen"/>
### Code generation and residual generation
To wrap up this example, let us use one of the MTES sets and generate C++-code for a residual generator. First, let's see which redundant equation that can be used for integral causality residual generation using the `MSOCausalitySweep` class method
```python
model.MSOCausalitySweep(mtes[0])
```
This outputs
```python
['mixed', 'mixed', 'mixed', 'mixed', 'mixed', 'mixed', 'mixed', 'int', 'mixed', 'mixed', 'int', 'mixed']
```
and thus the 11:th element in the first MTES can be used. The 11:th element correspond to the second measurement equation
```python
red_eq = mtes[0][10]
model.syme[red_eq]
Out[50]: Eq(f_b + i_b - y2, 0)
```
Now, get the rest of the equations to form the exactly determined set of equations and compute a mathing using the `Matching` class method
```python
M0 = [e for e in mtes[0] if e != red_eq]
Gamma = model.Matching(M0)
```
Now, all is set to generate the residual generator code using the `SeqResGen` class method
```python
model.SeqResGen(Gamma, red_eq, 'ResGen', batch=True, language='C')
```
which generate files ´ResGen.cc` and `ResGen_setup.py`. Have a look at the `ResGen_core()` function in the generated C++-file and you'll se how things work. The generated code can now be compiled by executing
```bash
python ResGen_setup.py build_ext --inplace
```
in a terminal.

<a name="examples"/>
## More examples
In the distribution, there are a few more examples included. To find where `pip` puts everything, run
```python
fdt.__path__
```
and have a look in the `examples` sub-folder.

<a name="installation"/>
## Installation
The package needs Python version 3.6 or newer, check version with 
```python
python3 --version
```
Now, create a [virtual environment](https://docs.python.org/3/tutorial/venv.html), don't install into the system wide python installation. You can do this as (only needed once) with
```bash
python3 -m venv env
```
and then activate the environment as
```bash
source ./env/bin/activate  # Linux/MacOS
``` 
in MacOS/Linux or if you're on a Windows machine
```
.\env\Scripts\activate  # Windows
```
Also a good idea to update the package manager `pip`
```bash
pip install -U pip
```
Then, install the toolbox 
```bash
pip install faultdiagnosistoolbox
```
and that is that.