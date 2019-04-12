
require './config/environment'

begin
  fi_check_migration

  run ApplicationController
rescue ActiveRecord::PendingMigrationError => err
  STDERR.puts err
  exit 1
end

use Rack::MethodOverride #need this line of code so app knows how to handle PATCH, PUT, DELETE requests
