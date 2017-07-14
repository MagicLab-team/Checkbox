Pod::Spec.new do |s|
    s.name         = "Checkbox"
    s.version      = "0.1.0"
    s.summary      = "Magic checkbox."
    s.homepage     = "https://github.com/MagicLab-team"
    s.license      = "MIT"
    s.author             = { "Roman Sorochak" => "roman.sorochak@gmail.com" }
    s.platform     = :ios, "8.0"
    s.ios.deployment_target = "8.0"
    s.source       = { :git => "https://github.com/MagicLab-team/Checkbox", :tag => s.version }
    s.source_files  = "Checkbox/*.swift"
    s.module_name = "Checkbox"
end
