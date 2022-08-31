#!/bin/bash

#InstallFirstServer.sh
set -e
set -x

export NODE_1=10.154.2.93
export NODE_2=10.154.2.98
export NODE_3=10.154.2.88
export USER=root

# The first server starts the cluster
/usr/local/bin/k3sup install\
 --k3s-version 'v1.17.5+k3s1'\
 --cluster\
 --context nico-clust\
 --user $USER\
 --ip $NODE_1