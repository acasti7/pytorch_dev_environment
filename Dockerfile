# devcontainer build --workspace-folder . --image-name torch_dev_image
# docker run -d -it --name torch_dev_container -v "$(pwd)"/src:/src -w /src torch_dev_image
# Use an official Python runtime as a parent image
FROM intel/intel-optimized-pytorch

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*


# Optional: if you need to run as non-root user
RUN useradd -ms /bin/bash vscode
USER vscode
WORKDIR /home/vscode
#RUN chown -R vscode:vscode /home

# Copy the current directory contents into the container at /app
RUN mkdir /home/vscode/app
COPY ./src /home/vscode/app

# Install any needed packages specified in requirements.txt
RUN python -m pip install --upgrade pip
# RUN python -m pip install --no-cache-dir ipykernel requests
RUN pip install -r /home/vscode/app/requirements.txt