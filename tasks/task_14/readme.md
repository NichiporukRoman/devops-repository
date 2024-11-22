# Task 14
## To do
1. Залить проект на github. Подключение к гиту должно быть с помощью ssh-key.
2. Cоздать ветку develop, внести изменение в файлы в develop и сделать pull request (merge request) в master (main). 
3. Все изменения производить в консоле. Показать откат коммита в develop ветке и сделать pull request (merge request).
4. Настроить git hooks так, чтобы в случае коммита, было отправлено письмо на электронную почту.
5. Создать 5 коммитов в develop ветке. В ветку main (master) записать только 1-й, 3-й и 5-й коммиты, которые были сделаны в develop

## Jobs 

1. Как сделать:
    1. Создаем репозиторий на github
    
    2. Далее на localhost в терминале создаем папку проекта:
    ```bash
    mkdir funnying-jobs
    ```
    3. Далее создаем local repository:
    ```bash
    echo "# funnying-jobs" >> README.md
    git init
    git add README.md
    ```
    Получаем

    ```sh
    hint: Using 'master' as the name for the initial branch. This default branch name
    hint: is subject to change. To configure the initial branch name to use in all
    hint: of your new repositories, which will suppress this warning, call:
    hint: 
    hint: 	git config --global init.defaultBranch <name>
    hint: 
    hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
    hint: 'development'. The just-created branch can be renamed via this command:
    hint: 
    hint: 	git branch -m <name>
    Initialized empty Git repository in /home/roman/funnying-jobs/.git/
    ```
    4. Создаем пары ssh ключей для доступа к github и прокидываем public key на github
    ```bash
    ssh-keygen -t rsa -b 4096 -C "romannichiporukk@gmail.com"
    ```
    5. Связываем репозитории (удаленный и локальный):
    ```
    git branch -M main
    git remote add origin git@github.com:NichiporukRoman/funnying-jobs.git
    git push -u origin main
    ```
2. Как сделать:
    1. В терминале создадим и переключимся на ветку develop:
    ```bash
    git branch develop
    git checkout develop
    ```
    2. Внесем изменения в `readme.md` и запушим ветку:
    ```bash
    echo "# funnying-jobs-develop" >> README.md
    git add .
    git commit -m "develop" 
    git push --set-upstream origin develop
    ```
3. Как сделать:
    1.  Просмотрим журнал коммитов:
    ```bash
    git log 
    ```
    2. Далее используя id коммита откатимся до него:
    ```bash 
    git reset <id>
    ```
    3. Запушим изменения:
    ```bash
    git push --force
    ```
4. Как сделать:
    1. Пишем файл `.git/hooks/post-commit `
    2. Пишем файл `.git/hooks/post-commit.py`
    3. Оба файла нужно сделать выполняемыми.
5. Как сделать 
    1. Для упрощения напишнм файд `5.sh`
    2. Выполним его
    ```bash
    bash 5.sh
    ```
    3. Далее сделае `cherry-pick` по 1, 3, 5 коммиту:
    ```bash
    git cherry-pick <id первого>
    git cherry-pick <id третьего>
    git cherry-pick <id пятого>
    ```
