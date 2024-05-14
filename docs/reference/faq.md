# Frequently asked questions

## What can I do with a single qubit?

You will of course not run useful algorithms, but you can benchmark the qubit's performance.

For example, you may:

- Measure the qubit's bit-flip and phase-flip lifetime
- Measure SPAM (State Preparation And Measurement) fidelity
- Measure gate fidelities 

All these measurements can be made with different values of `average_nb_photons`, to verify that adding photons affects performance in the way predicted by theory (exponential improvement of bit-flip performance and linear decrease of phase-flip performance).

See [the following notebook](https://github.com/Alice-Bob-SW/felis/blob/main/samples/1_hardware_experiments/2%20-%20Boson%204%20tutorial.ipynb) for a few examples

## Measuring long bit-flip lifetimes takes hours. How can I make this shorter?

Currently, the only way to measure a bit-flip lifetime is to repeat a few thousand times some experiments whose duration is comparable to the lifetime we want to measure, as shown in [this notebook](https://github.com/Alice-Bob-SW/felis/blob/main/samples/1_hardware_experiments/1%20-%20Bit-flip%20and%20phase-flip%20scaling%20on%20a%20physical%20qubit.ipynb) for example.

Although this is an acceptable method when the lifetime is measured in microseconds, this is no longer practical when the lifetime reaches several minutes with chips such as [Boson 4](../reference/boson_4_chips.md). At high numbers of photons, getting a reliable measurement may take several hours, sometimes even a full day.

We're working on introducing the "real-time trajectories" protocol featured in [our recent Nature paper](https://www.nature.com/articles/s41586-024-07294-3) ([arXiv link](https://arxiv.org/abs/2307.06617)), which will greatly reduce the time needed to measure long bit-flip lifetimes.

## Boson 4's phase-flip performance is disappointing. Is there any chance it will improve?

There are two things to consider here:

- X readout fidelity
- Phase-flip lifetime

The most visible issue is the X readout fidelity, which can be witnessed when measuring SPAM fidelity with a "Prepare $\ket{+}$ - Measure $X$" sequence. Our transmon-free X readout technique was introduced in [our recent Nature paper](https://www.nature.com/articles/s41586-024-07294-3) ([arXiv link](https://arxiv.org/abs/2307.06617)), as a first of its kind. It enabled us to reach very long bit-flip lifetimes, but it still lacks optimization. We must however optimize it so it can be used in a phase-flip QEC scheme. This is why:

- We are currently developing new transmon-free readout techniques that will enable us to reach below threshold operation.
- We may open pulse-level access to a Boson 4 chip to accelerate the discovery of new techniques. [Let us know](../contact_us.md) if you are interested in a collaboration.

Concerning the phase-flip lifetime:

- We are currently working on our nanofabrication to increase the resonators T1s.
- We are also implementing stronger stabilization techniques that will make our qubit gates faster and hence less error prone.

All of this is work in progress and we are looking forward to sharing our progress by making new chips available on Felis Cloud.

## Why are Felis Cloud jobs limited to 15 minutes?

Since there is only one Boson 4 chip available, limiting job duration ensures that the chip will not be blocked by a single user for a long period of time.

If you need exclusive access to the chip for a long period of time, please [contact us](../contact_us.md).

## Why do physical backends not support Hadamard gates?

A very important property of cat qubits is their biased noise: their bit-flip lifetime is much longer than their phase-flip lifetime. This property makes it possible to use much simpler quantum error correction codes.

But the Hadamard gate breaks this property: because it transforms the $\ket{+}$ state into the $\ket{0}$ state, it transforms a phase-flip into a bit-flip, therefore shortening the bit-flip lifetime. We say that the Hadamard gate is not "bias-preserving".

While it would be technically possible to implement a Hadamard gate on physical cat qubits, we choose not to do it and we implement error correction using only bias-preserving gates. We then apply Hadamard gates on error-corrected logical qubits.

But on a physical backend, even without a Hadamard gate, you may: 

- Initialize a qubit in the $\ket{+}$ state using `initialize('+', qubit_index)`
- Perform a X measurement using `measure_x(qubit_index, clbit_index)`

## When will a multi-qubit chip be available in Felis Cloud?

Probably not before 2025. But we are already working on it and will keep you updated. In the mean time, we will release updates to Boson 4 to broaden the range of experiments which can be performed with it.

## When will pulse-level access be available?

We are looking into this. If you have experiments in mind, please [contact us!](../contact_us.md).