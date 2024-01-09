FROM python:3.10-buster

# Download cache lists and install minimal versions
RUN apt-get update && apt-get -yq install --no-install-recommends \
    sudo vim build-essential libssl-dev libffi-dev python-dev libpcap-dev && \
    apt-get autoremove -yq && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install required pip dependencies
RUN pip install opencanary scapy pcapy-ng

# Copy config file across
COPY opencanary.conf /root/.opencanary.conf

# Copy the Python script for updating the configuration
COPY update_config.py /update_config.py

# Set the default application we are running
ENTRYPOINT ["python", "/update_config.py"]
#ENTRYPOINT [ "opencanaryd" ]

# Set the default arguments to be used for the entrypoint
CMD ["--dev"]
