# define base image
FROM python:3.9-alpine

# set the working dir
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
# PYTHONDONTWRITEBYTECODE: Prevents Python from writing pyc files to disc (equivalent to python -B option)
# PYTHONUNBUFFERED: Prevents Python from buffering stdout and stderr (equivalent to python -u option)

# install system dependencies: for checking the DB readiness before doing migration
RUN apk add --no-cache netcat-openbsd

# to install psycopg2 (for postgres), we need to install these two lines inside the docker
RUN apk add --no-cache python3 postgresql-libs
RUN apk add --no-cache --virtual .build-deps gcc python3-dev musl-dev postgresql-dev

# install dependency for pillow
RUN apk add --no-cache zlib-dev jpeg-dev

# install python libraries
COPY requirements.txt /app/
RUN python3 -m pip install -r requirements.txt --no-cache-dir
RUN apk --purge del .build-deps

# copy the project files
COPY . .

# RUN apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
#     apk add --no-cache zlib-dev jpeg-dev && \
#     python3 -m pip install -r requirements.txt --no-cache-dir && \
#     apk --purge del .build-deps