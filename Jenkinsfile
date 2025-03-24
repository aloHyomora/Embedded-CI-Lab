pipeline {
    agent any  // 어떤 환경에서든 실행 가능

    stages {
        stage('Clone Repository') {
            steps {
                checkout scm  // GitHub에서 코드 가져오기
            }
        }

        stage('Build') {
            steps {
                echo 'Building the project...'  // 실제 빌드 명령어를 추가할 수 있음
                echo 'make clean'
                echo 'make'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'  // 실제 테스트 실행 (예: Google Test, PyTest)
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'  // 배포 단계 (필요 시 추가)
            }
        }
    }
}
