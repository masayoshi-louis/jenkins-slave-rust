FROM openshift/jenkins-slave-base-centos7

ENV CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.31.1

RUN set -eux; \
    yum install -y file make gcc-c++ openssl-devel postgresql-devel; \
    curl https://static.rust-lang.org/rustup/archive/1.16.0/x86_64-unknown-linux-gnu/rustup-init -sSf > /tmp/rustup-init.sh; \
    echo "2d4ddf4e53915a23dda722608ed24e5c3f29ea1688da55aa4e98765fc6223f71 /tmp/rustup-init.sh" | sha256sum -c -; \
    chmod +x /tmp/rustup-init.sh; \
    /tmp/rustup-init.sh -y --no-modify-path --default-toolchain $RUST_VERSION; \
    chmod -R a+w $CARGO_HOME; \
    rm /tmp/rustup-init.sh; \
    yum clean all -y

RUN chown -R 1001:0 $CARGO_HOME; \
    chmod -R g+rw $CARGO_HOME

USER 1001
