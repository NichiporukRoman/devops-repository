# Gitlab CI/CD
![](https://softwarefinder.tudelft.nl/media/logo/gitlab-logo-gray-stacked-rgb.png)
## Gitlab как Github
GitLab и GitHub — это похожие платформы для управления репозиториями, но они отличаются по функциональности и подходу к работе. Вот основные различия и сходства:
### Общие черты
1. Управление репозиториями.
2. CI/CD
3. Удобные интерфейсы для работы с кодом, ревью, сравнения веток и управления задачами.
4. Поддерживают интеграции с популярными инструментами (Jira, Slack, Kubernetes и др.).
### Различия
| Признак | Github | Gitlab |
|---|---|---|
| CI/CD | - | Простая настройка runners для локального или облачного запуска |
| Self-Hosted | Можно установить на свои серверы (Community Edition бесплатно) / Подходит для организаций, которые хотят полный контроль над данными | Enterprise Server доступен, но требует лицензии и больше усилий для установки. |
| Инструменты DevOps | Основной упор на управление кодом и интеграцию с внешними DevOps-инструментами (например, Jenkins, CircleCI)     | Полный набор DevOps-инструментов: управление кодом, CI/CD, мониторинг, деплой | 
| Уровни прав доступа | Уровни прав проще: Admin, Maintainer, Collaborator | Более гибкое управление доступом: Owner, Maintainer, Developer, Reporter, Guest |
| Roadmaps и Issues | Поддержка базового управления задачами через Issues и Projects | Более развитый инструмент для управления задачами и дорожной картой проектов |
## Gitlab CI
GitLab CI/CD — это система для автоматизации процессов разработки, тестирования, сборки и доставки программного обеспечения (DevOps). Она встроена в GitLab и позволяет разработчикам организовать непрерывную интеграцию (CI) и доставку (CD) программных продуктов.

## Gitlab Runners
### По расположению
#### GitLab-hosted runners
Если вы используете GitLab.com или GitLab Dedicated, вы можете запускать свои задания CI/CD на GitLab-hosted runners . Эти runners управляются GitLab и полностью интегрированы с GitLab.com. По умолчанию эти runners включены для всех проектов. Вы можете отключить runners, если у вас есть роль Owner для проекта.
#### self-managed runners
В качестве альтернативы вы можете установить GitLab Runner и зарегистрировать собственные runners на GitLab.com или на своем собственном экземпляре. Чтобы использовать самоуправляемые runners, вы устанавливаете GitLab Runner на инфраструктуре, которой владеете или управляете.

### Executors(Исполнители)
GitLab Runner реализует различные исполнители, которые можно использовать для запуска сборок в разных средах.
GitLab Runner предоставляет следующие исполнители:
- `SSH`
- `Shell`
- `Parallels`
- `VirtualBox`
- `Docker`
- `Docker Autoscaler`
- `Docker Machine (auto-scaling)`
- `Kubernetes`
- `Instance`
- `Custom`
---
#### Shell 
Shell — самый простой в настройке исполнитель. Все необходимые зависимости для ваших сборок необходимо установить вручную на той же машине, на которой установлен GitLab Runner.
#### VirtualBox / Parallels
Вы можете использовать эти варианты для запуска своих сборок в операционных системах Windows, Linux, macOS или FreeBSD. GitLab Runner подключается к виртуальной машине и запускает на ней сборку. Исполнитель виртуальной машины также можно использовать для снижения затрат на инфраструктуру.
#### Docker
Вы можете использовать Docker для чистой среды сборки. Все зависимости для сборки проекта можно поместить в образ Docker, что делает управление зависимостями более простым. Вы можете использовать Docker executor для создания среды сборки с зависимыми службами , такими как MySQL.
#### Docker Machine
Docker Machine — это специальная версия Docker executor с поддержкой автоматического масштабирования. Она работает как типичный Docker executor, но с хостами сборки, создаваемыми по требованию Docker Machine.
#### Docker Autoscaler
Docker Autoscaler executor — это Docker executor с поддержкой автомасштабирования, который создает экземпляры по требованию для размещения заданий, обрабатываемых менеджером runner. Он оборачивает Docker executor , чтобы поддерживались все опции и функции Docker executor.

Docker Autoscaler использует Fleeting-плагины для автомасштабирования. Fleeting — это абстракция для группы автомасштабируемых экземпляров, которая использует плагины, поддерживающие облачных провайдеров, таких как Google Cloud, AWS и Azure.
#### Instance
Исполнитель экземпляра — это исполнитель с функцией автоматического масштабирования, который создает экземпляры по требованию для удовлетворения ожидаемого объема заданий, обрабатываемых диспетчером выполнения.

Исполнитель экземпляра также использует временные плагины для автоматического масштабирования.

Вы можете использовать экземпляр исполнителя, когда заданиям требуется полный доступ к экземпляру хоста, операционной системе и подключенным устройствам. Экземпляр исполнителя также можно настроить для размещения одноарендных и многоарендных заданий.
#### Kubernetes
Вы можете использовать Kubernetes executor для использования существующего кластера Kubernetes для ваших сборок. Executor вызывает API кластера Kubernetes и создает новый Pod (с контейнером сборки и контейнерами служб) для каждого задания GitLab CI.
#### SSH-исполнитель
Исполнитель SSH добавлен для полноты, но это наименее поддерживаемый исполнитель. Когда вы используете исполнитель SSH, GitLab Runner подключается к внешнему серверу и запускает сборки там. У нас есть несколько историй успеха от организаций, использующих этот исполнитель, но обычно вам следует использовать один из других типов.
#### Custom
Вы можете использовать Custom executor, чтобы указать собственные среды выполнения. Когда GitLab Runner не предоставляет executor (например, контейнеры Linux), он позволяет использовать пользовательские исполняемые файлы для подготовки и очистки сред.

---
### Runner status
| Статус | Описание |
|---|---|
| `online` | Исполнитель связался с GitLab в течение последних 2 часов и доступен для выполнения заданий |
| `offline` | Исполнитель не связывался с GitLab более 2 часов и недоступен для выполнения заданий. Проверьте исполнителя, чтобы узнать, можете ли вы вывести его в онлайн |
| `stale` | runner не связывался с GitLab более 7 дней. Если runner был создан более 7 дней назад, но он ни разу не связывался с экземпляром, он также считается устаревшим |
| `never_contacted` | runner никогда не связывался с GitLab. Чтобы заставить бегуна связаться с GitLab, запустите gitlab-runner run |

## Атрибуты Gitlab CI/CD

В GitLab CI/CD используются различные атрибуты в конфигурационном файле .gitlab-ci.yml для настройки пайплайнов, стадий, задач и окружений. Эти атрибуты определяют, как и когда выполнять задачи, а также управляют поведением пайплайна.

Вот ключевые категории атрибутов и их назначение:

1. Базовые атрибуты
    - `stages`: Определяет стадии выполнения пайплайна
    - jobs: Каждая задача в GitLab CI/CD — это отдельный job.   Атрибуты для их настройки:
        * `script`: Команды, которые будут выполнены в задаче
        * `stage`: Указывает, к какой стадии относится задача.
        * name: Имя задачи (например, build image или pull image).
2. Запуск и ограничения
    - `only` и `except`: Определяет, в каких ветках, тегах или событиях задача должна выполняться.
    - `rules`: Более гибкий аналог only/except, позволяет настраивать выполнение задач по условиям.
    - when: Указывает, когда задача будет запущена. Возможные значения:
        * on_success (по умолчанию)
        * on_failure
        * always
        * manual (ручной запуск)
        * delayed (отложенный запуск)
3. 