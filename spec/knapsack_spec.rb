require 'spec_helper'

describe Knapsack do
  describe '.tracker' do
    subject { described_class.tracker }

    it { should be_a Knapsack::Tracker }
    it { expect(subject.object_id).to eql described_class.tracker.object_id }
  end
end
