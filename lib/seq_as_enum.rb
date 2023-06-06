# frozen_string_literal: true

require_relative "seq_as_enum/version"

module SeqAsEnum
  DEFAULT_SEP = '_'.freeze

  private

  def seq_as_enum(*names, init: 0, data_as: nil, prefix: nil, sep: DEFAULT_SEP)
    raise ArgumentError, 'Cannot use prefix option with data_as option' if prefix && data_as
    raise ArgumentError, 'Cannot use sep option without prefix option' if sep != DEFAULT_SEP && !prefix

    counter = init
    key_values = names.to_h { |name| [name, counter].tap { counter = counter.succ } }

    if data_as
      class_name = "#{data_as}Data"
      data_class = const_defined?(:Data) ? Data.define(*names) : Struct.new(*names, keyword_init: true)
      const_set(class_name, data_class)
      data = data_class.new(**key_values)
      const_set(data_as, data)
    else
      key_values.each do |name, value|
        sep = '' unless sep
        name = "#{prefix}#{sep}#{name}".to_sym if prefix
        const_set(name, value)
      end
    end
  end
end
