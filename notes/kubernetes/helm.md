# Helm
Helm — это менеджер пакетов для Kubernetes, который упрощает развертывание, управление и обновление приложений внутри кластеров Kubernetes. Он предоставляет способ описания приложений с помощью шаблонов (Helm Charts) и автоматизирует многие сложные аспекты управления инфраструктурой.

![](https://helm.sh/img/helm.svg)
## Основные концепции Helm
### Chart
Helm Chart — это пакет, содержащий все необходимые файлы для развертывания приложения в Kubernetes. Chart включает:
- **Chart.yaml**: метаинформация о Chart (название, версия, описание).
- **values.yaml**: значения по умолчанию для параметров конфигурации.
- **Шаблоны (templates/)**: файлы, основанные на языке шаблонов Go, которые генерируют манифесты Kubernetes (YAML-файлы для объектов, таких как Deployment, Service и т.д.).
- **Другие файлы**: например, README.md, файлы зависимостей.

Пример структуры Helm Chart:
```
my-chart/
  Chart.yaml      # Основной файл метаданных
  values.yaml     # Значения по умолчанию
  templates/      # Шаблоны манифестов Kubernetes
  README.md       # Документация
```

### Release
Release — это экземпляр Chart, развернутый в Kubernetes-кластере. Каждый раз, когда вы "устанавливаете" Chart, создается новый Release с уникальным именем. Например:
```bash
helm install my-release my-chart # создаст Release с именем my-release.
```

### Repository
`Helm Repository` — это хранилище Chart'ов, которое позволяет публиковать и загружать пакеты. Например, `ArtifactHub` — популярное публичное хранилище Helm Chart'ов

### Шаблоны и Values
Helm использует язык шаблонов Go для создания динамических файлов. Значения в шаблонах подставляются из файла values.yaml или передаются вручную через команду helm install/upgrade.

Пример файла values.yaml:
```yml
replicaCount: 2
image:
  repository: nginx
  tag: "1.21"
service:
  type: ClusterIP
  port: 80
```

Пример шаблона из templates/deployment.yaml:
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-deployment
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Release.Name }}
  template:
    metadata:
      labels:
        app: {{ .Release.Name }}
    spec:
      containers:
        - name: nginx
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          ports:
            - containerPort: {{ .Values.service.port }}
```

- {{ .Release.Name }} — встроенная переменная, содержащая имя Release.
- {{ .Values.<key> }} — значение из файла values.yaml.

## Преимущества Helm

1. Упрощение управления приложениями:
    - Быстрое развертывание приложений через шаблоны.
    - Возможность обновления и отката версий.
2. Повторное использование:
    - Один Chart может быть использован для развертывания нескольких экземпляров приложений с разными конфигурациями.
3. Хранение истории:
    - Helm хранит историю всех установленных Release, что позволяет откатываться на предыдущие версии.
4. Широкая экосистема:
    - Существуют тысячи готовых Chart'ов для популярных приложений (PostgreSQL, Nginx, Redis и т.д.).

## Установка Helm
```bash
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```
## Базовые команды
* Поиск Chart'ов:
```bash
helm search repo <chart-name> # Пример: поиск nginx в репозиториях.
```

* Добавление репозитория, пример:
```bash 
helm repo add bitnami https://charts.bitnami.com/bitnami
```

* Обновление списка репозиториев:
```bash
helm repo update
```

* Установка Chart, пример:
```bash
helm install my-nginx bitnami/nginx
```

* Список установленных Release:
```bash
helm list
```

* Удаление Release
```bash
helm uninstall <release-name>
```

* Обновление Release
```bash
helm upgrade <release-name> <chart-name>
```