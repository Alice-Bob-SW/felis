# Frequently asked questions

## What can I do with a single qubit?

You will of course not run useful algorithms, but you can benchmark the qubit's performance.

For example, you may:

- Measure the qubit's bit-flip and phase-flip lifetime
- Measure SPAM (State Preparation And Measurement) fidelity
- Measure gate fidelities 

All these measurements can be made with different values of `average_nb_photons`, to verify that adding photons affects performance in the way predicted by theory (exponential improvement of bit-flip performance and linear decrease of phase-flip performance).

See the following notebook for a few examples **(link to add)**

## Why do physical backends not support Hadamard gates?

A very important property of cat qubits is their biased noise: their bit-flip lifetime is much longer than their phase-flip lifetime. This property makes it possible to use much simpler quantum error correction codes.

But the Hadamard gate breaks this property: because it transforms the $\ket{+}$ state into the $\ket{0}$ state, it transforms a phase-flip into a bit-flip, therefore shortening the bit-flip lifetime. We say that the Hadamard gate is not "bias-preserving".

While it would be technically possible to implement a Hadamard gate on physical cat qubits, we choose not to do it and we implement error correction using only bias-preserving gates. We then apply Hadamard gates on error-corrected logical qubits.

But on a physical backend, even without a Hadamard gate, you may: 

- Initialize a qubit in the $\ket{+}$ state using `initalize('+', qubit_index)`
- Perform a X measurement using `measure_x(qubit_index, clbit_index)`

## When will a multi-qubit chip be available in Felis Cloud?

Probably not before 2025. But we are already working on it and will keep you updated.

## When will pulse-level access be available?

We are looking into this. If you have experiments in mind, please [contact us!](../contact_us.md).