# Examples of emulation with Alice & Bob's Qiskit provider

This repository contains examples of local emulations of various types of
quantum processor architectures, using [Alice & Bob's Qiskit provider](https://github.com/Alice-Bob-SW/qiskit-alice-bob-provider).

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


## Running emulator example notebooks on qBraid

[<img src="https://qbraid-static.s3.amazonaws.com/logos/Launch_on_qBraid_white.png" width="150">](https://account.qbraid.com?gitHubUrl=https://github.com/Alice-Bob-SW/emulation-examples.git)

1. To launch the example notebooks on qBraid, click the Launch on qBraid button. It will take you to your qBraid Lab with the repository cloned.
2. From the FILES tab in the left sidebar, double-click on the `emulation-examples` directory, if you are not there already.
3. Open a notebook using the Filebroswer extension on the left panel.
4. Use the `alice & bob` environment which has the correct python packages to run the notebook.
5. You are now ready to run the example notebooks without tedious pip installs!

For other questions or additional help using qBraid, see [Lab Docs](docs.qbraid.com).
