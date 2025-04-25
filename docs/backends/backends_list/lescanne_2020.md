# Lescanne 2020

Backend name : `EMU:1Q:LESCANNE_2020`

Backend type : Emulator, physical

# About this backend
`EMU:1Q:LESCANNE_2020` is a numerical model emulating the processor used in the [seminal paper](https://arxiv.org/pdf/1907.11729.pdf) by Raphaël Lescanne in 2020, featuring a single cat qubit.

This numerical model is configured to act as a digital twin of the chip used in this paper, using the following parameters:

- Readout assignment matrix for Mz and Mx: P(1|0)=0.02, P(0|1)=0.06
- Perfect preparation for Px and Pz
- Pauli error probabilities interpolated for the “delay/idle” instruction from the T_bf and Gamma_pf plots in the paper

Please note that this design dates back to 2020 and does not represent the current performance of Alice & Bob's cat qubits. Better designs such as [the ones documented here](https://alice-bob.com/2023/07/21/concept-cats-designing-better-qubits/) have been introduced and will soon be available through Felis.

# Supported backend parameters
- `average_nb_photons`
    - Supported values: 1 to 7

Read more about backend parameters [here](../set_parameters.md)

# Supported gates
- `delay`
- `initialize(value, 0)`
    - `value` can only be one of the following: `0`, `1`, `+` or `-`
- `z(0)`
- `rz(0)`
- `measure(0, clbit_index)`
- `measure_x(0, clbit_index)`

Read more about supported gates [here](../../reference/supported_instructions.md).

# Supported providers
- ✅ `AliceBobLocalProvider`
- ✅ `AliceBobRemoteProvider`

# Connectivity

N/A - This backend features a single qubit.

# Expected performance
A sample notebook showing this backend's bit-flip and phase-flip scaling is available at https://github.com/Alice-Bob-SW/felis/blob/main/samples/1_hardware_experiments/1%20-%20Bit-flip%20and%20phase-flip%20scaling%20on%20a%20physical%20qubit.ipynb.

# Availability schedule
As an emulator, this backend is expected to be available 24/7.

Live status for backends is available at [https://api-gcp.alice-bob.com/console/status](https://api-gcp.alice-bob.com/console/status).