require 'test_helper'

class LexiquesControllerTest < ActionController::TestCase
  setup do
    @lexique = lexiques(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lexiques)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lexique" do
    assert_difference('Lexique.count') do
      post :create, :lexique => @lexique.attributes
    end

    assert_redirected_to lexique_path(assigns(:lexique))
  end

  test "should show lexique" do
    get :show, :id => @lexique.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @lexique.to_param
    assert_response :success
  end

  test "should update lexique" do
    put :update, :id => @lexique.to_param, :lexique => @lexique.attributes
    assert_redirected_to lexique_path(assigns(:lexique))
  end

  test "should destroy lexique" do
    assert_difference('Lexique.count', -1) do
      delete :destroy, :id => @lexique.to_param
    end

    assert_redirected_to lexiques_path
  end
end
