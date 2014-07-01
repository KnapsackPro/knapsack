require 'spec_helper'

describe 'Slow E' do
  it { sleep 1 }
  it { sleep 0.9 }
  it { sleep 0.5 }
end
