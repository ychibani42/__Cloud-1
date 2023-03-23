all:
	mkdir -p /home/ychibani/data/mariadb
	mkdir -p /home/ychibani/data/wordpress
	sudo chmod 777 /home/ychibani/data/wordpress
	sudo chmod 777 /home/ychibani/data/mariadb
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml up -d 

build:
	docker compose -f ./srcs/docker-compose.yml build 

stop:
	docker compose -f ./srcs/docker-compose.yml stop || true

down:
	docker compose -f ./srcs/docker-compose.yml down || true

clean:
	docker compose -f ./srcs/docker-compose.yml down || true
	docker system prune -af || true

fclean: clean
	docker network rm $$(docker network ls -q) 2>/dev/null || true
	docker volume rm -f $$(docker volume ls -q) || true
	docker volume prune -f || true
	sudo rm -rf /home/ychibani/data/mariadb
	sudo rm -rf /home/ychibani/data/wordpress

re : fclean all

in_mariabd:
	docker exec -it mariadb bash

in_wordpress:
	docker exec -it wordpress bash

in_nginx:
	docker exec -it nginx bash

log :
	docker compose -f srcs/docker-compose.yml logs
