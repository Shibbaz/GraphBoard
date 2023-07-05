#typed: true

class RecordLoader < GraphQL::Batch::Loader
  extend T::Sig

  sig do params(model: T.anything).returns(T.anything) end
  def initialize(model)
    @model = model
  end

  sig do params(ids: T.anything).returns(T.anything) end
  def perform(ids)
    T.must(@model)
    @model.where(author: ids).each { |record| fulfill(record.author, record) }
    ids.each { |author| fulfill(author, nil) unless fulfilled?(author) }
  end
end
