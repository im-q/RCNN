# Build

* If you want to use the `--squash` option in the below command, enable Docker experimental features (**CAUTION**: the shell redirection below will overwrite an existing `daemon.json` config file)

      echo '{ "experimental": true }' > /etc/docker/daemon.json && systemctl restart docker

* Build docker container

      docker build -t openhorizon/aarch64-tx2-tensorrt-3.0-cuda9.0:latest -f Dockerfile.tensorrt3.0-CUDA9 --squash --no-cache --compress .
