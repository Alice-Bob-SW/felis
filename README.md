# Felis, by Alice & Bob

This repository contains both the Felis documentation and sample notebooks that can be used to experiment with Alice & Bob's cat qubits.

## Documentation

Felis' documentation is located in the `docs` fodler and managed with `mkdocs`.

If you're only interested in the documentation, you can simply install `mkdocs` on your python enviroment with `pip`:

```bash
pip install mkdocs-material
```

and then serve the documentation with

```bash
mkdocs serve
```

Alternatively if you're also planning on working with the sample notebooks, we recommend that you use the `uv` package manager to manage the dependencies installation.

For the docs, simply run

```bash
uv run --group docs -- mkdocs serve
```

`uv` will take care of installing all the appropriate dependencies in a dedicated virtual enviroment before serving the docs.

### For maintainers

To publish update to the documentation, simply create a pull request.
Once the PR is approved and rebased, it will trigger the CI and publish
the new version.

## Sample notebooks

Read samples/README.md

## Qiskit provider

Visit https://github.com/Alice-Bob-SW/qiskit-alice-bob-provider
