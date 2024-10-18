# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Set environment variables to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    sudo \
    wget \
    cmake \
    libpcap-dev \
    libssl-dev \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install ttyd
RUN git clone https://github.com/tsl0922/ttyd.git /ttyd \
    && cd /ttyd \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && cd / \
    && rm -rf /ttyd

# Clone the HackingTool repository
RUN git clone https://github.com/Z4nzu/hackingtool.git /hackingtool

# Set permissions for the HackingTool directory
RUN chmod -R 755 /hackingtool

# Expose the port ttyd will run on
EXPOSE 10000

# Start ttyd to run the hackingtool with the specified command, allowing for interactive installation and execution
CMD ["bash", "-c", "cd /hackingtool && sudo bash install.sh && sudo hackingtool"]
