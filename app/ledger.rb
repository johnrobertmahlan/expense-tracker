module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  EXPENSES = [
    expense_1 = {
        'payee'     => 'Whole Foods',
        'amount'    => 95.20,
        'date'      => '2017-06-11'
    },

    expense_2 = {
        'payee'     => 'Starbucks',
        'amount'    => 5.75,
        'date'      => '2017-06-10'
    },
    
    expense_3 = {
        'payee'     => 'Zoo',
        'amount'    => 15.25,
        'date'      => '2017-06-10'
    },

    expense_4 = {
        'payee'     => 'Quiznos',
        'amount'    => 11.75,
        'date'      => '2017-06-12'
    },

    expense_5 = {
        'payee'     => 'Starbucks',
        'amount'    => 5.75,
        'date'      => '2017-06-13'
    }
  ]

  class Ledger
    def record(expense)
      # REMEMBER that the expense is being passed as a param here
      # it's RETRIEVED in the POST method in api.rb, where it comes from the request body
      # so all we have to do here is record the expense to the DB
      # UPDATE: we have to handle bad expenses, so the logic will get more complicated

      unless expense.key?('payee')
        message = 'Invalid expense: `payee` is required'
        return RecordResult.new(false, nil, message)
      end
      
      DB[:expenses].insert(expense)
      id = DB[:expenses].max(:id) # the ids will be sequential, so the HIGHEST id will be the NEWEST expense
      RecordResult.new(true, id, nil)
    end

    def expenses_on(date)
      EXPENSES.select {|e| e['date'] == date}
    end
  end
end