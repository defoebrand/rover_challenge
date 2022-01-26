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

  POSITION_DATA = {
    'N' => [1, 1, 5],
    'E' => [0, 1, 5],
    'S' => [1, -1, 0],
    'W' => [0, -1, 0]
  }.freeze

  class << self
    def process_instructions(orientation, instructions)
      position = orientation.dup
      instructions.each_char do |instruction|
        position = adjust_rover(position, instruction.upcase)
      end
      position
    end

    private

    def adjust_rover(position, instruction)
      case instruction
      when 'L'
        position[2] = TURN_LEFT[position[2]]
      when 'R'
        position[2] = TURN_RIGHT[position[2]]
      when 'M'
        move_forward(position)
      end
      position
    end

    def move_forward(position)
      direction = POSITION_DATA[position[2]]

      return if position[direction[0]] == direction[2]

      position[direction[0]] += direction[1]
    end
  end
end
