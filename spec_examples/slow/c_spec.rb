require 'spec_helper'

describe 'Slow C' do
  it { sleep 0.8 }
  it { sleep 0.1 }
  it { sleep 0.1 }
end
