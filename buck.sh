#!/usr/bin/env sh

BUCK_HOME=$(dirname "$(realpath $0)")

export JAVA_HOME="$BUCK_HOME/jre";

"$BUCK_HOME/python2/bin/python2" "$BUCK_HOME/bin/buck" "$@"
