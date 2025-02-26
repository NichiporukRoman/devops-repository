### **Ответы на вопросы:**  

#### **1. С помощью каких команд можно посмотреть содержимое текстового файла?**  
- `cat filename` – выводит весь файл  
- `less filename` – постраничный просмотр  
- `more filename` – постраничный просмотр (аналог `less`, но хуже)  
- `head filename` – первые 10 строк  
- `tail filename` – последние 10 строк  
- `nano filename` или `vim filename` – редактирование файла  

---

#### **2. Какими способами можно посмотреть 30-ю строку файла `/etc/passwd`?**  
- С `sed`:  
  ```bash
  sed -n '30p' /etc/passwd
  ```
- С `awk`:  
  ```bash
  awk 'NR==30' /etc/passwd
  ```
- С `head` и `tail`:  
  ```bash
  head -n 30 /etc/passwd | tail -n 1
  ```

---

#### **3. Какое преимущество дают `head` и `tail` при чтении больших файлов?**  
- Позволяют **не загружать весь файл** в память.  
- Быстрее, если нужен только кусок данных (например, заголовок `head` или логи в реальном времени `tail -f`).  

---

#### **4. Как найти файл, в котором есть слово «hello»?**  
```bash
grep -r "hello" /path/to/directory
```
Флаг `-r` рекурсивно ищет во всех файлах внутри папки.  

---

#### **5. Каким удобным способом можно смотреть изменяющийся файл?**  
```bash
tail -f filename
```
Показывает новые строки в реальном времени (полезно для логов).  

---

### **Задания:**  

#### **1. Вывести первые и последние 7 строк из файла `/etc/group`:**  
```bash
head -n 7 /etc/group
tail -n 7 /etc/group
```

---

#### **2. Вывести все строки ниже 14-й в файле `/etc/group`:**  
```bash
tail -n +15 /etc/group
```
(Флаг `+15` означает «начиная с 15-й строки».)  

---

#### **3. Используя `less`, найти слово `games` в файле `/etc/passwd`:**  
```bash
less /etc/passwd
```
Затем нажмите `/games` и Enter для поиска.  

---

#### **4. Найти слово `games` и номер строки в файле `/etc/passwd` с помощью `grep`:**  
```bash
grep -n "games" /etc/passwd
```
Флаг `-n` показывает номер строки.  

---

#### **5. Найти все файлы, содержащие `sync` в `/etc`:**  
```bash
grep -rl "sync" /etc
```

---

#### **6. Найти все файлы, содержащие `sync`, без учёта регистра букв:**  
```bash
grep -ri "sync" /etc
```
Флаг `-i` делает поиск **независимым от регистра**.



# Ссылка на игру: https://vim-adventures.com/