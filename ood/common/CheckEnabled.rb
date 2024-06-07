class CheckEnabled

  @cache = ActiveSupport::Cache::FileStore.new("/users/#{User.new.name}/.cache/OpenOnDemand/", :expires_in => 1.minute)

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

  def self.Enabled
    begin
      @Enabled = @cache.fetch("#{User.new.name}/enabled", race_condition_ttl: 30.seconds) do
        self.IsEnabled()
      end
      return @Enabled
    end
  end
end
