FROM donch/net-tools

RUN adduser --disabled-password --gecos "" myuser
USER myuser

COPY start.sh /bin/start.sh
EXPOSE 4321

ENTRYPOINT ["/bin/start.sh"]
CMD ["nc", "-l", "4323"]

