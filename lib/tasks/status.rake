task status: :environment do
  raise unless Book.count.zero?
end
