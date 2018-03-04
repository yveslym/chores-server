# README

<div\>Chore server (as is name says) is the server side of chore app project.<div>
<div\>Chore App is a mobile application that help user to efficiently spread routing<div> task with roommate, related or coworker.

### Overview

This project is a ruby on rails api project and use postgresql as Database. and use several models and controller to handle the logic flow

#### Chore

###### chore model:
* Chore model is the model that record chores in the that database. the chore model contain several properties such as:
 * Name: hold the chore name
 * description: property that hold chore description and also can contain specific detail about the chore
 * penalty: property that hold the penalty set for the chore if this chore wasn't done on time
 * reward: property that hold chore reward for a given special chore when is done

 The penalty and reward can be point or currency depending group agreement.
###### chore controller:
Chore controller handle all chores traffic flow. it's a restful api but also contain custom route


#### Group:
All chores is creating in the group therefore, group has one to many relationship to Chores
Also, a group has many participant which mean group has one to many relationship to User.



Contributors: Yveslym, ShennyO


## Documentation

<<<<<<< HEAD
### Endpoints

#### Chores

Get Chores

api/v1/chores
=======
* System dependencies
 * we use Device gem for authentication
 * simple_token_authentication to generate user_token
 * Jbuilder to create JSON view
* Configuration

* Database creation:

 Database as been created into Postgresql and contain 4 table:
  * user table: hold all user properties
  * chore table: hold all chores properties
  * group table: hold all groups properties
  * request table: hold friend, chore and group request

<div>User model as a foreign key on group table and has a many to many relationship as well,<div\> <div>also user as an one to many relationship to chore but can only access chores through group<div\>

Group model as a foreign key to user table and chore table, also as a one to many relationship to chore model

Chore model as a one to many relationship to both user and group.

* Database initialization
<div>after installing the bundle you will need to run set-up your postgresql and add it your<div> postgresql account on the database.yml file and run the migration to run the server locally. <div>But if you want to run it live, use the based url and the path to do some cool things.<div>



>>>>>>> b47fc225591bddc2aab2862d150572ddc92293a0

Required parameters:
- body:
- request_id:
- chore_id:

<<<<<<< HEAD
Returns:
=======
* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

The server as been deploy on heroku: https://chores-server.herokuapp.com/ as based url

NB: this is a api and doesn't contain any web page yet
* ...
>>>>>>> b47fc225591bddc2aab2862d150572ddc92293a0
