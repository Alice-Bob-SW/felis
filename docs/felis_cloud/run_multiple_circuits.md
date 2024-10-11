# How to run multiple circuits remotely

When sweeping over some parameters (for example, the number of photons in the cat), it is much faster to send all the circuits to the Alice & Bob Felis cloud service and then wait for the results:

```python
from qiskit_alice_bob_provider import AliceBobRemoteProvider
from qiskit import QuantumCircuit

# Replace the placeholder with your actual API key in the line below
remote = AliceBobRemoteProvider(api_key='YOUR_API_KEY')
backend = remote.get_backend('BACKEND_NAME')

circ = QuantumCircuit(1, 1)
circ.reset(0)
circ.delay(1, 0, unit='ms')
circ.measure(0, 0)

jobs = []
shots = 1_000
for nb_photons in range(2, 11):
    jobs.append(backend.run(circ, shots=shots, average_nb_photons=nb_photons))

results = [job.result() for job in jobs]
# for example, computing the number of bit flips:
flip_fractions = [r.get_counts().get('1', 0) / shots for r in results]
```

That’s because the API can run some parts of the processing in parallel. It also minimizes the number of network calls.

⚠️ Here’s an example of what you should not do:

```python
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Don't do this! This is much slower than the code snippet above.
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

from qiskit_alice_bob_provider import AliceBobRemoteProvider
from qiskit import QuantumCircuit

# Replace the placeholder with your actual API key in the line below
remote = AliceBobRemoteProvider(api_key='YOUR_API_KEY')
backend = remote.get_backend('BACKEND_NAME')

circ = QuantumCircuit(1, 1)
circ.reset(0)
circ.delay(1, 0, unit='ms')
circ.measure(0, 0)

shots = 1_000
results = []
for nb_photons in range(2, 11):
    job = backend.run(circ, shots=shots, average_nb_photons=nb_photons)
    results.append(job.result())

# for example, computing the number of bit flips:
flip_fractions = [r.get_counts().get('1', 0) / shots for r in results]
```