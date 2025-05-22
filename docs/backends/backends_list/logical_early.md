# 15 logical qubits

Backend name : `EMU:15Q:LOGICAL_EARLY`

Backend type : Emulator, logical

# About this backend
`EMU:15Q:LOGICAL_EARLY` reproduces what might be the behavior of one of the first useful logical chips, featuring 15 logical qubits with conservative hypotheses on qubit quality.

In this backend, information is physically stored in 13 "data" cat qubits (carrying the information of the logical qubit) and 12 "ancilla" cat qubits (used to perform error detection operations).

Physical qubits are abstracted here - errors are emulated using an analytical formula rather than by emulating the individual behavior of each physical qubit.

Logical error rates are between $10^{-3}$ and $10^{-4}$, but they can be made better (or worse) by tuning the `average_nb_photons`, `kappa_1`, `kappa_2`, and `distance` parameters - see [Chip settings](../../reference/supported_instructions.md) for more details.

# Supported backend parameters
- `average_nb_photons`
    - Default value: 7
    - Supported values: 4 and above
- `distance`
    - Default value: 13
    - Supported values: 3 and above, odd integers only
- `kappa_1`
    - Default value: 100
    - Supported values: 10 and above
- `kappa_2`
    - Default value: 100 000
    - Supported values: 100 and above

💡 The `kappa_1 / kappa_2` ratio must be between 1e-7 and 1e-1

Read more about backend parameters [here](../set_parameters.md)

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
This backend features an error model based on theoretical papers. It is not meant to accurately reproduce a specific current or future Alice & Bob chip.

The formulas and references we used are documented in the source code at https://github.com/Alice-Bob-SW/qiskit-alice-bob-provider/blob/main/qiskit_alice_bob_provider/processor/logical_cat.py

# Availability schedule
As an emulator, this backend is expected to be available 24/7.

Live status for backends is available at [https://api-gcp.alice-bob.com/console/status](https://api-gcp.alice-bob.com/console/status).