# Dockerized OpenTOSCA Environment for ARM processors

Docker files for running the entire [OpenTOSCA](https://github.com/OpenTOSCA) stack.

The fastest way to get started is using [Docker Compose](https://docs.docker.com/compose/):

    git clone https://github.com/wederbn/raspberry-pi-opentosca-dockerfiles.git && cd raspberry-pi-opentosca-dockerfiles
    docker-compose build
    docker-compose up

Wait 5-10 minutes, then open the [OpenTOSCA user interface](http://localhost:8080/opentosca).

| OpenTOSCA Component | URL | GitHub |
|:------------------- |:--- |:------ |
| OpenTOSCA UI | http://localhost:8088 | [Link](https://github.com/OpenTOSCA/ui) |
| OpenTOSCA Container API | http://localhost:1337 | [Link](https://github.com/OpenTOSCA/container) |
| OpenTOSCA Container Repository | http://localhost:8081 | [Link](https://github.com/OpenTOSCA/winery) |
| OpenTOSCA Modelling (Eclipse Winery™) | http://localhost:8090 | [Link](https://github.com/OpenTOSCA/winery) |
| Plan Engine (WSO2 BPS) | http://localhost:9763 | [Link](https://github.com/OpenTOSCA/engine-plan) |
| IA Engine (Apache Tomcat) | http://localhost:8080 | [Link](https://github.com/OpenTOSCA/engine-ia) |

---

### Tipps and Tricks

```bash
# Start services in background
docker-compose up -d

# Shutdown services and remove container
docker-compose down -v

# Display useful logs
docker-compose logs -f [--tail=1 <SERVICE_NAME>...]
docker-compose logs -f container
docker-compose logs -f engine-ia engine-plan
```
