#typed: true

class CustomScheduler
  extend T::Sig

  sig do params(klass: T.anything, serialized_record: T.anything).returns(T.anything) end
  def call(klass, serialized_record)
    klass.perform_async(serialized_record.to_h)
  end

  sig do params(subscriber:T.anything).returns(T.anything) end
  def verify(subscriber)
    Class === subscriber && subscriber.respond_to?(:perform_async)
  end
end
