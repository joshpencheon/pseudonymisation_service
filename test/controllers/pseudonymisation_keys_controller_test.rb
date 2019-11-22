require 'test_helper'

class PseudonymisationKeysControllerTest < ActionDispatch::IntegrationTest
  test 'should be accessible at an API-namespaced path' do
    assert_equal '/api/v1/keys', pseudonymisation_keys_path
  end

  test 'should list accessible keys' do
    get pseudonymisation_keys_url
    assert_response :success

    expected = PseudonymisationKey.accessible_by(current_user.ability).count
    actual = response.parsed_body.length
    assert_equal expected, actual
  end

  test 'should not allow POST requests' do
    post pseudonymisation_keys_url
    assert_response :not_found
  end
end