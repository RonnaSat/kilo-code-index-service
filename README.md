# Kilo Code Index - Infrastructure

This repository contains the Docker Compose setup for the backing services required by the **Kilo Code Index** system. It spins up a local vector database and an LLM inference engine.

## Services

- **Qdrant**: Vector database used for storing and searching code embeddings.
  - HTTP Port: `6333`
  - gRPC Port: `6334`
  - Storage: `./qdrant_storage`

- **Ollama**: Local LLM runner for generating embeddings and handling inference.
  - Port: `11434`
  - Storage: `./ollama`
  - Configuration: Managed via `ollama-startup.sh`

## Getting Started

1. **Start the infrastructure:**
   ```bash
   docker compose up -d
   ```

2. **Verify services:**
   - **Qdrant:** [http://localhost:6333/dashboard](http://localhost:6333/dashboard)
   - **Ollama:** Check logs or query the API.

3. **Connect Kilo Code Index:**
   Configure your Kilo Code Index application to point to these local services.

## Requirements

- Docker
- Docker Compose
- NVIDIA GPU (recommended for Ollama performance)