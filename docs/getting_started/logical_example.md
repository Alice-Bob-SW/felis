# An example with logical qubits

When you use a logical backend, you get error-corrected qubits with all-to-all connectivity and a universal gate set.

Logical backends are less noisy than physical backends, but they still feature noise. You may tune the backend's noise characteristics using parameters `distance`, `kappa_1`, `kappa_2` and `average_nb_photons` (read [Supported instructions](../reference/supported_instructions.md) for more details about these parameters and how to set them).

For the time being, logical backends are all emulators, but creating a QPU able to run in logical mode is Alice & Bob's main goal.

Here's an example using a logical backend, showing how continuous gates are decomposed into discrete gates.

We start by getting one of the two logical backends ([`EMU:15Q:LOGICAL_EARLY`](../backends/backends_list/logical_early.md)).

```python
from qiskit_alice_bob_provider import AliceBobLocalProvider
from qiskit import QuantumCircuit, transpile
import numpy as np

ab = AliceBobLocalProvider()

backend = ab.get_backend('EMU:15Q:LOGICAL_EARLY')
```

We then apply a `rx` gate, which is not supported by physical backends as it is not bias-preserving, and which is not a native logical operation either.

```
circ = QuantumCircuit(1,1)
circ.rx(np.pi / 8.0, 0)
circ.measure(0,0)
```

So, when we transpile the result to our logical backend:

```
circ = transpile(circ, backend)
print(circ)
```

We get the following circuit using only native logical gates:

```python
     ┌───────────────┐┌─────┐┌───┐┌───┐┌───┐┌─────┐┌───┐┌─────┐┌───┐┌───┐┌───┐»
   q ┤ Initialize(0) ├┤ Tdg ├┤ H ├┤ T ├┤ H ├┤ Tdg ├┤ H ├┤ Tdg ├┤ H ├┤ T ├┤ T ├»
     └───────────────┘└─────┘└───┘└───┘└───┘└─────┘└───┘└─────┘└───┘└───┘└───┘»
c: 1/═════════════════════════════════════════════════════════════════════════»
                                                                              »
«     ┌───┐┌───┐┌───┐┌─────┐┌───┐┌─────┐┌───┐┌───┐┌───┐┌─────┐┌───┐┌───┐┌───┐»
«   q ┤ T ├┤ T ├┤ H ├┤ Tdg ├┤ H ├┤ Tdg ├┤ H ├┤ T ├┤ H ├┤ Tdg ├┤ H ├┤ T ├┤ H ├»
«     └───┘└───┘└───┘└─────┘└───┘└─────┘└───┘└───┘└───┘└─────┘└───┘└───┘└───┘»
«c: 1/═══════════════════════════════════════════════════════════════════════»
«                                                                            »
«     ┌─────┐┌───┐┌─────┐┌───┐┌─────┐┌───┐┌───┐┌───┐┌───┐┌───┐┌───┐┌───┐┌─────┐»
«   q ┤ Tdg ├┤ H ├┤ Tdg ├┤ H ├┤ Tdg ├┤ H ├┤ T ├┤ H ├┤ T ├┤ T ├┤ T ├┤ H ├┤ Tdg ├»
«     └─────┘└───┘└─────┘└───┘└─────┘└───┘└───┘└───┘└───┘└───┘└───┘└───┘└─────┘»
«c: 1/═════════════════════════════════════════════════════════════════════════»
«                                                                              »
«     ┌───┐┌───┐┌───┐┌───┐┌───┐┌─────┐┌─────┐┌─────┐┌───┐┌─────┐┌───┐┌───┐┌───┐»
«   q ┤ H ├┤ T ├┤ H ├┤ T ├┤ H ├┤ Tdg ├┤ Tdg ├┤ Tdg ├┤ H ├┤ Tdg ├┤ H ├┤ T ├┤ H ├»
«     └───┘└───┘└───┘└───┘└───┘└─────┘└─────┘└─────┘└───┘└─────┘└───┘└───┘└───┘»
«c: 1/═════════════════════════════════════════════════════════════════════════»
«                                                                              »
«     ┌───┐┌───┐┌───┐┌───┐┌─────┐┌───┐┌─────┐┌─┐
«   q ┤ T ├┤ H ├┤ T ├┤ H ├┤ Tdg ├┤ H ├┤ Tdg ├┤M├
«     └───┘└───┘└───┘└───┘└─────┘└───┘└─────┘└╥┘
«c: 1/════════════════════════════════════════╩═
«                                             0 
```

This circuit may then be executed like any Qiskit circuit:

```
job = backend.run(circ, shots=1_000)
print(job.result().get_counts())
```

💡 **Note:** `backend.run()` transpiles your circuit if you didn't do it manually, but transpiling yourself enables you to examine the circuit which is actually executed.

Use logical backends to run quantum algorithms.

Don't hesitate to play with the `distance`, `kappa_1`, `kappa_2` and `average_nb_photons` settings to change the noise characteristics of your backend and study how this affects your results.

You may:
- Read [Supported instructions](../reference/supported_instructions.md) for more details about these parameters and how to set them)
- Check out our [sample notebook](https://github.com/Alice-Bob-SW/felis/blob/main/samples/2_algorithms/4%20-%20Benchmarking%20a%20logical%20cat%20qubit%20processor%20through%20the%20SWAP%20test.ipynb) showing how to perform this study

💡 **Note:** As you'll notice above, circuits are transpiled to Clifford + T gates, but our logical backends also natively support Toffoli gates. We are considering using the Clifford + Toffoli gate set instead of Clifford + T for some applications. While the transpilation engine does not (yet) compile to this gate set, you are free to develop your own engine and try it out using our logical backends!