class CheckQueues

  @cache = ActiveSupport::Cache::FileStore.new("/users/#{User.new.name}/.cache/OpenOnDemand/", :expires_in => 1.minute)

  def self.GetQueues()
    begin
      # get list of queues from sinfo
      script = "/hpc/sys/apps/slurm/current/bin/sinfo --hide -ho '%R %l %c %m %G'"
      o, status = Open3.capture2e(script)
      tmp_output = o.split("\n")

      output = []
      tmp_output.each do |q|
        params = q.gsub(/\s+/m, ' ').strip.split(" ")

        # convert time to hours
        hours = 0
        tmp = params[1].split("-")
        if tmp.count == 2
          hours = hours + 24*tmp[0].to_i
          hours = hours + tmp[1].split(":")[0].to_i
        else
          hours = hours + tmp[0].split(":")[0].to_i
        end
        params[1] = hours

        # convert memory to GB (implicit floor division)
        params[3] = params[3].to_i / 1024

        # get number of gpus
        if params[4] == "(null)"
          params[4] = 0
        else
          params[4] = params[4].split(":")[-1]
        end

        # if HTC, set cores to 1
        if params[0] == "htc"
          params[2] = 1
        end

        # only keep queues with time limits <= 24 hours
        if (hours < 25)
          # set the time limit to 12 hours or max queue time
          params[1] = [params[1].to_i, 12].min
          output.push(params) 
        end

      end
      return output
    end
  end

  def self.Queues
    begin
      @Queues = @cache.fetch("#{User.new.name}/queues", race_condition_ttl: 30.seconds) do
        self.GetQueues()
      end
      return @Queues
    end
  end
end
