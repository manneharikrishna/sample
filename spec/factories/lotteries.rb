FactoryGirl.define do
  factory :lottery, traits: [:predrawn] do
    sequence(:name) { |n| "Lottery #{n}" }

    headline 'This is an example headline'
    description 'This is an example lottery'
    starts_at { Time.current.beginning_of_year }
    ends_at { Time.current.end_of_year }

    repeat_every 86_400

    cover { fixture_file_upload('image.jpg', 'image/jpeg') }

    Lottery::TYPES.each do |type|
      trait type.to_sym do
        license { create(:license, lottery_type: type) }
      end
    end

    LotteryStateMachine.states.each do |state|
      trait state.to_sym do
        after(:create) do |lottery|
          create(:lottery_transition, lottery: lottery, to_state: state)
        end
      end
    end
  end
end
