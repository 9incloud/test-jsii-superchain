FROM jsii/superchain:1-buster-slim

ARG AWS_CLI_V2_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'
ARG CRED_PROCESS_URL='https://raw.githubusercontent.com/pahud/vscode/main/.devcontainer/bin/aws-sso-credential-process'

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

#USER gitpod

USER superchain:superchain

COPY ./.gitpod/oh-my-zsh.sh ./.gitpod/oh-my-zsh.sh

# Install Oh-My-Zsh and setup zsh
RUN sudo chmod +x ./.gitpod/oh-my-zsh.sh && ./.gitpod/oh-my-zsh.sh


# start zsh
CMD ["zsh"]
