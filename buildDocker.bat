docker stop ilch
docker rm ilch
docker build . -t ilch
docker run --name ilch -d -p 8080:8080  ilch
docker ps 
docker logs ilch