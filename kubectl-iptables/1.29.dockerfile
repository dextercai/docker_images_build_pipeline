FROM debian:12

RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg iptables sudo bash

RUN sudo mkdir -p -m 755 /etc/apt/keyrings
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring   

RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
RUN sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list

RUN sudo apt-get update && \
    sudo apt-get install -y kubectl
