FactoryGirl.define do
  factory :lottery_transition do
    lottery { create(:lottery) }

    to_state 'ready'
    sort_key 0
    most_recent true
  end
end
