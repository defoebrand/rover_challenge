FactoryBot.define do
  factory :rover_coordinate do
    initial_orientation { [1, 2, 'N'] }
    instructions { 'LMLMLMLMM' }
  end
end
