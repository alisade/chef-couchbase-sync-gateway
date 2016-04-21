include MiniTest::Chef::Assertions
include MiniTest::Chef::Context
include MiniTest::Chef::Resources

describe_recipe 'sync-gateway:default' do
  it 'succeeds' do
      assert run_status.success?
  end

  it 'creates config.json' do
      assert_path_exists file(node['sync_gateway']['config_path'])
  end

  describe "sync-gateway service" do
    let(:syncGateway) { service node['sync_gateway']['service_name'] }

    it "starts on boot" do
      syncGateway.must_be_enabled
    end

    it "is running as a daemon" do
      syncGateway.must_be_running
    end
  end
end

