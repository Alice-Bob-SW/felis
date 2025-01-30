# Changelog

## Version 1.1.1

`get_memory` functionality for Remote Providers:

* Introduced the `get_memory` function for the result of an `AliceBobRemoteProvider` job, enabling users to retrieve individual shot results from quantum circuit executions.
* This feature aligns with functionality already available in the `AliceBobLocalProvider`, ensuring consistency across providers.

Example Usage
Here’s how to retrieve the memory of a quantum circuit execution:
```python
from qiskit_alice_bob_provider import AliceBobRemoteProvider
from qiskit import transpile

# Initialize the remote provider
remote_provider = AliceBobRemoteProvider(
    '<API_KEY>',
    url='https://api.alice-bob.com/'
)

# Retrieve the backend and execute the circuit
backend = remote_provider.get_backend('<backend>')
circuit = <...>  # Define your quantum circuit
transpiled_circuit = transpile(circuit, backend)
job = backend.run(transpiled_circuit, shots=10000, memory=True)

# Retrieve the memory of the circuit
result = job.result()
memory = result.get_memory()

print(memory)
```

**Key Notes**

- The `memory=True` parameter in the `backend.run` method ensures shot-by-shot results are captured and retrievable.

## Version 1.1.0

- Migrated to Qiskit 1.3 :
    - Default `optimization_level` for `backend.transpile()` is changed from 1 to 2.
- Transpilation now works correctly for backend targets with only Clifford + T gate basis (except for gates CRY, RCCX and RCCCX on macOS for now)
- Alice & Bob custom options like `average_nb_photons` are not allowed for `backend.run()` with local provider because they will be ignored. They should be passed to `provider.get_backend()` instead.
- Drop support for Python 3.8


## Version 1.0.0

- Migrated to Qiskit 1.2 (BREAKING CHANGES for 1.0) :
    - Function `execute()` is removed in favor of `transpile()` + `backend.run()`
    - `circuit.cnot()` gate should now be declared with `circuit.cx()`
    - Python environments created with previous Qiskit versions need to be recreated
    - For more details about other Qiskit 1.0 changes, you can read the [complete migration guide](https://docs.quantum.ibm.com/migration-guides/qiskit-1.0-features).
- Specifying options for `get_backend()` no longer modifies the default 
  options for this backend on the Alice & Bob provider Python object.

Example to execute a circuit :
```python
# Legacy path
from qiskit import execute

job = execute(circuit, backend)

# New path
from qiskit import transpile

new_circuit = transpile(circuit, backend)
job = backend.run(new_circuit)
```


## Version 0.7.2

- Bump twine to version 5.1.1

## Version 0.7.1

- Use ipywidget to display job status on notebooks

## Version 0.7.0

- Deprecated Python 3.7 for the provider. Python 3.7 has been officially deprecated since June 27th 2023. ([https://devguide.python.org/versions/](https://devguide.python.org/versions)) This was triggered after ARM chip users experienced issues with installing the provider since Numpy is not built for ARM Python 3.7.
- Set max version of Python to 3.11 for the provider. Python 3.12+ introduces breaking changes to setuptools. The Alice & Bob team will support this version in the near future.
- Changed default remote API URL to `api-gcp.alice-bob.com` instead of `api.alice-bob.com`, following the official release of Felis Cloud on Google Cloud Platform. GCP is now the main point of entry to use Felis Cloud.
- Added a warning when instancing the `AliceBobRemoteProvider` if a new version of the provider is available on pypi.

## Version 0.6.0

- Improved feedback while running circuits using the remote provider

## Version 0.5.4

- Add support for the TDG gate for the logical backends of the remote provider (the TDG gate was already supported on the local provider)

## Version 0.5.3

- Fix a transpilation issue that prevented the usage of logical backends with the remote provider.

## Version 0.5.2

- Fix a transpilation issue for the logical backends, preventing the transpilation of circuits using a cswap gate.

## Version 0.5.1

- Improved transpilation and scheduling for the local backends, to better support programs imported from QASM code.

## Version 0.5.0

- Harmonized the `get_backend` functions of the remote and local provider to act in a similar manner. The following line is now working as it does for local:

```python
remote_provider.get_backend('EMU:6Q:PHYSICAL_CATS', average_nb_photons=4.5, kappa_1=1000)
```

## Version 0.4.2

- Released multi-qubits logical and physical targets for the remote provider, allowing to run these models remotely.

## Version 0.4.1

- Added support for Python 3.11

## Version 0.4.0

- Added logical backends: `EMU:15Q:LOGICAL_EARLY` and `EMU:40Q:LOGICAL_TARGET`