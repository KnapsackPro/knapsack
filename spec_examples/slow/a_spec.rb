require 'spec_helper'

describe 'Slow A' do
  it { sleep 1 }
  it { sleep 0.1 }
  it { sleep 0.5 }
end
