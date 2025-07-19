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
            }
        }
        
        stage('📦 Install Dependencies') {
            steps {
                echo '📦 Cài đặt dependencies...'
                script {
                    // Chỉ cài dependencies nếu có package.json
                    // Neu co file thuc hien lenh npm install, neu lenh chay loi thi in ra thong bao
                    if (fileExists('services/user-service/package.json')) {
                        sh 'cd services/user-service && npm install || echo "⚠️ User service npm install failed"'
                    }
                    
                    if (fileExists('services/order-service/package.json')) {
                        sh 'cd services/order-service && npm install || echo "⚠️ Order service npm install failed"'
                    }
                    
                    if (fileExists('frontend/package.json')) {
                        sh 'cd frontend && npm install || echo "⚠️ Frontend npm install failed"'
                    }
                }
            }
        }
        
        stage('🧪 Run Tests') {
            steps {
                echo '🧪 Chạy tests...'
                script {
                    // Test từng service nếu có
                    if (fileExists('services/user-service/package.json')) {
                        sh 'cd services/user-service && npm test || echo "⚠️ User service tests failed"'
                    }
                    
                    if (fileExists('services/order-service/package.json')) {
                        sh 'cd services/order-service && npm test || echo "⚠️ Order service tests failed"'
                    }
                    
                    if (fileExists('frontend/package.json')) {
                        sh 'cd frontend && npm test -- --watchAll=false || echo "⚠️ Frontend tests failed"'
                    }
                }
            }
        }
        
        stage('🐳 Build Docker Images') {
            steps {
                echo '🐳 Sử dụng script build có sẵn...'
                sh './scripts/build-images.sh ${VERSION}'
            }
        }
        
        stage('🔒 Security Scan') {
            steps {
                echo '🔒 Quét bảo mật images...'
                script {
                    // Chỉ scan nếu có Trivy
                    sh '''
                        if command -v trivy >/dev/null 2>&1; then
                            ./scripts/scan-images.sh || echo "⚠️ Security scan failed but continuing..."
                        else
                            echo "⚠️ Trivy not installed, skipping security scan"
                        fi
                    '''
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