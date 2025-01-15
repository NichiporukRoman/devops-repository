# Task 27 Yandex ВМ + Yandex БД 
## To do
1. Создать целевую группу ВМ с установленным nginx на каждой машине. 
2. Настройте автоматическое масштабирование на основе нагрузки CPU > 75%. 
3. Проверить работу масштабирования. 
4. Вторая часть: Создать кластер MySQL. 
5. Настроить окно обслуживания. 
6. Создать базу данных внутри и сделать резервную копию. 
7. Удалить БД и восстаноиться из резервной копии. 
8. Убедиться, что БД присутствует. 
## Jobs
1. Создаем снимок диска с установденным `nginx`.

2. Ниже конфигурация:
![console yandex cloud_folders_b1gdpi9tq9ude17i74k4_compute_create_group_2024_12_31_11_25_15](https://github.com/user-attachments/assets/712a7c1e-844c-49fa-ab52-f05d42eaedb7)

3. Все ок?

4. Делаем через Interface
![console yandex cloud_folders_b1gdpi9tq9ude17i74k4_managed_mysql_cluster_c9qjkhn9l3mfurdnhsqj_edit_2024_12_31_12_14_41](https://github.com/user-attachments/assets/78c960b2-dd94-4852-861e-11663a732cee)
![console yandex cloud_folders_b1gdpi9tq9ude17i74k4_managed_mysql_cluster_c9qjkhn9l3mfurdnhsqj_overview_2024_12_31_12_06_36](https://github.com/user-attachments/assets/1b4cc239-9e78-4e0a-a5c4-2e4e735efc6b)

5. Ниже пример:

6. Ниже пример:
![websql yandex cloud_folders_b1gdpi9tq9ude17i74k4_connections_a59vlrob1rl3mndcqkna_databases_db1_editor_2024_12_31_12_34_03](https://github.com/user-attachments/assets/1b229a21-e4a4-46a9-90ca-e22ff368c958)
![console yandex cloud_folders_b1gdpi9tq9ude17i74k4_managed_mysql_cluster_c9qqohhom6tq392femip_backups_2024_12_31_12_59_57](https://github.com/user-attachments/assets/36989584-7311-474d-aa07-57b5f9b56f3c)
![console yandex cloud_folders_b1gdpi9tq9ude17i74k4_managed_mysql_cluster_c9qqohhom6tq392femip_backups_2024_12_31_13_03_54](https://github.com/user-attachments/assets/5a555482-a684-4db6-80e9-8393542937f3)

7. Ниже пример:
![console yandex cloud_folders_b1gdpi9tq9ude17i74k4_managed_mysql_cluster_c9qqohhom6tq392femip_databases_2024_12_31_13_04_09](https://github.com/user-attachments/assets/e746fdb4-2d31-440b-9265-d6b4663fb1c9)
![console yandex cloud_folders_b1gdpi9tq9ude17i74k4_managed_mysql_cluster_c9qqohhom6tq392femip_databases_2024_12_31_13_04_22](https://github.com/user-attachments/assets/2d6b2610-adb8-4fd6-b8d2-7d61a0bbb76d)
![console yandex cloud_folders_b1gdpi9tq9ude17i74k4_managed_mysql_cluster_c9qqohhom6tq392femip_overview_2024_12_31_13_04_55](https://github.com/user-attachments/assets/0e0608e5-6b78-42a9-8624-23ad282df4e2)

8. Все ок.
![console yandex cloud_folders_b1gdpi9tq9ude17i74k4_managed_mysql_clusters_2024_12_31_13_20_52](https://github.com/user-attachments/assets/a8725727-cc8f-4e30-bad3-aa12756c14f4)
