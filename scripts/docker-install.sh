#!/usr/bin/env bash
set -euo pipefail

# 1. Проверка прав
if [[ $EUID -ne 0 ]]; then
   echo "Ошибка: скрипт требует прав root или sudo."
   exit 1
fi

# Определение версии DNF (DNF5 vs DNF4)
if command -v dnf5 &> /dev/null; then
    DNF="dnf5"
    PLUGINS_PKG="dnf5-plugins"
else
    DNF="dnf"
    PLUGINS_PKG="dnf-plugins-core"
fi

# 2. Удаление конфликтующих пакетов
echo "==> Удаление конфликтующих пакетов..."
$DNF remove -y docker docker-client docker-client-latest docker-common \
    docker-latest docker-latest-logrotate docker-logrotate docker-engine \
    podman runc || true

# 3. Установка зависимостей и критически важных модулей ядра
echo "==> Установка зависимостей и kernel-modules-extra..."
$DNF install -y $PLUGINS_PKG kernel-modules-extra

# 4. Добавление репозитория Docker
echo "==> Добавление репозитория Docker..."
$DNF config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 5. Установка Docker Engine и плагинов
echo "==> Установка Docker Engine, Containerd, Buildx и Compose..."
$DNF install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin \
    docker-compose-plugin --allowerasing

# 6. Загрузка модуля ядра для iptables (xt_addrtype)
echo "==> Загрузка модуля ядра xt_addrtype..."
modprobe xt_addrtype || echo "⚠️ Модуль не загружен в текущее ядро. Потребуется перезагрузка."

# 7. Запуск и добавление в автозагрузку
echo "==> Включение и запуск службы Docker..."
systemctl enable --now docker

# 8. Верификация
echo "==> Проверка Docker Engine..."
docker run --rm hello-world
echo "==> Проверка Docker Compose Plugin..."
docker compose version

# 9. Настройка прав пользователя (опционально)
if [[ -n "${SUDO_USER:-}" && "${SUDO_USER}" != "root" ]]; then
    echo "==> Добавление пользователя '${SUDO_USER}' в группу 'docker'..."
    usermod -aG docker "${SUDO_USER}"
fi

echo "==> Установка успешно завершена."
