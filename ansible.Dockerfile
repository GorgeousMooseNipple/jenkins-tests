FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y ansible ssh sshpass
RUN apt-get install -y python3-pip
RUN pip install --upgrade pip
RUN pip install pyvmomi==8.0.0.1 --force-reinstall
RUN service ssh start

WORKDIR /workspace
CMD ["/bin/bash"]
