#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <ip> <mount_location>"
  exit 1
fi

ip=$1
mount_location=$2

mount_nfs() {
  # Try to mount the NFS share with a 60-second timeout
  if timeout 60 mount -t nfs -o defaults,timeo=20,retrans=5,_netdev "$ip" "$mount_location"; then
    echo "NFS share mounted successfully"
  else
    echo "NFS share mount timed out after 60 seconds"
  fi
}

mount_nfs
