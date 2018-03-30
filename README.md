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

### Troubleshooting

Depending on how your version of Ruby was compiled, you may run into SSL
issues with Net::Http in the `ProductsController`. If that happens, remove
`use_ssl: true` and change the URI from `https` to `http`.
