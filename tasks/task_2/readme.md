# Task 2

## To do
1. Создать инстанс в aws наименьшего тира.
2. Создать там пользователей user1 и user2.
3. user1 должен заходить каждый раз только по ssh ключу на инстанс, а user2 должен каждый раз вводить свой пароль при попытке зайти на инстанс.
4. user1 должен иметь доступ к sudo, а user2 - нет.
5. Под пользователем user1 создать документ. Используя права доступа сделать так - чтоб пользователь user2 не смог прочитать содержимое документа.
6. Создать нового пользователя user3, настроить для него интерпритатор по умолчанию sh
## Jobs
1. ez
2. Создать там пользователей user1 и user2:
```
sudo useradd user1
sudo useradd user2
```
3. user1 должен заходить каждый раз только по ssh ключу на инстанс, а user2 должен каждый раз вводить свой пароль при попытке зайти на инстанс.

```
sudo passwd user2 ***
sudo passwd -f -u user1 
nano .ssh/authorized_keys <- for both
```
```
sudo nano /etc/ssh/sshd_config
```
Then set:
- for all:
    - PermitRootLogin -> no
    - PasswordAuthentification -> no
    - PermitEmptyPassword -> no
    - PubkeyAuthentification-> yes
- for user2:
    - Match User user2
    -   PermitRootLogin without-password
    -   PasswordAuthentication yes
    -   PermitEmptyPasswords yes


4. user1 должен иметь доступ к sudo, а user2 - нет:
```
cat /etc/group
sudo usermod -aG wheel user1
sudo gpasswd -d user2 wheel
```
5.  Под пользователем user1 создать документ. Используя права доступа сделать так - чтоб пользователь user2 не смог прочитать содержимое документа:
``` 
nano secret.txt
chmod 700 secret.txt
```
6. Создать нового пользователя user3, настроить для него интерпритатор по умолчанию sh
```
sudo usermod --shell /bin/sh user3
```
or
```
nano /etc/passwd -> change mannualy 
```