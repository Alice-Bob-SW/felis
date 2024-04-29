# 15 logical qubits

```python
backend = local.get_backend('EMU:15Q:LOGICAL_EARLY')
# This backend is not available in Alice & Bob Felis cloud service.
```

This backend reproduces what might be the behavior of one of the first useful logical chips, featuring 15 logical qubits with conservative hypotheses on qubit quality.

In this backend, information is physically stored in 13 "data" cat qubits (carrying the information of the logical qubit) and 12 "ancilla" cat qubits (used to perform error detection operations).

Physical qubits are abstracted here - errors are emulated using an analytical formula rather than by emulating the individual behavior of each physical qubit.

Logical error rates are between $10^{-3}$ and $10^{-4}$, but they can be made better (or worse) by tuning the `average_nb_photons`, `kappa_1`, `kappa_2`, and `distance` parameters - see [Chip settings](../../reference/supported_instructions.md) for more details.

You get all-to-all connectivity and a universal gate set.

This backend is well-suited to experimenting with logical qubits.

Its performance is not meant to accurately reproduce a specific current or future Alice & Bob chip.

⚠️ The native gate set of this emulator includes a T gate, which is not planned to be a native logical gate in our target architecture.

Our current target logical gate set is Clifford + Toffoli, which has been proved to be universal:
[https://arxiv.org/pdf/quant-ph/0205115.pdf](https://arxiv.org/pdf/quant-ph/0205115.pdf)
[https://arxiv.org/pdf/quant-ph/0301040.pdf](https://arxiv.org/pdf/quant-ph/0301040.pdf)

We are working on a compilation engine which will target Clifford + Toffoli, but our shortcut with the T gate lets you experiment with the logical mode earlier.