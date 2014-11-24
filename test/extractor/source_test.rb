require 'test_helper'

describe NoteTracker::Extractor::Source do
  let(:default_source) { NoteTracker::Extractor::Source.new }
  let(:source_with_tags) { NoteTracker::Extractor::Source.new "FIXME|TODO" }

  it 'should contains default tags' do
    default_source.tag.must_equal "OPTIMIZE|FIXME|TODO"
  end

  it 'should contains specific tags' do
    source_with_tags.tag.must_equal "FIXME|TODO"
  end
end