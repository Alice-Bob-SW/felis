# Lescanne 2020

```python
backend = remote.get_backend('EMU:1Q:LESCANNE_2020')
# or 
backend = local.get_backend('EMU:1Q:LESCANNE_2020')
```

This backend is a numerical model emulating the processor used in the [seminal paper](https://arxiv.org/pdf/1907.11729.pdf) by Raphaël Lescanne in 2020, featuring a single cat qubit.

This numerical model is configured to act as a digital twin of the chip used in this paper, using the following parameters:

- Readout assignment matrix for Mz and Mx: P(1|0)=0.02, P(0|1)=0.06
- Perfect preparation for Px and Pz
- Pauli error probabilities interpolated for the “delay/idle” instruction from the T_bf and Gamma_pf plots in the paper

Please note that this design dates back to 2020 and does not represent the current performance of Alice & Bob's cat qubits. Better designs such as [the ones documented here](https://alice-bob.com/2023/07/21/concept-cats-designing-better-qubits/) have been introduced and will soon be available through Felis.