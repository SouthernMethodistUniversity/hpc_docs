class CheckAccounts

  @cache = ActiveSupport::Cache::FileStore.new("/users/#{User.new.name}/.cache/OpenOnDemand/", :expires_in => 1.minute)

  def self.GetAccounts()
    begin
      # get list
      script = "/hpc/sys/apps/slurm/current/bin/sacctmgr list Associations Users=#{User.new.name} format=Account -P"
      o, status = Open3.capture2e(script)
      tmp_output = o.split("\n")
      output = []
      tmp_output.each do |q|
        tmp = q.strip
        if tmp != "Account" && tmp != "smu" && tmp != "default" 
          output.push(tmp)
        end
      end
      return output
    end
  end

  def self.Accounts
    begin
      @Accounts = @cache.fetch("#{User.new.name}/slurm_accounts", race_condition_ttl: 30.seconds) do
        self.GetAccounts()
      end
      return @Accounts
    end
  end
end
