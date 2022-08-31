#!/bin/bash

#3_InstallThirdServer.sh
set -e
set -x

export NODE_1=10.154.2.93
export NODE_2=10.154.2.98
export NODE_3=10.154.2.88
export USER=root

# The first server starts the cluster
/usr/local/bin/k3sup join \
  --k3s-version 'v1.17.5+k3s1' \
  --ip $NODE_3 \
  --user $USER \
  --server-user $USER \
  --server-ip $NODE_1