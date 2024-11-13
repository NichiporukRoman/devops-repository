# Task 10 | AWS S3 + CloudFront 
## To do
1. Взять простую html и залить на S3. 
2. Сделать Static website hosting.
3. Залить Static website hosting на клаудфронт. 
4. Нарисовать диаграмму AWS с помощщью draw.io.
## Jobs
1. Залить файл на s3 bucket:
```bash
aws s3 cp /path/to/source s3://www.roman.com/ --recursive
```

2. Делаем static website hosting:
    - Static website hosting: enable
    - Hosting type: Host a static website
    - Index document: index.html
3. Делаем cloudFront distribution:
