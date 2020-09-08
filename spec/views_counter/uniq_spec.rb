require_relative '../../source/views_counter/uniq'

describe ViewsCounter::Uniq do
  describe '#call' do
    subject { described_class.new(dataset).call }

    let(:dataset) do
      {
        "/about" => ["061.945.150.735"],
        "/about/2" => ["444.701.448.104", "444.701.448.104"],
        "/contact" => ["184.123.665.067", "184.123.665.067"],
        "/help_page/1" => ["126.318.035.038", "929.398.951.889", "722.247.931.582", "646.865.545.408"],
        "/home" => ["184.123.665.067", "235.313.352.950"],
        "/index" => ["444.701.448.104"]
      }
    end

    let(:expected_response) do
      ["/help_page/1 4 visits", "/home 2 visits", "/about 1 visits", "/about/2 1 visits", "/contact 1 visits", "/index 1 visits"]
    end

    it 'returns array with sorted and counted views' do
      expect(subject).to eq(expected_response)
    end
  end
end
