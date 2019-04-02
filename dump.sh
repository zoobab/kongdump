#!/bin/bash
set -e

URL="https://willing-newt-kong-admin.kong.svc.cluster.local:8444"
ENDPOINTS="certificates consumers plugins routes services snis upstreams"
DATADIR="$PWD/data"

mkdir -p $DATADIR
for i in $ENDPOINTS; do
    mkdir -p $DATADIR/$i
    curl -k -s $URL/$i | jq '.data | .[]' > $DATADIR/$i/out.json
done
