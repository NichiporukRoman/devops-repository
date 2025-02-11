### Ответы на вопросы:

#### **Как посмотреть размер файлов и директорий?**
1. **Файл:** `ls -lh filename`
2. **Директория (итоговый размер всех файлов внутри):**  
   ```bash
   du -sh directory_name
   ```
3. **Все файлы и папки в текущей директории с их размерами:**  
   ```bash
   du -h --max-depth=1
   ```
4. **Отсортированный список файлов по размеру:**  
   ```bash
   du -ah | sort -rh | head -10
   ```

#### **Чем отличается `;` от `+` у утилиты `find`?**
- `;` — выполняет команду для **каждого** найденного файла (заменяется `{};`).
- `+` — передает **список** файлов сразу одной командой (эффективнее).
  
**Пример:**  
```bash
find /etc -type f -exec ls -lh {} +
```
Этот вариант быстрее, чем:
```bash
find /etc -type f -exec ls -lh {} \;
```

#### **Для чего нужна архивация? Какая утилита используется для архивации?**
Архивация позволяет объединять файлы и сохранять их в одном контейнере (без сжатия). Основная утилита — `tar`.  
**Пример создания архива:**  
```bash
tar -cvf archive.tar /path/to/files
```

#### **Для чего нужно сжатие? Какие утилиты используются для сжатия, и чем они отличаются?**
Сжатие уменьшает размер файлов.  
Популярные утилиты:
- **gzip** (`.gz`) — быстрое, но средняя степень сжатия.
- **bzip2** (`.bz2`) — лучше сжимает, но медленнее.
- **xz** (`.xz`) — сильное сжатие, но медленнее всех.

**Пример:**  
```bash
tar -cvf archive.tar /path && gzip archive.tar  # создаст archive.tar.gz
tar -cvjf archive.tar.bz2 /path  # сразу сжимает bzip2
```

---

### **Задания с решениями:**

#### **1. Найдите самую большую директорию в корне. Затем найдите самую большую директорию/файл в этой директории.**
```bash
du -Sh /* | sort -rh | head -1
```
Допустим, самая большая `/var`. Дальше ищем в ней:
```bash
du -Sh /var/* | sort -rh | head -1
```
Продолжаем так же для найденной директории.

#### **2. Найдите все файлы в системе, которые принадлежат вашему пользователю.**
```bash
find / -type f -user $(whoami) 2>/dev/null
```
(Отключаем ошибки `Permission denied` с `2>/dev/null`).

#### **3. Найдите все директории в системе, в имени которых встречается «.d» и сохраните список в файл.**
```bash
find / -type d -name "*.d" > directories_list.txt
```

#### **4. Найдите все файлы в системе с SUID и скопируйте их в `~/suidfiles`.**
```bash
mkdir ~/suidfiles
find / -type f -perm -4000 -exec cp --parents {} ~/suidfiles \;
```

#### **5. Создайте архив с файлами из `/var/log` с `gzip` и `bzip`, сравните размеры.**
```bash
tar -cvf /tmp/logs.tar /var/log
gzip -k /tmp/logs.tar
bzip2 -k /tmp/logs.tar
ls -lh /tmp/logs.tar*
```

#### **6. Создайте директорию `exam`, файл `myfile`, жёсткую и символическую ссылки.**
```bash
mkdir exam && cd exam
touch myfile
ln myfile hardlink
ln -s myfile symlink
ls -li  # Смотрим inode
mv myfile $(stat -c %i myfile)
mv symlink $(stat -c %i symlink)
tar --exclude=$(stat -c %i symlink) -czvf exam.tar.gz exam
```

#### **7. Настройка `cron` для `backup`, `user`, `root`.**
Редактируем `crontab` для `backup`:
```bash
crontab -e -u backup
```
Добавляем строку:
```bash
0 0 * * * find /data -type f -mtime +5 -exec tar -rvf /backup/archive.tar {} \; -exec rm {} \;
```

Редактируем `crontab` для `user`:
```bash
crontab -e -u user
```
Добавляем строку:
```bash
*/10 * * * * touch /data/file_$(date +\%s)
```

Редактируем `crontab` для `root`:
```bash
crontab -e -u root
```
Добавляем строку:
```bash
30 23 * * 5 tar -czf /var/log/reports/$(date +\%F).tar.gz /data /backup/archive.tar
```

---

Готово! Если есть вопросы по конкретным моментам — спрашивай. 🚀