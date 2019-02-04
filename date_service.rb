class DateService

  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(formats)
    format_params(formats)
  end

  def formatted_time
    formats = @formats.map { |data| FORMATS[data] }.join('-')
    Time.now.strftime(formats)
  end

  def valid?
    @miss_format.empty?
  end

  def invalid_formats
    "Unknown time format #{@miss_format}"
  end

  private

  def format_params(params)
    params = params.split(',')
    @formats, @miss_format = params.partition { |param| FORMATS.key?(param) }
  end
end
