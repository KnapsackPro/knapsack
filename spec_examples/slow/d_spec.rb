require 'spec_helper'

describe 'Slow D' do
  it { sleep 1 }
  it { sleep 1 }
  it { sleep 2 }
end
