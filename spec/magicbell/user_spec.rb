describe MagicBell::User do

    before(:each) do 
      MagicBell.configure do |config|
        config.magic_address = magic_address
        config.api_key = api_key
        config.api_secret = api_secret
        config.project_id = project_id
        config.api_host = "https://api.example.com"
      end
    end

    let(:user) { MagicBell::User.new(email: 'hana@magicbell.io') }
    let(:api_key) { "dummy_api_key" }
    let(:magic_address) { "dummy_magic_address@ring.magicbell.io" }
    let(:api_secret) { "dummy_api_secret" }
    let(:project_id) { 1 }

    it "should be not throw an error on init" do
      expect(user.email).to eq 'hana@magicbell.io'
    end

    describe ".user_key" do
      before do
        MagicBell.configure do |config|
          config.api_secret = api_secret
        end
      end

      after do
        MagicBell.reset_config
      end

      it "calculates the user key for the given user's email" do
        expect(user.hmac_signature).to eq 'JOOgQ6zGwBwZDGfRN39ZMZGSVx9BwTOpY6B5lbWO6u0='
      end
    end

    describe "API " do

      let(:stubs)  { Faraday::Adapter::Test::Stubs.new }
      let(:conn)   { Faraday.new { |b| b.adapter(:test, stubs) } }


      it "should fetch notifications for the user" do
        #expect(stub).to have_been_requested.times(1)
        stubs.get("/notifications.json") do |env|
          [
            200,
            Hash.new,
            '{"user":{"id":39},"project_id":11,"unseen_count":0,"total":70,"per_page":15,"total_pages":5,"current_page":1,"notifications":[{"id":4997,"title":"RE: Whitelisting for META Communication","action_url":null,"meta_data":"{\"ticket_id\":26258679,\"reply_id\":18135139}","seen_at":1583234384,"sent_at":1583233650,"read_at":null},{"id":4228,"title":"RE: Whitelisting for META Communication","action_url":null,"meta_data":"{\"ticket_id\":26258679,\"reply_id\":18135005}","seen_at":1583233068,"sent_at":1583232532,"read_at":null}]}'  
          ]
        end
        allow(Faraday).to receive(:new).and_return(conn)
        expect(user.notifications.count).to eq 2
        stubs.verify_stubbed_calls
      end

      xit "should fetch preferences do the user" do
        #expect(user.preferences).to eq {notification_preferences: {new_ticket: {in_app: true}}}
      end

      xit "should set the notification preferences" do
        #user.preferences.set({notification_preferences: {new_ticket: {in_app: true}}})
      end
    end
end