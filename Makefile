all: run

build:
	docker build -t gin-go:latest .
run: build
	docker rm gin-api -f
	docker run -d -t -i --network host --name gin-api gin-go 
test:
	go build main.go
	./main
