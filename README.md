# Kilo Code Index - Infrastructure

This repository contains the Docker Compose setup for the backing services required by the **Kilo Code Index** system. It provides a local vector database and an LLM inference engine, configured for GPU acceleration.

## Services

### 1. Qdrant (Vector Database)
Stores and searches code embeddings.
- **Image:** `qdrant/qdrant:gpu-nvidia-latest`
- **Ports:**
  - HTTP: `6333`
  - gRPC: `6334`
- **Storage:** Persisted locally in `./qdrant_storage`.
- **Hardware:** Configured for NVIDIA GPU indexing.

### 2. Ollama (LLM Inference)
Local LLM runner for generating embeddings.
- **Build:** Custom build from `./ollama_build`.
- **Port:** `11434`
- **Storage:** Persisted in Docker volume `ollama_data`.
- **Default Model:** Automatically pulls and serves `qwen3-embedding:0.6b` on startup.
- **Hardware:** Configured to use all available GPUs (`gpus: all`).

## Requirements

- **Docker** & **Docker Compose**
- **NVIDIA GPU** with drivers installed.
- **NVIDIA Container Toolkit** (required for Docker to access the GPU).

## Getting Started

1. **Start the infrastructure:**
   ```bash
   docker compose up -d
   ```
   *Note: The first start may take a few minutes as it pulls the Qdrant image and the Ollama model.*

2. **Verify services:**
   - **Qdrant Dashboard:** [http://localhost:6333/dashboard](http://localhost:6333/dashboard)
   - **Ollama API:**
     ```bash
     curl http://localhost:11434/api/tags
     ```
     Should return a JSON list containing `qwen3-embedding:0.6b`.

3. **Logs:**
   Check the logs to see the model pulling progress:
   ```bash
   docker compose logs -f ollama
   ```

## Directory Structure

- `docker-compose.yml`: Main service definition.
- `qdrant_storage/`: Local bind-mount for Qdrant data persistence.
- `ollama_build/`: Contains the Dockerfile and entrypoint script for the customized Ollama image.
