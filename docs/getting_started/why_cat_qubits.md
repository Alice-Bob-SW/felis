# What is a cat qubit? What is it good for?

![cat_qubits_presentation](../media/getting_started/working_with_cat_qubits/cat_qubit_presentation.png)

Cat qubits are superconducting qubits which are particularly well-suited to implementing error correction, since they can advantageously trade bit-flip errors for phase-flip errors.

When tuning a specific parameter (the average number of the photons in the cat qubit), the frequency of bit-flip errors decreases exponentially, while the frequency of phase-flip errors increases only linearly.

This “biased noise” makes it possible to virtually eliminate bit-flip errors, while keeping phase-flip errors below the error correction threshold.

This in turn enables much simpler error correction schemes: because there’s virtually only one type of error to correct, you can use a simple repetition code, instead of a surface code that requires far more qubits.

Several physical qubits running a repetition code can then become a “logical qubit”, featuring a much lower error rate than any of the physical qubits it is made of.

Using cat qubits, we estimate we can build a fault-tolerant quantum computer [requiring 60 fewer qubits](https://arxiv.org/abs/2302.06639) than if we were using transmons.

To learn more about the physics of cat qubits, you can read our seminal paper at [https://www.nature.com/articles/s41567-020-0824-x](https://www.nature.com/articles/s41567-020-0824-x) or [https://arxiv.org/abs/1907.11729](https://arxiv.org/abs/1907.11729).