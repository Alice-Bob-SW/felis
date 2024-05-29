# Changelog

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