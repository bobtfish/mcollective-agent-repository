metadata    :name        => "repository",
            :description => "Agent to update on disk repsitories",
            :author      => "Tomas Doran",
            :license     => "ASL 2.0",
            :version     => "0.0.1",
            :url         => "https://github.com/bobtfish/mcollective-agent-repository",
            :timeout     => 5

requires :mcollective => "2.2.1"

action "update", :description => "Update a repository" do
    input :repository,
          :prompt      => "Repository",
          :description => "Repository name to update",
          :type        => :string,
          :validation  => '\A[a-zA-Z0-9_-]+\z',
          :optional    => false,
          :maxlength   => 50

    output :revision,
           :description => "The revision we've just updated to",
           :display_as  => "Revision",
           :default     => ""
end

