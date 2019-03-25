all: build upload

build:
	docker build --pull -t ambientsound/spotifyd:latest .

upload:
	docker push ambientsound/spotifyd:latest
