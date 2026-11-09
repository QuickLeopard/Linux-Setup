#!/usr/bin/env bash
set -euo pipefail

# 1. Проверка прав
if [[ $EUID -ne 0 ]]; then
   echo "Ошибка: скрипт требует прав root или sudo."
   exit 1
fi

# 2. Установка репозитория EPEL
echo "==> Установка репозитория EPEL..."
dnf install -y epel-release
dnf makecache

# 3. Установка Fail2ban и интеграции с firewalld
echo "==> Установка Fail2ban и плагина firewalld..."
dnf install -y fail2ban fail2ban-firewalld

# 4. Настройка конфигурации
echo "==> Создание конфигурационных файлов..."

# Копирование jail.conf в jail.local (защита от перезаписи при обновлениях пакетов)
if [[ ! -f /etc/fail2ban/jail.local ]]; then
    cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
fi

# Создание локального конфига для SSH
cat <<EOF > /etc/fail2ban/jail.d/sshd.local
[sshd]
enabled = true
port = ssh
logpath = %(sshd_log)s
backend = systemd
maxretry = 3
bantime = 1d
findtime = 10m
EOF

# 5. Запуск и добавление в автозагрузку
echo "==> Включение и запуск службы Fail2ban..."
systemctl enable --now fail2ban

# Небольшая задержка для полной инициализации демона перед проверкой статуса
sleep 2

# 6. Проверка статуса
echo "==> Проверка общего статуса..."
fail2ban-client status
echo "==> Статус jail для SSH:"
fail2ban-client status sshd

echo "==> Установка и базовая настройка завершены."
echo "==> Для разблокировки IP используйте: fail2ban-client set sshd unbanip <IP-адрес>"
