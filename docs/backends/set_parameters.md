# Set backend parameters

Depending on the backend, some settings affecting the backend's noise characteristics can be configured.

## Available parameters

### Summary

| Model | average_nb_photons | kappa_1 | kappa_2 | distance | Availability |
| --- | --- | --- | --- | --- | --- |
| [QPU:1Q:BOSON_4A](../backends/backends_list/boson_4.md) | ✅ | ❌ | ❌ | ❌ | Remote only |
| [QPU:1Q:BOSON_4B](../backends/backends_list/boson_4.md) | ✅ | ❌ | ❌ | ❌ | Remote only |
| [QPU:1Q:BOSON_4C](../backends/backends_list/boson_4.md) | ✅ | ❌ | ❌ | ❌ | Remote only |
| [EMU:1Q:LESCANNE_2020](../backends/backends_list/lescanne_2020.md) | ✅ | ❌ | ❌ | ❌ | Remote & Local |
| [EMU:6Q:PHYSICAL_CATS](../backends/backends_list/6_physical_cats.md) | ✅ | ✅ | ✅ | ❌ | Remote & Local |
| [EMU:40Q:PHYSICAL_CATS](../backends/backends_list/40_physical_cats.md) | ✅ | ✅ | ✅ | ❌ | Remote & Local |
| [EMU:15Q:LOGICAL_EARLY](../backends/backends_list/logical_early.md) | ✅ | ✅ | ✅ | ✅ | Remote & Local |
| [EMU:40Q:LOGICAL_TARGET](../backends/backends_list/logical_target.md) | ✅ | ✅ | ✅ | ✅ | Remote & Local |
| [EMU:40Q:LOGICAL_NOISELESS](../backends/backends_list/logical_noiseless.md) | ❌ | ❌ | ❌ | ❌ | Remote & Local |

### Average number of photons

- `average_nb_photons` is the number photons trapped in the qubit’s cavity.
- Increasing it will exponentially decrease the number of bit-flips, at the cost of a linear increase of the number of phase-flips.
- This parameter is available in all backends.

### $\kappa_1$ and $\kappa_2$

#### $\kappa_1$

- `kappa_1` is the one-photon loss rate, expressed in Hz.
- Qubit quality decreases as `kappa_1` increases, since one-photon losses causes phase-flips.
- [Boson 4 chips](../reference/boson_4_chips.md) feature `kappa_1 = 3.14*19_900`.
- This parameter is not available on a real chip and on digital twin emulators.

#### $\kappa_2$

- `kappa_2` is the two photon-loss rate, expressed in Hz.
- Qubit quality increases as `kappa_2` increases, since the exchange of pairs of photons is used to stabilize the qubit.
- [Boson 4 chips](../reference/boson_4_chips.md) feature `kappa_2 = 3.14*250_000`.
- This parameter is not available on a real chip and on digital twin emulators.

#### $\kappa_1/\kappa_2$

- The $\kappa_1/\kappa_2$ ratio is a good proxy for the quality of the physical chip.
- The lower this ratio, the higher the quality of the chip.
- Current Alice & Bob chips feature $\kappa_1/\kappa_2 < 10^{-2}$
- Getting error correction to work reliably requires $\kappa_1/\kappa_2 < 10^{-3}$
- Creating 100 logical qubits at a $10^{-8}$ error rate with 1500 qubits requires $\kappa_1/\kappa_2 < 10^{-4}$, as shown in [this article](https://arxiv.org/abs/2401.09541)
- Running Shor's algorithm on a 2048-bit number requires $\kappa_1/\kappa_2 < 10^{-5}$, as shown in [this article](https://arxiv.org/abs/2302.06639)

### Repetition code distance

- `distance` is the distance of the error correction code, i.e. the number of physical qubits used to create a logical qubits.
- Phase-flips are exponentially removed as the distance of the code is increased, but bit-flips increase linearly.
- This parameter is only available for logical backends.

## Set parameters

Parameters may be set while initializing a backend:

```python
from qiskit_alice_bob_provider import AliceBobLocalProvider
from qiskit import QuantumCircuit

provider = AliceBobLocalProvider()

backend = local.get_backend('EMU:1Q:LESCANNE_2020', average_nb_photons=3)
backend = local.get_backend('EMU:6Q:PHYSICAL_CATS', average_nb_photons=5)
backend = local.get_backend('EMU:40Q:PHYSICAL_CATS', kappa_2=500_000)
backend = local.get_backend('EMU:15Q:LOGICAL_EARLY', distance=13)

circuit = QuantumCircuit(...)
# ...

backend.run(circuit, shots=3000)
```

Or when executing a circuit:

```python
from qiskit_alice_bob_provider import AliceBobRemoteProvider
from qiskit import QuantumCircuit

# Replace the placeholder with your actual API key in the line below
remote = AliceBobRemoteProvider(api_key='YOUR_API_KEY')

backend = remote.get_backend('EMU:1Q:LESCANNE_2020')

circuit = QuantumCircuit(...)
# ...

backend.run(circuit, shots=3000, average_nb_photons=3)
```