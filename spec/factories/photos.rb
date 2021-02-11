FactoryGirl.define do
  factory :photo do
    player { create(:player) }
    image { fixture_file_upload('image.jpg', 'image/jpeg') }
  end
end
