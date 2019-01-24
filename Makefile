bla = $(shell pwd)
build:
	docker build -t pg-backup-manager .

buildrestic:
	docker run --rm -v "$(bla):/data" golang /bin/bash -c "git clone https://github.com/restic/restic && cd restic && go run build.go && cp restic /data/restic_app"
