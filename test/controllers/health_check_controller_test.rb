require 'test_helper'

class HealthCheckControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'healthy response' do
    get '/health'
    assert_response :ok
  end

  test 'without client session' do
    sign_out
    get '/health'
    assert_response :ok
  end

  test 'with DB connectivity issue' do
    ApplicationRecord.stubs(:connection).raises(ActiveRecord::ActiveRecordError)
    get '/health'
    assert_response :service_unavailable
  end

  test 'with pending migrations' do
    ActiveRecord::MigrationContext.any_instance.stubs(needs_migration?: true)
    get '/health'
    assert_response :service_unavailable
  end
end
