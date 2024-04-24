# Working with cat qubits: similarities & differences

In this page, we will assume that you are familiar with transmon qubits like the ones found in IBM systems, and that you have already run circuits using Qiskit.

# TL;DR

## What stays the same:

- You design and run quantum circuits made out of gates and qubits using Qiskit
- You can use most if not all of the gates you are used to (at least in logical mode, see below)

## What is different:

- There are two modes: physical and logical
    - The physical mode mimicks the behavior of physical qubits and features a limited set of gates. Error correction, logical qubits, and logical gates are implemented on top of physical qubits. In this mode:
        - Qubits feature a biased noise (fewer bit-flip errors, more phase-flip errors compared to a regular transmon)
        - You can only use a limited set of gates (so-called “bias-preserving” gates)
        - Additional native operations are available (prepare |+> or |->, measure along the X axis)
        - The chip can be tuned to use a different tradeoff between bit-flip and phase-flip errors
    - The logical mode mimicks the behavior of logical qubits (error-corrected abstract qubits made of several physical qubits). The logical mode features a universal set of gates and is used to run algorithms. In this mode:
        - You can use virtually any gate
        - You get all-to-all connectivity and a very low error rate
        - The noise bias is reduced if not completely eliminated

# What is a cat qubit? What is it good for?

![cat_qubits_presentation](../media/getting_started/working_with_cat_qubits/cat_qubit_presentation.png)

Cat qubits are superconducting qubits which are particularly well-suited to implementing error correction, since they can advantageously trade bit-flip errors for phase-flip errors.

When tuning a specific parameter (the average number of the photons in the cat qubit), the frequency of bit-flip errors decreases exponentially, while the frequency of phase-flip errors increases only linearly.

This “biased noise” makes it possible to virtually eliminate bit-flip errors, while keeping phase-flip errors below the error correction threshold.

This in turn enables much simpler error correction schemes: because there’s virtually only one type of error to correct, you can use a simple repetition code, instead of a surface code that requires far more qubits.

Several physical qubits running a repetition code can then become a “logical qubit”, featuring a much lower error rate than any of the physical qubits it is made of.

Using cat qubits, we estimate we can build a fault-tolerant quantum computer [requiring 60 fewer qubits](https://arxiv.org/abs/2302.06639) than if we were using transmons.

To learn more about the physics of cat qubits, you can read our seminal paper at [https://www.nature.com/articles/s41567-020-0824-x](https://www.nature.com/articles/s41567-020-0824-x) or [https://arxiv.org/abs/1907.11729](https://arxiv.org/abs/1907.11729).