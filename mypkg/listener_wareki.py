# SPDX-FileCopyrightText: 2024 Tsukasa Arakawa <s23c1004ac@s.chibakoudai.jp>
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Int16

class Listener(Node):
    def __init__(self):
        super().__init__('listener')
        self.subscription = self.create_subscription(Int16, 'year_topic', self.callback, 10)
        self.get_logger().info("受信待機中...")

    def callback(self, msg):
        seireki = msg.data
        wareki = self.convert_to_wareki(seireki)
        self.get_logger().info(f'西暦: {seireki}, 和暦: {wareki}')

        if seireki == 2035:
            self.get_logger().info("表示出来るのは2035年までです。終了します。")
            rclpy.shutdown()

    def convert_to_wareki(self, year):
        if year == 2019:
            return "平成31年（1月1日～4月30日） / 令和元年（5月1日以降）"
        elif year == 1989:
            return "昭和64年（1月1日～1月7日） / 平成元年（1月8日以降）"
        elif year >= 2019:
            return f"令和{year - 2018}年"
        elif year >= 1989:
            return f"平成{year - 1988}年"
        elif year >= 1926:
            if year == 1926:
                return "大正15年（1月1日～12月24日） / 昭和元年（12月25日以降）"
            return f"昭和{year - 1925}年"
        elif year >= 1912:
            if year == 1912:
                return "明治45年（1月1日～7月29日） / 大正元年（7月30日以降）"
            return f"大正{year - 1911}年"
        elif year >= 1868:
            if year == 1868:
                return "慶応4年（1月1日～10月22日） / 明治元年（10月23日以降）"
            return f"明治{year - 1867}年"
        else:
            return f"西暦{year}年（和暦対応外）"

def main(args=None):
    rclpy.init(args=args)
    node = Listener()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()

