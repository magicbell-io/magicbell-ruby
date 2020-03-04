describe MagicBell::HMAC do
  describe ".calculate" do
    let(:user_email) { "user@example.com" }
    let(:api_secret) { "dummy_magicbell_api_secret" }
    
    before(:each) do 
      MagicBell.configure do |config|
        config.api_secret = api_secret
      end
    end

    it "calculates HMAC for the given message and secret" do
      hmac = MagicBell::HMAC.calculate(user_email)
      expect(hmac).to eq("/x6KLY0tuu/9pvALrOxZn4Msbv6UT1qZ8PZvAQFmqcs=")
    end
  end
end