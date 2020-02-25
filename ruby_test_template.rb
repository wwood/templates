require 'rspec'
require 'pp'
require 'systemu'

# To run this test:
# $ rspec /path/to/test_script_being_tested.rb

# Assumes that the name of the file being tested is ../something.rb relative to the directory containing this test scripts, and the name of this tes script is test_something.rb
$:.unshift File.join(File.dirname(__FILE__),'..')
script_under_test = File.basename(__FILE__).gsub(/^test_/,'')
path_to_script = File.join(File.dirname(__FILE__),'..',script_under_test)


describe script_under_test do
  it 'should library test ok' do
    seqs = %w(a a a)
    trimmed = Bio::Alignment.new(seqs).trim_uninformative_columns
    trimmed[0].size.should eq(0) #"all seqs should be empty since they are all uninformative"
    assert_equal 3, trimmed.size #"should still have 3 seqs in it"
  end

  it 'should scripting test ok' do
    seqs = %w(>scaffold1 AANNTGTG)

    status, stdout, stderr = systemu "#{path_to_script} #{arg1}", 'stdin' => seqs
    stderr.should eq("")
    status.exitstatus.should eq(0)
    stdout.should eq("hello world")
  end
end
