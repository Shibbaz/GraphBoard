class FileNoKeyError < StandardError
  def message
    "File key is not found"
  end
end
