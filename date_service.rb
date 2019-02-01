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
    check_format
    @response = 'Vidgar Rulit!'
  end

  private

  def format_params(params)
    @params = params.split(',')
  end

  def time
    return Time.now.to_s if @params.empty?

    Time.now.strftime(@formats).to_s
  end

  def check_format
    @formats, @miss_format = @params.partition { |param| FORMATS[param] }
  end
end
