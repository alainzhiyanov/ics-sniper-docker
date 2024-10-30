#!/usr/bin/env bash



service openvswitch-switch start
ovs-vsctl set-manager ptcp:6640
pip3 install -e /ics-sniper/sutd-swat/swat_emulation_modbus/minicps

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
