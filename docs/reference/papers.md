# Useful scientific papers

## Exponential suppression of bit-flips in a qubit encoded in an oscillator

The first paper you'll want to read about cat qubits is the seminal paper by our CTO and co-founder Raphaël Lescanne. It explains the physics of cat qubits and shows a first experimental realization, which led to the foundation of Alice & Bob.

The chip in this paper is now called "Boson 1".

- Nature: [https://www.nature.com/articles/s41567-020-0824-x](https://www.nature.com/articles/s41567-020-0824-x)
- arXiv (in case you don't have a Nature subscription): [https://arxiv.org/abs/1907.11729](https://arxiv.org/abs/1907.11729)

## Repetition Cat Qubits for Fault-Tolerant Quantum Computation

Cat qubits are interesting because they make it easy to implement error correction. In this paper by our Chief of Theory Jérémie Guillaud, you'll learn how to implement a repetition code using cat qubits.

- Physical Review X: [https://journals.aps.org/prx/abstract/10.1103/PhysRevX.9.041053](https://journals.aps.org/prx/abstract/10.1103/PhysRevX.9.041053)

## One hundred second bit-flip time in a two-photon dissipative oscillator

While the bit-flip lifetime of the chip in Raphaël Lescanne's seminal experiment was limited to 1 ms, we found ways to extend this figure by several orders of magnitude. In this paper by Camille Berdou et al., we show how we can take the bit-flip lifetime to over 10" by removing the transmon used for measuring the cat qubit's state.

The chip in this paper is now called "Boson 2".

- arXiv: [https://arxiv.org/abs/2204.09128](https://arxiv.org/abs/2204.09128)

## Quantum control of a cat-qubit with bit-flip times exceeding ten seconds

"Boson 2" showed very promising bit-flip lifetimes, but it lacked a protocol to measure phase-flips. This paper by Ulysse Réglade et al. introduces a new measurement protocol and a new chip, making it possible to witness macroscopic bit-flip lifetimes (over 10 seconds) while retaining the ability to measure phase-flips.

The chip in this paper is now called "Boson 3".

- arXiv: [https://arxiv.org/abs/2307.06617](https://arxiv.org/abs/2307.06617)

## Autoparametric Resonance Extending the Bit-Flip Time of a Cat Qubit up to 0.3 s

In parallel, we also explore better transmon-based designs, such as AutoCat which reached a 0.3 s bit-flip lifetime.

- Physical Review X: [https://journals.aps.org/prx/abstract/10.1103/PhysRevX.14.021019](https://journals.aps.org/prx/abstract/10.1103/PhysRevX.14.021019)

## Performance Analysis of a Repetition Cat Code Architecture: Computing 256-bit Elliptic Curve Logarithm in 9 Hours with 126133 Cat Qubits

The reason why we invest in cat qubits is that they make it possible to reach the very low error rates required to run quantum computing's landmark algorithms. In this paper by Élie Gouzien et al., we describe the architecture of a fault-tolerant computer which can run Shor's algorithm using 60x fewer qubits than an architecture using transmons and a surface code.

- arXiv: [https://arxiv.org/abs/2302.06639](https://arxiv.org/abs/2302.06639)

## LDPC-cat codes for low-overhead quantum computing in 2D

And finally, our latest theoretical breakthrough is the adaptation of LDPC codes to cat qubits, which further reduces the number of qubits needed to run useful algorithms. In this paper by Diego Ruiz et al., written in collaboration with Inria, we show how to implement 100 logical qubits with only 1,500 physical qubits, or run Shor's algorithm with 200x fewer qubits than transmons with a surface code.

- arXiv: [https://arxiv.org/abs/2401.09541](https://arxiv.org/abs/2401.09541)