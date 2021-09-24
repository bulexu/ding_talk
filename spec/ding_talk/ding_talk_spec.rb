require 'spec_helper'

RSpec.describe DingTalk do

  it "has a version number and author" do
    expect(DingTalk::VERSION).not_to be nil
    expect(DingTalk::AUTHOR).not_to be nil
  end

end
