class CheckSSH

  @cache = ActiveSupport::Cache::FileStore.new("/users/#{User.new.name}/.cache/OpenOnDemand/known_hosts", :expires_in => 1.year)

  def self.GetSSH()
    begin
      # get list
      script = "/usr/bin/ssh-keygen -R 129.119.70.4"
      o, status = Open3.capture2e(script)
      return true
    end
  end

  def self.SSH
    begin
      @Accounts = @cache.fetch("#{User.new.name}/ssh_check", race_condition_ttl: 30.seconds) do
        self.GetSSH()
      end
      return @SSH
    end
  end
end
