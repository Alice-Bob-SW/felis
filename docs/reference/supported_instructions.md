# Supported instructions

## Supported Qiskit gates

### Custom Felis gates

All Felis backends support two custom Qiskit gates: `initialize` and `measure_x`:

- `initialize(value, qubit_index)`
    - It initializes qubit `qubit_index` to one of four supported `value`:   `'0'`, `'1'`, `'+'`, `'-'`

- `measure_x(qubit_index, clbit_index)`
    - It performs an X measurement on qubit `qubit_index` and stores the result in the classical bit `clbit_index`
    - The native Qiskit equivalent would be `H` + `measure`, but:
		- In physical backends, `H` is not supported
		- In logical backends, `measure_x` a less costly way to perform measurements in the X basis than `H` + `measure`

In addition to these two gates, you may use some or all of the other gates listed in the [Qiskit documentation](https://docs.quantum.ibm.com/api/qiskit/).

Gates (from Felis or from Qiskit) must be added to a Qiskit `QuantumCircuit`. For example:

```python
from qiskit import QuantumCircuit

circ = QuantumCircuit(1,1)
circ.x(0)
```

The sections below list which gates you may use depending on the backend you're using.

### Logical backends

We have two candidate logical gate sets for our future error-corrected quantum processors:
- Hadamard + Toffoli
- Clifford + T

Depending on the use case, one may yield better results than the other. In the scope of Felis' logical backends, we chose to support both T and Toffoli gates, so you can choose to which gate set you will transpile your programs. Our engine currently only transpiles to Clifford + T.

More precisely, the gates natively supported by all logical backends are:
- `initialize` (custom Felis gate)
- `measure_x` (custom Felis gate)
- `delay` ([native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/circuit#delay))
- `x` ([native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.XGate))
- `z` ([native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.ZGate))
- `measure` ([native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/circuit#measure))
- `t` ([native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.TGate))
- `tdg` ([native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.TdgGate))
- `h` ([native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.HGate))
- `s` ([native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.SGate))
- `sdg` ([native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.SdgGate))
- `cx` ([native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.CXGate))
- `ccx` ([native Qiskit gate](https://docs.quantum.ibm.com/api/qiskit/qiskit.circuit.library.CCXGate))

If the gate is not part of this native gate set, it will be implemented through transpilation, as shown in [this example](../getting_started/logical_example.md).

### Physical backends

Physical backends support a limited set of gates, summarized in this table:

| Instruction | [QPU:1Q:BOSON_4x] | [EMU:1Q:LESCANNE_2020] | [EMU:6/40Q:PHYSICAL_CATS] |
| --- | --- | --- | --- |
| `delay` | ✅ | ✅ | ✅ |
| `initialize` | ✅ | ✅ | ✅ |
| `z` | ✅ | ✅ | ✅ |
| `x` | ✅ | ❌ | ✅ |
| `rz` | ❌ | ✅ | ✅ |
| `cx` | ❌ | ❌ | ✅ |
| `measure` | ✅ | ✅ | ✅ |
| `measure_x` | ✅ | ✅ | ✅ |

Note that these operations are all bias-preserving (i.e. they do not convert a phase-flip error into a bit-flip error).

Because this gate set is not universal, transpiling an arbitrary circuit for physical backends is usually not possible. Physical backends are meant to run error correction experiments, rather than algorithms. If you want to run algorithms, consider using logical backends instead.

To know which gate is supported by which backend, check the table above or your backend's page in the [Backends section](../backends/about_backends.md)

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