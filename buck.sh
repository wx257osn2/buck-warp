#!/usr/bin/env sh

BUCK_HOME=$(dirname "$(realpath $0)")

export JAVA_HOME="$BUCK_HOME/jre";

export PATH=$BUCK_HOME/python2/bin:${PATH}

python2 "$BUCK_HOME/bin/buck" "$@"
