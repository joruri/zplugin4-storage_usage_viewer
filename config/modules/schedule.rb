every :hour do
  rake "#{Zomeki::NAME}:storage_usage_viewer:usages:check"
end