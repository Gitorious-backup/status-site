require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  context "Status codes" do
    should "have OK status" do
      assert_not_nil Status::OK
    end
  end

  should validate_presence_of :title
  should validate_presence_of :status
end
