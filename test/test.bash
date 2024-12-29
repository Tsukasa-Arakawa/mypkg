#!/bin/bash

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/.bashrc

START_YEAR=1985
END_YEAR=2005

LOG_FILE=/tmp/mypkg.log

echo "Starting test for years $START_YEAR to $END_YEAR..."
ros2 launch mypkg talk_listen.launch.py > $LOG_FILE &

LAUNCH_PID=$!

echo "==== Log Analysis ===="
for year in $(seq $START_YEAR $END_YEAR); do
    while ! grep -q "Listen: $year" $LOG_FILE; do
        sleep 1
    done
    echo "Year $year successfully received."
done

echo "Stopping ROS2 nodes..."
kill $LAUNCH_PID

echo "Test completed for years $START_YEAR to $END_YEAR."

