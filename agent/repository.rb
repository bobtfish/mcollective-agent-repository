module MCollective
  module Agent
    class Repository<RPC::Agent

      action "update" do
        repos_name = request[:repository]
        reply[:revision] = 'fnar'
      end

#        if config.pluginconf["nrpe.conf_file"]
#          files << "#{fdir}/#{config.pluginconf['nrpe.conf_file']}"
#        end


    end
  end
end

