require 'sinatra/base'
require 'json'

module ExpenseTracker
  class API < Sinatra::Base
    # this method is just creating a dummy hash with the same key every time
    # once we hook up a DB, we'll update this so that we can post real expenses
    post '/expenses' do
      JSON.generate('expense_id' => 42)
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