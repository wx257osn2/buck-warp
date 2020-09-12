#!/usr/bin/env sh

BUCK_HOME=$(dirname "$(realpath $0)")

export JAVA_HOME="$BUCK_HOME/jre";

"$BUCK_HOME/python3/bin/python3" "$BUCK_HOME/bin/buck" "$@"
