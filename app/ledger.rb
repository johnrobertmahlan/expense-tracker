module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  class Ledger
    def record(expense)
    end

    def expenses_on(date)
        expense_1 = {
          'payee'     => 'Whole Foods',
          'amount'    => 95.20,
          'date'      => '2017-06-11'
        }

        expense_2 = {
            'payee'     => 'Starbucks',
            'amount'    => 5.75,
            'date'      => '2017-06-10'
        }

        expense_3 = {
          'payee'     => 'Zoo',
          'amount'    => 15.25,
          'date'      => '2017-06-10'
        }

        expenses = [expense_1, expense_2, expense_3].select {|e| e['date'] == date}
    end
  end

end