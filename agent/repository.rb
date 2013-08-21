module MCollective
  module Agent
    class Repository<RPC::Agent

      action "update" do
        repos_name = request[:repository]
        conf = conf_for_repos repos_name
        if conf
          reply[:revision] = update_repos repos_name
        else
          raise("Repository '#{repos_name}' not found in config")
        end
        reply[:revision] = 'fnar'
      end

      def update_repos(repos_name)
        conf = conf_for_repos repos_name
        require 'pp'
        pp conf
        conf[:name] = repos_name
        conf[:type] = 'auto' unless conf[:type]

        if 'auto' == conf[:type]
          raise("auto type not supported yet")
        end

        case conf[:type]
        when 'git'
        when 'svn'
            
        else
          raise("The '#{conf[:type]}' type is not known / supported")
        end
      end

      def run(cmd)
        puts cmd
        0
      end
#        if config.pluginconf["nrpe.conf_file"]
#          files << "#{fdir}/#{config.pluginconf['nrpe.conf_file']}"
#        end

      def conf_for_repos(repo)
        conf = {}
        pluginconf.each do |k,v|
          if k =~ /^#{repo}\./
            conf[k.gsub(/^#{repo}\./, '').to_sym] = v
          end
        end
        return nil unless conf.keys.count > 0
        conf
      end

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

