FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \ 
    git \
    build-essential \
    cmake \
    ninja-build \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter/app

COPY --chown=jupyter:jupyter pyproject.toml uv.lock ./
COPY --chown=jupyter:jupyter samples/ samples/

RUN uv sync --group jupyter --frozen

FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

RUN useradd --create-home --shell /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter/app

COPY --from=builder --chown=jupyter:jupyter /home/jupyter/app /home/jupyter/app

EXPOSE 8888

CMD ["uv", "run", "--", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''"]
