#!/usr/bin/env rspec

require 'spec_helper'
require File.join(File.dirname(__FILE__), "../../", "agent", "repository.rb")

describe "repository agent" do
  before do
    agent_file = File.join([File.dirname(__FILE__), "../../agent/repository.rb"])
    @agent = MCollective::Test::LocalAgentTest.new("repository", :agent_file => agent_file).plugin
  end

  describe "#update" do
    let(:config){mock}
    let(:pluginconf){{
        'plugin.repository.examplerepos.directory' => '/tmp/git_checkouts/foo',
        'plugin.repository.examplerepos.from' => 'git://github.com/someone/foo',
        'plugin.repository.examplerepos.type' => 'git'
    }}

    before :each do
      config.stubs(:pluginconf).returns(pluginconf)
      MCollective::Config.stubs(:instance).returns(config)
    end

    it "pluginconf method returns stripped plugin conf" do
      c = @agent.pluginconf
      c.keys == 3
      c["examplerepos.directory"].should == "/tmp/git_checkouts/foo"
      c["examplerepos.from"].should == "git://github.com/someone/foo"
      c["examplerepos.type"].should == "git"
    end
  end

end

