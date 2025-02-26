### **Ответы на вопросы**  

#### **1. Вы пишете команду, нажимаете `Tab`, но вместо опций видите список файлов. Это нормально?**  
Нет, это не нормальное поведение. Скорее всего, **автодополнение команд не работает** из-за одной из причин:  
- **Пакет bash-completion не установлен** (проверьте `dpkg -l | grep bash-completion` в Debian/Ubuntu или `rpm -q bash-completion` в RHEL/CentOS).  
- **Файл автодополнения не подключён** (проверьте `.bashrc` или `/etc/bash.bashrc`).  
- **Ошибка в `~/.bashrc` или `~/.bash_profile`**, которая мешает загрузке автодополнения.  

**Решение:**  
Попробуйте перезапустить терминал или выполнить:  
```bash
source ~/.bashrc
```
Если не помогло, установите `bash-completion`:  
- **Debian/Ubuntu:** `sudo apt install bash-completion`  
- **RHEL/CentOS:** `sudo yum install bash-completion`  

---

#### **2. Проверка, не подменили ли команду `ls`**  
Чтобы проверить, какая именно команда `ls` выполняется, используйте:  
```bash
which ls
```
или  
```bash
type ls
```
или  
```bash
command -v ls
```
Если вывод **не** `/bin/ls`, возможно, `ls` – это алиас или скрипт. Проверьте с помощью:  
```bash
alias ls
```
Если `ls` переопределён, удалите алиас:  
```bash
unalias ls
```
Также проверьте содержимое `~/.bashrc`, `~/.bash_profile` и `/etc/profile`.  

---

#### **3. Вы добавили алиас в `~/.bashrc`, но он не работает. Почему?**  
Причины:  
1. **Не применили изменения** (нужно выполнить `source ~/.bashrc`).  
2. **Добавили алиас в другой файл** (например, в `~/.bash_profile`, который загружается только при логине).  
3. **Ошибка в синтаксисе алиаса**. Проверьте, правильно ли он записан:  
   ```bash
   alias ll='ls -l'
   ```
4. **Алиас был переопределён позже в `~/.bashrc` или другим скриптом**.  

**Решение:**  
Выполните:  
```bash
source ~/.bashrc
alias
```
и проверьте, есть ли ваш алиас в списке.  

---

### **Практические задания**  

#### **1. Создать алиас, который сохраняет список алиасов в файл**  
Добавьте в `~/.bashrc`:  
```bash
alias save_aliases="alias > ~/aliases_list.txt"
```
Примените изменения:  
```bash
source ~/.bashrc
```
Теперь при запуске `save_aliases` список алиасов сохранится в `~/aliases_list.txt`.  

---

#### **2. Два алиаса с одинаковыми названиями в `~/.bashrc`. Какой работает?**  
Если в `~/.bashrc` есть:  
```bash
alias mycmd="echo 'Первый алиас'"
alias mycmd="echo 'Второй алиас'"
```
То **работает последний объявленный алиас** (в данном случае `'Второй алиас'`).  

Проверить можно командой:  
```bash
alias mycmd
```

---

#### **3. Создать команду `getlog`, которая выводит последние 5 строк `/var/log/kdump.log` и добавляет в `mykernellog`**  
Добавьте в `~/.bashrc`:  
```bash
alias getlog="tail -n 5 /var/log/kdump.log | tee -a ~/mykernellog"
```
Примените изменения:  
```bash
source ~/.bashrc
```
Теперь команда `getlog` выведет последние 5 строк из `/var/log/kdump.log` и одновременно сохранит их в `~/mykernellog`.