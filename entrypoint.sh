#!/bin/sh
#Wait 5 seconds to allow for the database to be up and running.
sleep 10s;
#Execute database creation and seeding

#Use for local development (in case of using a different db then the default postgres one)
./TechChallengeApp updatedb && ./TechChallengeApp serve;

#uncomment when deploying into GC.
# ./TechTestApp updatedb -s && ./TechTestApp serve;