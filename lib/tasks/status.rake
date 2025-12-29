desc 'Check if there are books'
task status: :environment do
  raise if Book.none?
end
