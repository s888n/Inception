RED = \033[0;31m
GREEN = \033[0;32m
RESET = \033[0m
MAGENT = \033[0;35m
YELLOW = \033[0;33m
BLUE = \033[0;34m
CYAN = \033[0;36m
LOGIN = srachdi
URL= srachdi.42.fr

all: up 
volumes:
	@echo "${YELLOW}Creating volumes${RESET}"
	mkdir -p /home/$(LOGIN)/data
	mkdir -p /home/$(LOGIN)/data/mariadb
	mkdir -p /home/$(LOGIN)/data/website
	mkdir -p /home/$(LOGIN)/data/adminer 
	mkdir -p /home/$(LOGIN)/data/portainer

hosts:
	@echo "${YELLOW}Adding host${RESET}"
	@if ! grep -q "127.0.0.1 ${URL}" /etc/hosts; then \
	echo "127.0.0.1 ${URL}" >> /etc/hosts; \
    else \
		echo "${GREEN}Host already exists${RESET}"; \
    fi

up: hosts volumes
	@echo "${MAGENT}Starting containers${RESET}"
	docker-compose -f srcs/docker-compose.yml up -d
	@echo "${GREEN}Containers are up${RESET}"
	@echo "${BLUE}You can access the website at https://${URL} on the Host machine${RESET}"
down:
	@docker-compose -f srcs/docker-compose.yml down
	@echo "${CYAN}Containers are down${RESET}"

purge:
	@printf $(_DANGER) "Are you sure ?, All data will be lost " ; 
	@read -p  " [y/N] " ans && ans=$${ans:-N} ; \
    if [ $${ans} = y ] || [ $${ans} = Y ]; then \
        printf $(_DANGER) "Purging..." ; \
		sh ./srcs/requirements/tools/purge.sh ; \
    else \
		printf $(_SUCCESS) "Purge Canceled" ; \
    fi
status:
	@echo "${YELLOW}Containers status${RESET}"
	docker ps -a

re:purge up

.PHONY: all up down fclean hosts re purge volumes stats

_SUCCESS := "\033[32m %s \033[0m %s\n" 
_DANGER := "\033[31m %s \033[0m %s\n"
_WARNING := "\033[33m %s \033[0m %s\n"