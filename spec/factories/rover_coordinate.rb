FactoryBot.define do
  factory :rover_coordinate do
    initial_orientation { [1, 2, 'N'] }
    instructions { 'LMLMLMLMM' }
    grid_size { [5, 5] }
  end
end
