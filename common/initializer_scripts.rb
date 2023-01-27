require 'open3'

# find user conda environments
class CustomEnvironments
  def self.CondaEnvs
    @CondaEnvs ||= begin

      # get Conda environments from Conda info
      script = '/hpc/applications/anaconda/3/bin/conda info -e'
      o, status = Open3.capture2('bash', stdin_data: script)
      output = o.split("\n")
      @found_envs = []

      # check the output of Conda info for useable envs
      enabled_envs = []
      disabled_envs = []
      output.each do |env| 
        # skip envs in /hpc/applications and commented out lines
        if env =~ /^((?!hpc\/applications).)*$/ && env[0] != '#'
          # Conda info returns an optional name followed by a path
          # so split the current line into the name (possibly blank)
          # and the path to the env
          split_env = env.gsub(/\s+/m, ' ').strip.split(" ")
          # if the name is blank use the path as the name
          if split_env.count == 1
            split_env.push(split_env[0])
          end
          @found_envs.push(split_env)
        end
      end
      #return
      @found_envs
    end
  end

  def self.JupyterLabEnvs
    @JupyterLabEnvs ||= begin
       
      @jupyter_envs = []

      # always include the default python/3 module
      python3_module = [ "python/3",    "python/3" ]
      
      # always include to option to define a custom env
      custom_env = [ "Custom Environment - only use what is specified below", "custom"   ]
      @jupyter_envs.push(python3_module)
      @jupyter_envs.push(custom_env)

      # check the output of Conda info for useable envs
      enabled_envs = []
      disabled_envs = []
      self.CondaEnvs.each do |env| 
        # now check if there is a jupyter-lab in the env
        # if it exists, add it to the enabled list
        # otherwise add it to the disabled list
        jupyter_path = env[1] + "/bin/jupyter-lab"
        if File.file?(jupyter_path)
          env[0] = "(Conda Environment) " + env[0]
          enabled_envs.push(env)
        else
          env[1] = "No Jupyter Lab"
          disabled_envs.push(env)
        end
      end
      # add the found environments to the list
      # the disabled environments are listed last
      enabled_envs.each do |env|
        @jupyter_envs.push(env)
      end
      disabled_envs.each do |env|
        @jupyter_envs.push(env)
      end
      #return
      @jupyter_envs
    end
  end

  def self.JupyterNotebookEnvs
    @JupyterLabEnvs ||= begin
       
      @jupyter_envs = []

      # always include the default python/3 module
      python3_module = [ "python/3",    "python/3" ]
      
      # always include to option to define a custom env
      custom_env = [ "Custom Environment - only use what is specified below", "custom"   ]
      @jupyter_envs.push(python3_module)
      @jupyter_envs.push(custom_env)

      # check the output of Conda info for useable envs
      enabled_envs = []
      disabled_envs = []
      self.CondaEnvs.each do |env| 
        # now check if there is a jupyter-notebook in the env
        # if it exists, add it to the enabled list
        # otherwise add it to the disabled list
        jupyter_path = env[1] + "/bin/jupyter-notebook"
        if File.file?(jupyter_path)
          env[0] = "(Conda Environment) " + env[0]
          enabled_envs.push(env)
        else
          env[1] = "No Jupyter Lab"
          disabled_envs.push(env)
        end
      end
      # add the found environments to the list
      # the disabled environments are listed last
      enabled_envs.each do |env|
        @jupyter_envs.push(env)
      end
      disabled_envs.each do |env|
        @jupyter_envs.push(env)
      end
      #return
      @jupyter_envs
    end
  end
end

# class to help get group info about user
class GroupInfo
  def self.GroupMembership
    @GroupMembership || begin

      # get users groups
      script = '/usr/bin/id -Gn $USER'
      o, status = Open3.capture2('bash', stdin_data: script)

      @GroupMembership = []

      # loop over output and append all groups to list
      o.strip.split(" ").each do |group|
        @GroupMembership.push(group)
      end
      #return
      @GroupMembership
    end
  end

  def self.checkUserInGroup(group)
    return self.GroupMembership.include? group
  end
end

# Get reservation info from slurm
class ReservationInfo

  def self.SlurmReservations
    @SlurmReservations || begin

      # get reservations from scrontrol
      script = '/cm/shared/apps/slurm/current/bin/scontrol show res'
      o, status = Open3.capture2('bash', stdin_data: script)
      @SlurmReservations = o.strip

      #return
      @SlurmReservations
    end
  end

  # extract reservation names
  def self.Names
    @Names || begin
      @Names = self.SlurmReservations.scan(/ReservationName=\K[^ ]+/)
      #return
      @Names
    end
  end

  # extract reservation partitions
  def self.Partitions
    @Partition || begin
      @Partition = self.SlurmReservations.scan(/PartitionName=\K[^ ]+/)
      #return
      @Partition
    end
  end

  # extract reservation start times
  def self.StartTimes
    @StartTimes || begin
      @StartTimes = self.SlurmReservations.scan(/StartTime=\K[^ ]+/)
      #return
      @StartTimes
    end
  end

  # extract reservation end times
  def self.EndTimes
    @EndTimes || begin
      @EndTimes = self.SlurmReservations.scan(/EndTime=\K[^ ]+/)
      #return
      @EndTimes
    end
  end

  # extract reservation groups
  def self.Groups
    @Groups || begin
      @Groups = self.SlurmReservations.scan(/Groups=\K[^ ]+/)
      #return
      @Groups
    end
  end

  # compute currently valid reservations
  def self.ValidReservations
    @ValidReservations || begin
      res_names = ReservationInfo.Names
      res_queues = ReservationInfo.Partitions
      res_start = ReservationInfo.StartTimes
      res_end = ReservationInfo.EndTimes
      res_groups = ReservationInfo.Groups
      tmp_time = DateTime.now 
      valid_reservations_names = []
      valid_reservation_queues = []
      valid_reservation_ends = []

      # check if reservations are valid
      res_names.each_with_index do |name, i|
        tmp_queue = res_queues[i]
        tmp_group = res_groups[i]
        tmp_start = res_start[i].to_datetime
        tmp_end = res_end[i].to_datetime

        # fix time zones
        tmp_start = tmp_start.change(:offset => tmp_time.offset)
        tmp_end = tmp_end.change(:offset => tmp_time.offset)
   
        # check for valid group
        valid_group = false
        tmp_group.split(",").each do |group|
          if GroupInfo.checkUserInGroup(group)
            valid_group = true
          end
        end

        # check for valid time
        valid_time = false
        if tmp_start.past? && tmp_end.future?
          valid_time = true
        end

        if valid_time && valid_group
          valid_reservations_names.append(name)
          valid_reservation_queues.append(tmp_queue.strip)
          valid_reservation_ends.append(tmp_end)
        end
      end
      @ValidReservations = [valid_reservations_names, valid_reservation_queues, valid_reservation_ends]
      #return
      @ValidReservations
    end
  end
end



# call to generate a cache
CustomEnvironments.JupyterLabEnvs
CustomEnvironments.JupyterNotebookEnvs
GroupInfo.GroupMembership
ReservationInfo.ValidReservations
