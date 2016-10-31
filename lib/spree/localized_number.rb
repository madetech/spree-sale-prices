# Backported from Spree 2.4
module Spree
  class LocalizedNumber
    def self.parse(number)
      return number unless number.is_a?(String)
      separator, _ = I18n.t([:'number.currency.format.separator', :'number.currency.format.delimiter'])
      non_number_characters = /[^0-9\-#{separator}]/
      number.gsub!(non_number_characters, '')
      number.gsub!(separator, '.') unless separator == '.'
      number.to_d
    end
  end
end
