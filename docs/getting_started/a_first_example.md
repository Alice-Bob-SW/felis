# Running Qiskit programs: a first example

Here’s a very simple Qiskit program which lets you witness the biased noise of our cat qubits.

- ☝ If you’re not familiar with Qiskit, here’s a [short introduction](https://qiskit.org/documentation/intro_tutorial1.html).

- If you’re not familiar with cat qubits, you may want to read [Working with cat qubits: similarities & differences](working_with_cat_qubits.md) first.



You may paste the following code in a Python script or a Jupyter notebook.

First, we set up the provider and import dependencies:

```python
from qiskit import QuantumCircuit, execute
from qiskit.visualization import plot_histogram
from qiskit_alice_bob_provider import AliceBobRemoteProvider

# Replace the placeholder with your actual API key in the line below
# If you do not have an API key, read about the local provider
ab = AliceBobRemoteProvider(api_key='YOUR_API_KEY')
```

If you do not have an API key, read about the [the local Qiskit provider](../about_api_providers/the_local_provider.md) which can emulate circuits on your own computer.

We will then pick a backend to use:

```python
print(ab.backends())
backend = ab.get_backend('EMU:1Q:LESCANNE_2020')
```

Then, we design and execute a simple circuit sensitive to bit-flips (Prepare |0> / Wait / Measure on the Z axis), whose result would always be 0 in a noiseless environment:

```python
# Measure bit-flip errors after 1µs
c1 = QuantumCircuit(1, 1)
c1.delay(1, unit='us')
c1.measure(0, 0)
job1 = execute(c1, backend, shots=1000, average_nb_photons=3)
res1 = job1.result()
plot_histogram(res1.get_counts())
```

Then, we replicate the same idea to design and execute a circuit sensitive to phase-flips (Prepare |+> / Wait / Measure on the X axis), whose result should also always be 0 in a noiseless environment:

```python
# Measure phase-flip errors after 1 µs
c2 = QuantumCircuit(1, 1)
c2.initialize('+', 0)
c2.delay(1, unit='us')
c2.measure_x(0, 0)
job2 = execute(c2, backend, shots=1000, average_nb_photons=3)
res2 = job2.result()
plot_histogram(res2.get_counts())
```

The second circuit should show far more errors than the first, showing our qubits do have a noise bias: they are strongly protected against bit-flip errors.

Come and show us your results!

## Going further

Now that you understand how things work, you can start having fun.

Here are some ideas of experiments you can run:

- Showcase exponential suppression of bit flips by varying `average_nb_photons`
    - ℹ️ Varying `average_nb_photons` works differently in the local and in the remote provider. The example in this page works for the remote provider, see [The local Qiskit provider](../about_api_providers/the_local_provider.md) to learn how to adapt your code for the local provider.
- Showcase linear increase of the phase flip rate by varying `average_nb_photons`
- Measure the bit flip time
- Measure the phase flip time

In order to implement these ideas, have a look at the list of [Supported instructions](../going_further/supported_instructions.md).