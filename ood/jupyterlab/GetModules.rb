class GetModules

  @cache = ActiveSupport::Cache::FileStore.new("/users/#{User.new.name}/.cache/OpenOnDemand/", :expires_in => 1.minute)

  def self.LookForPythonMods()
    begin
      # try to find Python modules
      f = File.new("/users/jlagrone/ood_log.txt", "a")
      #script = "source /hpc/sys/apps/lmod/lmod/init/bash; module -t av python"
      script = "module -t av python"
      f.puts(script)
      o, status = Open3.capture2e('/bin/bash -i', stdin_data: script)
      output = o.split("\n")
      f.puts("status")
      f.puts(status)
      f.puts("o")
      f.puts(o)
      f.close
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
      #file = File.new("/users/jlagrone/ood_log.txt", "a")
      #file.puts("called function")
      #file.close
      @PythonModules = @cache.fetch("#{User.new.name}/python_modules", race_condition_ttl: 30.seconds) do
        self.LookForPythonMods()
      end
      #@PythonModules = self.LookForPythonMods()
      # return
      @PythonModules
    end
  end
end
