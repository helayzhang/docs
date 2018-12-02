upstream myserver {
    server 127.0.0.1:8080;
}
server {

	listen 80;

	server_name example.com;

    location / {
        proxy_set_header Host $host;
        proxy_set_header X-Real-Ip $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_pass http://myserver/;
    }
}
