describe Time do
  it "will respond to :raw_now" do
    expect(Time.respond_to?(:raw_now)).to be true
  end
end
