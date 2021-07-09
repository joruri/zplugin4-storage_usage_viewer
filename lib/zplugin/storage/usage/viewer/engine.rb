module Zplugin
  module Storage
    module Usage
      module Viewer
        class Engine < ::Rails::Engine
          engine_name 'zplugin_storage_usage_viewer'
          isolate_namespace Zplugin::Storage::Usage::Viewer

          config.i18n.load_path += Dir[root.join('config/locales/**/*.{rb,yml}')]

          class << self
            def version
              VERSION
            end

            def install
              commands = [
                "bundle exec rake db:migrate SCOPE=#{engine_name} RAILS_ENV=#{Rails.env}"
              ]
              require 'open3'
              Open3.capture3(commands.join(' && '))
            end

            def uninstall
              commands = [
                "rm -rf #{Zplugin::Storage::Usage::Viewer::SITE_BASE_DIR}",
                "bundle exec rake db:migrate SCOPE=#{engine_name} VERSION=0 RAILS_ENV=#{Rails.env}"
              ]
              require 'open3'
              Open3.capture3(commands.join(' && '))
            end

            def installed?
              context = ActiveRecord::MigrationContext.new(config.paths['db/migrate'].to_a, ActiveRecord::SchemaMigration)
              !context.needs_migration?
            end
          end
        end
      end
    end
  end
end
