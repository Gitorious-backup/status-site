require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  context "Displaying status" do
    setup do
      @status = Status.create :title => "OK", :body => "All systems go", :status => Status::OK
    end
    
    should "find status by ID" do
      get :show, :id => @status
      
      assert_response :success
      assert_equal @status, assigns(:status)
    end
  end

  context "Creating a status update" do
    setup do
      login_as(User.create({ :login => "bob", :password => "mike" }))
    end

    should "render the status form" do
      get :new
      
      assert_response :success
      assert_not_nil assigns(:status)
    end

     should "create a valid status" do
      assert_difference("Status.count", 1) do
        create_valid_status
      end
    end

    should "redirect after create" do
      create_valid_status

      assert_response :redirect
      assert_redirected_to :action => :show, :id => Status.last
    end

    should "not accept invalid statuses" do
      assert_no_difference("Status.count") do
        post :create, :status => {:title => "All OK", :body => "Yeah"}
      end
    end    
  end

  context "Updating an existing status" do
    setup do
      login_as(User.create({ :login => "bob", :password => "mike" }))
      create_valid_status
      @status = Status.current
    end

    should "render the edit form" do
      get :edit, :id => @status

      assert_response :success
    end

    should "update the status" do
      put :update, :id => @status, :status => {:title => "Yeah!"}

      assert_equal "Yeah!", @status.reload.title
    end
  end

  context "Display the current status" do
    setup do
      @older_status = Status.create! :title => "All OK", :body => "...", :status => Status::OK
      @current_status = Status.create! :title => "All OK", :body => "...", :status => Status::OK
    end

    should "display the latest status" do
      get :current
      assert_equal @current_status, assigns(:status)
    end
    
  end

  def create_valid_status
    post :create, :status => {:title => "All OK", :body => "All systems go", :status => Status::OK}
  end

  def login_as(user)
    session[:current_user_id] = user.id
  end
end
