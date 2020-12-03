module MagicBell
  module ApiOperations
    def get(url, options = {})
      response = HTTParty.get(
        url,
        options.merge(headers: authentication_headers)
      )
      raise_http_error_unless_2xx_response(response)

      response
    end

    def post(url, options = {})
      response = HTTParty.post(
        url,
        options.merge(headers: authentication_headers)
      )
      raise_http_error_unless_2xx_response(response)

      response
    end

    def put(url, options = {})
      response = HTTParty.put(
        url,
        options.merge(headers: authentication_headers)
      )
      raise_http_error_unless_2xx_response(response)

      response
    end

    private

    def raise_http_error_unless_2xx_response(response)
      return if response.success?
      e = MagicBell::Client::HTTPError.new
      e.response_status = response.code
      e.response_headers = response.headers.to_h
      e.response_body = response.body
      raise e
    end
  end
end