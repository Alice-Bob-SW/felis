# 40 logical qubits

Backend name : `EMU:40Q:LOGICAL_TARGET`

Backend type : Emulator, logical

# About this backend
`EMU:40Q:LOGICAL_TARGET` reproduces what might be the behavior of a mature logical chip, featuring 40 logical qubits. It is built using optimistic (but not unrealistic) hypotheses on qubit quality, taken from [this paper](https://arxiv.org/abs/2302.06639) and a distance 15 repetition code.

Just like for `EMU:15Q:LOGICAL_EARLY`, physical qubit behavior is abstracted, you get all-to-all connectivity and a universal gate set.

Error rates are extremely low (about $10^{-16}$), so this backend should be virtually impossible to distinguish from a noiseless backend when running short circuits. If you wish to use a truly noiseless backend, consider using `EMU:40Q:LOGICAL_NOISELESS` instead.

This backend is well-suited to studying fault-tolerant algorithms on small instances of problems.

⚠️ Although this backend makes it possible to choose from 40 different qubits, using it to run circuits using more than ~10-15 qubits will likely be slow or fail altogether. The exact limit depends on the capabilities of your machine.

By the time we have real chips featuring such low error rates, we will likely have much more than 40 logical qubits. But you’ll need terabytes of memory to run a 40 qubit emulator, so we thought it didn’t make sense to allow more here ;)

# Supported backend parameters
- `average_nb_photons`
    - Supported values: 4 and above
- `distance`
    - Supported values: 3 and above, odd integers only
- `kappa_1`
    - Supported values: 10 and above
- `kappa_2`
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