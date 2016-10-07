FROM debian:jessie
MAINTAINER Timo Furrer <tuxtimo@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
# Specify tor browser version to download
ENV TOR_BROWSER_VERSION 6.0.5

# Install required packages
RUN apt update
RUN apt install --yes --no-install-recommends ca-certificates curl xz-utils wget dirmngr gnupg libasound2 libdbus-glib-1-2 libgtk2.0-0 libxrender1 libxt6

RUN useradd -m anon

USER anon
WORKDIR /home/anon

# Add TOR browser
RUN curl -sSL -o /home/anon/tor.tar.xz https://www.torproject.org/dist/torbrowser/${TOR_BROWSER_VERSION}/tor-browser-linux64-${TOR_BROWSER_VERSION}_en-US.tar.xz
RUN curl -sSL -o /home/anon/tor.tar.xz.asc https://www.torproject.org/dist/torbrowser/${TOR_BROWSER_VERSION}/tor-browser-linux64-${TOR_BROWSER_VERSION}_en-US.tar.xz.asc

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "EF6E 286D DA85 EA2A 4BA7  DE68 4E2C 6E87 9329 8290"
RUN gpg --verify /home/anon/tor.tar.xz.asc

RUN tar xvf /home/anon/tor.tar.xz
RUN rm -f /home/anon/tor.tar.xz*

RUN mkdir ~/Downloads

CMD /home/anon/tor-browser_en-US/Browser/start-tor-browser
