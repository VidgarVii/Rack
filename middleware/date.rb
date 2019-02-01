class DateRequest
  FORMATS = {
    'year' => '%Y-',
    'month' => '%m-',
    'day' => '%d-',
    'hour' => '%H-',
    'minute' => '%M-',
    'second' => '%S'
  }.freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    if time?(env) && get?(env)
      set_format unless format_date(env['QUERY_STRING']).nil?

      if @miss_format.empty?
        body << time
      else
        status = 400
        body << "Unknown time format #{@miss_format}\n"
      end
    else
      status = 404
    end

    [status, headers, body]
  end

  private

  def format_date(format)
    return @params = [] if format.empty?

    @params = format.split('=')[1].split('%')
  end

  def get?(env)
    env['REQUEST_METHOD'] == 'GET'
  end

  def time
    return Time.now.to_s if @params.empty?

    Time.now.strftime(@formats).to_s
  end

  def set_format
    @miss_format = []
    @formats = ''

    @params.each do |param|
      if FORMATS[param]
        @formats += FORMATS[param]
      else
        @miss_format << param
      end
    end
  end

  def time?(env)
    env['REQUEST_PATH'] == '/time'
  end
end
