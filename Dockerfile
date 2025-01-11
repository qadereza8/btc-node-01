FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download and install Bitcoin Core
RUN wget https://bitcoincore.org/bin/bitcoin-core-27.1/bitcoin-27.1-x86_64-linux-gnu.tar.gz && \
    tar -xzf bitcoin-27.1-x86_64-linux-gnu.tar.gz && \
    install -m 0755 -o root -g root -t /usr/local/bin bitcoin-27.1/bin/*

# Create data directory
RUN mkdir /root/.bitcoin

# Copy bitcoin.conf
COPY bitcoin.conf /root/.bitcoin/bitcoin.conf

# Expose RPC port (optional)
EXPOSE 8332

# Start Bitcoin Core
CMD ["bitcoind", "-daemon"]
