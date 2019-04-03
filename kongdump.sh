#!/bin/bash

if [[ "$#" -ne "1" ]] ; then
    echo "Error, please a cluster URL"
    echo "Usage: $0 https://willing-newt-kong-admin.kong.svc.cluster.local:8444"
    exit 1
fi

URL="$1"
ENDPOINTS="certificates consumers plugins routes services snis upstreams"
DATADIR="$PWD/data"

function check_command() {
  PROGRAM=$1
  command -v $PROGRAM >/dev/null 2>&1 || { echo "ERROR, this script requires $PROGRAM but it's not installed.  Aborting." >&2; exit 1; }
}

function check_commands() {
  for i in "$@"; do
    check_command $i
  done
}

check_commands curl jq mkdir

mkdir -p $DATADIR
for ENDPOINT in $ENDPOINTS; do
    echo "Dumping $ENDPOINT"
    mkdir -p $DATADIR/$ENDPOINT
    ITEMS=$(curl -k -s $URL/$ENDPOINT | jq '.data')
    if [ ! -z "$ITEMS" ]; then
        IDS=$(echo "$ITEMS" | jq -r '.[] | .id' )
        COUNT="-1"
        for ID in $IDS ; do
            let "COUNT=$COUNT+1"
            ITEM=$(echo $ITEMS | jq -r .[$COUNT])
            echo "$ITEM" > $DATADIR/$ENDPOINT/$ID.json
            if [[ "$ENDPOINT" == *consumer* ]]; then
                APIKEYS=$(curl -k -s $URL/$ENDPOINT/$ID/key-auth | jq '.data | .[]')
                if [ ! -z "$APIKEYS" ]; then
                    echo "Dumping keys"
                    mkdir -p $DATADIR/$ENDPOINT/$ID
                    echo "$APIKEYS" > $DATADIR/$ENDPOINT/$ID/keys.json
                fi
                ACLSGROUPS=$(curl -k -s $URL/$ENDPOINT/$ID/acls | jq '.data | .[]')
                if [ ! -z "$ACLSGROUPS" ]; then
                    echo "Dumping groups"
                    mkdir -p $DATADIR/$ENDPOINT/$ID
                    echo "$APIKEYS" > $DATADIR/$ENDPOINT/$ID/groups.json
                fi
            fi
        done
    fi
done
