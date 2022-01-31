RSpec.describe RoverMovement do
  subject { described_class.process_instructions(*args) }

  describe '#process_instructions for one rover' do
    it 'returns the correct position after several left turns' do
      new_position = described_class.process_instructions([5, 5], [[1, 2, 'N'], 'LMLMLMLMM'])

      expect(new_position).to eq([[1, 3, 'N']])
    end

    it 'returns the correct position after several right turns' do
      new_position = described_class.process_instructions([5, 5], [[3, 3, 'E'], 'MMRMMRMRRM'])

      expect(new_position).to eq([[5, 1, 'E']])
    end

    it 'returns the correct position after several left and right turns' do
      new_position = described_class.process_instructions([5, 5], [[2, 3, 'W'], 'LMLMRMRRM'])

      expect(new_position).to eq([[3, 2, 'N']])
    end

    it 'accepts upper and lower case instruction characters' do
      new_position = described_class.process_instructions([5, 5], [[1, 2, 'N'], 'LmlmLmlmM'])

      expect(new_position).to eq([[1, 3, 'N']])
    end

    it 'ignores erroneous characters added to instructions string' do
      new_position = described_class.process_instructions([5, 5], [[3, 3, 'E'], 'MM543RMMASOD;IUJSADIJRMadfsdRRM'])

      expect(new_position).to eq([[5, 1, 'E']])
    end

    it 'does not move beyond the bounds of the given X axis size' do
      new_position = described_class.process_instructions([7, 5], [[3, 3, 'E'], 'MMRMMRMRRMMMMMMMMMMMMMMMMMMMMMMMM'])

      expect(new_position).to eq([[7, 1, 'E']])
    end

    it 'does not move beyond the bounds of the given Y axis size' do
      new_position = described_class.process_instructions([5, 7], [[3, 3, 'E'], 'MMRMMRMRRMMMRRRMMMMMMMMMMMMMMMMMM'])

      expect(new_position).to eq([[5, 7, 'N']])
    end

    it 'can handle extremely long instruction strings' do
      extremely_long_instructions = File.read('./spec/lib/mock_data/instruction_string.rb')

      new_position = described_class.process_instructions([5, 5], [[3, 2, 'W'], extremely_long_instructions])

      expect(new_position).to eq([[0, 5, 'W']])
    end
  end

  describe '#process_instructions for multiple rovers' do
    it 'returns an array with correct positions for each rover' do
      new_position = described_class.process_instructions([5, 5], [[1, 2, 'N'], 'LMLMLMLMM'],
                                                          [[3, 3, 'E'], 'MMRMMRMRRM'])

      expect(new_position).to eq([[1, 3, 'N'], [5, 1, 'E']])
    end
  end

  describe 'raises Exception' do
    it 'if given X axis size is less than 1' do
      error_message = 'Grid size must be declared as an [X, Y] number array, neither of which can be less than 1'

      expect do
        described_class.process_instructions([-1, 5], [[3, 333, 'E'], 'LMLMRMRRM'])
      end.to raise_error(ArgumentError, error_message)
    end

    it 'if given Y axis size is less than 1' do
      error_message = 'Grid size must be declared as an [X, Y] number array, neither of which can be less than 1'

      expect do
        described_class.process_instructions([5, 0], [[3, 333, 'E'], 'LMLMRMRRM'])
      end.to raise_error(ArgumentError, error_message)
    end

    it 'if given rover position X input exceeds given size X input' do
      error_message = 'Initial orientation must be array of two numbers greater than 0 and then a Cardinal direction'

      expect do
        described_class.process_instructions([5, 5], [[6, 3, 'E'], 'LMLMRMRRM'])
      end.to raise_error(ArgumentError, error_message)
    end

    it 'if given rover position Y input exceeds given size Y input' do
      error_message = 'Initial orientation must be array of two numbers greater than 0 and then a Cardinal direction'

      expect do
        described_class.process_instructions([5, 5], [[3, 6, 'E'], 'LMLMRMRRM'])
      end.to raise_error(ArgumentError, error_message)
    end

    it 'if improper rover heading input is given' do
      error_message = 'Initial orientation must be array of two numbers greater than 0 and then a Cardinal direction'

      expect do
        described_class.process_instructions([5, 5], [[3, 3, 'X'], 'LMLMRMRRM'])
      end.to raise_error(ArgumentError, error_message)
    end
  end
end
