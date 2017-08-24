task status: :environment do
  raise if Book.count.zero?
end
