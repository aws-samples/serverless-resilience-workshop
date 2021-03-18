# Serverless Resilience Workshop - Source Code

> Note: This source code is intended to be used as part of the lab materials
hosted at [https://resilience.workshop.aws](https://resilience.workshop.aws).

## Overview

The Serverless Resilience Workshop is a series of workshops that walk you
through the process of creating a Chaos experiment to test the resiliency of
a Serverless architecture. During the workshop you establish the steady state
of the application, perturb the application by injecting faults into the
environment, and then observe how the application responds to the turbulence.
You then apply corrections to your architecture to allow it to better perform
in turbulent conditions.

This repository contains the source code which implements, deploys, and
applies load to the application used in the workshop. This source code is
written with intentional errors and is for illustration purposes only. The
code is shared to be used as part of a series of workshops that walk you
through the process of creating a Chaos experiment to test the resiliency of
a Serverless architecture.

## LICENSE

This package depends on and may incorporate or retrieve a number of third-party
software packages (such as open source packages) at install-time or build-time
or run-time ("External Dependencies"). The External Dependencies are subject to
license terms that you must accept in order to use this package. If you do not
accept all of the applicable license terms, you should not use this package. We
recommend that you consult your company’s open source approval policy before
proceeding.

Provided below is a list of External Dependencies and the applicable license
identification as indicated by the documentation associated with the External
Dependencies as of Amazon's most recent review.

THIS INFORMATION IS PROVIDED FOR CONVENIENCE ONLY. AMAZON DOES NOT PROMISE THAT
THE LIST OR THE APPLICABLE TERMS AND CONDITIONS ARE COMPLETE, ACCURATE, OR
UP-TO-DATE, AND AMAZON WILL HAVE NO LIABILITY FOR ANY INACCURACIES. YOU SHOULD
CONSULT THE DOWNLOAD SITES FOR THE EXTERNAL DEPENDENCIES FOR THE MOST COMPLETE
AND UP-TO-DATE LICENSING INFORMATION.

YOUR USE OF THE EXTERNAL DEPENDENCIES IS AT YOUR SOLE RISK. IN NO EVENT WILL
AMAZON BE LIABLE FOR ANY DAMAGES, INCLUDING WITHOUT LIMITATION ANY DIRECT,
INDIRECT, CONSEQUENTIAL, SPECIAL, INCIDENTAL, OR PUNITIVE DAMAGES (INCLUDING
FOR ANY LOSS OF GOODWILL, BUSINESS INTERRUPTION, LOST PROFITS OR DATA, OR
COMPUTER FAILURE OR MALFUNCTION) ARISING FROM OR RELATING TO THE EXTERNAL
DEPENDENCIES, HOWEVER CAUSED AND REGARDLESS OF THE THEORY OF LIABILITY, EVEN
IF AMAZON HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. THESE LIMITATIONS
AND DISCLAIMERS APPLY EXCEPT TO THE EXTENT PROHIBITED BY APPLICABLE LAW.

* Mitm.js - https://www.npmjs.com/package/mitm - Modified AGPL-3.0
