module RoverMovement
  TURN_LEFT = {
    'N' => 'W',
    'E' => 'N',
    'S' => 'E',
    'W' => 'S'
  }.freeze

  TURN_RIGHT = {
    'N' => 'E',
    'E' => 'S',
    'S' => 'W',
    'W' => 'N'
  }.freeze

  class << self
    def process_instructions(size, *rovers)
      if invalid_size(size)
        raise ArgumentError,
              'Grid size must be declared as an [X, Y] number array, neither of which can be less than 1'
      end

      @position_data = {
        'N' => [1, 1, size[1]],
        'E' => [0, 1, size[0]],
        'S' => [1, -1, 0],
        'W' => [0, -1, 0]
      }.freeze

      rovers.map do |rover|
        handle_multiple_rovers(rover[0], rover[1])
      end
    end

    private

    def handle_multiple_rovers(orientation, instructions)
      position = orientation.dup

      if any_invalid_inputs(position)
        raise ArgumentError,
              'Initial orientation must be array of two numbers greater than 0 and then a Cardinal direction'
      end

      instructions.each_char do |instruction|
        adjust_rover(position, instruction.upcase)
      end
      position
    end

    def invalid_size(size)
      !size.is_a?(Array) || size.any? { |val| val < 1 }
    end

    def any_invalid_inputs(input)
      input[0..1].any? do |val|
        val.is_a?(Integer) && (val.negative? || val > 5)
      end || @position_data.keys.exclude?(input[2])
    end

    def adjust_rover(position, instruction)
      case instruction
      when 'L'
        position[2] = TURN_LEFT[position[2]]
      when 'R'
        position[2] = TURN_RIGHT[position[2]]
      when 'M'
        move_forward(position)
      end
    end

    def move_forward(position)
      direction = @position_data[position[2]]

      return if position[direction[0]] == direction[2]

      position[direction[0]] += direction[1]
    end
  end
end
