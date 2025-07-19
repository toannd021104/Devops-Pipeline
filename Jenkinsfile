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
        
        stage('📤 Push Images') {
            when {
                anyOf {
                    branch 'main'
                    branch 'master'
                }
            }
            steps {
                echo '📤 Push images lên registry...'
                script {
                    // Chỉ push khi ở main branch
                    sh './scripts/push-images.sh ${VERSION} ${REGISTRY} ${USERNAME} || echo "⚠️ Push failed"'
                }
            }
        }
        
        stage('🚀 Deploy to Kubernetes') {
            when {
                anyOf {
                    branch 'main'
                    branch 'master'
                }
            }
            steps {
                echo '🚀 Deploy lên Kubernetes...'
                script {
                    // Chỉ deploy khi có kubectl
                    sh '''
                        if command -v kubectl >/dev/null 2>&1; then
                            ./scripts/deploy-k8s.sh || echo "⚠️ Deploy failed"
                        else
                            echo "⚠️ kubectl not found, skipping deployment"
                        fi
                    '''
                }
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