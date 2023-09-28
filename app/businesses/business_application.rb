# frozen_string_literal: true

class BusinessApplication
  def self.call(*args)
    new(*args).call
  end

  def initialize(*args); end
end
