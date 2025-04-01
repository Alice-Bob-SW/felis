# Sample notebooks for Felis and Felis Cloud

This folder contains sample notebooks to help you experiment with cat qubits.
It uses [Felis, Alice & Bob's Qiskit provider](https://github.com/Alice-Bob-SW/qiskit-alice-bob-provider)
and may require a [Felis Cloud](https://felis.alice-bob.com/docs/felis_cloud/about_felis_cloud/) subscription
to run circuits on a real quantum hardware.

## Prerequisites

The project is managed with `uv`, a modern Python package manager. If not already installed:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## Running Locally (without Docker)

There are two main ways to run the notebooks locally (without Docker), depending on whether you already have Jupyter installed:

---

### Option 1: You already have Jupyter installed globally

If you already have a Jupyter Lab/Notebook instance and just want to install the Python dependencies required to run the code inside our notebooks:

```bash
uv sync --group kernel
```

This will install all the dependencies necessary.

Then register the environment as a Jupyter kernel:

```bash
uv run -- python -m ipykernel install --user --name=felis --display-name "Felis (uv)"
```

You can then just open your Jupyter environment and browse to the `samples/` folder to run the notebooks, making sure you select the `Felis (uv)` kernel.

---

### Option 2: You want to use an isolated Jupyter environment

If you don’t have Jupyter installed or prefer to use a fresh environment for this project, you can simply run:

```bash
uv run --group jupyter -- jupyter lab
```

This will:

- Create a `.venv/` folder (if one doesn’t exist)
- Install the core dependencies for our notebooks **plus** Jupyter Lab
- Launch Jupyter Lab in your browser

---

### 📁 Where to run the commands from?

You can run all of the above commands either:

- From the project **root** directory, or
- From the `samples/` subfolder directly

However, note:

> 🧠 If you run `uv run` or `uv sync` for the first time **from `samples/`**, the virtual environment `.venv/` will be created in the `samples/` folder instead of the project root.

For consistency, we recommend running from the project root unless you only care about the samples.

---

## Running with Docker

We also provide a `Dockerfile` if you want to run the notebooks in a contained environment.

> Run all the following commands from the root directory of the repository where the `Dockerfile` is located.

### 1. Build the image

```bash
docker build -t felis-samples .
```

### 2. Run the container

```bash
docker run -p 8888:8888 felis-samples
```

Then open [http://localhost:8888/lab](http://localhost:8888/lab) in your browser.

---

## Mounting local `samples/` folder in Docker

For live editing or if you want to use different notebooks you can also decide to mount your local `samples/` directory:

```bash
docker run -p 8888:8888 -v "$(pwd)/samples:/home/jupyter/app/samples" felis-samples
```
