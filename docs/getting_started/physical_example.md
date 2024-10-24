# An example with physical qubits

When you use a physical backend, qubit and gates feature the noise characteristics of physical cat qubits. In other words, each qubit of a physical backend corresponds to one qubit on a chip (real or emulated).

Cat qubits feature a strongly biased noise: their bit-flip lifetime can be very long (up to hundreds of seconds), but their phase-flip lifetime is relatively short (a few microseconds).

This property greatly reduces the number of qubits required to implement quantum error correction, up to 200 times as shown in [this article](https://arxiv.org/abs/2401.09541).

💡 **Note:** If you’re not familiar with cat qubits, you may want to read [Working with cat qubits: similarities & differences](working_with_cat_qubits.md) first.

Here's an example using a physical backend, showing how cat qubits feature a biased noise.

First, we set up the provider and import dependencies:

```python
from qiskit import QuantumCircuit
from qiskit.visualization import plot_histogram
from qiskit_alice_bob_provider import AliceBobLocalProvider

ab = AliceBobLocalProvider()
```

Then, we pick a backend to use:

```python
print(ab.backends())
backend = ab.get_backend('EMU:1Q:LESCANNE_2020')
```

Then, we design and execute a simple circuit sensitive to bit-flips (Prepare $\ket{0}$ / Wait / Measure on the Z axis), whose result would always be 0 in a noiseless environment:

```python
# Measure bit-flip errors after 1µs
c1 = QuantumCircuit(1, 1)
c1.delay(1, unit='us')
c1.measure(0, 0)
job1 = backend.run(c1, shots=1000, average_nb_photons=3)
res1 = job1.result()
plot_histogram(res1.get_counts())
```

Then, we replicate the same idea to design and execute a circuit sensitive to phase-flips (Prepare $\ket{+}$ / Wait / Measure on the X axis), whose result should also always be 0 in a noiseless environment:

```python
# Measure phase-flip errors after 1 µs
c2 = QuantumCircuit(1, 1)
c2.initialize('+', 0)
c2.delay(1, unit='us')
c2.measure_x(0, 0)
job2 = backend.run(c2, shots=1000, average_nb_photons=3)
res2 = job2.result()
plot_histogram(res2.get_counts())
```

The second circuit should show far more errors than the first, showing our qubits do have a noise bias: they are strongly protected against bit-flip errors.

Come and show us your results!

## Going further

Now that you understand how things work, you can start having fun.

Here are some ideas of experiments you can run:

- Showcase exponential suppression of bit-flips by varying `average_nb_photons`
- Showcase linear increase of the phase-flip rate by varying `average_nb_photons`
- Measure the bit-flip time
- Measure the phase-flip time

In order to implement these ideas, have a look at the list of [Supported instructions](../reference/supported_instructions.md).

You may also look at our [sample notebooks](sample_notebooks.md) for more inspiration.