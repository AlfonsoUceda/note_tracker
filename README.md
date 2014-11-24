# NoteTracker

[![Gem Version](https://badge.fury.io/rb/note_tracker.svg)](http://badge.fury.io/rb/note_tracker)
[![Build Status](https://travis-ci.org/AlfonsoUceda/note_tracker.svg)](https://travis-ci.org/AlfonsoUceda/note_tracker)
[![Code Climate](https://codeclimate.com/github/AlfonsoUceda/note_tracker/badges/gpa.svg)](https://codeclimate.com/github/AlfonsoUceda/note_tracker)
[![Coverage Status](https://coveralls.io/repos/AlfonsoUceda/note_tracker/badge.png)](https://coveralls.io/r/AlfonsoUceda/note_tracker)
[![Dependency Status](https://gemnasium.com/AlfonsoUceda/note_tracker.svg)](https://gemnasium.com/AlfonsoUceda/note_tracker)
[![Inline docs](http://inch-ci.org/github/alfonsouceda/note_tracker.svg?branch=master)](http://inch-ci.org/github/alfonsouceda/note_tracker)

This gem provides the feature to track your notes with pivotal tracker

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'note_tracker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install note_tracker

## Usage

The gem read your files and create pivotal stories in your project.

If you have a TODO string like:

```
# TODO: Build new phase
```

You'll have:

```
# [#STORY_ID] TODO: Build new phase
```

Use

```
note_tracker = NoteTracker::Client.new PIVOTAL_TRACKER_API, PIVOTAL_PROJECT_NUMBER
note_tracker.track tags: TAGS_STRING, directories: DIRECTORIES_ARRAY
```

TAGS_STRING can be "FIXME|TODO" for example. "OPTIMIZE|FIXME|TODO" is default.
DIRECTORIES_ARRAY can be %w(/home/your_home/my_project)


## Contributing

1. Fork it ( https://github.com/AlfonsoUceda/note_tracker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
