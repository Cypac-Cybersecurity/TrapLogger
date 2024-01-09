FROM python:3.10-buster

# Install dependencies
RUN apt-get update && apt-get -yq install --no-install-recommends \
    sudo vim build-essential libssl-dev libffi-dev python-dev libpcap-dev && \
    apt-get autoremove -yq && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /opencanary

# Copy necessary files
COPY opencanary/__init__.py ./opencanary/__init__.py
COPY requirements.txt setup.py ./
COPY bin /opencanary/bin
COPY opencanary ./opencanary
COPY entrypoint.sh /entrypoint.sh

# Install dependencies
RUN pip install -r requirements.txt
RUN pip install scapy pcapy-ng

# Make entrypoint executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "--dev" ]
