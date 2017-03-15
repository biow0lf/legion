require 'posix-spawn'
require 'cocaine'
require 'climate_control'

module Legion
  module ALTRPM
    class Base
      RPM_STRING_TAGS = [:name, :version, :release, :summary, :group, :license,
                         :url, :packager, :vendor, :distribution, :description,
                         :buildhost, :changelogname, :changelogtext].freeze
      RPM_INT_TAGS = [:epoch].freeze
      RPM_TIME_TAGS = [:buildtime, :changelogtime].freeze

      attr_reader :file, :locale

      def initialize(file, locale = 'C')
        @file = file
        @locale = locale
      end

      RPM_STRING_TAGS.each do |method|
        define_method(method) { read_tag(method.to_s.upcase) }
      end

      RPM_INT_TAGS.each do |method|
        define_method(method) do
          tag = read_tag(method.to_s.upcase)
          tag ? tag.to_i : tag
        end
      end

      RPM_TIME_TAGS.each do |method|
        define_method(method) { Time.at(read_tag(method.to_s.upcase).to_i) }
      end

      def filename
        raise NotImplementedError
      end

      def md5
        # TODO: Digest::MD5.file(file).hexdigest
        # make it more ruby and testable
        ClimateControl.modify LANG: locale do
          command = Cocaine::CommandLine.new('md5sum', ':file')
          command.run(file: file)
        end.split.first
      end

      def size
        File.size(file)
      end

      private

      def read_raw(queryformat)
        ClimateControl.modify LANG: locale do
          command = Cocaine::CommandLine.new('rpm', '-qp --queryformat=:queryformat :file')
          command.run(queryformat: queryformat, file: file)
          content = command.command_output
          return if content == '(none)' || content == ''
          content
        end
      end

      def read_tag(tag)
        read_raw("%{#{ tag }}")
      end
    end
  end
end
