pipeline {
    agent {
        label 'local'
    }
    
    environment {
        VERSION = "${BUILD_NUMBER}"
        REGISTRY = 'docker.io'
        USERNAME = 'toanndcloud' // Thay bằng Docker Hub username của bạn
    }
    
    stages {
        stage('📥 Checkout') {
            steps {
                echo '🔄 Lấy code từ repository...'
                sh 'pwd && ls -la'
                sh 'chmod +x scripts/*.sh'
                echo "Current branch: ${env.GIT_BRANCH}"
            }
        }
    
    }
    
    post {
        always {
            echo '🧹 Cleanup...'
            sh 'docker image prune -f || echo "Cannot cleanup Docker images"'
        }
        success {
            echo '🎉 Pipeline hoàn thành thành công!'
            sh 'docker images | grep microservices || echo "No images found"'
        }
        failure {
            echo '❌ Pipeline thất bại!'
        }
    }
}