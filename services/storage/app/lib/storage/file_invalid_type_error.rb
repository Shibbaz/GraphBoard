class FileInvalidTypeError < ActiveRecord::RecordNotFound
    def message
      'File is not found'
    end
end