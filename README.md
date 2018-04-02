# ZebraLeap

## Setup

    $ git clone git@github.com:woven-teams/zebraleap.git
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
