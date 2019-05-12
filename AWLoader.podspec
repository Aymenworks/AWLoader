Pod::Spec.new do |s|
  s.name         = "AWLoader"
  s.version      = "1.0.0"
  s.summary      = "AWLoader is a UI  Compoonent that allows you to integrate a loader that fits your needs within your app."
  s.description  = <<-DESC
AWLoader is a UI  Compoonent that allows you to integrate a loader that fits your needs within your app."
                   DESC
  s.homepage     = "https://github.com/Aymenworks/AWLoader"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Aymen Rebouh" => "aymenmse@gmail.com" }
  s.requires_arc = true
  s.ios.deployment_target = '9.0'
  s.source       = { :git => "https://github.com/Aymenworks/AWLoader.git", :tag => "#{s.version}" }
  s.source_files  = ['AWLoader/**/*.{swift,h}']
  s.public_header_files = 'AWLoader/**/*.h'
  s.social_media_url   = "https://twitter.com/aymenworks"
end
