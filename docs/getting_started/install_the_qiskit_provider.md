# Install the Qiskit provider

## Installation instructions

⚠️ No installation is required if you use Felis through OVH’s AI Notebooks. Get started [here](https://www.ovhcloud.com/en/public-cloud/ai-notebooks/).

Instructions below let you install Felis on your computer as an open source library.

## 0. Set up your environment

Qiskit is a Python framework, requiring Python 3.7 or later according to the [Qiskit documentation](https://qiskit.org/documentation/getting_started.html).

We assume you know how to install Python and set up an environment.

If you don’t, you can [go through the Python docs](https://www.python.org/about/gettingstarted/), or simply [reach out](../contact_us.md). We’ll be happy to help.

## 1. Get an API key

An API key is mandatory if you want to run circuits on real hardware.

Emulation can be run locally with no API key, but speed and max number of qubits will depend on the specs of your machine.

If you are part of our hardware beta program, you should have received an API key from us in your welcome email.

If you haven’t, or if you have lost your key, please [let us know](../contact_us.md).

## 2. Install the Alice & Bob Qiskit provider

```bash
pip install --upgrade qiskit-alice-bob-provider
```

Note: no need to install Qiskit separately, it will be installed automatically if it is not already installed.


⚠️ We are currently incompatible with the latest version of Qiskit (0.45) because of the breaking changes it introduces. We are currently reviewing the impact of these changes and will update this page when we are done.

In the mean time, you’ll need to run the provider in an environment using an earlier version of Qiskit.



## 3. Write your first Qiskit program

To use the Alice & Bob Qiskit provider in a Qiskit program, you need to instantiate it and retrieve a backend.

```python
from qiskit_alice_bob_provider import AliceBobRemoteProvider

# Replace the placeholder with your actual API key in the line below
ab = AliceBobRemoteProvider(api_key='YOUR_API_KEY')

print(ab.backends())
backend = ab.get_backend('EMU:1Q:LESCANNE_2020')
```

You may then use this backend to execute Qiskit circuits.

Don’t forget to add your API key in the sample code above!

For a complete example, please read [A first example](a_first_example.md) 


💡 Note: our examples all use `AliceBobRemoteProvider`, which runs the circuits on Alice & Bob machines, but you may also use `AliceBobLocalProvider`, which is limited to emulators and runs on your own machine.
Read more about this provider at [The local Qiskit provider](../about_api_providers/the_local_provider.md).

