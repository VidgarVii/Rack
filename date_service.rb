class DateService
  attr_reader :status, :response

  FORMATS = {
    'year' => '%Y-',
    'month' => '%m-',
    'day' => '%d-',
    'hour' => '%H-',
    'minute' => '%M-',
    'second' => '%S'
  }.freeze

  def initialize(format)
    format_params(format)
    @status = 200
    @miss_format.empty? ? time : error
  end

  private

  def format_params(params)
    params = params.split(',')
    @formats, @miss_format = params.partition { |param| FORMATS[param] }
  end

  def error
    @status = 400
    @response = "Unknown time format #{@miss_format}"
  end

  def time
    format = ''
    @formats.each { |data| format += FORMATS[data] }
    @response = Time.now.strftime(format).to_s
  end
end
