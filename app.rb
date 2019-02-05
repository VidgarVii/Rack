require_relative 'date_service'
require 'rack'

class App
  attr_reader :status, :body

  def call(env)
    @request = Rack::Request.new(env)
    return make_response(404, 'Page not found') unless request_time?

    format_date = DateService.new(@request.params['format'])
    if format_date.valid?
      make_response(200, format_date.formatted_time)
    else
      make_response(400, format_date.invalid_formats)
    end
  end

  private

  def request_time?
    @request.get? && @request.path == '/time' && @request.params['format']
  end

  def make_response(status, body)
    [status, { 'Content-Type' => 'text/plain' }, ["#{body}\n"]]
  end
end
