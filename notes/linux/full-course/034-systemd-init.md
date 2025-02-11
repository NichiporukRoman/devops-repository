### **Ответы на вопросы**  

1. **Для чего нужна система инициализации?**  
   Система инициализации (init system) управляет запуском, остановкой и мониторингом сервисов при загрузке и работе ОС. Она определяет порядок загрузки служб и процессов.  

2. **Какая система инициализации используется на нашем дистрибутиве?**  
   В современных дистрибутивах Linux чаще всего используется **systemd**. Для проверки:  
   ```bash
   ps --pid 1
   ```  
   Если вывод содержит `systemd`, значит, используется **systemd**.  

3. **Что такое таргеты?**  
   В **systemd** таргеты (`target`) – это группы сервисов и зависимостей, определяющие уровень работы системы (например, графический режим, однопользовательский режим). Они заменяют уровни выполнения (`runlevels`) в старых системах.  

4. **Какой таргет используется в нашей системе по умолчанию? Как это посмотреть?**  
   ```bash
   systemctl get-default
   ```  

5. **Как посмотреть, какие сервисы входят в этот таргет?**  
   ```bash
   systemctl list-dependencies <target>
   ```  
   Например, для `graphical.target`:  
   ```bash
   systemctl list-dependencies graphical.target
   ```  

6. **Что такое демоны?**  
   Демоны – это фоновые процессы, работающие без взаимодействия с пользователем, например, `sshd`, `nginx`, `cron`.  

7. **Что такое сервисы?**  
   Сервис – это программный компонент или демон, выполняющий определённую задачу в системе (например, веб-сервер, служба SSH).  

8. **Как узнать, какая команда выполняется при запуске сервиса?**  
   ```bash
   systemctl cat <service>
   ```  
   Например, для `nginx`:  
   ```bash
   systemctl cat nginx
   ```  
   Или посмотреть `ExecStart` в файле юнита:  
   ```bash
   systemctl show <service> | grep ExecStart
   ```  

9. **Как поменять текущий таргет?**  
   ```bash
   systemctl isolate <target>
   ```  
   Например, перейти в `multi-user.target`:  
   ```bash
   systemctl isolate multi-user.target
   ```  

10. **Как поменять дефолтный таргет?**  
    ```bash
    systemctl set-default <target>
    ```  
    Например, сделать `multi-user.target` дефолтным:  
    ```bash
    systemctl set-default multi-user.target
    ```  

11. **Как добавить или убрать сервис из автозагрузки?**  
    - Добавить в автозагрузку:  
      ```bash
      systemctl enable <service>
      ```  
    - Убрать из автозагрузки:  
      ```bash
      systemctl disable <service>
      ```  

12. **Как посмотреть, включён ли сервис?**  
    ```bash
    systemctl is-enabled <service>
    ```  

---

### **Задания**  

1. **Зайти в `rescue.target`, посмотреть `fstab`, вернуться в `graphical.target`**  
   ```bash
   systemctl isolate rescue.target
   cat /etc/fstab
   systemctl isolate graphical.target
   ```  

2. **Сделать `multi-user.target` режимом по умолчанию**  
   ```bash
   systemctl set-default multi-user.target
   ```  
   Проверить:  
   ```bash
   systemctl get-default
   ```