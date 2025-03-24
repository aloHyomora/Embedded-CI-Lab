pipeline {
    agent any  // 어떤 환경에서든 실행 가능

    environment {
        TIMEOUT_MINUTES = 2
    }

    stages {
        stage('Clone Repository') {
            steps {
                checkout scm  // GitHub에서 코드 가져오기
            }
        }

        stage('Build') {
            steps {
                echo 'Building the project...'  // 실제 빌드 명령어를 추가할 수 있음
                timeout(time: "${env.TIMEOUT_MINUTES}", unit: 'MINUTES') {
                    sh 'make clean && make TEST_MODE=1'
                }
            }
        }
        
        stage('QEMU Test') {
            steps {
                timeout(time: "${env.TIMEOUT_MINUTES}", unit: 'MINUTES') {
                    sh '''
                        qemu-system-arm -M stm32vldiscovery -nographic \
                        -kernel firmware.elf > qemu_output.txt & \
                        QEMU_PID=$!
                        
                        # Wait for expected output count
                        count=0
                        while [ $count -lt 5 ]; do
                            count=$(grep -c "Hello" qemu_output.txt)
                            sleep 1
                        done
                        
                        kill $QEMU_PID
                        exit 0
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'  // 배포 단계 (필요 시 추가)
            }
        }
    }
}
