# Install the Qiskit provider

## 1. Set up your environment

You need a Python 3.7 or later environment to use Felis.

We strongly recommend creating a new environment before attempting to install Felis.

We assume you know how to do this. If you don’t, you can [go through the Python docs](https://www.python.org/about/gettingstarted/), or simply [reach out](../contact_us.md).

## 2. Install the Alice & Bob Qiskit provider

```bash
pip install --upgrade qiskit-alice-bob-provider
```

Note: no need to install Qiskit separately, it will be installed automatically if it is not already installed.

⚠️ Felis is currently only compatible with Qiskit 0.44.3. If you have a more recent version of Qiskit, you will need to create a new environment before installing Felis.


## 3. Write your first Qiskit program

To use the Alice & Bob Qiskit provider in a Qiskit program, you need to instantiate it and retrieve a backend.

```python
from qiskit_alice_bob_provider import AliceBobLocalProvider
ab = AliceBobLocalProvider()

print(ab.backends())
backend = ab.get_backend('EMU:1Q:LESCANNE_2020')
```

You may then use `backend` as a target to execute a Qiskit circuit.

```python
from qiskit import QuantumCircuit, execute

circ = QuantumCircuit(1,1)
circ.reset(0)
circ.measure(0, 0)
job = execute(circ, backend, shots=1_000)
print(job.get_counts())
```

## 4. Enjoy!

Now that you understand the basics, you need to know that Felis features both [physical and logical backends](../backends/logical_physical.md), which work a little differently.

To go further, check out and compare these two examples:

- [An example with physical qubits](physical_example.md), which shows a core property of cat qubits
- [An example with logical qubits](logical_example.md), which creates a Bell state on logical qubits

💡 Note: unless otherwise stated, our examples all use `AliceBobLocalProvider`, which runs the circuits on your own machine. In order to run circuits on a real quantum chip or on cloud-based emulators, you need to use the `AliceBobRemoteProvider` and have a [Felis Cloud subscription](../felis_cloud/connect_to_felis_cloud.md).