FactoryGirl.define do
  factory :social_lottery_drawing, parent: :drawing do
    lottery { create(:lottery, :social) }

    after(:create) do |drawing|
      Entry::STATUSES.each do |status|
        entry = create(:entry, drawing: drawing, status: status)
        create(:ticket, drawing: drawing, entry: entry)
      end
    end
  end
end
