require "note_tracker/version"
require "tracker_api"

module NoteTracker
  autoload :Client,  'note_tracker/client'
  autoload :Tracker, 'note_tracker/tracker'

  module Extractor
    autoload :Source,     'note_tracker/extractor/source'
    autoload :Annotation, 'note_tracker/extractor/annotation'
  end
end
