# ZebraLeap

## Setup

    $ git clone git@github.com:woven-teams/zebraleap.git
    $ git clone https://github.com/stripe/stripe-mock.git

### Run ZebraLeap test server

    If you're on OSX, install from homebrew:
    $ brew install stripe/stripe-mock/stripe-mock

    Otherwise, download the latest release [here](https://github.com/stripe/stripe-mock/releases).

    To run it from a terminal:
    $ stripe-mock

### Set up our database and run server:

    $ cd zebraleap
    $ bundle install
    $ rake db:setup
    $ rails server

### Try it out

Navigate to http://localhost:3000/products/1/buy and you should see:

    { success: true }

in your browser.

## Run the tests

On this project we use RSpec for testing. You can run all of the tests with:

`rake spec`

Or run a single test file with:

`rspec ./spec/controllers/products_controller_spec.rb`
