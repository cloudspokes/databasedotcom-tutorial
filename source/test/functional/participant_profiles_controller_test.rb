require 'test_helper'

class ParticipantProfilesControllerTest < ActionController::TestCase
  setup do
    @participant_profile = participant_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:participant_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create participant_profile" do
    assert_difference('ParticipantProfile.count') do
      post :create, participant_profile: @participant_profile.attributes
    end

    assert_redirected_to participant_profile_path(assigns(:participant_profile))
  end

  test "should show participant_profile" do
    get :show, id: @participant_profile.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @participant_profile.to_param
    assert_response :success
  end

  test "should update participant_profile" do
    put :update, id: @participant_profile.to_param, participant_profile: @participant_profile.attributes
    assert_redirected_to participant_profile_path(assigns(:participant_profile))
  end

  test "should destroy participant_profile" do
    assert_difference('ParticipantProfile.count', -1) do
      delete :destroy, id: @participant_profile.to_param
    end

    assert_redirected_to participant_profiles_path
  end
end
