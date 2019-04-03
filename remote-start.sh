#!/bin/bash

cat > /tmp/tabs.$$ <<"EOF"
title: bot00;; command: ssh nat@bot00 bash ~/kv_store/start.sh
title: bot01;; command: ssh nat@bot01 bash ~/kv_store/start.sh
title: bot02;; command: ssh nat@bot02 bash ~/kv_store/start.sh
title: bot03;; command: ssh nat@bot03 bash ~/kv_store/start.sh
title: bot04;; command: ssh nat@bot04 bash ~/kv_store/start.sh
EOF

konsole --hold --tabs-from-file /tmp/tabs.$$
