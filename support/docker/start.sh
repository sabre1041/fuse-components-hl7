#!/bin/bash

# Start Fuse
/opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/bin/start

exec "$@"
