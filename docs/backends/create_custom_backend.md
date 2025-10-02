# Custom Backends

The `AliceBobLocalProvider` allows you to create custom quantum backends with your own parameters, Pauli noise models, and timing models. This gives you full control over backend behavior while leveraging the existing infrastructure.

## Overview

Custom backends enable you to:

- Define custom backend parameters (e.g., `kappa_1`, `kappa_2`, `average_nb_photons`, or any parameters you need)
- Implement custom Pauli noise models for specific quantum gates
- Set custom timing models for gate operations

## Quick Start

In this example, we will build a custom backend in which the X and measurement gates both:
- Feature a X error with probability 0.1
- Take 1e-6 second to execute

### 1. Create a Local Provider and Build Your Models

```python
from qiskit_alice_bob_provider import AliceBobLocalProvider

local = AliceBobLocalProvider()

def x_error(gate_params, backend_params):
  return {
      'X': backend_params['p'],
  }

def x_time(gate_params, backend_params):
  return 1e-6

def measure_error(gate_params, backend_params):
  return {
      'X': backend_params['p'],
  }

def measure_time(gate_params, backend_params):
  return 1e-6
```

### 2. Build Your Custom Backend

```python
custom_cat = local.build_custom_backend(
    backend_parameters={
        'n_qubits': 40,  # Mandatory
        'p': 0.1,
    },
    noise_models={
        'x': x_error,
        'mz': measure_error,
        },
    time_models={
        'x': x_time,
        'mz': measure_time,
    }
)
```

### 3. Run a Circuit on Your Custom Backend

```python
from qiskit import QuantumCircuit

circ = QuantumCircuit(1,1)
circ.x(0)
circ.measure(0,0)

job = custom_cat.run(circ, shots=1000)
print(job.result().get_counts())
```

The output of the code above should be close to `{'0': 180, '1': 820}`, as the expected outcome is:
- No error with probability $0.9^2 = 0.81$ 
- One X error with probability $2*0.9*0.1 = 0.18$
- Two X errors with probability $0.1^2 = 0.01$, cancelling each other out

Note that you need to specify a noise and time model for each gate you use.

## Function Reference

### `build_custom_backend()`

Creates a custom quantum backend with specified parameters and models.

#### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `name` | `str | None` | Name identifier for the custom backend |
| `backend_parameters` | `dict[str, Any] | None` | Backend-specific parameters (e.g., physical constants, device characteristics) |
| `noise_models` | `dict[str, NoiseFunction] | None` | Gate-specific noise functions mapping gate names to noise models |
| `time_models` | `dict[str, TimeFunction] | None` | Gate-specific timing functions mapping gate names to duration models |
| `validate_parameters` | `Callable[[dict[str, float]], bool] | None` | Optional function to validate backend parameters |
| `default_1q_noise_model` | `NoiseFunction | None` | Default noise model applied to all single-qubit gates |
| `default_1q_time_model` | `TimeFunction | None` | Default timing model applied to all single-qubit gates |

#### Function Types

**NoiseFunction**: 

- **Signature**: `(gate_parameters: list[float], backend_parameters: dict[str, Any]) -> dict[str, float]`
- **Returns**: Dictionary with 'X', 'Y', 'Z' Pauli error probabilities
- **Alternative**: Parameter-less function `() -> dict[str, float]` for constant noise

**TimeFunction**:

- **Signature**: `(gate_parameters: list[float], backend_parameters: dict[str, Any]) -> float`
- **Returns**: Gate execution time in appropriate units
- **Alternative**: Parameter-less function `() -> float` for constant duration

## Complete Example

Here is a mode complete example with a 2-qubit gate and default noise and time models.

### Step 1: Define Custom Functions

```python
from qiskit_alice_bob_provider import AliceBobLocalProvider

local = AliceBobLocalProvider()

def default_error(gate_params, backend_params):
  return {
      'X': backend_params['p'],
  }

def default_time(gate_params, backend_params):
  return 1e-6

def measure_error(gate_params, backend_params):
  return {
      'X': backend_params['p'],
  }

def cx_error(gate_params, backend_params):
  return {
      'XI': backend_params['p'],
      'XX': backend_params['p'],
  }

def cx_time(gate_params, backend_params):
  return 1e-6
```

### Step 2: Create the Backend

```python
custom_cat = local.build_custom_backend(
    name='Custom Cat Backend',
    backend_parameters={
        'n_qubits': 40,  # Mandatory
        'p': 0.1,
    },
    noise_models={
        'mz': measure_error,
        'cx': cx_error,
        },
    time_models={
        'mz': measure_time,
        'cx': default_time
    },
    default_1q_noise_model=default_error,
    default_1q_time_model=default_time
)
```

### 3. Run a Circuit on Your Custom Backend

```python
from qiskit import QuantumCircuit

circ = QuantumCircuit(2,1)
circ.x(1)
circ.cx(0,1)
circ.measure(1,0)

job = custom_cat.run(circ, shots=1000)
print(job.result().get_counts())
```

The output of the code above should be close to `{'0': 244, '1': 756}`, as the expected outcome on the second qubit is:
- No error with probability $0.9^3 = 0.729$ 
- One X error with probability $3*0.9^2*0.1 = 0.243$
- Two X errors with probability $3*0.9*0.1^2 = 0.027$, cancelling each other out
- Three X errors with probability $0.1^3 = 0.0001$, yielding a X error

Note that the noise model used for the X gate was the default noise model here. But if you specify a noise model for the X gate, it will override the default noise model.