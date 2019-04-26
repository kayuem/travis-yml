describe Travis::Yml, 'cache' do
  let(:empty) { {} }
  subject { described_class.apply(value) }

  describe 'given true on apt' do
    let(:value) { { cache: { apt: true } } }
    it { should serialize_to cache: { apt: true } }
    it { should_not have_msg }
  end

  describe 'given a seq of strs on directories' do
    let(:value) { { cache: { directories: ['str'] } } }
    it { should serialize_to cache: { directories: ['str'] } }
    it { should_not have_msg }
  end

  describe 'given a seq with apt and bundler' do
    let(:value) { { cache: [:apt, :bundler] } }
    it { should serialize_to cache: { apt: true, bundler: true } }
    it { should_not have_msg }
  end

  describe 'given a seq with apt and directories' do
    let(:value) { { cache: [:apt, directories: ['str']] } }
    it { should serialize_to cache: { apt: true, directories: ['str'] } }
    it { should_not have_msg }
  end

  describe 'given a seq with apt and directories' do
    let(:value) { { cache: [:apt, directories: ['str']] } }
    it { should serialize_to cache: { apt: true, directories: ['str'] } }
    it { should_not have_msg }
  end

  describe 'given a seq with apt, directories, and an unknown str' do
    let(:value) { { cache: [:apt, :unknown, directories: ['str']] } }
    it { should serialize_to cache: { apt: true, directories: ['str', 'unknown'] } }
    it { should_not have_msg }
  end

  describe 'given a seq with apt, directories, and an unknown str in a seq' do
    let(:value) { { cache: [:apt, [:unknown], directories: ['str']] } }
    it { should serialize_to cache: { apt: true, directories: ['str'] } }
    # rewrite Change::Cache to not drop unexpected things
    xit { should have_msg [:warn, :'cache.directories', :invalid_seq, value: 'unknown'] }
  end

  describe 'given a seq with apt, directories, and an unknown key with a str' do
    let(:value) { { cache: [:apt, directories: ['str'], unknown: 'str'] } }
    it { should serialize_to cache: { unknown: 'str', apt: true, directories: ['str'] } }
    it { should have_msg [:warn, :cache, :unknown_key, key: :unknown, value: 'str'] }
  end

  describe 'given a seq with a map on directories' do
    let(:value) { { cache: [directories: ['str', foo: 'bar']] } }
    it { should serialize_to cache: { directories: ['str'] } }
    it { should have_msg [:error, :'cache.directories', :invalid_type, expected: :str, actual: :map, value: { foo: 'bar' }] }
  end
end
