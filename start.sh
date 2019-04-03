#!/bin/bash
killall beam.smp
(cd ~/kv_store && iex --sname kv -S mix)
