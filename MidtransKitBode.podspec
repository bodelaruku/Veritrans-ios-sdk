Pod::Spec.new do |s|

s.name             = "MidtransKitBode"
s.version          = "1.11.0"
s.summary          = "Veritrans mobile SDK beta version bode"
s.homepage         = "https://veritrans.co.id/"
s.license          = 'MIT'
s.author           = { "bode" => "dedeprayitno241192@gmail.com" }
s.source           = { :git => 'https://github.com/bodelaruku/Veritrans-ios-sdk.git', :tag => s.version}
s.platform     = :ios, '9.0'
s.requires_arc = true

s.subspec 'UI' do |sp|
end

s.source_files = 'MidtransKit/MidtransKit/**/*.{h,m}'
s.resource_bundles = {
    'MidtransKit' => ['MidtransKit/MidtransKit/resources/*']
}
s.dependency 'MidtransCoreKit', '1.22.0'
s.static_framework = true
s.default_subspec = 'UI'

end
