Pod::Spec.new do |s|
  s.name         = "AWLoader"
  s.version      = "0.0.1"
  s.summary      = "A loader that is similar to the iOS App Store application."
  s.description  = <<-DESC
A iOS loader that is similar to Apple applications
                   DESC
  s.homepage     = "https://github.com/Aymenworks/AWLoader"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Aymen Rebouh" => "Aymen.Rebouh@mines-ales.org" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Aymenworks/AWLoader.git" }
  s.source_files  = "AWLoader.swift"
  s.exclude_files = "*.gif"
end
