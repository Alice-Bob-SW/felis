# Backends

## About backends

Our backends are all named following the pattern `[EMU|QPU]:xxQ:NAME`, where:

- `EMU` or `QPU` indicates whether this backend is an emulator (`EMU`) or a real quantum chip (`QPU`)
- `xxQ` indicates the maximum number of qubits of circuits supported by the backend (for example `1Q`, `7Q`, `40Q`…)
- `NAME` describes the chip being used or emulated

**Note:** Although some emulators support circuits with up to 40 qubits, using more than 10 or 15 qubits may result in execution being slow or failing altogether. The exact limit depends on your computer's memory and computing power.

## List of available backends

| Backend | Available in remote provider | Available in local provider |
| --- | --- | --- |
| [QPU:1Q:BOSON_4A](backends_list/boson_4a.md) | ✅ | ❌ |
| [EMU:1Q:LESCANNE_2020](backends_list/lescanne_2020.md) | ✅ | ✅ |
| [EMU:6Q:PHYSICAL_CATS](backends_list/6_physical_cats.md) | ✅ | ✅ |
| [EMU:40Q:PHYSICAL_CATS](backends_list/40_physical_cats.md) | ✅ | ✅ |
| [EMU:15Q:LOGICAL_EARLY](#15-logical-qubits) | ✅ | ✅ |
| [EMU:40Q:LOGICAL_TARGET](#40-logical-qubits) | ✅ | ✅ |

Supported instructions depend on each backend. Click a backends' name to see the instructions it supports.

## Checking available backends

You may list the backends supported by your version of the provider.

Here is an example with the local provider:

```python
from qiskit_alice_bob_provider import AliceBobLocalProvider

local = AliceBobLocalProvider

print(local.backends())
```

Note that some backends are only supported by the remote or the local provider (see the table above to know which).

If one of the backends documented here does not appear in any of your providers, you may need to update your provider with:

```bash
pip install --update qiskit-alice-bob-provider
```