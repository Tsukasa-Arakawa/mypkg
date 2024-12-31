# SPDX-FileCopyrightText: 2024 Tsukasa Arakawa <s23c1004ac@s.chibakoudai.jp>
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Int16

class Talker(Node):
    def __init__(self):
        super().__init__('talker')
        self.publisher_ = self.create_publisher(Int16, 'year_topic', 10)
        self.timer = self.create_timer(0.25, self.publish_year)
        self.current_year = 1865
        self.is_done = False

    def publish_year(self):
        if self.current_year > 2035:
            self.get_logger().info("Reached the year 2035. Terminating.")
            msg = Int16()
            msg.data = -1
            self.publisher_.publish(msg)
            self.timer.cancel()
            return

        msg = Int16()
        msg.data = self.current_year
        self.publisher_.publish(msg)
        self.get_logger().info(f'西暦: {self.current_year}')
        self.current_year += 1

def main(args=None):
    rclpy.init(args=args)
    node = Talker()
    try:
        while not node.is_done:
            rclpy.spin_once(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()

