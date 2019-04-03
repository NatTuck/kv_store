#!/bin/bash
# Note: apt install moreutils

HOSTS="bot00 bot01 bot02 bot03 bot04"
DIR=$(basename $(pwd))

cd ..
parallel -i rsync -rlpxzith --stats --del --safe-links $DIR nat@{}:~/ -- $HOSTS
parallel -i ssh nat@{} rm ~/.erlang.cookie -- $HOSTS
parallel -i scp ~/.erlang.cookie nat@{}:~ -- $HOSTS

