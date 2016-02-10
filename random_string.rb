require "csv"
require "byebug"

class RandomStringValue

	def randomize_length(randomized_array)
		random_length = rand(1...30)
		# $file_size += random_length
		randomized_array.shuffle.take(random_length)
	end

	def array_to_string(randomized_string)
		randomized_string.join.to_s
	end

	def random_lower_alphabet
		("a".."z").to_a
	end

	def random_upper_alphabet
		("A".."Z").to_a
	end

	def alphabetical_string #create random alphabetical string
		randomized_alphabet_array = []
		randomized_alphabet_array << random_lower_alphabet + random_lower_alphabet + random_upper_alphabet
		random_length_of_alphabet = randomize_length(randomized_alphabet_array[0]).shuffle 
		array_to_string(random_length_of_alphabet)
	end

	def real_number #create random real number
		random_number = rand(0.0..1_000_000.0)
		random_length = rand(1..7)
		final_random_number = random_number.round(random_length)
		final_random_number.to_s
	end

	def integer_string #create random integer string
		 rand(0..1_000_000_000).to_s
	end

	def random_spaces
		random_spaces = ""
		rand(1..10).times do
			random_spaces += " "
		end
		random_spaces
	end

	def alphanumeric_string #create random alphanumeric string
		randomized_alphanumeric_array = []
		randomized_alphanumeric_array << ("0".."9").to_a + random_lower_alphabet + random_upper_alphabet
		random_length_of_alphanumeric = randomize_length(randomized_alphanumeric_array[0]).shuffle
		random_spaces + array_to_string(random_length_of_alphanumeric) + random_spaces
	end	

end

max_file_size = 1_000_000
file_size = 0
temp_arr = []

		random_string = rand(1..4)
		random_string_value = RandomStringValue.new
		
		CSV.open("shoppr.csv", "a+") do |csv|
			
			while file_size < max_file_size
				random_string = rand(1..4)
				if random_string == 1
					temp_arr << random_string_value.alphabetical_string
				elsif random_string == 2
					temp_arr << random_string_value.real_number
				elsif random_string == 3
					temp_arr << random_string_value.integer_string
				elsif random_string == 4
					temp_arr << random_string_value.alphanumeric_string
				end

				file_size += (temp_arr.last.length + 2 )
			end
			csv << temp_arr

		end
	
		CSV.foreach("shoppr.csv") do |row|
			row.each do |string|
				if string[/[a-zA-Z]/] && string[/\d/]
					
					puts string + " - " + "alphanumeric"
				elsif string[/\d/] && string[/[.]/]	
					puts string + " - " + "real numbers"
				elsif string[/\d/]
					puts string + " - " + "integer"
				else
					puts string + " - " + "alphabetical strings"
				end
			end
		end

