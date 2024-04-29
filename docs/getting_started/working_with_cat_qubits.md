# Working with cat qubits: similarities & differences

In this page, we assume that you are familiar with transmon qubits like the ones found in IBM systems, and that you have already run circuits using Qiskit.

If this is the case, here is a pragmatic summary of what to expect with Felis.

## What stays the same:

- You design and run quantum circuits made out of gates and qubits using Qiskit
- You can use most if not all of the gates you are used to (at least in logical mode, see below)
- Your circuits can be run on emulators or real hardware (although real hardware requires a specific [Felis Cloud](../felis_cloud/connect_to_felis_cloud.md) subscription)

## What is different:

- There are two types of backends: physical and logical
    - **Physical backends**:
        - Reproduce the behavior of physical cat qubits, therefore exhibiting a strong noise bias (low bit-flip error rates, high phase-flip error rates)
        - May not be used to run quantum algorithms, because they feature a limited set of gates and limited connectivity
        - May be used to study quantum error correction or the properties of cat qubits
    - **Logical backends**:
        - Reproduce the behavior of logical qubits created out of several cat qubits running a quantum error correction code; noise bias may still be present but less so than with physical backends 
        - May be used to run quantum algorithms and study the impact of noise on the quality of their results; they feature a universal set of gates and all-to-all connectivity
        - Abstract away error correction, but let you tune its effect by using the `distance` parameter 
    - Learn more about logical and physical backends [here](../backends/logical_physical.md)
- In both modes:
    - The bit-flip/phase-flip ratio can be tuned by adjusting `average_nb_photons`
    - Additional native operations are available (prepare $\ket{+}$ or $\ket{-}$, measurement along the X axis); learn about them [here](../reference/supported_instructions.md)
    - Emulator backends which are not digital twins let you tune `kappa_1` and `kappa_2` parameters, representing the quality of the cat qubit (a good cat qubit has a low `kappa_1` and a high `kappa_2`)
    - Learn more about cat qubits and their figures of merit [here](why_cat_qubits.md)