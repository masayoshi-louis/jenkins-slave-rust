FROM openshift/jenkins-slave-base-centos7

ENV RUST_VERSION=nightly-2018-05-14 \
    CARGO_HOME=$HOME/.cargo \
    PATH=$HOME/.cargo/bin:$PATH

RUN set -x \
    && yum install -y file make gcc-c++ openssl-devel postgresql-devel \
    && curl -sSf https://static.rust-lang.org/rustup.sh > /tmp/rustup.sh \
    && chmod +x /tmp/rustup.sh \
    && /tmp/rustup.sh  --disable-sudo --yes --revision="nightly-2018-05-14" \
    && rm /tmp/rustup.sh \
    && yum clean all -y

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001
