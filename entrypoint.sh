#!/bin/bash

p4d configure set security=3
p4d protect
p4dctl start main && tail -F /opt/perforce/servers/master/root/logs/log