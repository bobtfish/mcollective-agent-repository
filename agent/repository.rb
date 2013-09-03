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
        repos = conf_for_repos repos_name
        require 'pp'
        pp repos 
        repos[:name] = repos_name
        repos[:type] = 'auto' unless repos[:type]

        if 'auto' == repos[:type]
          raise("auto type not supported yet")
        end

        Dir.chdir(repos[:directory]) do
          case repos[:type]
          when 'git'
            update_git repos
          when 'svn'
            update_svn repos
          else
            raise("The '#{repos[:type]}' type is not known / supported")
          end
        end
      end

      def update_git(repos)
        run 'git fetch origin'
        run 'git reset --hard master'
      end

      def update_svn(repos)
        run 'svn revert -r .'
        run 'svn up'
      end

      def run(cmd)
        puts cmd
        0
      end

      def conf_for_repos(repo)
        conf = {}
        pluginconf.each do |k,v|
          if k =~ /^#{repo}\./
            conf[k.gsub(/^#{repo}\./, '').to_sym] = v
          end
        end
        return nil unless conf.keys.count > 0

        if !conf[:directory]
          raise("Configureation for '#{repo}' does not have a .directory config key")
        end
        conf
      end

      def pluginconf
        conf = {}
        Config.instance.pluginconf.each do |k,v|
         if k =~ /^repository\./
            trim_k = k.gsub /^repository\./, ''
            conf[trim_k] = v
          end
        end
        conf
      end

    end # end Repository
  end # end Agent
end # end Mcollective

