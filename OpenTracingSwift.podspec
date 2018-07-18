Pod::Spec.new do |spec|
    spec.name          = 'OpenTracingSwift'
    spec.version       = '0.0.3'
    spec.license       = { :type => 'BSD' }
    spec.homepage      = 'https://github.com/lightstep/opentracing-swift'
    spec.authors       = { 'LightStep' => 'support@lightstep.com' }
    spec.summary       = 'Swift implementation of the OpenTracing standard'

    spec.source = {
        :git => 'https://github.com/lightstep/opentracing-swift.git',
        :tag => spec.version
    }

    spec.module_name   = 'OpenTracing'
    spec.swift_version = '4.1'

    spec.ios.deployment_target  = '10.0'
    spec.osx.deployment_target  = '10.12'

    spec.source_files = 'Sources/OpenTracing/*.swift'

end
