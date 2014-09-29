class MarsRover

	attr_accessor :x_up_right, :y_up_right, :x_coord, :y_coord, :heading

	# constructor method
	def initialize
		@x_up_right
		@y_up_right
		@x_coord
		@y_coord
		@heading
	end

	# instance methods
	def evaluateRoverInstructions
		file = File.open("mars_rover_input.txt", 'r')

		# read first line for Top Right Coordinates
		up_right_line = file.readline
		up_right_values = up_right_line.chomp!
		up_right_values = up_right_values.split(" ")
		@x_up_right = up_right_values[0]
		@y_up_right = up_right_values[1]
		# puts "Top Right Coordinates: (" + @x_up_right + "," + @y_up_right + ")"

		while !file.eof?

			# read line for Rover Position 
		  rover_position_line = file.readline
			rover_position_values = rover_position_line.chomp!
			rover_position_values = rover_position_values.split(" ")
			@x_coord = rover_position_values[0].to_i
			@y_coord = rover_position_values[1].to_i
			@heading = rover_position_values[2]

			#puts "Rover Position: (" + @x_coord.to_s + "," + @y_coord.to_s + "," + @heading + ")"

			# read line for Rover Instructions and Update Rover Position
		  rover_instructions = file.readline
		  rover_instructions = rover_instructions.chomp!
		  rover_instructions = rover_instructions.split("")
		  self.parseInstructions(rover_instructions)
		  puts @x_coord.to_s + " " + @y_coord.to_s + " " + @heading
		end

		file.close
	end

	def spinLeft
		if @heading == "N"
			@heading = "W"
		elsif @heading == "W"
			@heading = "S"
		elsif @heading == "S"
			@heading = "E"
		elsif @heading == "E"
			@heading = "N"
		end			
	end

	def spinRight
		if @heading == "N"
			@heading = "E"
		elsif @heading == "E"
			@heading = "S"
		elsif @heading == "S"
			@heading = "W"
		elsif @heading == "W"
			@heading = "N"
		end			
	end

	def moveForward
		if @heading == "N"
			@y_coord += 1
		elsif @heading == "E"
			@x_coord += 1
		elsif @heading == "S"
			@y_coord -= 1
		elsif @heading == "W"
			@x_coord -= 1
		end	
		
	end

	def parseInstructions(instruction_set)
		instruction_set.each { |i| 
			if i == "L"
				self.spinLeft
			elsif i == "R"
				self.spinRight
			elsif i == "M"
				self.moveForward
			end		
		}
	end
end

my_rover = MarsRover.new
my_rover.evaluateRoverInstructions