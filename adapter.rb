require_relative 'date_service'
require 'rack'

class Adapter
  def call(env)
    set_request(env)
    routes
    [status, headers, @body]
  end

  private

  def set_request(env)
    @request = Rack::Request.new(env)
  end

  def routes
    if @request.get? && @request.path == '/time'
      date_service = DateService.new(@request.params['format'])
      @body = [date_service.response]
      status(date_service.status)
    end
  rescue
    status
  end

  def status(number = 404)
    @status = number
  end

  def headers
    {'Content-Type' => 'text/plain'}
  end
end
