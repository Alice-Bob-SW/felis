# Sample notebook library

## A sample notebook repository

A set of introductory notebooks is available in the following repository:

[https://github.com/Alice-Bob-SW/emulation-examples](https://github.com/Alice-Bob-SW/emulation-examples)

We recommend starting with these examples!

## Bell state preparation

```python
from qiskit_alice_bob_provider import AliceBobLocalProvider
from qiskit import QuantumCircuit, execute, transpile

provider = AliceBobLocalProvider()

circ = QuantumCircuit(2, 2)
circ.initialize('0+')
circ.cx(0, 1)
circ.measure(0, 0)
circ.measure(1, 1)

print(circ.draw())
#      ┌──────────────────┐     ┌─┐   
# q_0: ┤0                 ├──■──┤M├───
#      │  Initialize(0,+) │┌─┴─┐└╥┘┌─┐
# q_1: ┤1                 ├┤ X ├─╫─┤M├
#      └──────────────────┘└───┘ ║ └╥┘
# c: 2/══════════════════════════╩══╩═
                               0  1 

# Default 6-qubit QPU with the ratio of memory dissipation rates set to
# k1/k2=1e-5 and cat size average_nb_photons set to 16.
backend = provider.get_backend('EMU:6Q:PHYSICAL_CATS')

print(transpile(circ, backend).draw())
# Timed and scheduled circuit:
#                 ┌───────────────┐                       ┌─┐   
#       q_0 -> 0 ─┤ Initialize(+) ├────────────────────■──┤M├───
#                 ├───────────────┤ ┌───────────────┐┌─┴─┐└╥┘┌─┐
#       q_1 -> 1 ─┤ Initialize(0) ├─┤ Delay(99[dt]) ├┤ X ├─╫─┤M├
#                ┌┴───────────────┴┐└───────────────┘└───┘ ║ └╥┘
# ancilla_0 -> 2 ┤ Delay(1050[dt]) ├───────────────────────╫──╫─
#                ├─────────────────┤                       ║  ║ 
# ancilla_1 -> 3 ┤ Delay(1050[dt]) ├───────────────────────╫──╫─
#                ├─────────────────┤                       ║  ║ 
# ancilla_2 -> 4 ┤ Delay(1050[dt]) ├───────────────────────╫──╫─
#                ├─────────────────┤                       ║  ║ 
# ancilla_3 -> 5 ┤ Delay(1050[dt]) ├───────────────────────╫──╫─
#                └─────────────────┘                       ║  ║ 
#           c: 2/══════════════════════════════════════════╩══╩═
#                                                          0  1

print(execute(circ, backend, shots=100000).result().get_counts())
# {'11': 49823, '00': 50177}

# Changing the cat size from 16 (default) to 4 and k1/k2 to 1e-2.
backend = provider.get_backend('EMU:6Q:PHYSICAL_CATS', average_nb_photons=4, kappa_2=1e4)
print(execute(circ, backend, shots=100000).result().get_counts())
# {'01': 557, '11': 49422, '10': 596, '00': 49425}
```

## Error detection code

```python
from qiskit_alice_bob_provider import AliceBobLocalProvider
from qiskit import QuantumCircuit, execute, transpile
from qiskit_aer import AerSimulator

provider = AliceBobLocalProvider()

def build_circuit(initial_state: str = '+++') -> QuantumCircuit:
    """A distance 3 error detection code with a single measurement cycle"""
    circ = QuantumCircuit(5, 5)
    
		# Data qubits state preparation
    circ.initialize(initial_state, [0, 2, 4])
    
    circ.barrier()
    
		# Ancilla qubits state preparation
    for i in [1, 3]:
        circ.initialize('+', i)
    
		# Syndrome measurement cycle
    for j in [-1, 1]:
        for i in [1, 3]:
            circ.cx(i, i + j)
    for i in [1, 3]:
        circ.measure_x(i, i)
    
    circ.barrier()
    
		# Data qubits measurement
    for i in [0, 2, 4]:
        circ.measure_x(i, i)

    return circ

# Distance 3 detection code
circ = build_circuit('+++')

print(circ.draw())
# *Prints an abstract circuit*

# Noiseless emulation
print(execute(circ.decompose(), AerSimulator(), shots=100000).result().get_counts())
# {'00000': 100000}

# Distance-3 detection code with a phase flip in the middle data qubit
circ = build_circuit('+-+')

# Noiseless emulation
print(execute(circ.decompose(), AerSimulator(), shots=100000).result().get_counts())
# {'01110': 100000}

# Emulation on physical cat qubits

# Default 6-qubit QPU with the ratio of memory dissipation rates set to
# k1/k2=1e-5 and cat size average_nb_photons set to 16.
backend = provider.get_backend('EMU:6Q:PHYSICAL_CATS')

print(transpile(circ, backend).draw())
# *Prints a timed and scheduled circuit*

results = execute(circ, backend, shots=100000).result().get_counts()
for word, observations in sorted(results.items(), key=lambda t: -t[1]):
    print(word, ':', observations)
# 01110 : 95734
# 01100 : 1999
# 00110 : 1909
# 01111 : 65
# 00100 : 59
# 10110 : 59
# 00000 : 48
# 01010 : 38
# 11110 : 35
# 01101 : 34
# 01000 : 17
# 00010 : 2
# 00111 : 1
```

## More complex examples

The following notebook contains more complex examples:

- Bit flip and phase flip scaling for the `EMU:1Q:LESCANNE_2020` model
- Study of Zeno gates oscillations with `EMU:6Q_PHYSICAL_CATS`
- Performance of a phase error correction code for various distances, using `EMU:6Q_PHYSICAL_CATS`

[demo.ipynb](https://file.notion.so/f/f/ea0e2d0b-186f-4506-b869-4ee2c5b1a1a7/372905b5-cb42-4968-b19f-853c549e0c3c/demo.ipynb?id=e2290f9e-d547-4329-aa87-b369e3c9c70d&table=block&spaceId=ea0e2d0b-186f-4506-b869-4ee2c5b1a1a7&expirationTimestamp=1713945600000&signature=85p36jZhfjhsgiUmTPmPX-_ed0OWVmk72rPE8xYwsRo&downloadName=demo.ipynb)