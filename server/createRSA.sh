#!bash
openssl genrsa -des3 -out my-ca.key 2048
openssl req -new -x509 -days 3650 -key my-ca.key -out my-ca.crt
openssl genrsa -des3 -out mars-server.key 1024
openssl req -new -key mars-server.key -out mars-server.csr
openssl x509 -req -in mars-server.csr -out mars-server.crt -sha1 -CA my-ca.crt -CAkey my-ca.key -CAcreateserial -days 3650
