### **Ответы на вопросы**  

1. **Какие операции можно производить с сервисами?**  
   В **systemd** можно:  
   - **Запускать** сервис:  
     ```bash
     systemctl start <service>
     ```  
   - **Останавливать** сервис:  
     ```bash
     systemctl stop <service>
     ```  
   - **Перезапускать** сервис:  
     ```bash
     systemctl restart <service>
     ```  
   - **Перезагружать конфигурацию сервиса** (без остановки процесса):  
     ```bash
     systemctl reload <service>
     ```  
   - **Включать/отключать автозапуск**:  
     ```bash
     systemctl enable <service>  # включить
     systemctl disable <service>  # отключить
     ```  
   - **Запрещать запуск сервиса**:  
     ```bash
     systemctl mask <service>
     ```  

2. **Как посмотреть информацию о сервисе?**  
   ```bash
   systemctl status <service>
   ```  
   Например:  
   ```bash
   systemctl status sshd
   ```  

3. **Чем отличается `restart` от `reload`?**  
   - `restart` **полностью перезапускает сервис**, останавливая и запуская его заново.  
   - `reload` **обновляет конфигурацию сервиса** без остановки (если сервис поддерживает такую возможность).  
   Например, `nginx` можно перезагрузить без остановки:  
   ```bash
   systemctl reload nginx
   ```  
   Но если в сервисе нет поддержки `reload`, нужно использовать `restart`.  

4. **Как запретить запуск сервиса и чем это отличается от «отключения» сервиса?**  
   - **Отключение (`disable`)** – сервис не стартует при загрузке, но его можно запустить вручную.  
     ```bash
     systemctl disable <service>
     ```  
   - **Запрет (`mask`)** – сервис вообще нельзя запустить (даже вручную).  
     ```bash
     systemctl mask <service>
     ```  
   Чтобы вернуть сервис в нормальное состояние:  
   ```bash
   systemctl unmask <service>
   ```  

5. **Как понять, что с сервисом есть проблемы?**  
   - Посмотреть статус:  
     ```bash
     systemctl status <service>
     ```  
   - Проверить последние логи:  
     ```bash
     journalctl -u <service> --no-pager -n 50
     ```  
   - Если сервис не запускается, узнать причину:  
     ```bash
     systemctl show <service> | grep -i exit
     ```  

6. **Почему некоторые сервисы пишут `active (running)`, а другие `active (exited)`?**  
   - `active (running)` – сервис запущен и выполняет свою работу (например, `nginx`).  
   - `active (exited)` – сервис выполнил свою задачу и завершился, но считается успешным (например, `cron` или `firewalld`).  

7. **Как посмотреть информацию не только о сервисах, но и о других юнитах systemd?**  
   - Все юниты:  
     ```bash
     systemctl list-units
     ```  
   - Только запущенные юниты:  
     ```bash
     systemctl list-units --state=running
     ```  
   - Юниты определённого типа (например, сокеты):  
     ```bash
     systemctl list-units --type=socket
     ```  

---

### **Задания**  

1. **Отключите сервис `sshd`, перезапустите систему и посмотрите статус**  
   ```bash
   systemctl disable sshd
   reboot
   systemctl status sshd
   ```  
   Ожидаемый результат: сервис не запущен, но его можно запустить вручную.  

2. **Запустите сервис `sshd` и посмотрите его статус**  
   ```bash
   systemctl start sshd
   systemctl status sshd
   ```  
   Ожидаемый результат: `active (running)`.  

3. **Запретите сервису `sshd` запускаться**  
   ```bash
   systemctl mask sshd
   systemctl status sshd
   ```  
   Ожидаемый результат: сервис заблокирован (`masked`). Попытка запустить его приведёт к ошибке.  

4. **Верните `sshd` право запускаться, добавьте в автозапуск, перезапустите систему и убедитесь, что всё работает**  
   ```bash
   systemctl unmask sshd
   systemctl enable sshd
   reboot
   systemctl status sshd
   ```  
   Ожидаемый результат: сервис работает (`active (running)`) и загружается автоматически.  