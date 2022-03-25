
#!/bin/bash

SCRIPT_DIR=$( dirname ${BASH_SOURCE[0]} )

export SECRET_KEY_BASE=$(mix phx.gen.secret)

(cd $SCRIPT_DIR && mix phx.server)