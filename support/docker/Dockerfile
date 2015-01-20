# Use jbossdemocentral/developer as the base
FROM jbossdemocentral/developer

# Maintainer details
MAINTAINER Andrew Block <andy.block@gmail.com>

# Environment Variables 

ENV FUSE_HOME /opt/jboss/fuse
ENV FUSE_VERSION_MAJOR 6
ENV FUSE_VERSION_MINOR 1
ENV FUSE_VERSION_MICRO 0

# ADD Installation Files
COPY installs/jboss-fuse-full-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.redhat-379.zip  /opt/jboss/

# Configure project prerequisites and run installer and cleanup installation components
RUN mkdir -p /opt/jboss/projects /opt/jboss/support \
  && unzip -q -d $FUSE_HOME /opt/jboss/jboss-fuse-full-6.1.0.redhat-379.zip \
  && rm -rf /opt/jboss/jboss-fuse-full-6.1.0.redhat-379.zip

# Copy demo, support files and helper script
COPY project /opt/jboss/projects/
COPY support/camel-test.hl7 /opt/jboss/support/
COPY support/users.properties $FUSE_HOME/jboss-fuse-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.redhat-379/etc/
COPY support/docker/start.sh /opt/jboss/


# Swtich back to root user to perform build and cleanup
USER root

# Build demo, adjust permissions and cleanup
RUN chown -R jboss:jboss $FUSE_HOME/jboss-fuse-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.redhat-379/etc/users.properties /opt/jboss/start.sh /opt/jboss/projects /opt/jboss/support \
  && chmod +x /opt/jboss/start.sh  

# Run as JBoss 
USER jboss

# Build Project
RUN mvn clean install -f /opt/jboss/projects/hl7demo/pom.xml

# Expose Ports
EXPOSE  8181

# Default Command
CMD ["/bin/bash"]

# Helper script
ENTRYPOINT ["/opt/jboss/start.sh"]
