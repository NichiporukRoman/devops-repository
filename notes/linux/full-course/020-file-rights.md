### Ответы на вопросы:

#### 1. **Запустите `ls -l /etc`, возьмите 3 случайных файла и опишите, какие права у этих файлов. Представьте эти права в численном виде.**

Пример вывода команды `ls -l /etc`:
```bash
-rw-r--r-- 1 root root  1171 Jan  4 09:52 passwd
-rw-r--r-- 1 root root   459 Jan  4 09:52 group
-rw-r--r-- 1 root root   666 Jan  4 09:52 shadow
```

- **passwd**:
  - Права: `-rw-r--r--`
  - Описание:
    - **`rw-`** (для владельца): право на чтение и запись.
    - **`r--`** (для группы): право на чтение.
    - **`r--`** (для остальных): право на чтение.
  - Числовые права: **644**

- **group**:
  - Права: `-rw-r--r--`
  - Описание:
    - **`rw-`** (для владельца): право на чтение и запись.
    - **`r--`** (для группы): право на чтение.
    - **`r--`** (для остальных): право на чтение.
  - Числовые права: **644**

- **shadow**:
  - Права: `-rw-r--r--`
  - Описание:
    - **`rw-`** (для владельца): право на чтение и запись.
    - **`r--`** (для группы): право на чтение.
    - **`r--`** (для остальных): право на чтение.
  - Числовые права: **644**

---

### Задания:

#### 1. **Создайте группы `company`, `it`, `sales`. Создайте директории `/company`, `/company/it`, `/company/sales`, `/company/shared`. Создайте пользователей `ituser1`, `ituser2`, `itadmin`, `suser1`, `suser2`, `sadmin`, так чтобы у всех пользователей основной группой была `company`, у пользователей `it*` оболочка была `bash`, дополнительной группой была `it`, а домашняя директория находилась в `/company/it/`. У пользователей `s*` оболочка должна быть `sh`, дополнительной группой должна быть `sales`, а домашняя директория внутри `/company/sales`. Содержимое директории `/company/sales` должны видеть только root и участники группы `sales`. Содержимое директории `/company/it` должны видеть только root и участники группы `it`. Все пользователи должны видеть содержимое директории `/company/shared`. Каждый пользователь должен создать файл внутри `/company/shared` со своим логином.**

1. **Создание групп:**
   ```bash
   sudo groupadd company
   sudo groupadd it
   sudo groupadd sales
   ```

2. **Создание директорий:**
   ```bash
   sudo mkdir -p /company/it /company/sales /company/shared
   ```

3. **Создание пользователей:**
   Для пользователей `it`:
   ```bash
   sudo useradd -m -g company -G it -d /company/it/ituser1 -s /bin/bash ituser1
   sudo useradd -m -g company -G it -d /company/it/ituser2 -s /bin/bash ituser2
   sudo useradd -m -g company -G it -d /company/it/itadmin -s /bin/bash itadmin
   ```

   Для пользователей `sales`:
   ```bash
   sudo useradd -m -g company -G sales -d /company/sales/suser1 -s /bin/sh suser1
   sudo useradd -m -g company -G sales -d /company/sales/suser2 -s /bin/sh suser2
   sudo useradd -m -g company -G sales -d /company/sales/sadmin -s /bin/sh sadmin
   ```

4. **Настройка прав доступа для директорий:**
   - Для `/company/it`:
     ```bash
     sudo chown root:it /company/it
     sudo chmod 770 /company/it
     ```
   - Для `/company/sales`:
     ```bash
     sudo chown root:sales /company/sales
     sudo chmod 770 /company/sales
     ```

5. **Настройка доступа к `/company/shared` (видимость для всех пользователей):**
   ```bash
   sudo chown root:company /company/shared
   sudo chmod 770 /company/shared
   ```

6. **Пользователи создают файлы в `/company/shared`:**
   Каждый пользователь может создать файл в директории `/company/shared`:
   ```bash
   touch /company/shared/ituser1
   touch /company/shared/ituser2
   touch /company/shared/itadmin
   touch /company/shared/suser1
   touch /company/shared/suser2
   touch /company/shared/sadmin
   ```

---

#### 2. **Создайте группы `academy`, `teachers` и `students`, соответствующие директории, а также пользователей (student & teacher). У всех пользователей должны быть домашние директории в соответствующих директориях (`/academy/students/student`). Только пользователи групп должны иметь доступ на соответствующие директории (`/academy/students`). Также создайте группу `staff`, у которой будет доступ во все указанные директории. Создайте расшаренную директорию `/academy/secret`, внутри которой пользователи групп `teachers` и `staff` смогут создавать файлы, но не смогут удалять чужие файлы. У пользователей группы `students` не должно быть доступа. Создайте «программу» `spy`, с помощью которой студенты смогут смотреть содержимое директории `/academy/secret1`. И с помощью `sudo` разрешите пользователям группы `students` от имени группы `teachers` удалять файлы внутри `/academy/secret`.**

1. **Создание групп и директорий:**
   ```bash
   sudo groupadd academy
   sudo groupadd teachers
   sudo groupadd students
   sudo groupadd staff

   sudo mkdir -p /academy/students /academy/teachers /academy/staff /academy/secret
   ```

2. **Создание пользователей для группы `students` и `teachers`:**
   ```bash
   sudo useradd -m -g academy -G students -d /academy/students/student -s /bin/bash student
   sudo useradd -m -g academy -G teachers -d /academy/teachers/teacher -s /bin/bash teacher
   ```

3. **Создание пользователя для группы `staff`:**
   ```bash
   sudo useradd -m -g academy -G staff -d /academy/staff/staff -s /bin/bash staff
   ```

4. **Установка прав доступа к директориям и файлам:**
   - Для `/academy/students` и `/academy/teachers`:
     ```bash
     sudo chmod 770 /academy/students /academy/teachers
     sudo chown root:students /academy/students
     sudo chown root:teachers /academy/teachers
     ```

   - Для `/academy/secret`:
     ```bash
     sudo chmod 770 /academy/secret
     sudo chown root:staff /academy/secret
     ```

5. **Создание программы `spy` для просмотра содержимого:**
   - Создайте файл `spy`:
     ```bash
     sudo touch /usr/local/bin/spy
     sudo chmod +x /usr/local/bin/spy
     ```

     Внутри `spy` создайте скрипт для просмотра содержимого директории:
     ```bash
     echo -e "#!/bin/bash\nls /academy/secret1" | sudo tee /usr/local/bin/spy > /dev/null
     ```

6. **Настройка прав для удаления файлов с помощью `sudo` для группы `students`:**
   Добавьте разрешение для группы `students` удалять файлы в `/academy/secret`:
   ```bash
   sudo visudo
   ```
   Добавьте строку:
   ```bash
   %students ALL=(teachers) NOPASSWD: /bin/rm /academy/secret/*
   ```

---

Эти задания покрывают основные вопросы управления пользователями, группами и правами в Linux. Они обеспечивают понимание принципов работы с файловой системой и управления доступом для пользователей и групп.