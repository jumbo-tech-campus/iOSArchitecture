Pod::Spec.new do |spec|
  spec.name = 'FeatureModule'
  spec.version = '0.1.0'
  spec.summary = 'An awesome feature.'

  spec.homepage = 'https://github.com/RuudPuts/Down'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = { 'Ruud Puts' => 'ruud.puts@gmail.com' }

  spec.swift_version = '4.2'
  spec.ios.deployment_target = '12.0'

  spec.source = { :git => 'https://github.com/RuudPuts/Down.git', :tag => spec.version.to_s }
  spec.source_files = 'FeatureModule/Source/**/*'
    
  spec.resource_bundles = {
    'FeatureModule' => ['FeatureModule/Assets/*']
  }
end
