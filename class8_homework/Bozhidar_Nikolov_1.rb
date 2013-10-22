require 'csv'

def student_names file_name
	names = file_name.split("_")[0..1]
	names = names[0] + " " + names[1]
	return names
end	

output_is_in_file = false
output_file_name = ""
output_file_is_arg = false
file_name = ""
array = Array.new()

Dir.chdir("../class7_homework")
print array
Dir.glob("*.rb").each do |current_file|
	print array
	file_name = current_file.split("_")[0]
	if file_name.to_s != "test"
		#Hristiqn Zarkov gave me the right to use his folder with test data
		Dir.chdir("../class8_homework/Hristiqn_Zarkov_test_data")
		`mkdir test_program`
		`cp #{current_file} ../class8_homework/Hristiqn_Zarkov_test_data/test_program`
		File.open("#{current_file}", "r").each do |line|
			if line =~ /"w"/
				output_is_in_file = true
				line = line.split("""")[1]
				if line =~ /ARGV[0]/
					output_file_is_arg = true
				else
					output_file_name = line
				end
			end
		end
		Dir.chdir("test_program")
		if output_is_in_file == true
			if output_file_is_arg == true
				`ruby #{current_file} ../subs.srt output.txt`
				if File.exists?("output.txt")
					result = `diff #{output_file_name} ../expected_subs.txt`
					result = result.gsub!(/\r\n/, "")
					if result == ""
						string = "#{student_names(current_file)},#{result},1"
						array << string
					else
						string = "#{student_names(current_file)},#{result},0"
						array << string
					end
				else
					string = "#{student_names(current_file)},Compilation error,0"
					array << string
				end
				output_file_is_arg = false
				output_is_in_file = false
			else
				 `ruby #{current_file} ../subs.txt`
				if File.exists?(output_file_name)
					result = `diff #{output_file_name} ../expected_subs.txt`
					result = result.gsub!(/\r\n/, "")
					if result == ""
						string = "#{student_names(current_file)},#{result},1"
						array << string
					else	
						string = "#{student_names(current_file)},#{result},0"
						array << string
					end
				else
					string = "#{student_names(current_file)},Compilation error,0"
					array << string
				end
				output_is_in_file = false
			end		
		elsif output_is_in_file == false
			File.open("output.txt", "w") do |line|
				line << `ruby #{current_file} ../28.srt`
			end
			if File.exists?("output.txt")
				result = `diff output.txt ../result.txt`
				result = result.gsub!(/\r\n/, "")
				student_names = current_file.split("_")[0..1]
				if result == ""
					string = "#{student_names(current_file)},#{result},1"
					array << string
				else
					string = "#{student_names(current_file)},#{result},0"
					array << string
				end
			else 
				string = "#{student_names(current_file)},Compilation error,0"
				array << string
			end
		end
	end
	`rm -f test_program`
end

Dir.chdir("..")
File.open("results1.csv", "w") do |line|
	array.each do |element|
		line << element
	end
end