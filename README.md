# Django sample application written in Hylang

This project is a sample implementation of django app using Django REST framework with Hylang. 

## How to set up

### Setup using Docker

The easiest way to get backend up and running is via [Docker](https://www.docker.com/). See [docs](https://docs.docker.com/get-started/) to get started. Once set up run the following command:

`docker-compose up`

This command takes care of populating products list with sample data.

It may take a while for the process to complete, as Docker needs to pull required dependencies. Once it is done, the application should be accessible at `0.0.0.0:8000`.
