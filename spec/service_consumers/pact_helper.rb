require_relative '../rails_helper'
require 'pact/provider/rspec'

require_relative 'books'

Pact.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

Pact.service_provider 'Backend' do
  honours_pact_with 'Provider' do
    pact_uri 'https://raw.githubusercontent.com/sirech/shelf2-frontend/master/pacts/react-backend.json'
  end
end

# rubocop:disable Metrics/BlockLength
Pact.provider_states_for 'React' do
  provider_state 'i have some books' do
    set_up do
      books.each do |book|
        create(:book, **book)
      end
    end
  end

  provider_state 'i have books for different years' do
    set_up do
      years.each do |h|
        year = h[:year]
        count = h[:count]
        create_list(:book, count, year: year)
      end
    end
  end

  provider_state 'i am not logged in' do
    set_up do
      create(:user, id: 1, name: 'Tronald', password: 'Dumpinator')
    end
  end

  provider_state 'i am logged in' do
    set_up do
      create(:user, id: 1, name: 'Tronald', password: 'Dumpinator')
    end
  end
end
# rubocop:enable Metrics/BlockLength
