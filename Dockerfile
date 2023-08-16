FROM python:3.6
MAINTAINER Arun Bhosale "arun.bhosale@gmail.com" # Change the name and email address
COPY app.py test.py /app/
WORKDIR /app
RUN pip install flask pytest flake8 # This downloads all the dependencies
CMD ["python", "app.py"]
