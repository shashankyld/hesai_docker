# hesai_docker
This docker contains ROS1 package of the hesai lidar. Use ROS1-ROS2 bridge docker to bridge lidar messages in ROS1 to ROS2 network.

Step 0: Inspect Lidar WebPage
```
http://131.220.233.235/
```
make sure that ip address of the lidar and the computer are in the same network iPv4 range (Use correct terminology here) 
[Insert Image]
and confirm if receiving address is correct by using 
```
ifconfig
```


