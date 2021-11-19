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
    end

    def expenses_on(date)
        EXPENSES.select {|e| e['date'] == date}
    end
  end
end