# Task 6
## To do
### Task 5 Networking

## To do
1. Создать свою VPC.
2. Создать 2 сервера: 1-ый паблик ( бастион хост), 2-ой сервер - приватный (нет публичного IP) 
3. Написать скрипт, который будет храниться на бастион хосте и сможет логиниться на приватный сервер по ssh и выполнять там команду обновления пакетов (apt update). 
4. Установить и настроить WireGuard и подключиться через него к приватной машине 
5. Проверить циркуляцию пакетов ssh через tcpdump (через указание интерфейса и напраления и через интерейс any - объяснить разницу)
## Jobs
1. Steps:
    1. Create VPC
    2. Create Gateway -> attach it to VPC
    3. Create Subnet:
        1. public: Auto-assign IP settings -> yes
        2. private:
    4. Create nat
    5. Route tables:
        1. public:
            1. add route
            2. Destination:0.0.0.0/0 Target: roman-gateway

        2. private:
            1. add route
            2. Destination:0.0.0.0/0 Target: roman-nat

2.  Создать 2 instances в нашей VPC: 1 - private, 1 - public 
    1. Преднастройка:
        1. Публичный инстанс (бастион-хост):
            - Разрешить входящие соединения по SSH (порт 22) от вашего IP-адреса.
            - Разрешить входящие соединения по Wireguard от вашего IP-адреса.
        2. Приватный инстанс:
            - Разрешите входящие соединения по SSH (порт 22) только из публичной подсети (10.0.0.0/25).
    2. Создать instances с нужными VPC и подсетями.
3. Запуск скрипта осуществляется при помощи команды:
```bash
sudo bash update.ssh
```
или
```bash
sudo bash custom_update.ssh <private-key> <private-ip>
```
4. Установка wireguard vpn:
```bash
curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
chmod +x wireguard-install.sh
sudo ./wireguard-install.sh
```
По настройкам:
    - Ip меняем на публичный ip instance
    - CIDR сети меняем на CIDR VPC 

5. tcpdump — это мощная утилита для перехвата и анализа сетевых пакетов в реальном времени. Она позволяет отслеживать трафик, проходящий через сетевые интерфейсы, что полезно для диагностики сетевых проблем, безопасности и отладки.
    1. tcpdump -i wg0: Захватывает только зашифрованный трафик, проходящий через интерфейс VPN (wg0). Это полезно для проверки активности туннеля WireGuard.
    2. tcpdump -i any: Захватывает весь трафик на всех интерфейсах, поэтому вы увидите незашифрованный исходящий SSH-трафик до его передачи в туннель, а также зашифрованный трафик, который проходит через wg0.