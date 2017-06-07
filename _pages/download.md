---
permalink: /download/
layout: single
title: About -- Download & Installation
---
<script type="text/javascript">
window.onload = function() {

  var a = document.getElementById("downloadlink");

  //Set code to run when the link is clicked
  // by assigning a function to "onclick"
  a.onclick = function() {

    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-92989843-1', 'auto');
    ga('send', 'event', 'Toolbox', 'download');

    //If you don't want the link to actually
    // redirect the browser to another page,
    // "google.com" in our example here, then
    // return false at the end of this block.
    // Note that this also prevents event bubbling,
    // which is probably what we want here, but won't
    // always be the case.
    return true;
  }
}


</script>
<h1>Download and Installation</h1>

The latest version of the package can always be obtained from this page
(<https://faultdiagnosistoolbox.github.io/>). The current version of the toolbox
can be found in the zip-archive <a href="/_releases/FaultDiagnosisToolbox_2017-06-07.zip" id="downloadlink">FaultDiagnosisToolbox_2017-06-07.zip</a>
and the current documentation (also included in the zip file) [documentation](/_releases/user-manual_2017-06-07.pdf).

The toolbox requires a Matlab v7.6 (R2008a) or later for the object-oriented functionality.
Main functionality also requires the [Symbolic Toolbox](https://www.mathworks.com/products/symbolic.html)
version 7.14 (2012a) or later.

### References
If you use this toolbox in your research, please cite
> Erik Frisk, Mattias Krysander, and Daniel Jung. "_A Toolbox for Analysis and Design of
Model Based Diagnosis Systems for Large Scale Models_" IFAC World Congress, 2017.
Toulouse, France, 2017.

You can also find more references to related work on our [references](/references) page.

## Installation

The installation procedure is very simple:
* Uncompress the zip-file
*  Add the src directory to the Matlab-path
* (optional) There are C++ implementations of some computationally
  expensive algorithms. It is not necessary to compile these for the
  toolbox to work, there are Matlab implementations directly
  installed. However, with the compiled versions there might be
  significant increases in performance. See below for instructions

After the installation, head to the `examples` directory to try out functionality or
look in the [tutorials](/tutorial/) section of this site.

## Compiled implementations

To compile the C++ sources, it is required that a functioning compiler
is installed and configured for use with Matlab. Instructions below
are directly applicable for Linux/MacOS systems. There are binaries
included in the distribution if you do not want to compile the sources
yourself. In the directory `binaries` there are compiled files
for 64 bit Linux and MacOS. Copy the files corresponding to your system
into the `src` directory and hope for the best.

There are two algorithms that have C++ implementations; minimal hitting set and
an MSO algorithm.

### Minimal Hitting Set
To compile, open Matlab and go to the `src` directory. To
compile, type (output from an
MacOS system)
{% highlight matlab %}
>> mex MHScompiled.cc
Building with 'Xcode Clang++'.
MEX completed successfully.
{% endhighlight %}

Verify that everything has worked by

{% highlight matlab %}
>> exist('MHSCompiled')

ans =

     3
{% endhighlight %}
The use of the compiled algorithm is optional, full functionality is
obtained with the Matlab implementation of the minimal hitting set
algorithm.

### MSO algorithm

The MSO algorithm uses a library for computing with sparse
matrices. The sparse matrix library is part of the software SuiteSparse and can be
downloaded from <http://faculty.cse.tamu.edu/davis/suitesparse.html>. You do not
have to compile and install the entire SuiteSparse library, only the
CSparse part. The CSparse source is included in the zip-archive.

To install on a Linux or a MacOS system with developer tools installed,
go to the CSparse directory and write at a terminal prompt, not in Matlab:
{% highlight bash %}
> cd CSparse
> make
{% endhighlight %}

When the CSParse library is compiled, open Matlab and go to the `src` directory and type:
{% highlight matlab %}
%% Specify installation directory for CSparse
CSPARSEDIR = '../CSparse';

% Derive include and lib directory
CSPARSEINC=['-I' fullfile(CSPARSEDIR, '/Include')];
CSPARSELIB=['-L' fullfile(CSPARSEDIR, '/Lib')];

%% Compile sources and link mex-file

mex('-c', '-largeArrayDims', CSPARSEINC,'MSOAlg.cc');
mex('-c', '-largeArrayDims', CSPARSEINC,'SparseMatrix.cc');
mex('-c', '-largeArrayDims', CSPARSEINC,'StructuralAnalysisModel.cc');
mex('-c', '-largeArrayDims', CSPARSEINC,'FindMSOcompiled.cc');

% Link
mex(CSPARSELIB, 'FindMSOcompiled.o', 'SparseMatrix.o', 'StructuralAnalysisModel.o', 'MSOAlg.o', '-lcsparse');

%Specify installation directory for CSparse
CSPARSEDIR = '[INSTALLATIONDIR]';

% Derive include and lib directory
CSPARSEINC=['-I' fullfile(CSPARSEDIR, '/Include')];
CSPARSELIB=['-L' fullfile(CSPARSEDIR, '/Lib')];

% Compile sources
mex('-c', '-largeArrayDims', CSPARSEINC,'MSOAlg.cc');
mex('-c', '-largeArrayDims', CSPARSEINC,'SparseMatrix.cc');
mex('-c', '-largeArrayDims', CSPARSEINC,'StructuralAnalysisModel.cc');
mex('-c', '-largeArrayDims', CSPARSEINC,'FindMSOcompiled.cc');

% Link
mex(CSPARSELIB, 'FindMSOcompiled.o', 'SparseMatrix.o', ...
'StructuralAnalysisModel.o', 'MSOAlg.o', '-lcsparse');  
{% endhighlight %}
On a Mac system, you might get warnings when linking due to different
deployment versions used by the Matlab compiler and the compiler used,
``_ld: warning: object file
  (../CSparse/Lib/libcsparse.a(cs_add.o)) was built for newer OSX
  version (10.12) than being linked (10.9)_''. To avoid this warning,
recompile CSparse with the build version of Matlab by setting the
environment variable `MACOSX_DEPLOYMENT_TARGET=10.9` before
running `make` to build CSparse.

Verify that everything has worked and the binary has been generated by
{% highlight matlab %}
>> exist('FindMSOcompiled')

ans =

     3  
{% endhighlight %}

For Linux and MacOS there are pre-compiled versions and to
install, copy the suitable files from the binaries directory into
the src directory.
