require 'sinatra/base'

class FakeService < Sinatra::Base
  private

  def render(name, status: 200, content_type: :json)
    content_type content_type
    status status

    load_fixture("#{name}.#{content_type}")
  end

  def load_fixture(file_name)
    File.read("spec/fixtures/#{service_name}/#{file_name}")
  end

  def service_name
    self.class.name.gsub(/^Fake/, '').underscore
  end
end
