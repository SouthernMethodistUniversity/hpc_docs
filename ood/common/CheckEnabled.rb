class CheckEnabled

#  @cache = ActiveSupport::Cache::FileStore.new("/users/#{User.new.name}/.cache/OpenOnDemand/", :expires_in => 1.minute)

  def self.IsEnabled()
    begin
      # get users shell
      script = "/usr/bin/getent passwd #{User.new.name}"
      o, status = Open3.capture2e(script)
      tmp_output = o.split("\n")
      output = true
      File.open('/users/jlagrone/ood_test.log', 'w') do |fo|
      old_std = $stdout
      $stdout = fo
      puts "tmp_output: #{tmp_output}"
      tmp_output.each do |q|
        tmp = q.strip
        if tmp.include? "jlagrone" #"/sbin/nologin"
          puts "tmp: #{tmp}"
          output = false
        end
      end
      end
      $stdout = old_std

      return output
    end
  end

  def self.Enabled
    begin
      @Enabled = self.IsEnabled() #@cache.fetch("#{User.new.name}/enabled", race_condition_ttl: 30.seconds) do
        #self.IsEnabled()
      end
      return @Enabled
    end
  end
end
