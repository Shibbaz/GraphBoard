class CustomScheduler
    def call(klass, serialized_record)
      klass.perform_async(serialized_record.to_h)
    end
  
    def verify(subscriber)
      Class === subscriber && subscriber.respond_to?(:perform_async)
    end
end