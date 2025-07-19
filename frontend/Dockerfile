#Stage 1 (builder):
#Node.js container → Install deps → Build React → Tạo /app/build/
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build



#Stage 2 (runtime):  
#Nginx container → Copy /app/build từ stage 1 → Serve static files

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
# Copy nginx config (server block only)
COPY nginx-docker.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
