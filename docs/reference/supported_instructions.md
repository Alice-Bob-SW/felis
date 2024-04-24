# Supported instructions

## Supported Qiskit instructions

The `EMU:20Q:PERFECT_QUBITS` and `EMU:7Q:TRANSMONS` backends, as well as the logical backends `EMU:15Q:LOGICAL_EARLY` and `EMU:40Q:LOGICAL_TARGET`, support a universal set of gates, so they should run any gate listed in [https://qiskit.org/documentation/tutorials/circuits/3_summary_of_quantum_operations.html](https://qiskit.org/documentation/tutorials/circuits/3_summary_of_quantum_operations.html).

The backends with physical cat qubits (both emulators and QPUs) support a limited set of gates, [as detailed below](#state-preparations).

### Chip settings

Depending on the backend, some settings of the chip can be configured.

Local backends must be configured when creating the backend:

```python
from qiskit_alice_bob_provider import AliceBobLocalProvider
from qiskit import QuantumCircuit, execute

local = AliceBobLocalProvider()

backend = local.get_backend('EMU:1Q:LESCANNE_2020', average_nb_photons=3)
backend = local.get_backend('EMU:6Q:PHYSICAL_CATS', average_nb_photons=5)
backend = local.get_backend('EMU:40Q:PHYSICAL_CATS', kappa_2=5)
backend = local.get_backend('EMU:15Q:LOGICAL_EARLY', 

circuit = QuantumCircuit(...)
# ...

execute(circuit, backend, shots=3000)
```

Remote backends must be configured when executing a circuit:

```python
from qiskit_alice_bob_provider import AliceBobRemoteProvider
from qiskit import QuantumCircuit, execute

# Replace the placeholder with your actual API key in the line below
remote = AliceBobRemoteProvider(api_key='YOUR_API_KEY')

backend = remote.get_backend('EMU:1Q:LESCANNE_2020')

circuit = QuantumCircuit(...)
# ...

execute(circuit, backend, shots=3000, average_nb_photons=3)
```

Here’s a recap of the tunable settings on currently available backends:

| Model | average_nb_photons | kappa_1 | kappa_2 | distance | Availability |
| --- | --- | --- | --- | --- | --- |
| [EMU:1Q:LESCANNE_2020](../backends/backends_list/lescanne_2020.md) | ✅ | ❌ | ❌ | ❌ | Remote & Local |
| [EMU:6Q:PHYSICAL_CATS](../backends/backends_list/6_physical_cats.md) | ✅ | ✅ | ✅ | ❌ | Remote & Local |
| [EMU:40Q:PHYSICAL_CATS](../backends/backends_list/40_physical_cats.md) | ✅ | ✅ | ✅ | ❌ | Remote & Local |
| [EMU:15Q:LOGICAL_EARLY](../backends/backends_list/logical_early.md) | ✅ | ✅ | ✅ | ✅ | Remote & Local |
| [EMU:40Q:LOGICAL_TARGET](../backends/backends_list/logical_target.md) | ✅ | ✅ | ✅ | ✅ | Remote & Local |

Some explanations:

- `average_nb_photons` is the number photons trapped in the qubit’s cavity. Increasing it will exponentially decrease the number of bit-flips, at the cost of a linear increase of the number of phase-flips
- `kappa_1` and `kappa_2` are the one-photon loss rate and the two-photon loss rate respectively. The loss of single photons is detrimental because it causes phase-flips, while the exchange of pairs of photons is used to stabilize the qubit. As a consequence, `kappa_1 / kappa_2` is a good proxy for the quality of the physical chip: the smaller this number (say $10^{-5}$) the fewer bit-flips and phase-flips.
- `distance` is the distance of the error correction code, i.e. the number of physical qubits used to create a logical qubits. Phase-flips are exponentially removed as the distance of the code is increased, but bit-flips increase linearly. This parameter is only available for logical backends.

### State preparations

```python
c = QuantumCircuit(1, 1)

# P0 (here on qubit #0)
c.initialize('0', 0)

# P1 (here on qubit #0)
c.initialize('1', 0)

# P+ (here on qubit #0)
c.initialize('+', 0)

# P- (here on qubit #0)
c.initialize('-', 0)
```

- Preparing |0>, |1>, |+> and |-> are native operations
- Due to the restricted gate set, preparing states other than these four might not work

### Measurements

```python
c = QuantumCircuit(1, 1)

# Mz (here on qubit #0, result stored in classical bit #0)
c.measure(0, 0)

# Mx (here on qubit #0, result stored in classical bit #0)
c.measure_x(0, 0)
```

Note that measure_x is not a standard Qiskit operation - it only exists in this provider:

- It is a native physical operation on a cat qubit
- It is equivalent to H + measure on a transmon, but remember that [H is not a supported gate in physical mode](../getting_started/working_with_cat_qubits.md).

### Operations

```bash
import numpy as np

c = QuantumCircuit(1, 1)

# X (here on qubit #0)
c.x(0)

# Z (here on qubit #0)
c.z(0)

# Rz (here with angle pi/4 on qubit #0)
c.rz(np.pi / 4.0, 0)

# CNOT (here on qubits #0 and #1 - requires a backend with 2 qubits or more)
c.cx(0, 1)

# Delay (here delays the whole circuit by 1µs)
c.delay(1, unit='us')
```

Note that these operations are all bias-preserving (i.e. they do not convert a phase-flip error into a bit-flip error).

Any instruction other than those listed above is not supported by physical backends.


⚠️ In `EMU:1Q:LESCANNE_2020` and future real hardware (at least at the beginning), the X gate is implemented virtually, by transpiling the circuit and post-processing the results.

In all other backends, the X gate is executed at its specific position in the circuit; it can be noisy and its fidelity depends on the backend you use.



## Supported QIR instructions

The API exposes the list of available targets (the equivalent of Qiskit backends) and details for each of them the list of supported instructions.

[https://api.alice-bob.com/v1/targets/](https://api.alice-bob.com/v1/targets/)

- Here’s a sample response (for the `EMU:1Q:LESCANNE_2020` model only).
    
    ```json
    [
    	{
    		"name": "EMU:1Q:LESCANNE_2020",
    		"numQubits": 1,
    		"instructions": [
    			{
    				"signature": "__quantum__qis__read_result__body:i1 (%Result*)"
    			},
    			{
    				"signature": "__quantum__qis__z__body:void (%Qubit*)"
    			},
    			{
    				"signature": "__quantum__qis__x__body:void (%Qubit*)"
    			},
    			{
    				"signature": "__quantum__qis__mz__body:void (%Qubit*, %Result*)"
    			},
    			{
    				"signature": "__quantum__qis__m__body:void (%Qubit*, %Result*)"
    			},
    			{
    				"signature": "__quantum__qis__measure__body:void (%Qubit*, %Result*)"
    			},
    			{
    				"signature": "__quantum__qis__mx__body:void (%Qubit*, %Result*)"
    			},
    			{
    				"signature": "__quantum__qis__reset__body:void (%Qubit*)"
    			},
    			{
    				"signature": "__quantum__qis__delay__body:void (double, %Qubit*)"
    			},
    			{
    				"signature": "__quantum__qis__prepare_x__body:void (i1, %Qubit*)"
    			},
    			{
    				"signature": "__quantum__qis__prepare_z__body:void (i1, %Qubit*)"
    			},
    			{
    				"signature": "__quantum__qis__rz__body:void (double, %Qubit*)"
    			}
    		],
    		"inputParams": {
    			"nbShots": {
    				"required": true,
    				"default": 1000,
    				"constraints": [
    					{
    						"min": 1,
    						"max": 10000000
    					}
    				]
    			},
    			"averageNbPhotons": {
    				"required": true,
    				"default": 4.0,
    				"constraints": [
    					{
    						"min": 1.0,
    						"max": 7.0
    					}
    				]
    			}
    		}
    	},
      ...
    ]
    ```
    

When working with the remote provider `AliceBobRemoteProvider`, the supported QIR instructions are fetched by the provider from the API and converted into Qiskit instructions.