# Start with the base Python container
# FIXME: Update the version
FROM docker.io/python:3.12.3

# Install packages that are required. 
RUN pip install psutil==7.2.2
RUN pip install Django==6.0.1

# Create a non-root user to run the application
RUN useradd -d /app -M django

# Copy the Python code into the container
COPY --chown=django:django djangotutorial /app

# Set environment variables 
ENV PORT=8080 
ENV STUDNET_NAME="Marcos Della"
ENV SITE_NAME="cis-92.geekstyle.net"
ENV SECRET_KEY="fixme-54321"
ENV DEBUG=1
ENV DATA_DIR="/data"
ENV PORT=8080
ENV DJANGO_SUPERUSER_USERNAME="admin"
ENV DJANGO_SUPERUSER_PASSWORD="test"
ENV DJANGO_SUPERUSER_EMAIL="test@test.test"

# Set the working directory
WORKDIR /app 

# Default command to execute in the container
CMD ["/bin/sh", "-c", "./start.sh"]
