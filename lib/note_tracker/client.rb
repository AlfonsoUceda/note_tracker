module NoteTracker
  class Client
    def initialize(options = {})
      @tracker_token   = options.fetch(:tracker_token)
      @tracker_project = options.fetch(:tracker_project)
    end

    def track(options = {})
      Tracker.new(@tracker_token, @tracker_project, options).perform
    end
  end
end