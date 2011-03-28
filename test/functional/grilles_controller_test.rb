require 'test_helper'

class GrillesControllerTest < ActionController::TestCase
  setup do
    @grille = grilles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grilles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grille" do
    assert_difference('Grille.count') do
      post :create, :grille => @grille.attributes
    end

    assert_redirected_to grille_path(assigns(:grille))
  end

  test "should show grille" do
    get :show, :id => @grille.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @grille.to_param
    assert_response :success
  end

  test "should update grille" do
    put :update, :id => @grille.to_param, :grille => @grille.attributes
    assert_redirected_to grille_path(assigns(:grille))
  end

  test "should destroy grille" do
    assert_difference('Grille.count', -1) do
      delete :destroy, :id => @grille.to_param
    end

    assert_redirected_to grilles_path
  end
end
