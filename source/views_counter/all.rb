require_relative 'base'

module ViewsCounter
  class All < ::ViewsCounter::Base

    private

    def counted_dataset
      dataset.transform_values(&:length)
    end
  end
end
