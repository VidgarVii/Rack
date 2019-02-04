require_relative 'date_service'
require 'rack'

class Adapter
  attr_reader :status, :body

  def call(env)
    route(Rack::Request.new(env))

    [status, headers, body]
  end

  private

  def route(request)
    if request.get? && request.path == '/time' && request.params['format']
      date_service(request.params['format'])
    else
      @body = ''
      @status = 404
    end
  end

  def date_service(format)
    date_service = DateService.new(format)
    @body = [date_service.response]
    @status = 200
  rescue DateServiceError => error
    @body = [error.to_s]
    @status = 400
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end
end
