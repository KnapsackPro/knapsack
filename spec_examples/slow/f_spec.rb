require 'spec_helper'

describe 'Slow F' do
  it { sleep 0.1 }
  it { sleep 0.2 }
  it { sleep 0.3 }
end
