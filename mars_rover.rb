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
	def readInstructionLine(file,split_char)
		line = file.readline
		line = line.chomp!
		line = line.split(split_char)
	end

	def setUpRightCoordinates(line_reader)
		@x_up_right = line_reader[0]
		@y_up_right = line_reader[1]
	end

	# If spin_direction is left then left_spin_heading value will be evaluated
	# or if spin_direction is right then right_spin_heading will evaluated
	# i.e. Left Turn from N or Right Turn from S results in W
	def evaluateSpin(spin_direction,left_spin_heading, right_spin_heading)
		@heading == left_spin_heading && spin_direction == "left" || 
			@heading == right_spin_heading && spin_direction == "right"
	end

	def spin(direction)
		if self.evaluateSpin(direction,"N","S")
			@heading = "W"
		elsif self.evaluateSpin(direction,"W","E")
			@heading = "S"
		elsif self.evaluateSpin(direction,"S","N")
			@heading = "E"
		elsif self.evaluateSpin(direction,"E","W")
			@heading = "N"
		end	
	end

	def moveForward
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

	def parseInstructions(instruction_set)
		instruction_set.each { |i| 
			if i == "L"
				self.spin("left")
			elsif i == "R"
				self.spin("right")
			elsif i == "M"
				self.moveForward
			end		
		}
	end

	def setRoverStartCoordinates(line_reader)
		@x_coord = line_reader[0].to_i
		@y_coord = line_reader[1].to_i
		@heading = line_reader[2]
	end

	def outputRoverCoordinates
		puts @x_coord.to_s + " " + @y_coord.to_s + " " + @heading
	end
	
	# read first line for Top Right Coordinates
	def handleTopRightCoordsInstruction(file)
		line_reader = self.readInstructionLine(file, " ")
		self.setUpRightCoordinates(line_reader)
	end

	# read line for Rover Position
	def handleRoverPositionInstruction(file)
		line_reader = self.readInstructionLine(file, " ")
		self.setRoverStartCoordinates(line_reader)
	end

	# read line for Rover Instructions and Update Rover Position
	def handleRoverMoveInstructions(file)
		line_reader = self.readInstructionLine(file, "")
		self.parseInstructions(line_reader)
		self.outputRoverCoordinates
	end
end

my_rover = MarsRover.new
file = File.open("mars_rover_input.txt", 'r')
my_rover.handleTopRightCoordsInstruction(file)

while !file.eof?
  my_rover.handleRoverPositionInstruction(file)
	my_rover.handleRoverMoveInstructions(file)
end

file.close