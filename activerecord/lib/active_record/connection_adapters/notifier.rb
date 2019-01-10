# frozen_string_literal: true

module ActiveRecord
  module ConnectionAdapters
    class Notifier
      attr_reader :instrumenter

      def initialize(instrumenter = ActiveSupport::Notifications.instrumenter)
        @instrumenter = instrumenter
      end

      def emit(event_name, payload = {}, &block)
        instrumenter.instrument(event_name, payload) do
          block.call(payload) if block_given?
        end
      end
    end
  end
end
