FROM debian:trixie
# Removed from ansible:libcrystalhd-dev libfreetype6-dev python3-future

LABEL CODENAME="Trixie becomes v13,  testing no release date set"
RUN apt update \
    && apt --yes upgrade \
    && apt install --yes apt-utils ansible git plocate python3-apt vim

WORKDIR /root/source/ansible
COPY . ./
RUN ./mythtv.yml --limit=localhost --extra-vars='{"venv_active":true}'

WORKDIR /root/source
RUN git clone https://github.com/MythTV/mythtv.git

WORKDIR /root/source/mythtv
RUN git checkout fixes/35 \
    && cmake --preset qt5 \
    && VIRTUAL_ENV=/usr/local/dist cmake --build build-qt5
