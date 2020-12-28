# Provides a healthcheck endpoint
class HealthCheckController < ApplicationController
  skip_before_action :authenticate, :log_user

  def health
    if db_ready?
      head :ok
    else
      head :service_unavailable
    end
  end

  private

  def db_ready?
    !ApplicationRecord.connection.migration_context.needs_migration?
  rescue ActiveRecord::ActiveRecordError
    false
  end
end
