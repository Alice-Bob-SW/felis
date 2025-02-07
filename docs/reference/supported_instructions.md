# Supported instructions

## Supported Qiskit gates

### Logical backends

Logical backends ([`EMU:15Q:LOGICAL_EARLY`](../backends/backends_list/logical_early.md) and [`EMU:40Q:LOGICAL_TARGET`](../backends/backends_list/logical_target.md)) support a universal set of gates, so they should run any gate listed in [https://qiskit.org/documentation/tutorials/circuits/3_summary_of_quantum_operations.html](https://qiskit.org/documentation/tutorials/circuits/3_summary_of_quantum_operations.html).

If the gate is not part of the backend's native gate set, it will be implemented through transpilation, as shown in [this example](../getting_started/logical_example.md).

### Physical backends

Physical backends support a limited set of gates among the following:

- `delay(duration, qarg=qubit_index, unit='ns')`
    - This is a [native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.Delay)
    - It attempts to preserve the state of qubit `qubit_index` during the specified `duration` and `unit`
    - Minimum value: 1 ns
- `initialize(value, qubit_index)`
    - This is a custom Felis gate
    - It initializes qubit `qubit_index` to one of four supported `value`:   `'0'`, `'1'`, `'+'`, `'-'`
- `z(qubit_index)`
    - This is a [native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.ZGate)
    - It performs a phase-flip (transforming $\ket{+}$ into $\ket{-}$ and the reverse) on qubit `qubit_index`
- `x(qubit_index)`
    - This is a [native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.XGate)
    - It performs a bit-flip (transforming $\ket{0}$ into $\ket{1}$ and the reverse) on qubit `qubit_index`
- `rz(angle, qubit_index)`
	- This is a [native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.RZGate)
	- It performs a rotation of angle `angle` around the Z axis on qubit `qubit_index`
- `cx(qubit_index_1, qubit_index_2)`
	- This is a [native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.CXGate)
	- It performs a controlled X gate (also called "CNOT") between qubits `qubit_index_1` and `qubit_index_2`
	- It is only available on backends featuring at least 2 qubits
- `measure(qubit_index, clbit_index)`
    - This is a [native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.Measure)
    - It performs a Z measurement on qubit `qubit_index` and stores the result in the classical bit `clbit_index`
- `measure_x(qubit_index, clbit_index)`
    - This is a custom Felis gate
    - It performs an X measurement on qubit `qubit_index` and stores the result in the classical bit `clbit_index`
    - The native Qiskit equivalent would be `H` + `measure`, but `H` is not supported by physical backends.

Note that these operations are all bias-preserving (i.e. they do not convert a phase-flip error into a bit-flip error).

Any instruction other than those listed above is not supported by physical backends.

To know which gate is supported by which backend, check your backend's page in the [Backends section](../backends/about_backends.md)

Gates must be added to a Qiskit `QuantumCircuit`. For example:

```python
from qiskit import QuantumCircuit

circ = QuantumCircuit(1,1)
circ.x(0)
```

## Supported QIR instructions

The API exposes the list of available targets (the equivalent of Qiskit backends) and details for each of them the list of supported instructions.

[https://api-gcp.alice-bob.com/v1/targets/](https://api-gcp.alice-bob.com/v1/targets/)

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