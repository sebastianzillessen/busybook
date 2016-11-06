#app/validators/not_in_past_validator.rb
class NotInPastValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present? && value <= Time.zone.today
      record.errors.add attribute,
                        (options[:message] || "can't be in the past")
    end
  end
end