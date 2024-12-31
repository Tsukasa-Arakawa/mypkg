# SPDX-FileCopyrightText: 2024 Tsukasa Arakawa <s23c1004ac@s.chibakoudai.jp>
# SPDX-License-Identifier: BSD-3-Clause

from setuptools import setup

package_name = 'mypkg'

setup(
    name=package_name,
    version='0.0.0',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='tsuka28',
    maintainer_email='s23c1004ac@s.chibakoudai.jp',
    description='an assignment2 of robosys',
    license='BSD-3-Clause',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'talker = mypkg.talker_seireki:main', 
            'listener = mypkg.listener_wareki:main',
        ],
    },
)
