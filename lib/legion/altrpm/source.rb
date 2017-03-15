module Legion
  module ALTRPM
    class Source < Base
      def filename
        "#{ name }-#{ version }-#{ release }.src.rpm"
      end
    end
  end
end
