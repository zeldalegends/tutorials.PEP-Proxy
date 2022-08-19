@echo off
rem set COMPOSE_PROJECT_NAME=pep-proxy-only
rem docker compose down
rem docker compose pull
docker compose -f docker-compose-pep-proxy-only.yml -p pep-proxy-only up --build --remove-orphans -d
:loop
docker compose -f docker-compose-pep-proxy-only.yml logs -t --until 1m
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
pause
goto loop
