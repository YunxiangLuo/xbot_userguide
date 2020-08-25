### xbot_navi包部署说明书

> xbot_navi 包最后使用的场景是，人脸识别为注册用户之后，机器人开始语音播报，然后执行导航，完成从您自定义的起点开始，一直到终点的导航流程。
>
> https://yt.droid.ac.cn/xbot-u/xbot_navi/issues/10 中提供了删减流程后的demo.py 。不需要人脸识别，仅完成从点到点的导航。



### 1. 准备工作

#### 1.1 本说明对应的代码版本

以下使用说明对应的软件版本为：

- https://yt.droid.ac.cn/xbot-u/xbot/commit/2e50cc3d4e78d4094d13f15ec96b81ee3408e144
- https://yt.droid.ac.cn/xbot-u/xbot_navi/commit/2c6ed715f8a438b4cdf0792ccf5adfe4c70db6be
- https://yt.droid.ac.cn/xbot-u/xbot_talker/commit/93e39e7e32637b7870a8403836ff5efdd21f53a3
- https://yt.droid.ac.cn/xbot-u/xbot_face/commit/773b0e9db58024dd6bf93c267cbbbda0458d1c2c

#### 1.2  操作流程

1. 按照人脸注册的流程在机器人中录入个人照片
2. 按照本文文档部署



### 2. 导航部署

#### 2.1. 建图

- （1）启动建图功能：roslaunch xbot_navi build_map.launch

  > ssh 远程连接xbot机器人后运行。因为建图时机器人不方便外接显示器，ssh远程控制更加方便。

- （2）建图效果可视化：roslaunch xbot_navi rviz_build_map.launch 

  > 配置主从之后，在从机上运行。主要是方便查看建图效果。

- （3）保存地图：
  - roscd xbot_navi/map  为了能把地图保存到xbot_navi/map目录下
  - rosrun map_server map_saver -f 807

#### 2.2. 创建访问点

- （1）修改input_keypoints.launch文件中的mapfile

  ```
  <arg name="map_file"       default="$(find xbot_navi)/map/807.yaml" />
  ```

- （2）roslaunch xbot_navi input_keypoints.launch

- （3）rosrun xbot_navi input_keypoint.py

  - 按照命令窗口的提示，输入即将定义的关键点个数。
  - 在rviz中，点击2D Nav Goal，在地图上点击设置访问点。个数与之前定义的个数一致。假设定义了3个访问点，当你已经在rviz中设置了3个，脚本会将自动生成kp.json文件，并将点信息都自动保存到kp.json文件中（kp.json文件的路径默认在执行该命令的目录下）

#### 2.3. 定义路线

- （1）打开demo.launch文件，修改：

  - 修改map_file

    ```
    <arg name="map_file"       default="$(find xbot_navi)/map/807.yaml" />
    ```

  - 修改kp.json文件和greet.json文件的路径

    ```
    <node name = "demo" pkg = "xbot_navi" type = "demo.py">
    		<param name = "/demo/kp_path" value = "$(find xbot_navi)/param/kp.json" />
    		<param name = "/demo/greet_path" value = "$(find xbot_navi)/script/807/greet.json" />
    	</node>
    ```

- （2）定义greet.json文件

  没有greet.json文件的，按照以下格式生成greet.json（这个文件定义的是人脸识别用户）

  ```
  {
  	"xijing":{"isVIP":true,"greet_words":"hello"},
  	"wangxiaoyun":{"isVIP":true,"greet_words":"hello"}
  }
  ```

- （3）打开demo.py文件，修改：

  - 修改kp.json和greet.json文件路径

    ```
    self.kp_path = rospy.get_param('/demo/kp_path','/home/xbot/catkin_ws/src/xbot_navi/script/807/kp.json')
    self.greet_path = rospy.get_param('/demo/greet_path','/home/xbot/catkin_ws/src/xbot_navi/script/807/greet.json')
    ```

  - 将demo.py脚本中所有的    ``` self.play_srv(False, 2, '', kp['play_words'])``` 第二个参数由1更换为2.
  - 修改以下路径，chat和play前注意加上/xbot

    ```
    # 请求chat服务
    self.chat_srv = rospy.ServiceProxy('/xbot/chat',chat)
    # 请求播放服务
    self.play_srv = rospy.ServiceProxy('/xbot/play',play)
    ```

  > 后面两项配置是代码包版本更新不统一遗留的问题。后续已经修复。

- （4）启动路线
  
- roslaunch xbot_navi demo.launch
  
- （5）发送个信号，开始行走：
  
  - rostopic pub -1 /demo/visit std_msgs/Bool "data: true"