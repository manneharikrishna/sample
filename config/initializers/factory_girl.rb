FactoryGirl::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess

  def self.fixture_path
    Rails.root.join('spec/fixtures/files')
  end
end
