#! /bin/bash
echo "running sc agent "
/etc/netapp/snapcreator/scAgent4.1.2/bin/scAgent start
echo "running old entrypoint with args"
/entrypoint.sh "$@"
