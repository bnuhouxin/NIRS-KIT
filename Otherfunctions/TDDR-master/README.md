# Temporal Derivative Distribution Repair (TDDR)
![TDDR demonstration](https://raw.githubusercontent.com/frankfishburn/TDDR/master/demo.png)
## About
The code within this repository is the reference implementation for the TDDR algorithm as described in:

Fishburn F.A., Ludlum R.S., Vaidya C.J., & Medvedev A.V. (2019). Temporal Derivative Distribution Repair (TDDR): A motion correction method for fNIRS. _NeuroImage_, 184, 171-179. doi: [10.1016/j.neuroimage.2018.09.025](https://doi.org/10.1016/j.neuroimage.2018.09.025)

---
## Usage
Matlab:
```Matlab
signals_corrected = TDDR(signals, sample_rate);
```

Python:
```Python
from TDDR import TDDR
signals_corrected = TDDR(signals, sample_rate);
```

### Inputs
**signals**: A [sample x channel] matrix of uncorrected optical density data

**sample_rate**: A scalar reflecting the rate of acquisition in Hz

### Outputs
   **signals_corrected**: A [sample x channel] matrix of corrected optical density data

---
## Toolboxes
#### NIRS Brain AnalyzIR
The TDDR algorithm is implemented in the `nirs.modules.TDDR` module. Typical usage looks like this:
```matlab
% Construct preprocessing job with TDDR motion correction
job = nirs.modules.OpticalDensity();
job = nirs.modules.TDDR(job);
job = nirs.modules.BeerLambertLaw(job);

% Run job on raw data
hb = job.run(raw);
```
#### Homer2
While Homer2 does not yet contain the TDDR method, a Homer2-compatible script is available in this repository at `toolboxes/Homer2/hmrMotionCorrectTDDR.m`. Usage is similar to other motion correction scripts shipped by Homer2.
