#!/bin/bash

# Executa a atualização dos repositórios
sudo apt update

# Mostra as atualizações disponíveis
sudo apt list --upgradable -a

# Pergunta ao usuário se deseja prosseguir com a atualização
#read -p "Deseja continuar com a atualização? (s/n): " response

#if [[ "$response" =~ ^[sS]$ ]]; then
  # Executa a atualização do sistema
#  sudo apt upgrade -y
#  echo "Atualização concluída."
#else
#  echo "Atualização cancelada."
#fi
