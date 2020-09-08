require_relative '../source/views_parser'

describe ViewsParser do
  describe '#call' do
    subject { described_class.new(file_name).call }

    let(:file_name) { 'spec/support/files/webserver.log' }
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
      {
        all: ["/help_page/1 4 visits", "/about/2 2 visits", "/contact 2 visits", "/home 2 visits", "/about 1 visits", "/index 1 visits"],
        uniq: ["/help_page/1 4 visits", "/home 2 visits", "/about 1 visits", "/about/2 1 visits", "/contact 1 visits", "/index 1 visits"]
      }
    end

    it 'returns all and uniq views counters' do
      expect(::FileParser).to receive(:new).with(file_name).and_return(double(call: dataset))
      expect(subject).to eq(expected_response)
    end

    context 'file name is incorrect' do
      let(:file_parser_dbl) { double }

      before do
        allow(::FileParser).to receive(:new).with(file_name).and_return(file_parser_dbl)
        allow(file_parser_dbl).to receive(:call).and_raise(::FileParser::FileNotFoundError)
      end

      it 'returns error message' do
        expect(subject).to eq('Sorry, the file does not exist!')
      end
    end
  end
end
