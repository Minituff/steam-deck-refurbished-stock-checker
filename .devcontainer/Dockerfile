# https://github.com/devcontainers/images/tree/main/src/python
FROM mcr.microsoft.com/devcontainers/python:3.13

# These files must be ignored in the docker ignore
COPY requirements.txt /tmp/app/requirements.txt
COPY requirements-dev.txt /tmp/app/requirements-dev.txt

RUN echo "Installing packages..." && \
  apt-get update && \
  apt-get install -y --no-install-recommends nano curl jq dos2unix && \
  rm -rf /var/lib/apt/lists/* && \
  echo "Packages installed."

RUN echo "Installing Python packages..." && \
  # This will also install everything in requirements.txt file
  python3 -m pip install --upgrade pip && \
  python3 -m pip --no-cache-dir install -r /tmp/app/requirements-dev.txt && \
  echo "Installation complete."
