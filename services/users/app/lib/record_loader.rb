#typed: true

class RecordLoader < GraphQL::Batch::Loader
  extend T::Sig

  sig do params(model: T.anything).returns(String) end
  def initialize(model)
    @model = model
  end

  sig do params(ids: T.anything).returns(T.anything) end
  def perform(ids)
    T.must(@model)
    @model.where(id: ids).each { |record| fulfill(record.id, record) }
    ids.each { |id| fulfill(id, nil) unless fulfilled?(id) }
  end
end
