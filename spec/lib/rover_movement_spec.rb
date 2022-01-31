RSpec.describe RoverMovement do
  subject { described_class.process_instructions(*args) }

  describe '#process_instructions' do
    it 'returns the correct position after several left turns' do
      new_position = described_class.process_instructions([1, 2, 'N'], 'LMLMLMLMM')

      expect(new_position).to eq([1, 3, 'N'])
    end

    it 'returns the correct position after several right turns' do
      new_position = described_class.process_instructions([3, 3, 'E'], 'MMRMMRMRRM')

      expect(new_position).to eq([5, 1, 'E'])
    end

    it 'returns the correct position after several left and right turns' do
      new_position = described_class.process_instructions([2, 3, 'W'], 'LMLMRMRRM')

      expect(new_position).to eq([3, 2, 'N'])
    end

    it 'accepts upper and lower case instruction characters' do
      new_position = described_class.process_instructions([1, 2, 'N'], 'LmlmLmlmM')

      expect(new_position).to eq([1, 3, 'N'])
    end

    it 'ignores erroneous characters added to instructions string' do
      new_position = described_class.process_instructions([3, 3, 'E'], 'MM543RMMASOD;IUJSADIJRMadfsdRRM')

      expect(new_position).to eq([5, 1, 'E'])
    end

    it 'does not move beyond the bounds of the given 5 x 5 grid' do
      new_position = described_class.process_instructions([3, 3, 'E'], 'MMRMMRMRRMMMMMMMMMMMMMMMMMMMMMMMRRM')

      expect(new_position).to eq([4, 1, 'W'])
    end

    it 'can handle extremely long instruction strings' do
      extremely_long_instructions = File.read('./spec/lib/mock_data/instruction_string.rb')

      new_position = described_class.process_instructions([3, 2, 'W'], extremely_long_instructions)

      expect(new_position).to eq([0, 5, 'W'])
    end

    describe 'raises Exception' do
      it 'if improper axis positions inputs are given' do
        expect do
          described_class.process_instructions([3, 333, 'E'], 'LMLMRMRRM')
        end.to raise_error(
          ArgumentError, 'Please input two space delimited numbers from 0-5 and a Cardinal Direction of N, S, E, or W'
        )
      end

      it 'if an improper heading input is given' do
        expect do
          described_class.process_instructions([3, 3, 'X'], 'LMLMRMRRM')
        end.to raise_error(
          ArgumentError, 'Please input two space delimited numbers from 0-5 and a Cardinal Direction of N, S, E, or W'
        )
      end
    end
  end
end
