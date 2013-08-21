= Mcollective repository agent =

This agent updates svn or git repositories on your servers

== Configuration ==

plugin.repository.repos.NAME.directory: '/opt/git_checkouts/foo'
plugin.repository.repos.NAME.from: 'git://github.com/someone/foo'
plugin.repository.repos.NAME.bare: ?? Is this needed
plugin.repository.repos.NAME.type: git

