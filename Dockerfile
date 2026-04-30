###########################################################
# Dockerfile that builds a Windrose Dedicated Server
# Uses Wine to run the Windows server on Linux
###########################################################
FROM cm2network/steamcmd:root as build_stage

LABEL maintainer="jan@civitelli.de"

ENV STEAMAPPID 4129620
ENV STEAMAPP windrose
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

# Enable 32-bit architecture and install Wine
RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		ca-certificates \
		lib32z1 \
		wine \
		wine32 \
		wine64 \
		xvfb \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& rm -rf /var/lib/apt/lists/*

COPY etc/entry.sh "${HOMEDIR}/entry.sh"

RUN chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}"

FROM build_stage AS bullseye-base

ENV WR_SERVERNAME="Windrose Server" \
    WR_PORT=7777 \
    WR_PASSWORD="" \
    WR_MAXPLAYERS=4 \
    WR_INVITECODE="CHANGE" \
    WR_WORLDID="default" \
    WINEDEBUG=-all \
    DISPLAY=:99

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# 7777/udp = game traffic
# 7777/tcp = game traffic
EXPOSE 7777/tcp \
	7777/udp