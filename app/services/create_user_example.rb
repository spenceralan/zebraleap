# As we start to build out our service layer, we thought we should
# establish some very basic patterns. Here's where we landed,
# although let's plan to make changes as we go.

# We were inspired by this blog post:
# https://github.com/infinum/rails-handbook/blob/master/Design%20Patterns/Service%20Objects.md

class CreateUserExample
  def initialize user
    @user = user
  end

  def call
    # call the third-party API with one or more @user fields
    # handle any errors
    # return true or false to indicate success
  end
end
