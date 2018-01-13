# PhoneBuzz
A simple web application to play the FizzBuzz game through phone call using [Twilio](https://www.twilio.com/)

### Setup

The following configurations should be available in the rails ENV for the application to work
* TWILIO_AUTH_TOKEN
* TWILIO_ACCOUNT_SID
* TWILIO_NUMBER
* API_HOST (The host URL at which this application is gonna be hosted)

##### Local Deployment
You can make use of the the [dotenv](https://github.com/bkeepers/dotenv) ruby gem that 
this application comes bundled with. Just create a `.env` file in the application's
root directory like the sample given below.

##### Heroku Deployment
A `Procfile` is already present in this project for heroku deployment. <br>
For the environment variables, create them using the ```heroku config:set``` command. <br>
Example: ```heroku config:set KEY=VALUE```

###### Download required gems
   ```
   bundle install
   ```

###### Database initialization
   ```
   rake db:migrate
   ```

###### Run server
   ```
   rails server
   ```
   
###### Sample .env file
```
TWILIO_AUTH_TOKEN={TOKEN}
TWILIO_ACCOUNT_SID={SID}
TWILIO_NUMBER=+11231231234
API_HOST=https://host.com
```