# Custom Backends

The `AliceBobLocalProvider` allows you to create custom quantum backends with your own parameters, noise models, and timing models. This gives you full control over backend behavior while leveraging the existing infrastructure.

## Overview

Custom backends enable you to:

- Define custom backend parameters (e.g., `kappa_1`, `kappa_2`, `average_nb_photons`, or any parameters you need)
- Implement custom noise models for specific quantum gates
- Set custom timing models for gate operations

## Quick Start

### 1. Create a Local Provider

```python
from qiskit_alice_bob_provider import AliceBobLocalProvider

local = AliceBobLocalProvider()
```

### 2. Build Your Custom Backend

```python
custom_backend = local.build_custom_backend(
    name='My Custom Backend',
    backend_parameters={
        'd': 2,
        'nbar': 2,
        'k1': 20,
        'k2': 200
    },
    noise_models={
        'delay': custom_delay_error_function
    },
    time_models={
        'delay': custom_delay_time_function
    },
    default_1q_noise_model=lambda: {'X': 0.001, 'Y': 0.001, 'Z': 0.001},
    default_1q_time_model=lambda: 0.1
)
```

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

Here's a step-by-step example creating a custom backend for cat qubits with delay gate modeling:

### Step 1: Define Custom Functions

```python
def custom_delay_error(gate_parameters: list[float], backend_parameters: dict[str, Any]) -> dict[str, float]:
    """Calculate delay-induced errors based on physical parameters."""
    from qiskit_alice_bob_provider.processor.logical_cat import LogicalCat
    
    # Extract backend parameters with defaults
    distance = backend_parameters.get('d', 2)
    nbar = backend_parameters.get('nbar', 2)
    kappa_1 = backend_parameters.get('k1', 20)
    kappa_2 = backend_parameters.get('k2', 200)
    
    # Get gate duration from gate parameters
    duration = gate_parameters[0]
    
    # Calculate and return error probabilities
    return LogicalCat._delay_error(duration, distance, nbar, kappa_1, kappa_2)

def custom_delay_time(gate_parameters: list[float], backend_parameters: dict[str, Any]) -> float:
    """Return the delay duration directly from gate parameters."""
    return gate_parameters[0]
```

### Step 2: Create the Backend

```python
# Initialize provider
local = AliceBobLocalProvider()

# Build custom backend
custom_cat = local.build_custom_backend(
    name='Custom Cat Backend',
    backend_parameters={
        'd': 2,        
        'nbar': 2,     
        'k1': 20,      
        'k2': 200      
    },
    noise_models={
        'delay': custom_delay_error
    },
    time_models={
        'delay': custom_delay_time
    },
    # Default models for single-qubit gates
    default_1q_noise_model=lambda: {'X': 0.001, 'Y': 0.001, 'Z': 0.001},
    default_1q_time_model=lambda: 0.1
)
```

### Step 3: Use Your Backend

```python
# Your custom backend is now ready for circuit transpilation and execution
# Use it like any other Qiskit backend
```