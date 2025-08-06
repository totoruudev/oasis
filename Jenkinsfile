pipeline {
    agent any

    tools {
        jdk 'jdk17'
        gradle 'gradle-8.7'
    }

    environment {
        DB_HOST = "${env.DB_HOST}"
        DB_NAME = "${env.DB_NAME}"
        DB_USER = "${env.DB_USER}"
        DB_PASS = "${env.DB_PASS}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/totoruudev/oasis.git'
            }
        }
        stage('Build') {
            steps {
                bat 'cd backend && gradle clean build -x test'
            }
        }
//         stage('Test') {
//             steps {
//                 bat 'cd backend && gradle test'
//             }
//         }
//         stage('Run Locally') {
//             steps {
//                 bat 'cd backend && java -jar build\\libs\\app.jar'
//             }
//         }
        stage('Deploy to AWS EC2') {
            steps {
                bat """
                REM ==============================
                REM Step 1: EC2에 JAR 업로드
                REM ==============================
                scp -i C:\\oasis.pem^
                 -o StrictHostKeyChecking=no ^
                 backend\\build\\libs\\app.jar ^
                 ec2-user@ec2-3-34-191-154.ap-northeast-2.compute.amazonaws.com:/home/ec2-user/

                REM ==============================
                REM Step 2: EC2에서 기존 애플리케이션 종료 및 재실행
                REM ==============================
                ssh -i C:\\oasis.pem^
                 -o StrictHostKeyChecking=no ^
                 ec2-user@ec2-3-34-191-154.ap-northeast-2.compute.amazonaws.com ^
                 "pkill -f oasis || true && nohup java -jar /home/ec2-user/oasis.jar > app.log 2>&1 &"
                """
            }
        }
    }
}
