module JsonHelper
  def json_response
    @json_response ||= JSON.parse response.body
  end

  def json_response!
    expect(response.body).not_to be_blank
    json_response
  end
end

RSpec.configure do |c|
  c.include JsonHelper
end
