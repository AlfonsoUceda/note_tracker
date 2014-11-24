require 'test_helper'

describe NoteTracker::VERSION do
  it 'returns current version' do
    NoteTracker::VERSION.must_equal '0.0.2'
  end
end