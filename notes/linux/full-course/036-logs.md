### **Ответы на вопросы**  

1. **Куда программы ведут свои логи?**  
   - `/var/log/` – основная директория для логов в Linux.  
   - `/var/log/syslog` или `/var/log/messages` – общий системный лог.  
   - `/var/log/auth.log` – логи аутентификации.  
   - `/var/log/kern.log` – логи ядра.  
   - `/var/log/journal/` – двоичные логи **journald**.  

2. **Что такое syslog? Как программы отправляют логи в syslog?**  
   - `syslog` – стандарт для логирования в Unix-системах.  
   - Программы отправляют логи через `logger` или API `syslog()`.  
     ```bash
     logger "This is a test log"
     ```  

3. **Какие объекты логирования есть у syslog?**  
   - **Фасилити (facility)** – категория логов (auth, mail, daemon и т. д.).  
   - **Приоритет (severity)** – уровень важности (`debug`, `info`, `warning`, `error`, `crit` и т. д.).  

4. **В чем отличие `journald` от `rsyslog`?**  
   - `journald` (из **systemd**) – бинарные логи с мощным поиском (`journalctl`).  
   - `rsyslog` – традиционный текстовый логгер, используемый многими программами.  

5. **Зачем в системе два демона логирования?**  
   - `journald` удобен для поиска (`journalctl`).  
   - `rsyslog` нужен для совместимости и ротации (`logrotate`).  

6. **Как сделать так, чтобы логи из `journald` оставались после перезагрузки?**  
   ```bash
   mkdir -p /var/log/journal
   systemctl restart systemd-journald
   ```  

7. **Как изменить время хранения логов journald?**  
   - Изменить `/etc/systemd/journald.conf`:  
     ```ini
     SystemMaxUse=500M
     MaxRetentionSec=2week
     ```  
   - Применить:  
     ```bash
     systemctl restart systemd-journald
     ```  

8. **Как посмотреть сообщения ядра?**  
   ```bash
   journalctl -k
   dmesg | less
   ```  

9. **Как посмотреть логи определённого сервиса?**  
   ```bash
   journalctl -u <service>
   ```  

10. **Как посмотреть последние логи сервиса?**  
    ```bash
    journalctl -u <service> -n 50
    ```  

11. **Как посмотреть логи с последнего запуска системы?**  
    ```bash
    journalctl -b
    ```  

12. **Что такое ротация логов и как её настроить?**  
    - Автоматическое удаление старых логов.  
    - Используется `logrotate` (`/etc/logrotate.conf`).  

13. **Как отправить свои сообщения в syslog?**  
    ```bash
    logger -p user.error "This is an error log"
    ```  

14. **Как смотреть логи определённого сервиса в реальном времени?**  
    ```bash
    journalctl -u <service> -f
    tail -f /var/log/syslog
    ```  

---

### **Задания**  

1. **Создать скрипт, который создаёт файл, записывает последнюю строку из `syslog`, отправляет сообщение в `syslog`.**  

   ```bash
   #!/bin/bash
   touch /tmp/logfile.txt
   tail -n 1 /var/log/syslog >> /tmp/logfile.txt
   logger "Logs collected"
   ```  

2. **Настроить `rsyslog` для записи логов этого скрипта в `/var/log/collect.log`.**  
   - Добавить в `/etc/rsyslog.d/collect.conf`:  
     ```
     if $programname == 'logger' then /var/log/collect.log
     & stop
     ```  
   - Перезапустить `rsyslog`:  
     ```bash
     systemctl restart rsyslog
     ```  

3. **Настроить ротацию логов `/var/log/collect.log` (еженедельная, хранение 1 месяц).**  
   - Добавить в `/etc/logrotate.d/collect`:  
     ```
     /var/log/collect.log {
         weekly
         rotate 4
         compress
         missingok
         notifempty
     }
     ```  

4. **Создать скрипт, отправляющий логи разного уровня в `syslog`, настроить `rsyslog`.**  

   ```bash
   #!/bin/bash
   logger -p debug "This is normal log"
   logger -p user.error "This is error"
   logger -p user.crit "This is critical error"
   ```  

   - Добавить в `/etc/rsyslog.d/mylogs.conf`:  
     ```
     user.debug /var/log/mylog.debug
     user.error /var/log/mylog.error
     user.crit /var/log/mylog.crit
     ```  
   - Перезапустить `rsyslog`:  
     ```bash
     systemctl restart rsyslog
     ```  

5. **Настроить ротацию логов (`mylog.debug` ежедневно с сжатием, `mylog.error` ежедневно без сжатия, `mylog.crit` раз в неделю, 5 ротаций).**  
   - Добавить в `/etc/logrotate.d/mylogs`:  
     ```
     /var/log/mylog.debug {
         daily
         rotate 5
         compress
         missingok
         notifempty
     }
     /var/log/mylog.error {
         daily
         rotate 5
         nocreate
         missingok
         notifempty
     }
     /var/log/mylog.crit {
         weekly
         rotate 5
         missingok
         notifempty
     }
     ```  

6. **Создать файл `/etc/allowedusers` и скрипт с проверкой пользователя.**  
   - Файл `/etc/allowedusers`:  
     ```
     myuser
     ```  
   - Скрипт проверки (`check_user.sh`):  
     ```bash
     #!/bin/bash
     USERNAME=$(whoami)

     if ! grep -q "^$USERNAME$" /etc/allowedusers; then
         echo "This incident will be reported"
         logger -p user.error "User $USERNAME tried to run this script!"
         exit 1
     fi

     ls /data/
     echo -n "Enter filename: "
     read FILENAME
     echo -n "Enter new timestamp (YYYY-MM-DD HH:MM:SS): "
     read TIMESTAMP

     touch -d "$TIMESTAMP" "/data/$FILENAME"
     ```  
   - Сделать скрипт исполняемым:  
     ```bash
     chmod +x check_user.sh
     ```