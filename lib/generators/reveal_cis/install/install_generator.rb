require 'rails'

if ::Rails.version < "3.1"
  module RevealCis
    module Generators
      class InstallGenerator < ::Rails::Generators::Base

        desc "This generator installs  Jquery , CSS and Images"
        source_root File.expand_path('../../../../../app/assets', __FILE__)

        def copy_jquery_nested
          copy_file "javascripts/jquery-1.4.4.min.js", "public/javascripts/jquery-1.4.4.min.js"
          copy_file "javascripts/jquery.reveal.js", "public/javascripts/jquery.reveal.js"
          copy_file "stylesheets/reveal.css", "public/stylesheets/reveal.css"
          copy_file "stylesheets/modal-gloss.png", "public/stylesheets/modal-gloss.png"
        end
      end
    end
  end
else
  module RevealCis
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        desc "This generator installs  Jquery , CSS and Images"
        source_root File.expand_path('../../../../../app/assets', __FILE__)
        def add_assets
          if detect_js_format.nil?
            copy_file "javascripts/jquery-1.4.4.min.js", "app/assets/javascripts/jquery-1.4.4.min.js"
            copy_file "javascripts/jquery.reveal.js", "app/assets/javascripts/jquery.reveal.js"
          else
            insert_into_file "app/assets/javascripts/application#{detect_js_format[0]}", "#{detect_js_format[1]} require jquery-1.4.4.min\n", :after => "jquery_ujs\n"
            insert_into_file "app/assets/javascripts/application#{detect_js_format[0]}", "#{detect_js_format[1]} require jquery.reveal\n", :after => "jquery-1.4.4.min\n"
          end
          if detect_css_format.nil?
            copy_file "stylesheets/jquery.notifications.css", "app/assets/stylesheets/jquery.notifications.css"
            copy_file "stylesheets/modal-gloss.png", "app/assets/stylesheets/modal-gloss.png"
          else
            insert_into_file "app/assets/stylesheets/application#{detect_css_format[0]}", "#{detect_css_format[1]} require reveal\n", :after => "require_self\n"
          end

        end

        def detect_js_format
          return ['.js.coffee', '#='] if File.exist?('app/assets/javascripts/application.js.coffee')
          return ['.js', '//='] if File.exist?('app/assets/javascripts/application.js')
        end
        def detect_css_format
          return ['.css.scss', '*='] if File.exist?('app/assets/stylesheets/application.css.scss')
          return ['.css', '*='] if File.exist?('app/assets/stylesheets/application.css')
        end
      end
    end
  end
end
