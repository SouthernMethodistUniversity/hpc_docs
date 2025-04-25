class CustomEnvironments

  @cache = ActiveSupport::Cache::FileStore.new("/users/#{User.new.name}/.cache/OpenOnDemand/", :expires_in => 1.minute)

  def self.LookForConda()
    begin
      # try to find a path for conda
      # conda is usually a shell function, so it's not easily checked
      # look for CONDA_EXE environment variable
      script = "eval $(conda shell.bash hook);  /usr/bin/env | /usr/bin/grep -oP 'CONDA_EXE=\\K.+'"
      o, status = Open3.capture2('/bin/bash -l', stdin_data: script)
      output = o.split("\n")
      if output.empty?
        output
      else
        return output[0]
      end
    end
  end

  def self.LookForMamba()
    begin
      # try to find a path for mamba
      script = 'eval $(mamba shell.bash hook); /usr/bin/which mamba'
      o, status = Open3.capture2('/bin/bash -l', stdin_data: script)
      output = o.split("\n")
      if output.empty?
        return output
      else
        return output[0]
      end
    end
  end

  def self.LookForMicromamba()
    begin
      # try to find a path for micromamba
      script = 'eval $(micromamba shell.bash hook); /usr/bin/which micromamba'
      o, status = Open3.capture2('/usr/bin/bash -l', stdin_data: script)
      output = o.split("\n")
      if output.empty?
        return output
      else
        return output[0]
      end
    end
  end

  def self.GetCondaProviders()
    begin

      @FoundCondaProviders = []

      # system defaults in conda module
      val = ["Conda", "/hpc/m3/apps/conda/bin/conda"]
      @FoundCondaProviders.push(val)
      val = ["Mamba", "/hpc/m3/apps/conda/bin/mamba"]
      @FoundCondaProviders.push(val)
      
      temp = LookForMamba()
      if !(temp.empty?)
        val = ["Mamba", temp]
        @FoundCondaProviders.push(val)
      end

      temp = LookForMicromamba()
      if !(temp.empty?)
        val = ["Micromamba", temp]
        @FoundCondaProviders.push(val)
      end

      temp = LookForConda()
      if !(temp.empty?)
        val = ["Conda", temp]
        @FoundCondaProviders.push(val)
      end
 
      return @FoundCondaProviders
    end
  end

  def self.CondaProviders
    begin
      @CondaProviders = @cache.fetch("#{User.new.name}/conda_providers", race_condition_ttl: 30.seconds) do
        self.GetCondaProviders()
      end
      @CondaProviders
    end
  end

  def self.GetCondaEnvs(conda_command)
    begin

       # get Conda environments from Conda info
      script = conda_command + ' info -e'
      o, status = Open3.capture2('/usr/bin/bash -l', stdin_data: script)
      output = o.split("\n")
      conda_env = []
    
      # parse the output
      output.each do |env|
        # skip commented out lines
        if env[0] != '#' && !env.strip.empty?
          # Conda info returns an optional name followed by a path
          # so split the current line into the name (possibly blank)
          # and the path to the env
          split_env = env.split
    
          # if the name is blank insert a blank into the array
          if split_env.count == 1
            split_path = split_env[0].split('/')
            split_env = [split_path[-1], split_env[0]]
            split_env.push("Conda Env (unnamed, using path end)")
          else
            split_env.push("Conda Env")
          end
          split_env.push(conda_command)

          conda_env.push(split_env)
        end
      end

      return conda_env
    end
  end    

  def self.GetMambaEnvs(mamba_command)
    begin

       # get Conda environments from Conda info
      script = mamba_command + ' env list -q'
      o, status = Open3.capture2('/usr/bin/bash -l', stdin_data: script)
      output = o.split("\n")
      mamba_env = []

      # parse the output
      output.each do |env|
        # skip commented out lines
        if env[0] != '#' && !env.strip.empty?
          # Mamba info returns an optional name followed by a path
          # so split the current line into the name (possibly blank)
          # and the path to the env
          split_env = env.split

          # if the name is blank insert a blank into the array
          if split_env.count == 1
            split_path = split_env[0].split('/')
            split_env = [split_path[-1], split_env[0]]
            split_env.push("Mamba Env (unnamed, using path end)")
          else
            split_env.push("Mamba Env")
          end
          split_env.push(mamba_command)

          mamba_env.push(split_env)
        end
      end

      return mamba_env
    end
  end

  def self.GetMicromambaEnvs(micromamba_command)
    begin

       # get Conda environments from Conda info
      script = micromamba_command + ' env list -q'
      o, status = Open3.capture2('/usr/bin/bash -l', stdin_data: script)
      output = o.split("\n")
      micromamba_env = []

      # parse the output
      # first 2 lines are headers
      output.shift
      output.shift

      output.each do |env|
        # skip commented out lines
        if env[0] != '#' && !env.strip.empty?
          # Micromamba info returns an optional name, optional activation, followed by a path
          # so split the current line into the name (possibly blank)
          # and the path to the env
          split_env = env.split

          # remove * for activated if present
          if split_env[0] == '*'
            split_env.shift
          end
          if split_env[1] == '*'
            split_env.delete_at(1)
          end

          # if the name is blank insert a blank into the array
          if split_env.count == 1
            split_path = split_env[0].split('/')
            split_env = [split_path[-1], split_env[0]]
            split_env.push("Micromamba Env (unnamed, using path end)")
          else
            split_env.push("Micromamba Env")
          end
          split_env.push(micromamba_command)
           
          micromamba_env.push(split_env)
        end
      end

      return micromamba_env
    end
  end    

  def self.UniqueEnvs()
    begin
   
      envs = []
      
      # get all the environments
      self.CondaProviders.each do |provider|
        if provider[0] == "Conda"
          temp = self.GetCondaEnvs(provider[1])
          temp.each do |val|
            envs.push(val)
          end
        elsif provider[0] == "Mamba"
          temp = self.GetMambaEnvs(provider[1])
          temp.each do |val|
            envs.push(val)
          end
        elsif provider[0] == "Micromamba"
          temp = self.GetMicromambaEnvs(provider[1])
          temp.each do |val|
            envs.push(val)
          end
        end
      end

      # remove duplicates. Prefer version with name if it exists
      i = 0
      while i < envs.count() do
        j = i + 1
        while j < envs.count() do
          if (envs[i][1] == envs[j][1])
            # if one has a name, keep that one
            if envs[i][0].empty? && !(envs[j][0].empty?)
              envs[i][0] = envs[j][0]
              envs[i][1] = envs[j][1]
              envs[i][2] = envs[j][2]
              envs[i][3] = envs[j][3]
            end
            envs.delete_at(j)
          else
            j += 1
          end
        end
        i += 1
      end
      return envs
    end
  end


  def self.CondaEnvs()
    begin

      conda_env = self.UniqueEnvs()
      return conda_env
    end
  end

  def self.JupyterLabEnvs
    begin
       
      @JupyterLabEnvs = []

      # always include to option to define a custom env
      custom_env = [ "Custom Environment - only use what is specified below", "custom", "user provided", "user provided"   ]
      @JupyterLabEnvs.push(custom_env)

      # check the output of Conda info for useable envs
      enabled_envs = []
      disabled_envs = []
      @CondaEnvsTest = @cache.fetch("#{User.new.name}/conda_envs", race_condition_ttl: 30.seconds) do
        self.CondaEnvs()
      end
      @CondaEnvsTest.each do |env| 
        # now check if there is a jupyter-lab in the env
        # if it exists, add it to the enabled list
        # otherwise add it to the disabled list
        jupyter_path = env[1] + "/bin/jupyter-lab"
        if File.file?(jupyter_path)
          tmp_env = env
          tmp_env[0] = "(" + env[2] + ") " + env[0]
          enabled_envs.push(tmp_env)
        else
          tmp_env = env
          tmp_env[0] = "(" + env[2] + " -- Install jupyterlab to use) " + env[0]
          tmp_env[1] = "No Jupyter Lab"
          disabled_envs.push(tmp_env)
        end
      end
      # add the found environments to the list
      # the disabled environments are listed last
      enabled_envs.each do |env|
        @JupyterLabEnvs.push(env)
      end
      disabled_envs.each do |env|
        @JupyterLabEnvs.push(env)
      end
      #return
      @JupyterLabEnvs
    end
  end
end
