describe Time do
  it 'responds to :raw_now' do
    expect(Time.respond_to?(:raw_now)).to be true
  end
end
