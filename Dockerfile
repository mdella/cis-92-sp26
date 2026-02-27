# Start with the base Python container
# FIXME: Update the version
FROM docker.io/python:3.12.3

# Install packages that are required. 
RUN pip install psutil==7.2.2
RUN pip install Django==6.0.1

# Copy the Python code into the container
COPY djangotutorial /app

# Set environment variables 
ENV PORT=8080 

# Set the working directory
WORKDIR /app 

# Default command to execute in the container
CMD ["/bin/sh", "-c", "python ./manage.py runserver 0.0.0.0:$PORT"]
