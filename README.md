
# 🐳 Multi-Container Application with Reverse Proxy and SSL

This repository demonstrates a multi-container Docker Compose setup where an application is exposed securely via a reverse proxy using host-installed SSL certificates.

[GitHub Repository](https://github.com/sumandhakal04/multi-container-application)


---

## 🚀 Project Overview

This project includes:

- Backend nodejs application containers
- A reverse proxy container (NGINX) handling HTTPS traffic
- SSL/TLS certificates installed on the **host machine** and mounted into the reverse proxy container for secure HTTPS termination

The setup is ideal for learning how to deploy containerized services behind a secure HTTPS reverse proxy with Docker Compose.

---

## 📁 Project Structure

```
.
├── .githubactions/workflow             # Backend application source code and Dockerfile
├── reverse-proxy/                      # NGINX config files
├── docker-compose.yml                  # Docker Compose configuration for multi-container setup
├── .env                                # Environment variables (if any)
├── terraform                           # Terraform config for creating an azurevm
├── README.md
```

---

## 🛠️ Setup & Running the Application

1. **Clone the repository**

   ```bash
   git clone https://github.com/sumandhakal04/multi-container-application.git
   cd multi-container-application
   ```

2. **Ensure SSL certificates are installed on your host machine**  
   For example, via Certbot:
   ```bash
   sudo certbot certonly --standalone -d yourdomain.com
   ```

3. **Start the containers with Docker Compose**

   ```bash
   docker-compose up -d --build
   ```

4. **Verify all containers are running**

   ```bash
   docker-compose ps
   ```

5. **Access the application**

   The API service will be running on `https://example.com/`.

   ```

## Endpoints

- `GET /todos`: Retrieve all todos.
- `POST /todos`: Create a new todo.
- `GET /todos/:id`: Retrieve a single todo by its ID.
- `PUT /todos/:id`: Update a single todo by its ID.
- `DELETE /todos/:id`: Delete a single todo by its ID.

---

## 🔐 SSL Certificate Handling

- TLS/SSL certificates (e.g., from Let's Encrypt) are **installed on the host machine**, typically under `/etc/letsencrypt/live/yourdomain.com/`.
- These certificates are **mounted as read-only volumes** into the reverse proxy container via Docker Compose.
- The reverse proxy container (NGINX) uses these certificates to serve HTTPS traffic.

Example volume mount in `docker-compose.yml`:

```yaml
services:
  reverse_proxy:
    image: nginx:alpine
    container_name: nginx
    volumes:
      - ./nginx/conf.d/nginx.conf:/etc/nginx/conf.d/nginx.conf
      - /etc/letsencrypt:/etc/letsencrypt:ro
    ports:
      - "80:80"
      - "443:443"
    depends_on:
      - todo-app
    networks:
      - app-network
    restart: always
```

NGINX configuration snippet for SSL:

```nginx
server {
    listen 443 ssl;
    server_name example.com;

    # TLS certs from Let's Encrypt
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

    location / {
        proxy_pass http://todo-app:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

---

## ⚙️ Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/) installed
- SSL certificates installed on the host (e.g., using [Certbot](https://certbot.eff.org/))
- Basic familiarity with Docker and Docker Compose

---

## 🧩 How It Works

- The **backend service** runs the application on an internal Docker network.
- The **reverse proxy** (NGINX) listens on ports 80 and 443 on the host.
- Incoming HTTPS requests terminate SSL at NGINX using the mounted certificates.
- NGINX proxies requests to the backend service internally.

---

