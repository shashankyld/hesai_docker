
IM_NAME=ipbalfredo/hesai-node:noetic:
CONT_NAME=hesai-node-container # You will need to apply the exact same name to container_name in orb-container/docker-compose.yml

default: up enter

up:
	docker compose up -d

run:
	docker run -it --privileged --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix  -v /home/shashank/Documents/photogrammetrylab/hesai_docker/config:/workspace/rosworkspace/src/HesaiLidar_General_ROS/launch/config --network=host --name ${CONT_NAME} ${IM_NAME} bash

enter:
	clear && docker exec -it ${CONT_NAME} bash

launch_hesai:
	clear && docker exec -it ${CONT_NAME} bash -c "source /opt/ros/noetic/setup.bash && roslaunch hesai_lidar hesai_lidar.launch lidar_type:="PandarXT-32" frame_id:="PandarXT-32""

down:
	docker compose down

build_without_cache:
	docker build --no-cache -t ${IM_NAME} .

build:
	docker build -t ${IM_NAME} .
delete_hesai:
	docker rmi ${IM_NAME}
