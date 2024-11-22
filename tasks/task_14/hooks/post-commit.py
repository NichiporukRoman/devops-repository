import smtplib
from email.mime.text import MIMEText

smtp_host = 'smtp.yandex.by'
login = "dispyu@yandex.by"
password = "lcrtxvktmdqhehiw"
subject = 'you\'re has commited'
body = 'you\'re has commited'

msg = MIMEText(body, 'plain', 'utf-8')
msg['Subject'] = subject
msg['From'] = login
msg['To'] = 'romannichiporukk@gmail.com'
s = smtplib.SMTP(smtp_host, 587, timeout=10)
s.starttls()
s.login(login, password)
s.sendmail(msg['From'], 'romannichiporukk@gmail.com', msg.as_string())
print("Удачная доставка")
