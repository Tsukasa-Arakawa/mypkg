#!/bin/bash
# SPDX-FileCopyrightText: 2024 Tsukasa Arakawa <s23c1004ac@s.chibakoudai.jp>
# SPDX-License-Identifier: BSD-3-Clause

export ROS_LOG_DIR=/tmp/ros_logs
mkdir -p $ROS_LOG_DIR

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/.bashrc

START_YEAR=1865
END_YEAR=1900

echo "Starting test for years $START_YEAR to $END_YEAR..."

ros2 run mypkg talker > talker.log 2>&1 &
TALKER_PID=$!
if ! kill -0 $TALKER_PID 2>/dev/null; then
    echo "Failed to start talker node."
    exit 1
fi

ros2 run mypkg listener > listener.log 2>&1 &
LISTENER_PID=$!
if ! kill -0 $LISTENER_PID 2>/dev/null; then
    echo "Failed to start listener node."
    kill $TALKER_PID 2>/dev/null
    exit 1
fi

echo "Talker PID: $TALKER_PID"
echo "Listener PID: $LISTENER_PID"

YEAR=$START_YEAR
while kill -0 $TALKER_PID 2>/dev/null && kill -0 $LISTENER_PID 2>/dev/null; do
    sleep 1
    if grep -q "西暦: $YEAR" listener.log; then
        WAREKI_MSG=$(grep "西暦: $YEAR" listener.log | tail -n 1)
        echo "Talker sent: $YEAR, Listener response: $WAREKI_MSG"
        YEAR=$((YEAR + 1))
        if [ $YEAR -gt $END_YEAR ]; then
            echo "Reached END_YEAR $END_YEAR. Stopping test."
            break
        fi
    else
        echo "Waiting for listener to receive year: $YEAR..."
    fi
done

echo "Stopping nodes..."
kill $TALKER_PID 2>/dev/null
kill $LISTENER_PID 2>/dev/null

echo "Test completed."

