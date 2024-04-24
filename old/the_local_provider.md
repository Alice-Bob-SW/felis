# The local Qiskit provider

By default, the main Alice & Bob Qiskit provider `AliceBobRemoteProvider` runs all circuits remotely, on Alice & Bob classical or quantum computers.

If you would rather emulate your circuit locally, you need to instantiate the local Qiskit provider `AliceBobLocalProvider` instead of the remote one:

```python
from qiskit_alice_bob_provider import AliceBobLocalProvider
from qiskit import QuantumCircuit, execute, transpile

provider = AliceBobLocalProvider()

circ = QuantumCircuit(2, 2)
circ.initialize('0+')
circ.cx(0, 1)
circ.measure(0, 0)
circ.measure(1, 1)

print(circ.draw())

# Default 6-qubit QPU with the ratio of memory dissipation rates set to
# k1/k2=1e-5 and cat size average_nb_photons set to 16.
backend = provider.get_backend('EMU:6Q:PHYSICAL_CATS')

print(transpile(circ, backend).draw())

print(execute(circ, backend, shots=100000).result().get_counts())
# {'11': 49823, '00': 50177}

# Changing the cat size from 16 (default) to 4 and k1/k2 to 1e-2.
backend = provider.get_backend('EMU:6Q:PHYSICAL_CATS', average_nb_photons=4, kappa_2=1e4)
print(execute(circ, backend, shots=100000).result().get_counts())
# {'01': 557, '11': 49422, '10': 596, '00': 49425}
```

As can be seen in the example above, the main difference with the remote provider `AliceBobRemoteProvider` is that the settings (like `average_nb_photons` or `kappa_2`) must be configured in `get_backend(...)` instead of `execute(...)`. Learn more in [Chip settings](../reference/supported_instructions.md).