Pod::Spec.new do |s|
  s.name             = "JSBadgeView"
  s.version          = '2.0.0'
  s.summary          = "Customizable UIKit badge view like the one on applications in the iOS springboard."
  s.description      = "Customizable UIKit badge view like the one on applications in the iOS springboard. Very optimized for performance: drawn entirely using CoreGraphics."
  s.homepage         = "https://github.com/JaviSoto/JSBadgeView"
  s.license          = 'MIT'
  s.author           = { 'Javier Soto' => 'ios@javisoto.es' }
  s.source           = { :git => 'https://github.com/JaviSoto/JSBadgeView.git', :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'JSBadgeView' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'QuartzCore'
end
