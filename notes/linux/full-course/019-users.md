### Ответы на вопросы:

#### 1. **Возьмите любую строчку из `/etc/passwd` и «расшифруйте», что написано.**

Строки в файле `/etc/passwd` имеют следующий формат:
```
username:password:UID:GID:GECOS:homedir:shell
```

Пример строки:
```
sysadmin:x:10101:10000:sysadmin user:/home/sysadmin:/bin/bash
```

- **username** (`sysadmin`): Имя пользователя.
- **password** (`x`): Здесь хранится пароль, но в современных системах это обычно «x», что означает, что пароль хранится в `/etc/shadow`.
- **UID** (`10101`): Идентификатор пользователя.
- **GID** (`10000`): Идентификатор основной группы пользователя.
- **GECOS** (`sysadmin user`): Это поле может содержать дополнительные данные, такие как полное имя пользователя.
- **homedir** (`/home/sysadmin`): Путь к домашней директории пользователя.
- **shell** (`/bin/bash`): Указание на оболочку, которую будет использовать пользователь при входе.

#### 2. **В каких файлах хранится информация о пользователях и группах?**

- **/etc/passwd** — Хранит основную информацию о пользователях, такую как имя пользователя, UID, GID, домашняя директория, оболочка.
- **/etc/shadow** — Хранит зашифрованные пароли пользователей и данные о политике паролей.
- **/etc/group** — Хранит информацию о группах пользователей, включая название группы, GID и членов группы.
- **/etc/gshadow** — Хранит зашифрованные пароли групп.

---

### Задания:

#### 1. **Создайте директорию `/home/it`. Создайте группу IT с идентификатором 10000. Создайте 3 пользователей - `sysadmin`, `helpdesk` и `netadmin`, домашние директории которых будут находиться в `/home/it`, а также они будут входить в группу IT и оболочкой у всех будет `/bin/bash`. Идентификаторы должны быть 10101, 10201, 10301.**

1. Создание директории `/home/it`:
   ```bash
   sudo mkdir /home/it
   ```

2. Создание группы IT с GID 10000:
   ```bash
   sudo groupadd -g 10000 IT
   ```

3. Создание пользователей с домашними директориями в `/home/it` и указанием GID для группы IT:
   ```bash
   sudo useradd -u 10101 -g IT -d /home/it/sysadmin -s /bin/bash sysadmin
   sudo useradd -u 10201 -g IT -d /home/it/helpdesk -s /bin/bash helpdesk
   sudo useradd -u 10301 -g IT -d /home/it/netadmin -s /bin/bash netadmin
   ```

#### 2. **Предоставьте пользователю `sysadmin` все права на систему. Пользователь `netadmin` должен иметь возможность запускать команду `nmtui` от имени `root`. А пользователь `helpdesk` должен иметь возможность менять пароли всех пользователей, кроме `sysadmin` и `root`.**

1. Предоставить пользователю `sysadmin` все права на систему:
   - Добавить `sysadmin` в группу `sudo`:
     ```bash
     sudo usermod -aG sudo sysadmin
     ```

2. Разрешить пользователю `netadmin` запускать команду `nmtui` от имени `root`:
   - Открыть файл `/etc/sudoers`:
     ```bash
     sudo visudo
     ```
   - Добавить строку:
     ```
     netadmin ALL=(ALL) NOPASSWD: /usr/bin/nmtui
     ```

3. Разрешить пользователю `helpdesk` менять пароли всех пользователей, кроме `sysadmin` и `root`:
   - Открыть файл `/etc/sudoers`:
     ```bash
     sudo visudo
     ```
   - Добавить строку:
     ```
     helpdesk ALL=(ALL) NOPASSWD: /usr/sbin/chpasswd, !/usr/sbin/chpasswd sysadmin, !/usr/sbin/chpasswd root
     ```

#### 3. **Создайте три группы – `marketing`, `sales` и `it`. Для каждой группы создайте директорию внутри `/home`, а также по два пользователя - `user.marketing`, `manager.marketing`, `user.sales`, `manager.sales`, `admin` и `helpdesk`. Группы для пользователей должны быть основными. `manager`-ы должны иметь возможность залогиниться, а `юзеры` нет. У `manager`-ов должна быть своя домашняя директория, а для `user`-ов домашней директорией должна выступать директория группы.**

1. Создание групп:
   ```bash
   sudo groupadd marketing
   sudo groupadd sales
   sudo groupadd it
   ```

2. Создание директорий для каждой группы:
   ```bash
   sudo mkdir /home/marketing
   sudo mkdir /home/sales
   sudo mkdir /home/it
   ```

3. Создание пользователей для каждой группы и установка необходимых прав:
   - Для группы `marketing`:
     ```bash
     sudo useradd -m -g marketing -s /bin/bash manager.marketing
     sudo useradd -m -g marketing -s /bin/false user.marketing
     ```
   - Для группы `sales`:
     ```bash
     sudo useradd -m -g sales -s /bin/bash manager.sales
     sudo useradd -m -g sales -s /bin/false user.sales
     ```
   - Для группы `it`:
     ```bash
     sudo useradd -m -g it -s /bin/bash admin
     sudo useradd -m -g it -s /bin/false helpdesk
     ```

4. Установка правильных прав для входа в систему (для `manager`-ов):
   ```bash
   sudo usermod -s /bin/bash manager.marketing
   sudo usermod -s /bin/bash manager.sales
   sudo usermod -s /bin/bash admin
   ```

Теперь у пользователей `manager.marketing`, `manager.sales` и `admin` есть возможность входить в систему, а у остальных пользователей доступ к оболочке будет ограничен.

---

Эти задания демонстрируют основные операции по созданию и управлению пользователями и группами в Linux, а также настройке прав доступа для выполнения различных действий.