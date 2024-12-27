# Task 18 | Monitoring
## To do
1. Поднять с помощью docker-compose прометеус, нод-экспортер и алертменаджер.
2. Написать алерт для прометеуса по cpu.
3. Сделать вывод слак или телеграмм на выбор.

4. 2 часть Поднять ещё один инстанс.
5. Подключить нод-экспортер с помощью docker или docker-compose.
6. В прометеусе сделать задачи по лейблам алерта (СPU с одного инстанса, VM с другого инстанса).
7. Убрать весь хардкод айпишников, использовать теги авс инстансов Сделать алерты.
## Jobs
1. Ниже пояснение к реализации:

### docker-compose.yml:

Для `node-exporter` сервиса мы монтируем некоторые необходимые пути от хоста к контейнеру в `:ro` режиме «только для чтения»:
- /proc
- /sys
- /

Служба `prometheus` сохраняет свои данные в локальном каталоге на хосте по адресу `./prometheus_data`. `Docker Compose` создаст этот каталог после запуска prometheusконтейнера.

На следующем этапе мы создадим файл конфигурации `Prometheus`, который `Compose` будет считывать из `./prometheus.yml`.
### prometheus.yml:
На этом этапе вы настроите `Prometheus` для сбора метрик `node-exporter` и отправки их в `Grafana Cloud`. Мы настроим следующие разделы

- `global`: Глобальные настройки `Prometheus` по умолчанию. В этом примере мы устанавливаем `scrape_interval` для скрапинга метрик из настроенных заданий значение 15 секунд.
- `scrape_configs`: Определенные задания по очистке.
- `remote_write`: Конфигурация Prometheus для отправки полученных метрик на удаленную конечную точку.

<details open>
<summary>По строчно</summary>

* `global`:

```yml
global:
    scrape_interval: 1m
```

1. scrape_interval: 1m

Указывает глобальную частоту сбора метрик — раз в минуту.
Это настройка по умолчанию, которая применяется ко всем заданиям (job_name), если в них не указано иное.

* `scrape_configs`:

```yml
scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 1m
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node'
    static_configs:
      - targets: ['node-exporter:9100'] 
```
1. job_name: 'prometheus'

    - Это задание для мониторинга самого Prometheus.
    - scrape_interval: 1m:

        * Частота сбора метрик для этого задания — раз в минуту.
        * Перезаписывает значение из global.scrape_interval.
    - static_configs:
        * targets: ['localhost:9090']:
            - Prometheus собирает свои собственные метрики через HTTP-эндпоинт http://localhost:9090/metrics.
2. job_name: 'node'
    - Это задание для сбора метрик от Node Exporter.
    - static_configs:
        * targets: ['node-exporter:9100']:
            - Указывает на Node Exporter, который запущен в контейнере и доступен через сеть Docker Compose.

- `remote_write`:
```yml
remote_write:
  - url: '<Your Prometheus remote_write endpoint>'
    basic_auth:
      username: '<Your Grafana Username>'
      password: '<Your Grafana Cloud Access Policy Token>'
```
3. `remote_write`:
    - Указывает, что собранные метрики должны быть отправлены на удаленный сервер.
    - Это используется для интеграции с такими платформами, как `Grafana Cloud` или другими системами, поддерживающими формат `Prometheus`.

    - Параметры:
        * url: 
            - Адрес удаленного сервиса для приема метрик (например, https://prometheus-us-central1.grafana.net/api/prom/push для Grafana Cloud).
        * basic_auth:
            - username: Логин для аутентификации, обычно это ваш пользователь в Grafana Cloud.
            - password: Токен доступа для вашей Grafana Cloud организации.
</details>

