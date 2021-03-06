require_relative '../db/sql_runner'

require_relative 'film'

class Screening

  attr_accessor :film_id, :film_time, :no_tickets
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @film_id = options['film_id'].to_i()
    @film_time = options['film_time']
    @no_tickets = options['no_tickets'].to_i()
  end

  def save()
    sql = "INSERT INTO screenings (film_id, film_time, no_tickets) VALUES ($1, $2, $3)
    RETURNING id;"
    values = [@film_id, @film_time, @no_tickets]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i()
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE screenings SET (film_id, film_time, no_tickets) = ($1, $2, $3)
    WHERE id = $4;"
    values = [@film_id, @film_time, @no_tickets, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM screenings;"
    values = []
    screenings = SqlRunner.run(sql, values)
    return screenings.map { |screening| Screening.new(screening)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    values = []
    SqlRunner.run(sql, values)
  end

end
