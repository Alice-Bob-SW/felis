# 40 logical qubits, noiseless

| Backend name | `EMU:40Q:LOGICAL_NOISELESS` |
| Backend type | Emulator, logical |

# About this backend
`EMU:40Q:LOGICAL_NOISELESS` is a noiseless backend featuring the same native gate set as the other logical backends, but without a noise model.

It is meant to study the quality of your transpilation, as it runs faster than the other noisy backends.

# Supported backend parameters
This backend does not have parameters, since it does not have a noise model.

# Supported gates
- `initialize` ([custom Felis gate](../../reference/supported_instructions.md))
- `measure_x` ([custom Felis gate](../../reference/supported_instructions.md))
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

This gate set is universal, meaning any gate in a circuit can be decomposed into a series of the gates above when transpiling the circuit for this backend.

Read more about supported gates [here](../../reference/supported_instructions.md).

# Supported providers
- ✅ `AliceBobLocalProvider`
- ✅ `AliceBobRemoteProvider`

# Connectivity

As a logical backend, this backend features all-to-all connectivity.

# Expected performance
This backend doesn't feature a noise model.

# Availability schedule
As an emulator, this backend is expected to be available 24/7.

Live status for backends is available at [https://api-gcp.alice-bob.com/console/status](https://api-gcp.alice-bob.com/console/status).