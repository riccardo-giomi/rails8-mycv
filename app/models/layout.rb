class Layout < ApplicationRecord
  class PageBreaks <  ActiveRecord::Type::Value
    def type = :page_breaks

    def cast(value)
      case value
      when Array
        value
      when Hash
        value.select { |_, v| v.present? }.keys
      else
        raise ArgumentError.new "Cannot cast #{value} to Layout::PageBreak, invalid type"
      end
    end

    def serialize(value = [])
      ActiveSupport::JSON.encode(cast(value), escape: false)
    end

    def deserialize(value)
      return [] if value.blank?
      ActiveSupport::JSON.decode(value)
    end
  end

  belongs_to :cv
  validates_uniqueness_of :cv_id

  ActiveRecord::Type.register(:page_breaks, PageBreaks)
  attribute :page_breaks, :page_breaks
end
