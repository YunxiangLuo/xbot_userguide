# 升级日志

## 2.0.0版本changelog

1. 增加了一块PCB，用于获取IMU数据以及控制上方云台。
2. IMU数据全部使用float类型上传，数据未计算好，需要按照协议解析计算；
3. IMU芯片贴反了，因此y,z轴加速度取负，y,z角速度取负，yaw,pitch取负。
4. 增加舵机故障状态位字段上传



## 2.2.0版本changelog

1. IMU数据更改九轴数据使用uint16类型上传;
2. 增加软件版本字段上传；
3. 时间戳由前一版本2字节加长到4字节；
4. 超声红外只分别安装两路，其他4路数据保留但无数据，仅使用中路上传



## 3.0.0版本changelog

1. IMU芯片贴正了；
2. IMU数据经过校正；

## 3.2

### 3.2.3

1. 重新安装（更新）了librealsense2-dkms、librealsense2-utils、librealsense2-dev
2. 卸载了ros-kinetic-realsense2-camera，从github下载了最新源码并编译
3. 解决了realsense在launch启动后video号就消失，设备就disconnected的问题
4. 解决了急停、声音开关、云台角度控制发一次有时候未生效的问题，正常连接情况下监测返回结果，若未到达则一直发送控制指令，直到到达目标位置。
5. 解决了偶尔有些回传数据解析丢弃导致timeout报错的问题，现在连续4s未接收到数据超时则报错。
6. 喇叭、电机软开关在程序结束时关闭，在程序运行时打开。
7. 解决了xbot_talker对话几轮之后程序无疾而终的问题。

### 3.2.4

1. 增加自动寻找人脸识别摄像头usb id
2. 将xbot_checker加入到xbot_tools/scripts中的check文件夹，改进check机制。













