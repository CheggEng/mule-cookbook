require 'serverspec'

set :backend, :exec

describe 'mule::default' do
  context 'mule user' do
    let(:mule_user) { user('mule') }
    it 'is created' do
      expect(mule_user).to exist
    end

    it 'has the correct uid' do
      expect(mule_user).to have_uid 4000
    end

    it 'has login shell /bin/bash' do
      expect(mule_user).to have_login_shell '/bin/bash'
    end

    it 'has a home directory' do
      expect(mule_user).to have_home_directory '/home/mule'
    end
  end

  context 'mule group' do
    let(:mule_group) { group('mule') }
    it 'is created' do
      expect(mule_group).to exist
    end

    it 'has the correct gid' do
      expect(mule_group).to have_gid 4000
    end
  end

  context 'mule package' do
    let(:mule_current_dir) { file('/opt/mule/versions/current') }
    let(:mule_version_dir) { file('/opt/mule/versions/mule-3.5.0') }

    it 'installs in a versioned directory' do
      expect(mule_version_dir).to be_directory
    end

    it 'creates a symlink to the current version' do
      expect(mule_current_dir).to be_linked_to '/opt/mule/versions/mule-3.5.0'
    end
  end

  context 'mule init script' do
    let(:script) { file('/etc/init.d/mule') }

    it 'exists' do
      expect(script).to be_file
    end

    it 'has mode 0755' do
      expect(script).to be_mode 755
    end
  end

  context 'mule service' do
    let(:mule_service) { service('mule') }

    it 'is enabled' do
      expect(mule_service).to be_enabled
    end

    it 'is running' do
      expect(mule_service).to be_running
    end
  end
end
