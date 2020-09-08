require_relative '../source/file_parser'

describe FileParser do
  describe '#call' do
    subject { described_class.new(file_name).call }

    let(:file_name) { 'spec/support/files/webserver.log' }
    let(:expected_response) do
      {
        "/about" => ["061.945.150.735"],
        "/about/2" => ["444.701.448.104"],
        "/contact" => ["184.123.665.067"],
        "/help_page/1" => ["126.318.035.038", "929.398.951.889", "722.247.931.582", "646.865.545.408"],
        "/home" => ["184.123.665.067", "235.313.352.950"],
        "/index" => ["444.701.448.104"]
      }
    end

    it 'returns initially parsed dataset from file' do
      expect(subject).to eq(expected_response)
    end

    context 'file does not exists' do
      let(:file_name) { 'spec/support/files/wrong.log' }

      it 'raises error' do
        expect { subject }.to raise_error(::FileParser::FileNotFoundError)
      end
    end
  end
end
