@echo off
REM 1. JAR 파일 EC2로 업로드
scp -i D:\oasis\oasis.pem ^
  -o StrictHostKeyChecking=no ^
  backend\build\libs\app.jar ^
  ec2-user@ec2-3-34-191-154.ap-northeast-2.compute.amazonaws.com:/home/ec2-user/

REM 2. EC2에서 기존 앱 중지 & 새 앱 실행
ssh -i D:\oasis\oasis.pem ^
  -o StrictHostKeyChecking=no ^
  ec2-user@ec2-3-34-191-154.ap-northeast-2.compute.amazonaws.com ^
  "pkill -f app.jar || true && nohup java -jar /home/ec2-user/app.jar > app.log 2>&1 &"

pause