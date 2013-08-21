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
      def pluginconf
        conf = {}
        Config.instance.pluginconf.each do |k,v|
         if k =~ /^plugin\.repository\./
            trim_k = k.gsub /^plugin\.repository\./, ''
            conf[trim_k] = v
          end
        end
        conf
      end

    end # end Repository
  end # end Agent
end # end Mcollective

