# 40 logical qubits

```python
backend = local.get_backend('EMU:40Q:LOGICAL_TARGET')
# This backend is not available in Alice & Bob Felis cloud service.
```

This backend reproduces what might be the behavior of a mature logical chip, featuring 40 logical qubits. It is built using optimistic (but not unrealistic) hypotheses on qubit quality, taken from [this paper](https://arxiv.org/abs/2302.06639) and a distance 15 repetition code.

Just like for `EMU:15Q:LOGICAL_EARLY`, physical qubit behavior is abstracted, you get all-to-all connectivity and a universal gate set (temporarily including a T gate).

Error rates are extremely low (about $10^{-16}$), so this backend should be virtually impossible to distinguish from a noiseless backend when running short circuits.

This backend is well-suited to studying fault-tolerant algorithms on small instances of problems.

Its performance is not meant to accurately reproduce a specific current or future Alice & Bob chip.


⚠️ Although this backend makes it possible to choose from 40 different qubits, using it to run circuits using more than ~10-15 qubits will likely be slow or fail altogether. The exact limit depends on the capabilities of your machine.

By the time we have real chips featuring such low error rates, we will likely have much more than 40 logical qubits. But you’ll need terabytes of memory to run a 40 qubit emulator, so we thought it didn’t make sense to allow more here ;)

⚠️ The native gate set of this emulator includes a T gate, which is not planned to be a native logical gate in our target architecture.

Our current target logical gate set is Clifford + Toffoli, which has been proved to be universal:
[https://arxiv.org/pdf/quant-ph/0205115.pdf](https://arxiv.org/pdf/quant-ph/0205115.pdf)
[https://arxiv.org/pdf/quant-ph/0301040.pdf](https://arxiv.org/pdf/quant-ph/0301040.pdf)

We are working on a compilation engine which will target Clifford + Toffoli, but our shortcut with the T gate lets you experiment with the logical mode earlier.