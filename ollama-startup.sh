#!/bin/bash
set -e

# Configuration
MODEL_NAME="embeddinggemma"

echo "Starting Ollama..."
/bin/ollama serve &
OLLAMA_PID=$!

# Wait for Ollama to wake up
echo "Waiting for Ollama API..."
until /bin/ollama list >/dev/null 2>&1; do
  sleep 1
done

# Check if model exists, otherwise pull it
if /bin/ollama list | grep -q "$MODEL_NAME"; then
  echo "Model '$MODEL_NAME' is ready."
else
  echo "Pulling '$MODEL_NAME'..."
  /bin/ollama pull "$MODEL_NAME"
fi

echo "Initialization complete. Ollama is running."

# Keep the script running to keep the container alive
wait $OLLAMA_PID
