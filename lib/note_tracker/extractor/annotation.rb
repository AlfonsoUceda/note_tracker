module NoteTracker
  module Extractor
    class Annotation < Struct.new(:line, :tag, :story_id, :text)
      def self.directories
        @directories ||= %w(app config db lib test) + (ENV['SOURCE_ANNOTATION_DIRECTORIES'] || '').split(',')
      end

      def self.extensions
        @extensions ||= {}
      end

      # Registers new Annotations File Extensions
      #   SourceAnnotationExtractor::Annotation.register_extensions("css", "scss", "sass", "less", "js") { |tag| /\/\/\s*(#{tag}):?\s*(.*)$/ }
      def self.register_extensions(*exts, &block)
        extensions[/\.(#{exts.join("|")})$/] = block
      end

      register_extensions("builder", "rb", "rake", "yml", "yaml", "ruby") { |tag| /#\s*(\[#\d+\])?\s*(#{tag}):?\s*\s*(.*)$/ }
      register_extensions("css", "js") { |tag| /\/\/\s*(\[#\d+\])?\s*(#{tag}):?\s*\s*(.*)$/ }
      register_extensions("erb") { |tag| /<%\s*#\s*(\[#\d+\])?\s*(#{tag}):?\s*(.*?)\s*%>/ }

      # Returns a representation of the annotation that looks like this:
      #
      #   [126] [TODO] This algorithm is simple and clearly correct, make it faster.
      #
      # If +options+ has a flag <tt>:tag</tt> the tag is shown as in the example above.
      # Otherwise the string contains just line and text.
      def to_s(options={})
        s = "[#{line.to_s.rjust(options[:indent])}] "
        s << "[#{tag}] " if options[:tag]
        s << text
      end

      def trackered?
        !!story_id
      end
    end
  end
end
