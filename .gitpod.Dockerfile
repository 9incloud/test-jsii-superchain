FROM jsii/superchain:1-buster-slim

ARG AWS_CLI_V2_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'
ARG CRED_PROCESS_URL='https://raw.githubusercontent.com/pahud/vscode/main/.devcontainer/bin/aws-sso-credential-process'
ARG USERNAME=gitpod
ARG USER_UID=33333
ARG USER_GID=33333

USER root:root

# Install custom tools, runtime, etc.
RUN ["apt-get", "update"]

RUN ["apt-get", "install", "-y", "zsh", "jq", "wget"]

# install aws-sso-credential-process
RUN cd /usr/local/bin && \
  curl -o aws-sso-credential-process "${CRED_PROCESS_URL}" && \
  chmod +x aws-sso-credential-process

# install aws cdk && aws-cli v2
RUN npm i -g aws-cdk && \
  curl "${AWS_CLI_V2_URL}" -o "/tmp/awscliv2.zip" && \ 
  unzip /tmp/awscliv2.zip -d /tmp && \
  /tmp/aws/install

# Setup user
RUN mkdir -p /etc/sudoers.d

RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME

RUN chmod 0440 /etc/sudoers.d/$USERNAME

USER superchain:superchain
