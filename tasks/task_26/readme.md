# Task №26 | GitOps
## To do
1. Солюшен с nginx перевести на helm.
2. Задеплоить с помощью ArgoCD.
## Jobs
1. 

2. 

Чтобы узнать пароль:
```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath={.data.password} | base64 -d
```