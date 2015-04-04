describe NRB::Ester do

  it 'responds to version' do
    expect(NRB::Ester).to respond_to :version
  end


  it 'gives a version string' do
    expect(NRB::Ester.version).to be_a String
  end

end
