FROM donch/net-tools

RUN adduser --disabled-password --gecos '' newuser

USER newuser

COPY start.sh /home/newuser/start.sh

RUN chmod +x /home/newuser/start.sh

EXPOSE 4321

ENTRYPOINT ["/home/newuser/start.sh"]

CMD ["nc", "-l", "4323"]
