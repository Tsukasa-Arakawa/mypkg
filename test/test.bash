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
ros2 run mypkg talker > $LOG_FILE &
TALKER_PID=$!
ros2 run mypkg listener >> $LOG_FILE &
LISTENER_PID=$!

echo "==== Log Analysis ===="
for year in $(seq $START_YEAR $END_YEAR); do
    while ! grep -q "Listen: $year" $LOG_FILE; do
        sleep 1
    done
    echo "Year $year successfully received."
done

echo "Stopping ROS2 nodes..."
kill $TALKER_PID $LISTENER_PID

echo "Test completed for years $START_YEAR to $END_YEAR."

