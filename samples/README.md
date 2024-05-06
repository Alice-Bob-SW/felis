# Sample notebooks for Felis and Felis Cloud

This repository contains sample notebooks to help you experiment with cat qubits
It uses [Felis, Alice & Bob's Qiskit provider](https://github.com/Alice-Bob-SW/qiskit-alice-bob-provider)
and may require a [Felis Cloud](https://felis.alice-bob.com/docs/felis_cloud/about_felis_cloud/) subscription
to run circuits on a real quantum hardware.

To install dependencies and run:
```
pip install -r requirements.txt
jupyter notebook
```

We recommend to install dependencies in a virtual environment to avoid
messing your system-wide Python installation:

```
python -m venv venv
. venv/bin/activate
pip install -r requirements.txt
python -m jupyter notebook
```