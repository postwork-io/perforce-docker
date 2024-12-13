#!/bin/bash

/bin/bash -c "p4 configure set security=3"
/bin/bash -c "p4 protect"
/bin/bash -c "p4dctl start main && tail -F /opt/perforce/servers/main/root/logs/log"