require ('pry-byebug')

require_relative './models/customer'
require_relative './models/film'
require_relative './models/ticket'
require_relative './models/screening'

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()
Screening.delete_all()

customer1 = Customer.new({'name' => "Fiona",'funds' => 30})
customer1.save()

film1 = Film.new({ 'title' => "Blade Runner 2049", 'price' => 8})
film1.save()

film2 = Film.new({ 'title' => "It", 'price' => 7})
film2.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
ticket1.save()

ticket2 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id })
ticket2.save()

screening1 = Screening.new({ 'film_id' => film1.id, 'film_time' => "13:30"})
screening1.save()

screening2 = Screening.new({ 'film_id' => film1.id, 'film_time' => "16:30"})
screening2.save()

# screening1.film_time = "15:00"
# screening1.update()

# screening1.delete()

# ticket2.buy(customer1, film2)

# ticket1.film_id = film2.id
# ticket1.update()

# customer1.delete()
#
# film1.delete()
#
# ticket1.delete()

# film1.title = "New Title"
# film1.update()

binding.pry
nil
