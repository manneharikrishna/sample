FactoryGirl.define do
  factory :drawing_transition do
    drawing { create(:drawing) }

    to_state 'ready'
    sort_key 0
    most_recent true
  end
end
