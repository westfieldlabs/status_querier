RSpec.describe StatusQuerier do
  it 'has a version number' do
    expect(StatusQuerier::VERSION).not_to be nil
  end

  context '#allow?' do
    it 'with an unknown status: joe' do
      expect(StatusQuerier.allow?('joe')).to be false
    end

    StatusQuerier::SUPPORTED_STATUSES.each do |status|
      it "with a known status: #{status}" do
        expect(StatusQuerier.allow?(status)).to be true
      end
    end
  end
end

