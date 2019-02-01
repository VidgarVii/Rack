require_relative 'middleware/date'
require_relative 'app'

use DateRequest
run App.new
