#!/usr/bin/env bash

service openvswitch-switch start
ovs-vsctl set-manager ptcp:6640
pip2 install pandas minicps
pip2 install --force-reinstall -v cpppo==4.3.0

if [ $# -gt 0 ]
then
  if [ "$1" == "mn" ]
  then
    bash -c "$@"
  else
    mn "$@"
  fi
else
  bash
fi

service openvswitch-switch stop
