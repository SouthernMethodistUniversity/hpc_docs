class GetModules

  @cache = ActiveSupport::Cache::FileStore.new("/users/#{User.new.name}/.cache/OpenOnDemand/", :expires_in => 1.minute)

  def self.LookForPythonMods()
    begin
      # try to find Python modules
      script = "module -t avail python"
      o, status = Open3.capture2('/bin/bash -l', stdin_data: script)
      output = o.split("\n")

      File.write('/users/jlagrone/ood_log', output, mode: 'a')

      modules = []
      # parse the output
      output.each do |mod|
        split_mod = mod.split('/')
        if split_mod[0] == "python"
          tmp = [split_mod[0], split_mod[1], split_mod[2], split_mod[3]]
          modules.append(tmp)
        end
      end
      return modules
    end
  end

  def self.PythonModules()
    begin
      @PythonModules = @cache.fetch("#{User.new.name}/python_modules", race_condition_ttl: 30.seconds) do
        self.LookForPythonMods()
      end
      # return
      @PythonModules
    end
  end
end
