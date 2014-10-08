class MarsRover
	# constructor method
	def initialize
		@x_up_right
		@y_up_right
		@x_coord
		@y_coord
		@heading
	end

	# instance methods
	def read_instruction_line(file,split_char)
		line = file.readline
		line = line.chomp!
		line = line.split(split_char)
	end

	def set_up_right_coordinates(line_reader)
		@x_up_right = line_reader[0]
		@y_up_right = line_reader[1]
	end

	# read first line for Top Right Coordinates
	def handle_top_right_coords_instruction(file)
		line_reader = self.read_instruction_line(file, " ")
		self.set_up_right_coordinates(line_reader)
	end

	def set_rover_start_coordinates(line_reader)
		@x_coord = line_reader[0].to_i
		@y_coord = line_reader[1].to_i
		@heading = line_reader[2]
	end

	# read line for Rover Position
	def handle_rover_position_instruction(file)
		line_reader = self.read_instruction_line(file, " ")
		self.set_rover_start_coordinates(line_reader)
	end

	# If spin_direction is left then left_spin_heading value will be evaluated
	# or if spin_direction is right then right_spin_heading will evaluated
	# i.e. Left Turn from N or Right Turn from S results in W
	def evaluate_spin(spin_direction,left_spin_heading, right_spin_heading)
		@heading == left_spin_heading && spin_direction == "left" || 
			@heading == right_spin_heading && spin_direction == "right"
	end

	def spin(direction)
		if self.evaluate_spin(direction,"N","S")
			@heading = "W"
		elsif self.evaluate_spin(direction,"W","E")
			@heading = "S"
		elsif self.evaluate_spin(direction,"S","N")
			@heading = "E"
		elsif self.evaluate_spin(direction,"E","W")
			@heading = "N"
		end	
	end

	def move_forward
		if @heading == "E"
			@x_coord += 1
		elsif @heading == "N"
			@y_coord += 1
		elsif @heading == "W"
			@x_coord -= 1
		elsif @heading == "S"
			@y_coord -= 1
		end	
	end

	def parse_instructions(instruction_set)
		instruction_set.each do |i| 
			if i == "L"
				self.spin("left")
			elsif i == "R"
				self.spin("right")
			elsif i == "M"
				self.move_forward
			end		
		end
	end

	def output_rover_coordinates
		puts @x_coord.to_s + " " + @y_coord.to_s + " " + @heading
	end
	
	# read line for Rover Instructions and Update Rover Position
	def handle_rover_move_instructions(file)
		line_reader = self.read_instruction_line(file, "")
		self.parse_instructions(line_reader)
		self.output_rover_coordinates
	end

	def handle_instruction_file(file)
		self.handle_top_right_coords_instruction(file)

		while !file.eof?
		  self.handle_rover_position_instruction(file)
			self.handle_rover_move_instructions(file)
		end
	end
end

my_rover = MarsRover.new
file = File.open("mars_rover_input.txt", 'r')
my_rover.handle_instruction_file(file)
file.close