class Knight
	
	DELTAS = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[-1,2],[1,-2],[-1,-2]] # possible relative moves

	def self.valid_moves(startpos)
		raw_moves = DELTAS.collect {|delta| [startpos[0] + delta[0], startpos[1] + delta[1]]}
		legal_moves = raw_moves.select {|endpos| endpos[0].between?(0,7) && endpos[1].between?(0,7)}
	end
end

class Position
	attr_reader :pos, :parent, :children

	def initialize(pos, parent)
		@pos = pos
		@parent = parent
		@children = []
	end

	def to_s
		pos_str = "[#{@pos[0]},#{@pos[1]}]"
		if !parent.nil?
			pos_str += " : parent [#{@parent.pos[0]},#{@parent.pos[1]}]"
		end
		pos_str
	end
end

def add_children(node, target, visited)
	startpos = node.pos
	legal_moves = Knight.valid_moves(startpos)
	unvisited = legal_moves.select {|pos| !visited.include?(pos)}
	target_node = nil
	found = false
	unvisited.each do |endpos|
		new_node = Position.new(endpos,node)
		node.children << new_node
		if endpos == target
			target_node = new_node
			found = true
			break
		end
		visited << endpos
	end
	return found, target_node
end

def trace_path(node)
	path = [node.pos]
	while !node.parent.nil? do
		node = node.parent
		path.unshift(node.pos)
	end
	path
end

def build_tree(startpos, target)
	root = Position.new(startpos, nil)
	if startpos == target
		path = [startpos]
	else
		current_node = root
		visited = []
		queue = []
		found = false
		target_node = nil
		while !found do
			found, target_node = add_children(current_node, target, visited)
			if !found
				# add children to queue
				current_node.children.each {|child| queue.unshift(child)}
				# take next node for search from queue
				current_node = queue.pop
			end
		end
		path = trace_path(target_node)
	end
	path
end

def get_pos
	valid = false
	while !valid do
		input = gets.chomp
		x_str, y_str = input.split(",")
		x = x_str.to_i
		y = y_str.to_i
		
		if x.between?(0,7) && y.between?(0,7)
			valid = true
		else
			valid = false
			puts "Invalid input, try again"
			print "Please enter a valid position : "
		end
	end
	[x,y]
end

def knight_moves(start,target)
	path = build_tree(start,target)
	movecount = (path.length) - 1
	puts "You made it in #{movecount} moves! Here's your path: "
	path.each {|pos| puts "[#{pos[0]}, #{pos[1]}]"}
end

quit = false
while !quit do
	print "Enter q to quit, or anything else to continue: "
	input = gets.chomp
	case input
	when "q"
		quit = true
	else
		print "Enter start position as x,y (0 <= x <= 7, 0 <= y <= 7) : "
		startpos = get_pos
		print "Enter goal position as x,y (0 <= x <= 7, 0 <= y <= 7) : "
		target = get_pos
		knight_moves(startpos,target)
	end
end