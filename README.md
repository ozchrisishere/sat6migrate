# Overview

This script will allow you to migrate from one Satellite 6 server to another. The idea is to run the script on the host you intend to migrate 

This script has been tested to migrate from a Satellite 6.3 to a Satellite 6.7 instance. 

# How it works

* Performs API call to the old Satellite server to grab the curren host details
* Stores the host group and activation key as variables
* Performs a wget of the bootstrap that is used to do the migration
* Makes the bootstrap executable
* Runs the bootstrap with the host group and activation key variable


# Requirements

* The host to be migrated must be registered to a Satellite 6 Server
* The host group and activation key must be the same on both servers you intend to migrate the host across
* There needs to be a service account on the old and new Satellites
* Need an ability to deploy the script to the host to be migrated

The migration script can be copied and extended to support custom enviroments by adding more variables and changing the hard coded values.

# Author

Chris Simon
chsimon@redhat.com  
