FROM elixir:1.13 AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
		sudo			\
		locales			\
		openssl			\
		libjansson4		\
		mosquitto mosquitto-clients rsyslog \
	&& rm -rf /var/lib/apt/lists/*

#libpython3.7 libssl1.1  libxml2  libmariadb3 libcurl4 libstdc++6 libc6 gcc-4.9 \
# wiringpi
# python-mysql.connector
	
# RUN apt-get install -y   
# Add User p4d and give Privileges
ENV USER p4d
RUN useradd --create-home -s /bin/bash ${USER}
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER}
#WORKDIR /home/${USER}
USER ${USER}
#Add German locales
RUN sudo touch /usr/share/locale/locale.alias
RUN sudo sed -i '/de_DE.UTF-8/s/^# //g' /etc/locale.gen && sudo locale-gen
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE.UTF-8
ENV LC_ALL de_DE.UTF-8
#export ENV
RUN set -o allexport
