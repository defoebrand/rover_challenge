FactoryBot.define do
  factory :rover_coordinate do
    initial_orientation { [1, 2, 'N'] }
    instructions { 'LMLMLMLMM' }

    trait :skip_validations do
      to_create { |record| record.save(validate: false) }
    end
  end
end
