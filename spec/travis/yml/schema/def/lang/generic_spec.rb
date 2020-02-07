describe Travis::Yml::Schema::Def::Generic do
  subject { Travis::Yml.schema[:definitions][:language][:generic] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :generic,
        title: 'Generic',
        summary: kind_of(String),
        see: kind_of(Hash),
        type: :object,
        normal: true
    )
  end
end
