#!/bin/bash

export WD=`pwd`

cat > /tmp/tabs.$$ <<"EOF"
title: node0;; workdir: $WD;; command: iex --sname node0@localhost -S mix
title: node1;; workdir: $WD;; command: iex --sname node1@localhost -S mix
title: node2;; workdir: $WD;; command: iex --sname node2@localhost -S mix
EOF

konsole --hold --tabs-from-file /tmp/tabs.$$
