# only test for built-in bluetooth support if we are on the Raspberry Pi 3
cpu_info = command('cat /proc/cpuinfo').stdout

if cpu_info.include?('a02082') or cpu_info.include?('a22082')
  describe "RPi 3: built-in wifi works" do
    describe command('ifconfig -a') do
      its(:stdout) { should contain /wlan0/ }
    end

    describe command('ethtool -i wlan0') do
      its(:stdout) { should contain /driver: brcmfmac/ }
      its(:stdout) { should contain /version: 7.45.41.26/ }
      its(:stdout) { should contain /firmware-version: 01-df77e4a7/ }
    end
  end
end

describe "RPi 3: built-in wifi firmware is installed" do
  describe file('/lib/firmware/brcm/brcmfmac43430-sdio.bin') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
  end
end

describe "RPi 3: built-in wifi works" do
  describe command('ifconfig -a') do
    its(:stdout) { should contain /wlan0/ }
  end

  describe command('ethtool -i wlan0') do
    its(:stdout) { should contain /driver: brcmfmac/ }
    its(:stdout) { should contain /version: 7.45.41.26/ }
    its(:stdout) { should contain /firmware-version: 01-df77e4a7/ }
  end
end
