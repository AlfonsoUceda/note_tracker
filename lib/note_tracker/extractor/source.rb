# Class copied from [1] and modified to store pivotal tracker id
#
# [1]: https://github.com/rails/rails/blob/master/railties/lib/rails/source_annotation_extractor.rb
module NoteTracker
  module Extractor
    class Source
      # Prints all annotations with tag +tag+ under the root directories +app+,
      # +config+, +db+, +lib+, and +test+ (recursively).
      #
      # Additional directories may be added using a comma-delimited list set using
      # <tt>ENV['SOURCE_ANNOTATION_DIRECTORIES']</tt>.
      #
      # Directories may also be explicitly set using the <tt>:dirs</tt> key in +options+.
      #
      #   SourceAnnotationExtractor.enumerate 'TODO|FIXME', dirs: %w(app lib), tag: true
      #
      # If +options+ has a <tt>:tag</tt> flag, it will be passed to each annotation's +to_s+.
      #
      # See <tt>#find_in</tt> for a list of file extensions that will be taken into account.
      #
      # This class method is the single entry point for the rake tasks.
      def self.enumerate(tag, options={})
        extractor = new(tag)
        dirs = options.delete(:dirs) || Extractor::Annotation.directories
        extractor.display(extractor.find(dirs), options)
      end

      attr_reader :tag

      def initialize(tag = nil)
        @tag = tag || "OPTIMIZE|FIXME|TODO"
      end

      # Returns a hash that maps filenames under +dirs+ (recursively) to arrays
      # with their annotations.
      def find(dirs)
        dirs.inject({}) { |h, dir| h.update(find_in(dir)) }
      end

      # Returns a hash that maps filenames under +dir+ (recursively) to arrays
      # with their annotations. Only files with annotations are included. Files
      # with extension +.builder+, +.rb+, +.erb+, +.haml+, +.slim+, +.css+,
      # +.scss+, +.js+, +.coffee+, +.rake+, +.sass+ and +.less+
      # are taken into account.
      def find_in(dir)
        results = {}
        p dir
        p ".. #{Dir.glob("#{dir}/*")}"
        Dir.glob("#{dir}/*") do |item|
          p item
          next if File.basename(item)[0] == ?.

          if File.directory?(item)
            results.update(find_in(item))
          else
            extension = Extractor::Annotation.extensions.detect do |regexp, _block|
              regexp.match(item)
            end

            if extension
              pattern = extension.last.call(tag)
              results.update(extract_annotations_from(item, pattern)) if pattern
            end
          end
        end

        results
      end

      # If +file+ is the filename of a file that contains annotations this method returns
      # a hash with a single entry that maps +file+ to an array of its annotations.
      # Otherwise it returns an empty hash.
      def extract_annotations_from(file, pattern)
        lineno = 0
        result = File.readlines(file).inject([]) do |list, line|
          lineno += 1
          next list unless line =~ pattern
          tag = $2
          text = $3
          story_id = $1.to_s.scan(/\d+/).first
          list << Extractor::Annotation.new(lineno, tag, story_id, text)
        end
        result.empty? ? {} : { file => result }
      end

      # Prints the mapping from filenames to annotations in +results+ ordered by filename.
      # The +options+ hash is passed to each annotation's +to_s+.
      def display(results, options={})
        options[:indent] = results.flat_map { |f, a| a.map(&:line) }.max.to_s.size
        results.keys.sort.each do |file|
          puts "#{file}:"
          results[file].each do |note|
            puts "  * #{note.to_s(options)}"
          end
          puts
        end
      end
    end
  end
end