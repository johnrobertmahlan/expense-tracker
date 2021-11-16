require 'sinatra/base'
require 'json'
require 'pry'

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

    # right now, this method is kind of useless because we're not persisting any requests
    # since there's no data to get, we're going to keep failing our specs
    # so, we need to find a way to persist expenses in a DB
    # then we can grab them using params
    get '/expenses/:date' do
      JSON.generate([])
    end
  end
end