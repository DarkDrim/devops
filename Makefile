build:
	docker build -t ops-img .

up:
	docker stop ops || true && docker rm ops || true
	docker run -d --rm -p 80:80 --name ops ops-img

ash:
	docker exec -it ops ash

image-push:
	docker tag ops-img drim/devops:1.0.0
	docker push drim/devops:1.0.0
