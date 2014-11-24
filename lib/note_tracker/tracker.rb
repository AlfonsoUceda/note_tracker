require 'tempfile'
require 'fileutils'

module NoteTracker
  class Tracker
    def initialize(token, project, options = {})
      @token = token
      @project = project
      @tags_to_track = options.fetch(:tags) { "OPTIMIZE|FIXME|TODO" }
      @directories_to_track = options.fetch(:directories) { %w(.) }
    end

    def perform
      results_annotation_extractor.each do |file, annotations|
        temp_file = Tempfile.new('foo')

        File.open(file, 'r') do |file|
          file.each_line do |line|
            annotation = annotations.detect { |annotation| annotation.line == file.lineno }
            if annotation && !annotation.trackered?
              story_id = create_story(annotation).id
              line.gsub!("#{annotation.tag}","[##{story_id}] #{annotation.tag}")
            end
            temp_file.puts line
          end
        end

        temp_file.close
        FileUtils.mv(temp_file.path, file)
      end
    end

    private

    def tracker_client
      @tracker_client ||= TrackerApi::Client.new(token: @token)
    end

    def tracker_project
      @tracker_project ||= tracker_client.project(@project)
    end

    def create_story(annotation)
      tracker_project.create_story(name: annotation.text)
    end

    def results_annotation_extractor
      Extractor::Source.new(@tags_to_track).find(@directories_to_track)
    end
  end
end
