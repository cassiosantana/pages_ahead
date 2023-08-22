# frozen_string_literal: true

class ApplicationService
  def self.call(*args)
    new(*args).call
  end

  def initialize(*args); end
end
