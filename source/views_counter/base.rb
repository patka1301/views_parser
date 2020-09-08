module ViewsCounter
  class Base
    def initialize(dataset)
      @dataset = dataset
    end

    def call
      formatted_dataset
    end

    private

    def formatted_dataset
      sorted_dataset.map { |key, value| "#{key} #{value} visits" }
    end

    def sorted_dataset
      counted_dataset.sort_by { |_k, v| -v }
    end

    def counted_dataset
      raise NotImplementedError
    end

    attr_reader :dataset
  end
end
