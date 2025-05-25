# FROM python:3.11
# MAINTAINER Azeema Khanum "azeemakhanum2k3@gmail.com" # Change the name and email address
# COPY app.py test.py /app/
# WORKDIR /app
# RUN pip install flask pytest flake8 # This downloads all the dependencies
# CMD ["python", "app.py"]
# Use the official Python 3.11 base image
FROM python:3.11

# Set the maintainer
MAINTAINER Azeema Khanum "azeemakhanum2k3@gmail.com"

# Set the working directory inside the container
WORKDIR /app

# Copy the application files into the container
COPY app.py test.py /app/

# Install necessary Python packages
RUN pip install --no-cache-dir flask pytest flake8

# Expose the port that the Flask app will run on
EXPOSE 5000

# Command to run the Flask app
CMD ["python", "app.py"]
