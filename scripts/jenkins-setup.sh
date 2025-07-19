#!/bin/bash

# Script cài đặt Jenkins đơn giản với Docker
echo "🚀 Cài đặt Jenkins đơn giản..."

# Kiểm tra Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker chưa được cài đặt!"
    echo "📖 Cài đặt Docker trước: https://docs.docker.com/get-docker/"
    exit 1
fi

echo "✅ Docker OK"

# Khởi động Jenkins đơn giản
echo "🐳 Khởi động Jenkins..."
docker run -d \
    --name jenkins \
    --restart unless-stopped \
    -p 8080:8080 \
    -p 50000:50000 \
    -v jenkins_data:/var/jenkins_home \
    jenkins/jenkins:lts

# Chờ Jenkins khởi động
echo "⏳ Chờ Jenkins khởi động..."
sleep 30

# Lấy password
echo "✅ Jenkins đã khởi động!"
echo ""
echo "🌐 Truy cập: http://localhost:8080"
echo ""
echo "🔑 Password:"
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

echo ""
echo "📋 Các bước tiếp theo:"
echo "1. Mở trình duyệt và truy cập http://localhost:8080"
echo "2. Nhập initial admin password (hiển thị ở trên)"
echo "3. Cài đặt suggested plugins"
echo "4. Tạo admin user"
echo "5. Cấu hình Jenkins URL"
