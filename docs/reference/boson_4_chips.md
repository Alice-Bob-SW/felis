# Boson 4 chips

## The Boson 4 design

Boson 4 is part of the “Boson” series of chip designs, meant to demonstrate promising ways of implementing [cat qubits](../getting_started/why_cat_qubits.md).

![A Boson 4 chip](../media/backends/boson4.png)

Just like its two predecessors, Boson 4 is a transmon-free design. This enables it to reach very long bit-flip lifetimes (up to 276 seconds measured in Alice & Bob’s lab).

As its name suggests, Boson 4 follows three previous designs:

- [Boson 1](https://www.nature.com/articles/s41567-020-0824-x) is the design which started Alice & Bob. It demonstrated the possibility to exponentially suppress bit-flips, while only linearly increasing phase-flips. Its bit-flip lifetime however saturated at 1 ms, due to the presence of a transmon in the experimental setup.
- [Boson 2](https://arxiv.org/abs/2204.09128) showed it is possible to take bit-flip lifetime up to 100 seconds by removing the transmon from the setup. This design however lacked the possibility to measure phase-flips.
- [Boson 3](https://arxiv.org/abs/2307.06617) improved upon Boson 2 by introducing a new readout protocol making it possible to do transmon-free measurements along the X and the Z axis. Its bit-flip lifetime reached over 10 seconds.

Boson 4 uses the same readout protocols as Boson 3, but manages to reach longer bit-flip lifetimes than any of its predecessors.

A Boson 4 chip features two independent cat qubits, which are not coupled with one another.

We are currently working on a paper giving a more detailed description of the Boson 4 design.

## Available Boson 4 backends

You may run circuits on a Boson 4 chip using the [`QPU:1Q:BOSON_4A`](../backends/backends_list/boson_4a.md) backend ([Felis Cloud](../felis_cloud/about_felis_cloud.md) subscription required).

## Main performance figures

The figures below can all be reproduced using **this notebook (link to add)**

### Lifetime

These figures represent the chip's bit-flip and phase-flip lifetime.

When preparing the $\ket{0}$ state, the probability of a Z measurement yielding 0 after a delay of duration $t$ decays as $\exp(-t/T_{bf})$, where $T_{bf}$ is the bit-flip lifetime.

When preparing the $\ket{+}$ state, the probability of an X measurement yielding + after a delay of duration $t$ decays as $\exp(-t/T_{pf})$, where $T_{pf}$ is the phase-flip lifetime.

💡 **Note:** if you're used to working with transmons, you know that state decay only happens if you start from the $\ket{1}$ state. With cat qubits, the $\ket{0}$ and $\ket{1}$ states are virtually interchangeable. Experimental differences might remain, but they're mostly due to sampling noise and calibration inaccuracies.

|  | average_nb_photons = 4 | average_nb_photons = 16 |
| --- | --- | --- |
| Bit-flip | 1 ms | > 100 seconds |
| Phase-flip | 2 µs | 0.5 µs |

💡 **Note:** Measuring lifetimes over 100 seconds is challenging using repeated measurements and a chip shared between users:

- Doing 1000 shots of a 100-second experiment takes almost 28 hours
- Doing shorter experiments yields too few errors; this requires using more shots and does not make experiments significantly shorter

We are working on adding the “real-time trajectories” protocol described in [this paper](https://arxiv.org/pdf/2307.06617.pdf), which enables shorter measurements.

### SPAM errors

These figures represent sequence error (# shots giving the expected result / # of shots).

| Sequence | average_nb_photons = 4 | average_nb_photons = 16 |
| --- | --- | --- |
| P0 - Mz | 2 % | < 0.001 % |
| P+ - Mx | 38 % | 47 % |

💡 **Note:** As you notice, while this chip's bit-flip performance is stellar, the phase-flip performance is still somewhat underwhelming. Cat qubit architectures are less demanding regarding qubit quality (a repetition code has a higher threshold than a surface code), but phase-flip performance still needs to improve by 1 to 2 orders of magnitude for error correction to work reliably. We are focused on improving this, with several promising solutions being tested in our lab. Stay tuned!

### Z gate performance

These figures represent the probability of getting a bit-flip or phase-flip during a Z-gate.

|  | average_nb_photons = 4 | average_nb_photons = 16 |
| --- | --- | --- |
| Bit-flip | 0.15 % | < 0.001 % |
| Phase-flip | 20 % | 40 % |

### Chip parameters

These parameters were measured in Alice & Bob’s lab and cannot be reproduced using Felis.

| Metric | Measured value | Comments |
| --- | --- | --- |
| f_a | 1.079 GHz |  |
| f_b | 7.898 GHz |  |
| κ_1/2π | 2.26 kHz | Bare kappa_1 measured |
| κ_1_eff/2π | not measured | Effective kappa_1 (under pump) |
| κ_b/2π | 22 MHz |  |
| κ_2/2π | 250 kHz |  |
| g_2/2π | 1.2 MHz | quote here phi_pump simulated |
| K/2π | -12 kHz |  |
| κ_φ/2π | ... kHz | the measurement is broken at the moment (04/24). Could be replaced with T2R and T1 (wip) |
| n_th | 2 |  |
| n_th_buffer | not measured | we don't know how to measure it at the moment (03/24) |

## Gate implementation details

To be retrieved from the datasheet when it is validated

Include the experiment verifying that the Z gate is bias-preserving