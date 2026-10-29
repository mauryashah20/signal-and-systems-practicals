# Signals and Systems Practicals

A comprehensive repository containing MATLAB implementations for **Signals and Systems** laboratory experiments and practicals.

---

## 📚 Contents

| Practical | Title / Topic | Key Concepts |
|:---:|:---|:---|
| **[Practical 1](practical_1.m)** | **Introduction to MATLAB Environment** | Basic arithmetic, Continuous-time sine waves, Discrete-time cosine waves, Subplots and visualization. |
| **[Practical 2](practical_2.m)** | **Elementary Continuous & Discrete Signals** | Unit impulse $\delta[n]$, Unit step $u(t)$, Ramp $r(t)$, Signum $\text{sgn}(t)$, and signal transformations (shifting, scaling, reversal). |
| **[Practical 3](practical_3.m)** | **Periodic & Aperiodic Waveform Generation** | Sine/cosine, Sinc function, Triangular waveforms, Rectangular pulses, Sawtooth waveforms, and Exponential signals. |
| **[Practical 4](practical_4.m)** | **System Properties Verification** | Linearity ($T\{a x_1 + b x_2\} = a T\{x_1\} + b T\{x_2\}$), Time-Invariance, and BIBO Stability analysis ($\sum |h[n]| < \infty$). |
| **[Practical 5](practical_5.m)** | **Discrete-Time Linear Convolution** | Custom convolution algorithm implementation and verification against MATLAB's built-in `conv` function. |
| **[Practical 6](practical_6.m)** | **Impulse Response, Filtering & Frequency Response** | System analysis using `impz`, `filter`, and `freqz` functions on difference equations. |
| **[Practical 7](practical_7.m)** | **Fourier Series Waveform Synthesis** | Harmonic synthesis and reconstruction of Square, Sawtooth, and Triangular periodic waves. |
| **[Practical 8](practical_8.m)** | **Time-Domain Convolution vs. FFT Multiplication** | Verification of convolution property of Fourier Transform ($x_1[n] * x_2[n] \leftrightarrow X_1(e^{j\omega}) \cdot X_2(e^{j\omega})$) using FFT/IFFT. |
| **[Practical 9](practical_9.m)** | **Auto-Correlation & Cross-Correlation** | Energy/Power signal correlation, periodicity detection, and Time Delay Estimation (TDE) via cross-correlation peaks. |
| **[Practical 10](practical_10.m)** | **LTI System Convolution, Z-Domain & Deconvolution** | Direct linear convolution, Z-transform inverse response, matrix deconvolution (inverse filter design), and step response steady-state analysis. |

---

## 🚀 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/mauryashah20/signal-and-systems-practicals.git
   ```
2. Open MATLAB or GNU Octave.
3. Navigate to the cloned directory:
   ```matlab
   cd('signal-and-systems-practicals')
   ```
4. Run any practical script in the MATLAB Command Window or Editor:
   ```matlab
   run('practical_1.m')
   ```

---

## 🛠 Prerequisites

- MATLAB (R2018b or later recommended) or GNU Octave
- Signal Processing Toolbox (optional, scripts contain standalone fallback implementations)

