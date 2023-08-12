module Api
  class BaseService
    def self.call(*args)
      new(*args).call
    end

    def initialize(*args); end
  end
end
