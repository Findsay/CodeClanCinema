require_relative '../db/sql_runner'

require_relative 'customer'
require_relative 'film'
require_relative 'screening'


class Ticket

  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @customer_id = options['customer_id'].to_i()
    @film_id = options['film_id'].to_i()
    @screening_id = options['screening_id'].to_i()
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id, screening_id) VALUES ($1, $2, $3)
    RETURNING id;"
    values = [@customer_id, @film_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i()
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id, screening_id) = ($1, $2, $3)
    WHERE id = $4;"
    values = [@customer_id, @film_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets;"
    values = []
    tickets = SqlRunner.run(sql, values)
    return tickets.map { |ticket| Ticket.new(ticket)}
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    values = []
    SqlRunner.run(sql, values)
  end

  def buy(customer, film)
    customer.funds -= film.price
    customer.update
  end

  def check_if_available(no_of_tickets, screening)
    no_of_tickets > screening.no_tickets
    return "Sorry there are no tickets left for this screening"
  end

  def reduce_available(screening, no_of_tickets)
    screening.no_tickets -= no_of_tickets
    screening.update
  end


end
