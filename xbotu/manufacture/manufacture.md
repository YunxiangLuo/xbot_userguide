# XBot-U出厂检验检测

## 检查与备份时间

2019年10月22日

## xbot_checker使用说明

由于PCB1与PCB2使用了相同的USB串口芯片FTDI，因此在上位机无法使用设备号（0403:6001）来区分两路数据，因此在做串口映射的时候无法区分；

为了实现进一步区分两个相同芯片的串口，在映射规则中增加ATTR{serial}属性，即产品序列号区分。

| PCB     | 芯片型号 | 设备号    | 映射结果     |
| ------- | -------- | --------- | ------------ |
| PCB1    | FTDI     | 0403:6001 | /dev/xbot    |
| PCB2    | FTDI     | 0403:6001 | /dev/sensor  |
| rplidar | CP2101   | 10c4:ea60 | /dev/rplidar |

该程序实现了一键读取两块PCB的数据并将两个USB区分开，读取对应的序列号属性，追加到准备好的映射文件中，写入linux操作系统的端口映射文件目录中。

并且，同时将udev文件夹中的激光雷达映射端口文件复制到linux操作系统的端口映射文件目录中。

使用方法：

进入xbot_check文件夹目录下运行

```
sudo python xbot_checker*.py
```

*为下表中版本对应的编号。

## 版本分类

| 版本号 | gitlab tag | 固件             | 上位机软件       | xbot_checker     | 通信协议                           |
| ------ | ---------- | ---------------- | ---------------- | ---------------- | ---------------------------------- |
| 1.0.0  | 1.0.0      | firmware1.tar.gz | xbot1.0.0.tar.gz | 单块PCB，无      | xbot协议1(for 1.0.0).doc           |
| 2.0.0  | 2.0.0      | firmware2.tar.gz | xbot2.0.0.tar.gz | xbot_checker2.py | xbot协议2(for 2.0.0).doc           |
| 2.2.0  | 2.2.0      | firmware3.tar.gz | xbot2.2.0.tar.gz | xbot_checker3.py | xbot协议3(for 2.2.0 and 3.0.0).doc |
| 3.0.0  | 3.0.0      | firmware3.tar.gz | xbot3.0.0.tar.gz | xbot_checker3.py | xbot协议3(for 2.2.0 and 3.0.0).doc |

### 子版本Y号功能对应表（X.Y.Z）

| 功能                | PCB1 | PCB2 |
| ------- | -------- | ---------|
| 通用基础功能        | 2     | 2 |
| 无线充电功能        | 4     | 4 |

### 子版本Z号功能临时对应表（X.Y.Z）
说明：IMU9轴校准和USB虚拟串口优化功能 不影响协议本身  

| 优化功能号          | PCB1       |    PCB2   |
| ------- | -------- | ---------  |
| IMU9轴校准          |  待确定    |   待确定   |
| USB虚拟串口         |   待确定   |  待确定   |

 稳定实现后合并到Y版本号



## changelog

### 2.0.0版本changelog

1. 增加了一块PCB，用于获取IMU数据以及控制上方云台。
2. IMU数据全部使用float类型上传，数据未计算好，需要按照协议解析计算；
3. IMU芯片贴反了，因此y,z轴加速度取负，y,z角速度取负，yaw,pitch取负。
4. 增加舵机故障状态位字段上传



### 2.2.0版本changelog

1. IMU数据更改九轴数据使用uint16类型上传;
2. 增加软件版本字段上传；
3. 时间戳由前一版本2字节加长到4字节；
4. 超声红外只分别安装两路，其他4路数据保留但无数据，仅使用中路上传



### 3.0.0版本changelog

1. IMU芯片贴正了；
2. IMU数据经过校正；

### 3.2

#### 3.2.3

1. 重新安装（更新）了librealsense2-dkms、librealsense2-utils、librealsense2-dev
2. 卸载了ros-kinetic-realsense2-camera，从github下载了最新源码并编译
3. 解决了realsense在launch启动后video号就消失，设备就disconnected的问题
4. 解决了急停、声音开关、云台角度控制发一次有时候未生效的问题，正常连接情况下监测返回结果，若未到达则一直发送控制指令，直到到达目标位置。
5. 解决了偶尔有些回传数据解析丢弃导致timeout报错的问题，现在连续4s未接收到数据超时则报错。
6. 喇叭、电机软开关在程序结束时关闭，在程序运行时打开。
7. 解决了xbot_talker对话几轮之后程序无疾而终的问题。













