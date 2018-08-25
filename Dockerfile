FROM microsoft/azure-functions-node8 AS base

# Chrome setup by "Justin Ribeiro <justin@justinribeiro.com>"
# https://github.com/justinribeiro/dockerfiles/blob/master/chrome-headless/Dockerfile
FROM base AS chrome
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	--no-install-recommends \
	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update && apt-get install -y \
	google-chrome-stable \
	--no-install-recommends \
	&& apt-get purge --auto-remove -y curl gnupg \
	&& rm -rf /var/lib/apt/lists/*
# RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome \
#     && mkdir -p /home/chrome && chown -R chrome:chrome /home/chrome \
# 	&& chown -R chrome:chrome /opt/google/chrome
# USER chrome
EXPOSE 9222

# /usr/bin/google-chrome-stable
ENV CHROME_BIN=google-chrome-stable
ENV CHROME_PORT=9222
