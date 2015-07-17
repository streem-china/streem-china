namespace :load do
  task :defaults do
    set :actioncable_role, :app
    set :actioncable_path,        -> { "#{current_path}/cable" }
    set :actioncable_puma_pid,    -> { "#{fetch(:actioncable_path)}/tmp/pids/puma.pid" }
    set :actioncable_puma_state,  -> { "#{fetch(:actioncable_path)}/tmp/pids/puma.state" }
    set :actioncable_puma_config, -> { "#{fetch(:actioncable_path)}/config/puma.rb" }
    set :actioncable_config_ru,   -> { "#{fetch(:actioncable_path)}/config.ru" }
  end
end

namespace :actioncable do
  desc 'Start ActionCable'
  task :start do
    on roles fetch(:actioncable_role) do |host|
      within fetch(:actioncable_path) do
        with rails_env: fetch(:rails_env) do
          if test "[ -f #{fetch(:actioncable_puma_pid)} ]" and test "kill -0 $(cat #{fetch(:actioncable_puma_pid)})"
            warn 'ActionCable is running'
          else
            execute :bundle, :exec, :puma, "-C #{fetch(:actioncable_puma_config)} #{fetch(:actioncable_config_ru)}"
          end
        end
      end
    end
  end

  desc 'Restart ActionCable'
  task :restart do
    on roles fetch(:actioncable_role) do
      within fetch(:actioncable_path) do
        with rails_env: fetch(:rails_env) do
          if test "[ -f #{fetch(:actioncable_puma_pid)} ]" and test "kill -0 $(cat #{fetch(:actioncable_puma_pid)})"
            execute :bundle, :exec, :pumactl, "-S #{fetch(:actioncable_puma_state)} restart"
          else
            invoke 'actioncable:start'
          end
        end
      end
    end
  end

  desc 'Stop ActionCable'
  task :stop do
    on roles fetch(:actioncable_role) do
      within fetch(:actioncable_path) do
        with rails_env: fetch(:rails_env) do
          if test "[ -f #{fetch(:actioncable_puma_pid)} ]"
            if test "kill -0 $(cat #{fetch(:actioncable_puma_pid)})"
              execute :bundle, :exec, :pumactl, "-S #{fetch(:actioncable_puma_state)} stop"
            else
              warn 'ActionCable is not running'
            end

            execute :rm, fetch(:actioncable_puma_pid)
            execute :rm, fetch(:actioncable_puma_state) if test "[ -f #{fetch(:actioncable_puma_state)} ]"
          else
            warn 'ActionCable is not running'
          end
        end
      end
    end
  end

  desc 'ActionCable Status'
  task :status do
    on roles fetch(:actioncable_role) do
      within fetch(:actioncable_path) do
        with rails_env: fetch(:rails_env) do
          if test "[ -f #{fetch(:actioncable_puma_pid)} ]"
            if test "kill -0 $(cat #{fetch(:actioncable_puma_pid)})"
              info 'ActionCable is running'
            else
              warn 'ActionCable is not running'

              execute :rm, fetch(:actioncable_puma_pid)
              execute :rm, fetch(:actioncable_puma_state) if test "[ -f #{fetch(:actioncable_puma_state)} ]"
            end
          else
            warn 'ActionCable is not running'
          end
        end
      end
    end
  end
end
