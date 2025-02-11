## **1. С помощью какой программы можно работать с файлами в графическом интерфейсе?**  
В **Linux**:  
- **Nautilus** (GNOME)  
- **Dolphin** (KDE)  
- **Thunar** (XFCE)  
- **PCManFM** (LXDE)  

В **Windows**:  
- **Проводник (Explorer.exe)**  

## **2. Как узнать текущую директорию в командной строке?**  
```bash
pwd
```
(*print working directory* – вывести рабочую директорию).  

## **3. Что удобнее — полный или относительный путь?**  
- **Полный путь** (`/home/user/docs/file.txt`) удобен для скриптов и автоматизации.  
- **Относительный путь** (`../file.txt`) удобен для быстрого перемещения.  
**Выбор зависит от ситуации.**  

## **4. Как сделать так, чтобы не приходилось писать целиком команду или путь?**  
- **Автодополнение**: `Tab` в командной строке.  
- **Алиасы** (`alias ll='ls -lah'`).  
- **Добавление пути в `$PATH`** (для программ, запускаемых без полного пути).  

## **5. Какими способами можно вернуться в домашнюю директорию пользователя?**  
- `cd ~`  
- `cd` (без аргументов)  
- `cd $HOME`


# Practice

### **1. Создание директории „New Dir“ с тремя пробелами в названии без кавычек**  
Используем экранирование пробелов (`\`):  
```bash
mkdir New\ \ \ Dir
```

### **2. Разом создать директорию `dira` со вложенной `dirb`**  
```bash
mkdir -p dira/dirb
```

### **3. Удалить `dirb`, не удаляя `dira`**  
```bash
rmdir dira/dirb
```

### **4. Все способы зайти в `/usr/share/doc/man-pages`**  

#### **Если вы в домашней директории (`~`):**  
```bash
cd /usr/share/doc/man-pages  # Полный путь
cd ../../usr/share/doc/man-pages  # Относительный путь (из /home/user)
cd $(find /usr/share/doc -type d -name "man-pages")  # Через `find`
```

#### **Если вы в `/etc/`:**  
```bash
cd /usr/share/doc/man-pages  # Полный путь
cd ../usr/share/doc/man-pages  # Относительный путь
cd $(find /usr/share/doc -type d -name "man-pages")  # Через `find`
```

---

### **5. Копирование `Music` в GUI и заход в `Music (copy)`**  
В GUI:  
- **Копировать → Вставить (Ctrl+C, Ctrl+V).**  
- Переход в `Music (copy)` возможен через:
  ```bash
  cd Music\ \(copy\)
  cd "Music (copy)"
  cd $(ls | grep "Music (copy)")
  ```

---

### **6. Переименовать `Music (copy)`, добавив пробелы перед скобкой, и зайти в неё**  
```bash
mv Music\ \(copy\) Music\ \ \ \(copy\)
```
Заход в неё:  
```bash
cd Music\ \ \ \(copy\)
cd "Music   (copy)"
cd $(ls | grep "Music")
```

---

### **7. Переключение между `/usr/share/applications` и `/var/log/chrony`**  
```bash
cd /usr/share/applications
cd /var/log/chrony

# Быстрое переключение
cd -
pushd /usr/share/applications; popd
```

---

### **8. Посмотреть содержимое `/usr/bin/` из домашней директории**  
**Полный путь:**  
```bash
ls /usr/bin/
```
**Относительный путь:**  
```bash
ls ../../usr/bin/
```

---

### **9. Создать `/tmp/testdir` полным и относительным путём**  
**Полный путь:**  
```bash
mkdir /tmp/testdir
```
**Относительный путь:**  
```bash
mkdir ../../tmp/testdir
```

---

### **10. Создать `/home/user/testdir1/testdir11/testdir111` из `/usr/share/applications` и вывести содержимое**  
```bash
mkdir -p /home/user/testdir1/testdir11/testdir111
ls -R /home/user/testdir1
```

---

### **11. Создать `/home/user/testdir2/testdir22` и `/tmp/testdir2/testdir22` из `/var/log`, затем посмотреть их содержимое**  
```bash
mkdir -p /home/user/testdir2/testdir22 /tmp/testdir2/testdir22
ls -R /home/user/testdir2 /tmp/testdir2/testdir22
```

---

### **12. Удалить `/home/user/testdir1` и `/tmp/testdir2/testdir22` одной командой из `/tmp` с выводом информации**  
```bash
rm -rv ~/testdir1 /tmp/testdir2/testdir22
```