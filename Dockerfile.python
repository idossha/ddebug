# Dockerfile for debugging

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    # core system utilities
    curl \
    git \
    unzip \
    tar \
    \
    python3.11 \
    python3-pip \
    python3-venv \
    python3-dev \

    # command line tools
    bc \
    jq \
    vim \
    tmux \
    tree \
    parallel \ 
    \
    # Testing tools
    bats \
    \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Python packages and create symlinks
Run python3.11 -m pip install --upgrade pip

# Clones the repo
RUN git clone https://github.com/idohaber/ddebug.git /ddebug
  
# Install Neovim v.0.11.0 from source 
RUN git clone https://github.com/neovim/neovim.git /tmp/neovim \
    && cd /tmp/neovim \
    && git checkout v0.11.0 \
    && make CMAKE_BUILD_TYPE=Release \ 
    && make install \
    && rm -rf /tmp/neovim

# Create symlinks for config files
RUN ln -sf /ddebug/config/.tmux.conf /root/.tmux.conf && \
ln -sf /ddebug/config/nvim /root/.config/

# Install plugins using lazy.nvim
RUN nvim --headless "+LAZY! sync" +qa

# Source tmux
RUN tmux source-file /root/.tmux.conf || true

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
WORKDIR /workspace

