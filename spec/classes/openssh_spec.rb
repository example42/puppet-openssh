require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'openssh' do

  let(:title) { 'openssh' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' } }

  describe 'Test standard installation' do
    let(:params) { { } }

    it { should contain_package('openssh').with_ensure('present') }
    it { should contain_service('openssh').with_ensure('running') }
    it { should contain_service('openssh').with_enable('true') }
    it { should contain_file('openssh.conf').with_ensure('present') }
  end

  describe 'Test decommissioning' do
    let(:params) { {:absent => true} }

    it { should contain_package('openssh').with_ensure('absent') }
    it { should contain_service('openssh').with_ensure('stopped') }
    it { should contain_service('openssh').with_enable('false') }
    it { should contain_file('openssh.conf').with_ensure('absent') }
  end

  describe 'Puppi Integration' do
    let(:params) { {:puppi => true, :puppi_helper => "myhelper"} }

    it { should contain_file('puppi_openssh').with_ensure('present') }
    it 'should generate a valid puppi data file' do
      content = catalogue.resource('file', 'puppi_openssh').send(:parameters)[:content]
      expected_lines = [ '  puppi_helper: myhelper' , '  puppi: true' ]
      (content.split("\n") & expected_lines).should == expected_lines
    end
  end

end

