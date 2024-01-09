FROM python:3.10-buster

# Install dependencies including Git and Gettext
RUN apt-get update && apt-get install -y \
    git \
    nano \
    gettext \
    sudo \
    vim \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev \
    libpcap-dev && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Clone OpenCanary repository
RUN git clone https://github.com/thinkst/opencanary.git /opencanary

# Set working directory
WORKDIR /opencanary

# Install Python dependencies
RUN pip install -r requirements.txt
RUN pip install scapy pcapy-ng

# Copy the modified opencanary.conf with placeholders
COPY opencanary.conf /opencanary/opencanary.conf.template

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Make the script executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--dev"]
