FROM openshift/jenkins-slave-base-centos7:v3.11 

# update java version to 11
RUN yum install -y java-11-openjdk && yum clean all

# arguments with software versions
ARG KUBECTL_VERSION="1.21.1"
ARG HELM_VERSION="3.6.0"
ARG HADOLINT_VERSION="2.4.1"
ARG TFENV_VERSION="2.2.2"

# update PATH with tfenv directory
ENV PATH="/home/jenkins/.tfenv/bin:${PATH}"

# set workdir
WORKDIR /home/jenkins

# install kubectl
RUN curl -LO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" &&\
    mv kubectl /usr/local/bin/

# install helm 
RUN curl -LO "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" &&\
    tar -zxvf "helm-v${HELM_VERSION}-linux-amd64.tar.gz" &&\
    cp linux-amd64/helm /usr/local/bin/ &&\
    rm -rf linux-amd64 "helm-v${HELM_VERSION}-linux-amd64.tar.gz"

# install helm push plugin
RUN helm plugin install "https://github.com/chartmuseum/helm-push.git"

# install hadolint
RUN curl -L -o /usr/local/bin/hadolint "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64" &&\
    chmod +x /usr/local/bin/hadolint

# install tfenv
RUN curl -L -o "tfenv-v${TFENV_VERSION}.tar.gz" "https://github.com/tfutils/tfenv/archive/refs/tags/v${TFENV_VERSION}.tar.gz" &&\
    tar -vxzf "tfenv-v${TFENV_VERSION}.tar.gz" &&\
    mv "tfenv-${TFENV_VERSION}" .tfenv &&\
    rm "tfenv-v${TFENV_VERSION}.tar.gz"
