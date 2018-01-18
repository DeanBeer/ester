require 'robut'
require 'connection_mock'
require 'presence_mock'

require 'shared/robut'

describe NRB::Ester::Robut do

  let(:connection) { Robut::ConnectionMock }
  let(:message) { '' }
  let(:private_sender) { nil }
  let(:reply_to) { Robut::PresenceMock.new connection }
  let(:robut_nick) { 'mockie' }
  let(:sender) { 'Occam Razor' }
  let(:subject) { Fake::FakeRobut.new(reply_to, private_sender) }
  let(:time) { Time.now }

  it_behaves_like :a_robut

end
