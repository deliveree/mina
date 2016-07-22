module Mina
  class Configuration
    include Singleton

    attr_reader :variables

    def initialize
      @variables ||= {}
    end

    def set(key, value = nil, &block)
      variables[key] = block || value
    end

    def fetch(key, default = nil)
      value = ENV[key.to_s] || variables.fetch(key, default)
      value.respond_to?(:call) ? value.call : value
    end

    def remove(key)
      variables.delete(key)
    end

    def set?(key)
      !variables.fetch(key, nil).nil?
    end

    def ensure!(key)
      fail "#{key} must be defined!" unless set?(key)
    end

    def reset!
      @variables = {}
    end
  end
end