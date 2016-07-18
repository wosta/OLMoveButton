Pod::Spec.new do |s|

  s.name         = 'OLMoveButton'
  s.license      = 'MIT'
  s.requires_arc = true
  s.version      = '0.0.2'
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.framework    = 'UIKit'
  s.summary      = 'AssistiveTouch & move Button'
  s.author       = { "wosta" => "weiwang1202@126.com" }
  s.source_files = 'OLMoveView/**/*.{h,m}'
  s.homepage     = 'https://github.com/wosta/OLMoveButton'
  s.source       = { :git => 'https://github.com/wosta/OLMoveButton.git', :tag => '0.0.2' }
                      
end