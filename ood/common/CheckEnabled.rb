class CheckEnabled

  @cache = ActiveSupport::Cache::FileStore.new("/users/#{User.new.name}/.cache/OpenOnDemand/", :expires_in => 5.seconds)

  def self.IsEnabled()
    begin
      # get users shell
      script = "/usr/bin/getent passwd #{User.new.name}"
      o, status = Open3.capture2e(script)
      tmp_output = o.split("\n")
      output = true
      tmp_output.each do |q|
        tmp = q.strip
        if tmp.include? "/sbin/nologin"
          output = false
        end
      end
      return output
    end
  end

  def self.AccountEnabled
    begin
      @AccountEnabled = @cache.fetch("#{User.new.name}/account_enabled", race_condition_ttl: 2.seconds) do
        self.IsEnabled()
      end
      return @AccountEnabled
    end
  end
end
