RSpec.describe RoverCoordinate do
  subject { create(:rover_coordinate) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:initial_orientation) }
    it { is_expected.to validate_presence_of(:instructions) }
  end

  context 'when saving a new record' do
    it 'calculates and saves the final orientation' do
      expect(subject.final_orientation).to eq([1, 3, 'N'])
    end
  end
end
