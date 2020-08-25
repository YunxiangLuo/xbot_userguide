#!/usr/bin/env bash
# xbot-u用户手册
cd xbotu/userguide
sphinx-build -b html . build
# make latexpdf
mv build userguide
scp -r userguide root@39.105.40.54:/var/www/html/docs/products/xbotu
# xbot-u出厂检验手册
cd ../manufacture
sphinx-build -b html . build
# make latexpdf
mv build manufacture
scp -r manufacture root@39.105.40.54:/var/www/html/docs/products/xbotu



# xbot-arm单臂用户手册
cd ../../xbotarm/single
sphinx-build -b html . build
# make latexpdf
mv build single
scp -r single root@39.105.40.54:/var/www/html/docs/products/xbotarm

# 桌面机械臂用户手册
cd ../../darm/userguide
sphinx-build -b html . build
# make latexpdf
mv build userguide
scp -r userguide root@39.105.40.54:/var/www/html/docs/products/darm
