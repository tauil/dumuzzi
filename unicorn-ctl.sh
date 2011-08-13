#!/bin/sh
echo "Stopping Unicorn..."
kill -quit `cat tmp/pids/unicorn.pid`
sleep 3
echo "Starting Unicorn and Workers..."
unicorn_rails -c config/unicorn.rb -E production -D
echo "Done."
