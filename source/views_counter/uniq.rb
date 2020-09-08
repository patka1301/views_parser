require_relative 'base'

module ViewsCounter
  class Uniq < ::ViewsCounter::Base

    private

    def counted_dataset
      dataset.transform_values { |ips| ips.uniq.length }
    end
  end
end
