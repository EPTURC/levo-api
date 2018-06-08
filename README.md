# Levo-API
 An app built with Ruby on Rails to connect Truck Drivers and Manager

See the project running on [Heroku](https://epturc-levo.herokuapp.com/api/v1/drivers)

## Setting Up the Environment


First up, your system will need the [prerequisites for running Ruby on Rails installed](https://rubyonrails.org/) and [PostgresSQL](https://www.postgresql.org/)

Once you have these:

```
# Checkout the project

$ git clone https://github.com/EPTURC/levo-api

$ cd levo-api

# Install the project dependencies

$ gem install bundler

$ bundle install

# Create the local database

With psql, run: 

$ psql
$ CREATE DATABASE levo_development;

# Run the project

$ rails s
```


## Contributing

Read the [project guidelines for contributing](https://github.com/EPTURC/levo-api/blob/master/docs/CONTRIBUTING.md)
