# 6 physical cats

```python
backend = local.get_backend('EMU:6Q:PHYSICAL_CATS')
# This backend is not available in Alice & Bob Felis cloud service.
```

This backend reproduces the behavior of a chip featuring 6 cat qubits, with a circular neighbor connectivity (each qubit has two neighbors).

It only supports bias-preserving gates (see [Supported instructions](../../reference/supported_instructions.md)).

It can be used to implement the smallest error correction code.

![6-physical-qubits coupling map](../../media/going_further/backends/6_physical_qubits_map.png)

This backend is configured to have the same properties as the qubits used in the paper [High-performance repetition cat code using fast noisy operations](https://arxiv.org/abs/2212.11927) [Le Régent et al., 2022]. It is not meant to accurately reproduce a specific current or future Alice & Bob chip.

More details about our assumptions can be found in the comments of the backend’s code: [https://github.com/Alice-Bob-SW/qiskit-alice-bob-provider/blob/main/qiskit_alice_bob_provider/processor/physical_cat.py#L178](https://github.com/Alice-Bob-SW/qiskit-alice-bob-provider/blob/main/qiskit_alice_bob_provider/processor/physical_cat.py#L178)