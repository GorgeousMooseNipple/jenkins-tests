FROM python:3.14-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y ansible sshpass
RUN pip install --upgrade pip
RUN pip install pyvmomi==8.0.0.1 --force-reinstall

WORKDIR /workspace
CMD ["/bin/bash"]
