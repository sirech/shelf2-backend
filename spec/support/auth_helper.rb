module AuthHelper
  def can_authenticate_with(_token)
    allow_any_instance_of(AuthenticateRequest).to receive(:verify).and_return(true)
  end
end

RSpec.configure do |c|
  c.include AuthHelper
end
