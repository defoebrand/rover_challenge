RSpec.describe RoverCoordinate do
  subject { create(:rover_coordinate) }

  let(:rover_with_undefined_grid) { create(:rover_coordinate, grid_size: []) }
  let(:rover_with_string_inputs) { create(:rover_coordinate, initial_orientation: %w[1 2 N]) }
  let(:rover_with_missing_x_position) { create(:rover_coordinate, initial_orientation: [nil, '2', 'N']) }
  let(:rover_with_missing_y_position) { create(:rover_coordinate, initial_orientation: ['1', nil, 'N']) }
  let(:rover_with_missing_direction) { create(:rover_coordinate, initial_orientation: ['1', '2', nil]) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:instructions) }
  end

  context 'when saving a new record' do
    it 'calculates and saves the final orientation' do
      expect(subject.final_orientation).to eq([1, 3, 'N'])
    end

    it 'adjusts initial_orientation inputs to match a [number, number, string] pattern' do
      expect(rover_with_string_inputs.initial_orientation).to eq([1, 2, 'N'])
    end

    it 'rejects initial_orientation if X position is missing from initial_orientation' do
      error_message = 'Initial orientation must be array of two numbers greater than 0 and then a Cardinal direction'

      expect { rover_with_missing_x_position }.to raise_error(ArgumentError, error_message)
    end

    it 'rejects initial_orientation if Y position is missing from initial_orientation' do
      error_message = 'Initial orientation must be array of two numbers greater than 0 and then a Cardinal direction'

      expect { rover_with_missing_y_position }.to raise_error(ArgumentError, error_message)
    end

    it 'rejects initial_orientation if direction is missing from initial_orientation' do
      error_message = 'Initial orientation must be array of two numbers greater than 0 and then a Cardinal direction'

      expect { rover_with_missing_direction }.to raise_error(ArgumentError, error_message)
    end

    it 'sets default grid_size to [5, 5] if grid_size input is missing' do
      expect(rover_with_undefined_grid.final_orientation).to eq([1, 3, 'N'])
    end
  end
end
