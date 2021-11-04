require_relative '../../../app/api'
require 'rack/test'

# UNIT TESTS!!!

module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  RSpec.describe API do
    include Rack::Test::Methods

    # STEP 4: We'll need an app again since every HTTP request should create a new instance of API
    def app
      API.new(ledger: ledger)
    end

    # STEP 5: since the API class takes an instance of the Ledger class as a param
    # we need something to be our ledger object
    # but since we ONLY want to test the API class, not the Ledger class
    # we'll create a MOCK of that class using instance_double
    let(:ledger) { instance_double ('ExpenseTracker::Ledger') }

    # STEP 1: Test our ability to post expenses
    describe 'POST /expenses' do

      # STEP 2: we need to test what happens when we SUCCEED
      context 'when the expense is successfully recorded' do
        it 'returns the expense id' do

          # STEP 6: we want some dummy data to pass into our Ledger double
          expense = {'some' => 'data'}
          
          # STEP 7: we configure how our ledger object will work
          # we ALLOW ledger to receive record (which is a METHOD not yet defined on the Ledger class)
          # the record method takes a PARAM: expense
          # the method then RETURNS a new instance of the RecordResult class with the data we stub out here
          allow(ledger).to receive(:record)
            .with(expense)
            .and_return(RecordResult.new(true, 417, nil))

          # STEP 8: now that we've configure our test, we need to DO stuff
          # so, we call the POST method from Rack::Test to our expenses endpoint
          # and we EXPECT it to return the expense_id that we stubbed out above
          # essentially, we CALL the POST method that we routed in our API class
          # and PASS IN as our param the result of JSON.generate(expense)
          # that is why { 'some' => 'data' } is returned as our expense when we put a pry in our API class
          # and then since we just stubbed out a result, we have the result we want
          post '/expenses', JSON.generate(expense)
          parsed = JSON.parse(last_response.body)
          expect(parsed).to include('expense_id' => 417)
        end

        it 'responds with a 200 (OK)' do
          expense = { 'some' => 'data' }

          allow(ledger).to receive(:record)
            .with(expense)
            .and_return(RecordResult.new(true, 417, nil))

          post '/expenses', JSON.generate(expense)
          
          # WHY NOT: expect(last_response).to have_http_status(200)
          expect(last_response.status).to eq(200)
        end
      end

      # STEP 3: we need to test what happens when we FAIL
      context 'when the expense fails validation' do
        # it 'returns an error message'
        # it 'responds with a 422 (Unprocessable entity)'
      end
    end
  end
end