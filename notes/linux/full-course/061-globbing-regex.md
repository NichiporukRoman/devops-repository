### **Ответы на вопросы**  

1. **В чем отличие глоббинга от регулярных выражений?**  
   - **Глоббинг (Globbing)** используется **в оболочках (bash, zsh)** для работы с именами файлов.  
   - **Регулярные выражения (Regex)** используются в **sed, grep, awk, perl и других утилитах** для обработки текста.  
   - Отличия:  
     | Функция | Глоббинг | Регулярные выражения |
     |---------|----------|----------------------|
     | Применяется к | Именам файлов | Тексту в файлах |
     | Символы | `*`, `?`, `[]` | `.`, `*`, `+`, `[]`, `^`, `$`, `\` и т. д. |
     | Где используется | `ls`, `rm`, `cp`, `mv` | `grep`, `sed`, `awk`, `perl` |

---

2. **При работе с `sed`, изменится ли исходный файл?**  
   - **По умолчанию – нет**. `sed` выводит изменённый текст в stdout, но не записывает изменения.  
   - Чтобы изменить файл **на месте**, нужно использовать флаг `-i`:  
     ```bash
     sed -i 's/old_text/new_text/g' file.txt
     ```
   - Без `-i`, можно сохранить изменения в новый файл:  
     ```bash
     sed 's/old_text/new_text/g' file.txt > newfile.txt
     ```

---

3. **Как прочитать файл конфигурации `httpd` (Apache) без комментариев?**  
   - Используем `grep`, чтобы удалить строки, начинающиеся с `#`:  
     ```bash
     grep -vE '^\s*#' /etc/httpd/conf/httpd.conf | grep -vE '^\s*$'
     ```
   - **Разбор команды:**  
     - `grep -vE '^\s*#'` — удаляет строки, начинающиеся с `#` (учитывает пробелы перед `#`).  
     - `grep -vE '^\s*$'` — удаляет пустые строки.  

---

4. **Можно ли одной командой создать 100 папок вида `backup_server_id1`, `backup_server_id2` ... `backup_server_id100`?**  
   - **Да**, с помощью `mkdir` и `{}`:  
     ```bash
     mkdir backup_server_id{1..100}
     ```
   - Это создаст **100 папок**:  
     ```
     backup_server_id1 backup_server_id2 ... backup_server_id100
     ```
   - Можно использовать `seq` и `xargs`:  
     ```bash
     seq 1 100 | xargs -I {} mkdir backup_server_id{}
     ```