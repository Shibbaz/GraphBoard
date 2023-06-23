class FileInvalidTypeError < StandardError
  def message
    "File is not found"
  end
end
