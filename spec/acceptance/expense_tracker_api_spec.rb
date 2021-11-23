require 'rack/test'
require 'json'
require 'pry'
require_relative '../../app/api'

# ACCEPTANCE TESTS!!!

module ExpenseTracker
  RSpec.describe 'expense tracker API', :db do
    include Rack::Test::Methods

    # STEP 2: Sinatra requires a method called APP that returns an object representing the app
    # once this method is defined, we need to actually implement the code that lets us call .new
    def app 
      ExpenseTracker::API.new
    end

    # STEP 5: set up a helper method for posting expenses
    # this will set up TEST data that hopefully our app can then match
    # it essentially reiterates the code from earlier steps which can now be commented out
    # Question: this method is being called, but I only have one test example
    # so are the tests really being run from inside this method?
    def post_expense(expense)
      post '/expenses', JSON.generate(expense)
      expect(last_response.status).to eq(200)

      parsed = JSON.parse(last_response.body)
      expect(parsed).to include('expense_id' => a_kind_of(Integer))
      expense.merge('id' => parsed['expense_id'])
    end

    # this is an acceptance test
    # the purpose of it is to make sure that we can save the expenses we record
    it 'records submitted expenses' do

        # STEP 1: define a coffee hash with some keys/values
        # coffee = {
        #   'payee' => 'Starbucks',
        #   'amount' => '5.75',
        #   'date' => '2017-06-10'
        # }

      pending 'need to persist expenses'

      # As part of STEP 5, we refactor our data to be built using our helper method
      coffee = post_expense(
          'payee'     => 'Starbucks',
          'amount'    => 5.75,
          'date'      => '2017-06-10'
      )

      zoo = post_expense(
          'payee'     => 'Zoo',
          'amount'    => 15.25,
          'date'      => '2017-06-10'
      )

      groceries = post_expense(
          'payee'     => 'Whole Foods',
          'amount'    => 95.20,
          'date'      => '2017-06-11'
      )

      # try posting a JSON-ified coffee hash to /expenses
      # NB: this post is calling a METHOD from Rack::Test
      # as long as the specs don't error out, we don't need any expectations
      # post '/expenses', JSON.generate(coffee)

      # STEP 3: check whether our app knows where to send a POST request
      # this is essentially a test to make sure we have set up our routes
      # getting anything other than a 200 status means we haven't set up our routes
      # NB: the last_response method also comes from Rack::Test
      # expect(last_response.status).to eq(200)

      # STEP 4: check whether our app returns data in the right format
      # we want each expense to have a unique expense_id
      # parsed = JSON.parse(last_response.body)
      # expect(parsed).to include('expense_id' => a_kind_of(Integer))
      
      # STEP 6: try GETTING the expenses posted on June 10, 2017
      # this post is calling a METHOD from Rack::Test
      # as long as there's no error, the GET request doesn't break anything
      get '/expenses/2017-06-10'

      # STEP 7: check whether our app knows where to send a POST request
      # this is essentially a test to make sure we have set up our routes
      # getting anything other than a 200 status means we haven't set up our routes
      # NB: the last_response method also comes from Rack::Test
      expect(last_response.status).to eq(200)

      # STEP 8: grab the results of our GET request and make sure they're correct
      expenses = JSON.parse(last_response.body)
      expect(expenses).to contain_exactly(coffee, zoo)
    end
  end
end