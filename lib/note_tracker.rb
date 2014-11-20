require "note_tracker/version"
require "tracker_api"

module NoteTracker
  autoload :Client,                    'note_tracker/client'
  autoload :SourceAnnotationExtractor, 'note_tracker/source_annotation_extractor'
  autoload :Tracker,                   'note_tracker/tracker'
end
