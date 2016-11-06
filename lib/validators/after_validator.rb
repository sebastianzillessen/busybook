#app/validators/not_in_past_validator.rb
class AfterValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present? && options.has_key?(:attr)
      compare=record.send(options[:attr])
      if compare.present? && value >= compare
        record.errors.add attribute,
                          (options[:message] || "must be before self.#{options[:attr]}='#{compare}'")
      end
    end
  end
end