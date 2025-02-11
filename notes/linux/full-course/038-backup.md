### **Ответы на вопросы**  

1. **Как посмотреть размер файлов и директорий?**  
   - Файл: `ls -lh <файл>` или `du -h <файл>`  
   - Директория: `du -sh <директория>`  
   - Все файлы в каталоге: `du -ah <директория> | sort -hr | head`  

2. **Чем отличается `;` от `+` у утилиты `find`?**  
   - `;` – выполняет команду для каждого найденного файла отдельно:  
     ```bash
     find . -name "*.log" -exec rm {} \;
     ```  
   - `+` – передаёт список файлов за один вызов команды, что эффективнее:  
     ```bash
     find . -name "*.log" -exec rm {} +
     ```  

3. **Для чего нужна архивация? Какая утилита используется для архивации?**  
   - Архивация объединяет несколько файлов в один архив (без сжатия).  
   - Основная утилита: `tar`  
     ```bash
     tar -cvf archive.tar /path/to/files
     ```  

4. **Для чего нужно сжатие? Какие утилиты используются для сжатия, и чем они отличаются?**  
   - Сжатие уменьшает размер файлов для экономии места.  
   - Основные утилиты:  
     - `gzip` – быстрое, но не самое эффективное сжатие (`.gz`).  
     - `bzip2` – лучшее сжатие, но медленнее (`.bz2`).  
     - `xz` – компромисс между скоростью и эффективностью (`.xz`).  
   - Пример:  
     ```bash
     gzip file.txt  # создаст file.txt.gz
     bzip2 file.txt  # создаст file.txt.bz2
     xz file.txt  # создаст file.txt.xz
     ```  

---

### **Задания**  

1. **Найти самую большую директорию в корне, затем в ней самую большую директорию/файл и так по цепочке**  
   ```bash
   du -ahx / | sort -rh | head -10
   ```  
   Повторять команду для найденных каталогов.  

2. **Найти все файлы, принадлежащие текущему пользователю**  
   ```bash
   find / -user $(whoami) 2>/dev/null
   ```  

3. **Найти все директории с `.d` в имени и сохранить список в файл**  
   ```bash
   find / -type d -name "*.d" > directories_list.txt
   ```  

4. **Найти все файлы с `suid` и скопировать их в `~/suidfiles`**  
   ```bash
   mkdir -p ~/suidfiles
   find / -type f -perm -4000 -exec cp {} ~/suidfiles/ \; 2>/dev/null
   ```  

5. **Создать архив `/var/log` с помощью `gzip` и `bzip2`, сравнить размеры**  
   ```bash
   tar -cvf logs.tar /var/log
   gzip -c logs.tar > logs.tar.gz
   bzip2 -c logs.tar > logs.tar.bz2
   ls -lh logs.tar.gz logs.tar.bz2
   ```  

6. **Создать `exam`, файл `myfile`, жёсткую и символьную ссылку, архив, удалить символическую ссылку из архива**  
   ```bash
   mkdir exam && cd exam
   touch myfile
   ln myfile hardlink
   ln -s myfile symlink
   stat myfile hardlink symlink  # получить иноды
   mv myfile <inode_number_myfile>
   mv symlink <inode_number_symlink>
   cd ..
   tar --exclude=exam/symlink -cvf exam.tar exam
   ```  

7. **Создать пользователя `backup`, настроить cron на удаление старых файлов, добавить `user` и `root` в cron**  

   **Создание пользователя:**  
   ```bash
   sudo useradd -m backup
   sudo passwd backup
   ```  

   **Cron для `backup` (удаление файлов старше 5 дней, добавление в архив):**  
   ```bash
   crontab -u backup -e
   ```  
   Добавить:  
   ```
   0 0 * * * find /data -type f -mtime +5 -exec tar -rvf /backup/archive.tar {} \; -exec rm {} \;
   ```  

   **Cron для `user` (создание файла каждые 10 минут):**  
   ```bash
   crontab -u user -e
   ```  
   Добавить:  
   ```
   */10 * * * * touch /data/file_$(date +\%s)
   ```  

   **Cron для `root` (запись отчёта по пятницам в 23:30):**  
   ```bash
   crontab -e
   ```  
   Добавить:  
   ```
   30 23 * * 5 tar -cvf /var/log/reports/$(date +\%Y-\%m-\%d).tar /data /backup/archive.tar
   ```  