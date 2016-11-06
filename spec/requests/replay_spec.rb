require 'rails_helper'

RSpec.describe "Replay Spec", type: :request do

  describe 'a set of replays' do
    Dir['test/records/*'].each do |file|
      it "should not fail for #{file}" do

        system "bundle exec ./test/replay.rb #{file}"

        expect($?.exitstatus).to eq(0)
      end
    end
  end
end
