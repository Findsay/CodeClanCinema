require_relative '../db/sql_runner'

require_relative 'customer'
require_relative 'film'

class Ticket

  def initialize(options)
    @id = options['id']to.i() if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  

end
