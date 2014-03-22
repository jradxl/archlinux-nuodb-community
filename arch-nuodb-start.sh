#!/bin/sh
#
# Start the NuoDB Agent and WebConsole
# 

die () { echo "$*"; exit 1; }

/opt/nuodb/etc/nuoagent start

/opt/nuodb/etc/nuowebconsole start

exit 0

