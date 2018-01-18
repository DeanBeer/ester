require 'robut'
require 'connection_mock'
require 'presence_mock'

require 'shared/robut'

describe NRB::Ester::BeerStyle do

  let(:connection) { Robut::ConnectionMock }
  let(:message) { '' }
  let(:private_sender) { nil }
  let(:reply_to) { Robut::PresenceMock.new connection }
  let(:robut_nick) { 'mockie' }
  let(:sender) { 'Occam Razor' }
  let(:subject) { NRB::Ester::BeerStyle.new(reply_to, private_sender) }
  let(:time) { Time.now }

  it_behaves_like :a_robut

  it 'knows three commands' do
    expect(subject.commands.length).to eq 3
  end


  %w( bjcp style styles ).each do |command|
    it "should respond to the #{command} command" do
      expect(subject.commands).to include(command)
    end
  end


  context :handling_messages do

    before do
      Robut::ConnectionMock.configure { |c| c.nick = robut_nick }
    end

    it 'handles styles' do
      subject.handle(time, sender, 'styles')
puts subject.inspect
puts reply_to.messages.inspect
    end

  end

end
