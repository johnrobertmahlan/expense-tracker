require 'sinatra/base'
require 'json'
require 'pry'
require_relative 'ledger'

module ExpenseTracker
  class API < Sinatra::Base
    # Instances of this class will be created when HTTP requests come through to my app
    def initialize(ledger: Ledger.new)
      @ledger = ledger
      super()
    end

    # BELOW ARE MY ROUTES!!! (but they're also methods??? is that just a Sinatra thing instead of separating out routes and controllers?)
    # this method is just creating a dummy hash with the same key every time
    # once we hook up a DB, we'll update this so that we can post real expenses
    #   JSON.generate('expense_id' => 42)
    post '/expenses' do
      expense = JSON.parse(request.body.read)
      result = @ledger.record(expense)
      
      if result.success?
        JSON.generate(
            {
            'expense_id' => result.expense_id
            }
        )
      else 
        status 422
        JSON.generate('error' => result.error_message)
      end
    end

    get '/expenses/:date' do
    # params are on the request object for Rack but seem to be free-standing in Sinatra

      date = request.params["date"]
    # date = params["date"]

    # likewise, the return values for Rack and Sinatra are different
    # Sinatra requires that they be cast as strings
    
      expenses = @ledger.expenses_on(date)
    # expenses.to_s => SO APPARENTLY RETURN VALUES MUST BE CAST AS STRINGS FOR SINATRA TO WORK
    end
  end
end