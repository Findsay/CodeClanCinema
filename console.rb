require ('pry-byebug')

require_relative './models/customer'
require_relative './models/film'

Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({'name' => "Fiona",'funds' => 30})
customer1.save()

film1 = Film.new({ 'title' => "Blade Runner 2049", 'price' => 8})
film1.save()

film2 = Film.new({ 'title' => "It", 'price' => 7})
film2.save()

# customer1.delete()
#
# film1.delete()

# film1.title = "New Title"
# film1.update()

binding.pry
nil
