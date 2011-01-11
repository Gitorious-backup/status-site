require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  context "Status codes" do
    should "have OK status" do
      assert_not_nil Status::OK
    end

    should "not allow invalid codes" do
      status = Status.new :title => "OK", :body => "Yes", :status => 0

      assert_no_difference "Status.count" do
        status.save
      end
    end

    should "allow OK" do
      status = Status.new :title => "OK", :body => "Yes", :status => Status::OK

      assert_difference "Status.count" do
        status.save
      end
    end

    should "allow SORTA" do
      status = Status.new :title => "OK", :body => "Yes", :status => Status::SORTA

      assert_difference "Status.count" do
        status.save
      end
    end

    should "allow DOWN" do
      status = Status.new :title => "OK", :body => "Yes", :status => Status::DOWN

      assert_difference "Status.count" do
        status.save
      end
    end
  end

  should validate_presence_of :title
  should validate_presence_of :status
end
