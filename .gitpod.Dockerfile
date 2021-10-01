FROM jsii/superchain:1-buster-slim

ARG AWS_CLI_V2_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'

USER root:root

# Install custom tools, runtime, etc.
RUN ["apt-get", "update"]

RUN ["apt-get", "install", "-y", "zsh", "&&", "apt-get", "install", "-y", "jq", "wget"]

# install aws-sso-credential-process
RUN cd /usr/local/bin && \
  curl -o aws-sso-credential-process "${CRED_PROCESS_URL}" && \
  chmod +x aws-sso-credential-process

#USER gitpod

USER superchain:superchain

# install aws cdk && aws-cli v2
RUN npm i -g aws-cdk && \
  curl "${AWS_CLI_V2_URL}" -o "awscliv2.zip" && \ 
  unzip /tmp/awscliv2.zip && \
  sudo ./aws/install

COPY ./.gitpod/oh-my-zsh.sh ./.gitpod/oh-my-zsh.sh

# Install Oh-My-Zsh and setup zsh
RUN sudo chmod +x ./.gitpod/oh-my-zsh.sh && ./.gitpod/oh-my-zsh.sh


# start zsh
CMD ["zsh"]
