#!/bin/bash
set -e

# Remove um arquivo de PID do servidor existente, se existir
if [ -f /warehouse_control/tmp/pids/server.pid ]; then
  rm /warehouse_control/tmp/pids/server.pid
fi

# Executa o comando passado para o docker run
exec "$@"
