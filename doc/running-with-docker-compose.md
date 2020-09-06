## Running with docker-compose

Docker-compose file has been added to the repository. An entry script has been added and docker file has been modified
to work with entrypoint.sh script which also builds and populates the database.

Based on the port settings and configrations on your system, modify the conf.toml file accordingly.

My changes:

"DbUser" = "postgres"
"DbPassword" = "docker"
"DbName" = "app"
"DbPort" = "5432"
"DbHost" = "db"
"ListenHost" = "0.0.0.0"
"ListenPort" = "3000"