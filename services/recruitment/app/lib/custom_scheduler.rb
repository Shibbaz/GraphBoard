class CustomScheduler
  # method doing actual schedule
  def call(klass, serialized_record)
    klass.perform_async(serialized_record.to_h)
  end

  # method which is checking whether given subscriber is correct for this scheduler
  def verify(subscriber)
    Class === subscriber && subscriber.respond_to?(:perform_async)
  end
end
