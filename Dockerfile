# docker run -d -it --name pytorch_dev_env -v "$(pwd)"/src:/src -w /src intel/intel-optimized-pytorch
# Use an official Python runtime as a parent image
FROM intel/intel-optimized-pytorch

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY ./src /app/src

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install any needed packages specified in requirements.txt
RUN python -m pip install --upgrade pip
# RUN python -m pip install --no-cache-dir ipykernel requests
RUN pip install -r src/requirements.txt

# Set up environment variables
ENV PYTHONUNBUFFERED=1

# Optional: if you need to run as non-root user
RUN useradd -m vscode
USER vscode

# Make port 80 available to the world outside this container
EXPOSE 8888