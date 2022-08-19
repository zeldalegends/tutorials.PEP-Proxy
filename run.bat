@echo off
rem set COMPOSE_PROJECT_NAME=fiware

set ETHEREUM_PRIVATE_KEY=5f00a68d77e79e051aeafd7dec7657999dce84c045a8aa9d7995137267f91e52
set ETHEREUM_PUBLIC_KEY=0406c16dffbd03799962604dac8056a0615fd0586c1a1df8c09c05bedd41acec25ab9756c6bc577d0804d4244ed08d86a5bd3fb83991fc67ca13c096a8b8f040e9
set FIWARE_EMAIL=gamesup@libero.it
set FIWARE_PASSWORD=fisupport
set FIWARE_CLIENT_ID=b80f851b77254ba7b6a04294cd06e7d5
set FIWARE_CLIENT_SECRET=59114108aedb4866960faf028fb5c7bf

set DOCKER_FILE=docker-compose.yml
set PROJECT_NAME=fiware
if "%1"=="/?" echo Usage: run [--context-broker-only^|--pep-proxy-only] & exit 1
if "%1"=="-h" echo "Usage: run [--context-broker-only|--pep-proxy-only]" & exit 1
if "%1"=="--help" echo "Usage: run [--context-broker-only|--pep-proxy-only]" & exit 1
if "%1"=="--context-broker-only" set DOCKER_FILE=docker-compose-context-broker-only.yml & set PROJECT_NAME=context-broker
if "%1"=="--pep-proxy-only" set DOCKER_FILE=docker-compose-pep-proxy-only.yml & set PROJECT_NAME=pep-proxy

rem docker compose -f %DOCKER_FILE% down
rem docker compose -f %DOCKER_FILE% pull
docker compose -f %DOCKER_FILE% -p %PROJECT_NAME% up --build --remove-orphans -d

:loop
docker compose -f %DOCKER_FILE% logs -t --until 1m
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
pause
goto loop