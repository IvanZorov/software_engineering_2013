require "csv"

information=Hash.new(0.0)


	CSV.foreach("bank.csv") do |row|
		information[row[0] ]+=row[1].to_f
	end

	max=information.max_by{ |date,income| income }
        puts max[0]
