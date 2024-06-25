FROM donch/net-tools

EXPOSE 4321

RUN adduser --disabled-password --gecos '' nonrootuser

COPY start.sh /home/nonrootuser/start.sh
RUN chmod +x /home/nonrootuser/start.sh

USER nonrootuser

ENTRYPOINT ["/home/nonrootuser/start.sh"]

CMD ["nc", "-l", "4323"]
