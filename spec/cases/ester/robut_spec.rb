require 'robut'
require 'connection_mock'
require 'presence_mock'

module Fake
  class FakeRobut < NRB::Ester::Robut
  end
end

describe NRB::Ester::Robut do

  let(:connection) { Robut::ConnectionMock }
  let(:message) { '' }
  let(:private_sender) { nil }
  let(:reply_to) { Robut::PresenceMock.new connection }
  let(:robut_nick) { 'mockie' }
  let(:sender) { 'Occam Razor' }
  let(:subject) { Fake::FakeRobut.new(reply_to, private_sender) }
  let(:time) { Time.now }

  it 'should have a command list' do
    expect(subject.commands).to be_an Array
  end


  it 'should allow writing the commands' do
    expect(subject).to respond_to(:commands=)
  end


  it 'handle should return nil by default' do
    expect(subject.handle(time,sender,message)).to be_nil
  end


  context 'handling commands' do
    let(:command) { 'blark' }
    let(:commanding_message) { "#{command} #{innocuous_message}" }
    let(:commands) { [command] }
    let(:direct_commanding_message) { "#{robut_nick} #{command} #{innocuous_message}" }
    let(:innocuous_message) { "what time is it? 4:30" }

    before do
      Robut::ConnectionMock.configure do |config|
        config.nick = robut_nick
      end
      subject.commands = commands
    end


    it 'sets commands' do
      expect(subject.commands).to eq commands
    end


    it 'handles direct commands' do
      expect(subject.send(:sent_command, message: direct_commanding_message)).to eq command
    end


    it 'handles commands' do
      expect(subject.send(:sent_command, message: commanding_message)).to eq command
    end


    it 'handles innocuous messages' do
      expect(subject.send(:sent_command, message: innocuous_message)).to be_nil
    end

  end

end
