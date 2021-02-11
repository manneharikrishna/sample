require 'support/fake_service'

class FakeKAR < FakeService
  OWNED = '12036355776'.freeze
  NOT_OWNED = '12345678901'.freeze

  get "/kar-direct/customers/*/accounts/#{OWNED}/karVerifyAccountOwner" do
    render :owned, content_type: :text
  end

  get "/kar-direct/customers/*/accounts/#{NOT_OWNED}/karVerifyAccountOwner" do
    render :not_owned, content_type: :text
  end
end
