module VandaCollection
  class Error < StandardError; end
  class ClientError < Error; end
  class NotFoundError < ClientError; end
  class SystemNumberFormatError < ClientError; end
end