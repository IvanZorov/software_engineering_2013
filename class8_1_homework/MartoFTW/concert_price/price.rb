require 'csv'

all = []
CSV.foreach(ARGV[0]) do |row|
        if (row[3].to_i == ARGV[1].to_i)
                all << row
        end 
end
all = all.sort_by{|a,b,c,d,e,f| a}
all = all.reverse
CSV.open("price_result.csv","w") do |csv|
        all.each do |row|
                csv << row
	end
end


