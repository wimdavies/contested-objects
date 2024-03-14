module VandaCollection
  class Error < StandardError; end
  class ClientError < Error; end
  class SystemNumberFormatError < ClientError; end
  class ResponseStatusCodeError < ClientError; end
  class NotFoundError < ResponseStatusCodeError; end
end