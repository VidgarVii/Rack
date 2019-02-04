class DateService
  attr_reader :response

  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(format)
    format_params(format)

    @miss_format.empty? ? time : error
  end

  private

  def format_params(params)
    params = params.split(',')
    @formats, @miss_format = params.partition { |param| FORMATS[param] }
  end

  def error
    @response = raise DateServiceError, "Unknown time format #{@miss_format}"
  end

  def time
    format = @formats.map { |data| FORMATS[data] }.join('-')
    @response = Time.now.strftime(format)
  end
end

class DateServiceError < StandardError
end
