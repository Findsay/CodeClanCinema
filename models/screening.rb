require_relative '../db/sql_runner'

require_relative 'film'

class Screening

  attr_accessor :film_id, :film_time

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @film_id = options['film_id'].to_i()
    @film_time = options['film_time']
  end

  def save()
    sql = "INSERT INTO screenings (film_id, film_time) VALUES ($1, $2)
    RETURNING id;"
    values = [@film_id, @film_time]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i()
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE screenings SET (film_id, film_time) = ($1, $2)
    WHERE id = $3;"
    values = [@film_id, @film_time, @id]
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
