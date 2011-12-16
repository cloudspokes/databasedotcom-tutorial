require 'test_helper'

class FitnessGoalsControllerTest < ActionController::TestCase
  setup do
    @fitness_goal = fitness_goals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fitness_goals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fitness_goal" do
    assert_difference('FitnessGoal.count') do
      post :create, fitness_goal: @fitness_goal.attributes
    end

    assert_redirected_to fitness_goal_path(assigns(:fitness_goal))
  end

  test "should show fitness_goal" do
    get :show, id: @fitness_goal.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fitness_goal.to_param
    assert_response :success
  end

  test "should update fitness_goal" do
    put :update, id: @fitness_goal.to_param, fitness_goal: @fitness_goal.attributes
    assert_redirected_to fitness_goal_path(assigns(:fitness_goal))
  end

  test "should destroy fitness_goal" do
    assert_difference('FitnessGoal.count', -1) do
      delete :destroy, id: @fitness_goal.to_param
    end

    assert_redirected_to fitness_goals_path
  end
end
