# image donch/net-tools
FROM donch/net-tools

COPY start.sh /bin/start.sh

# start.sh Non-root user creation and permission 
RUN addgroup -S groupeTP && adduser -S userTP -G groupeTP \
    && chown userTP:groupeTP /bin/start.sh \
    && chmod +x /bin/start.sh

# Creation of a temp directory specific to the application
RUN mkdir -p /tmp/appTP && chown userTP:groupeTP /tmp/appTP

# Expose port 4321
EXPOSE 4321

# Define user non-root as user by default
USER userTP

# Define /bin/start.sh as entrypoint of the image
ENTRYPOINT ["/bin/start.sh"]

# Define "nc -l 4323" as default command of the image
CMD ["nc", "-l", "4323"]
