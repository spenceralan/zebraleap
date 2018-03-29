# See also:
# https://github.com/infinum/rails-handbook/blob/master/Design%20Patterns/Service%20Objects.md

class ExampleService
  def initialize params
    @local_var = params[:local_var]
  end

  def call
    # do some things
    # handle any errors
    # return true or false to indicate success
  end
end
