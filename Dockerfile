# devcontainer build --workspace-folder . --image-name torch_dev_image
# docker run -d -it --name torch_dev_container -v "$(pwd)"/src:/src -w /src torch_dev_image
# Use an official Python runtime as a parent image
FROM intel/intel-optimized-pytorch

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*


# Optional: if you need to run as non-root user
RUN useradd -m vscode
USER vscode

# Copy the current directory contents into the container at /app
RUN mkdir /home/vscode/src
COPY ./src /home/vscode/src

WORKDIR /home/vscode

# Install any needed packages specified in requirements.txt
RUN python -m pip install --upgrade pip
# RUN python -m pip install --no-cache-dir ipykernel requests
RUN pip install -r vscode/src/requirements.txt

# Set up environment variables
ENV PYTHONUNBUFFERED=1

# Make port 8888 available to the world outside this container
EXPOSE 8888