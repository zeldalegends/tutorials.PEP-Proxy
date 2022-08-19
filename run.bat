@echo off
rem set COMPOSE_PROJECT_NAME=fiware-aio
rem docker compose down
rem docker compose pull
docker compose up -d --build
:loop
docker compose logs
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
pause
goto loop
