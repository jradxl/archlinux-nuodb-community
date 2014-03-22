#!/bin/sh
#
# Start the NuoDB Agent and WebConsole
# 

die () { echo "$*"; exit 1; }

/opt/nuodb/etc/nuoagent stop

/opt/nuodb/etc/nuowebconsole stop

exit 0



