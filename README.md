## BT Real Estate Website using Django
This repo contains personal project of Django web development, following Django development course by Brad Traversy on Udemy.

### See the running app demo
You can see the running app demo [here](http://52.63.44.101:9000/)

### Requirements
1. Install [Docker](https://docs.docker.com/engine/install/) in your machine
2. Create two environment files: `.env.prod` and `.env.prod.db`, which define the system settings. Create  `env` folder and put the two environment files there.
   
    `.env.prod` content:
    ```
    DEBUG=0
    SECRET_KEY=<replace with any secret key you want>
    DJANGO_ALLOWED_HOSTS=localhost 127.0.0.1
    SQL_ENGINE=django.db.backends.postgresql
    SQL_DATABASE=<replace with a database name you want>
    SQL_USER=<replace with a database username you want>
    SQL_PASSWORD=<replace with a database password you want>
    SQL_HOST=db
    SQL_PORT=5432
    DATABASE=postgres
    ```
    `.env.prod.db` content:
    ```
    POSTGRES_USER=<fill with the same database username you specify above>
    POSTGRES_PASSWORD=<fill with the same database password you specify above>
    POSTGRES_DB=<fill with the same database name you specify above>
    ```
Note that you don't need to create the database by yourself. You only need to specify any database name, username and password you want. The database will be created by the Postgres docker image automatically when you later run `docker compose` (see below). 

### How to run the the app
1. Run `docker compose -f Dockerfile.prod.yaml up -d` to compose three required containers: (i) Django webapp, (ii) Postgres for database, and (iii) Nginx for server. If you use the old docker, you may need to replace `docker compose` with `docker-compose`
2. Check if all three containers run properly by `docker ps`. The three containers are expected to appear in the list
3. Run the database migration by `docker exec django_c python manage.py migrate`
4. Collect Django static files by `docker exec django_c python manage.py collectstatic`
5. Open `http://localhost:9000` on your browser to see the django webapp
6. Otional: 
    * Create superuser for django admin
      * Enter the django container by `docker exec -it django_c sh`
      * Run `python manage.py createsuperuser` and proceed with specifying your username and password
    * Login into the django admin in `http://localhost/admin` using the username and password you created above
    * As admin, you can add some data via the django admin dashboard. For example, you can add house listing data, realter, etc.

**Note**: 
* Alternatively, you can setup a CI/CD pipeline, such as using [Jenkins](https://www.jenkins.io/), for smooth continous deployment
* For development purpose, you may compose the yaml file for development instead, by `docker compose -f Dockerfile.dev.yaml up -d`. Any code change you make during development will be directly reflected in the app running at `http://localhost:9000`

