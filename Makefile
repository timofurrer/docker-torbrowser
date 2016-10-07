build:
	docker build -t tuxtimo/torbrowser .

run:
	docker run -it --rm -e DISPLAY=$(DISPLAY) -v /tmp/.X11-unix:/tmp/.X11-unix:ro tuxtimo/torbrowser
