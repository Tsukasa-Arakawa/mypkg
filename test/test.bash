#!/bin/bash

export ROS_LOG_DIR=/tmp/ros_logs
mkdir -p $ROS_LOG_DIR

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
while true; do
    if grep -q "Reached the year 2035. Terminating." $LOG_FILE; then
        echo "Termination message detected. Ending test."
        break
    fi
    sleep 2
done

echo "Stopping ROS2 nodes..."
kill $TALKER_PID $LISTENER_PID

echo "Test completed for years $START_YEAR to $END_YEAR."

