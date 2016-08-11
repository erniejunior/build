# Write in this file customization code that will get executed after all the
# soures have beenloaded.

# Uncomment to reenable building the RTT test suite
# This is disabled by default as it requires a lot of time and memory
#
# Autobuild::Package['rtt'].define "BUILD_TESTING", "ON"

# Package specific prefix:
# Autobuild::Package['rtt'].prefix='/opt/autoproj/2.0'
#
# See config.yml to set the prefix:/opt/autoproj/2.0 globally for all packages.

env_set 'TYPELIB_USE_GCCXML', '1'
Autoproj.env_inherit 'CMAKE_PREFIX_PATH'
Autoproj.env_add_path 'CMAKE_PREFIX_PATH', Autobuild::Package['rtt'].prefix

Autoproj.manifest.each_autobuild_package do |pkg|
    if pkg.kind_of?(Autobuild::Orogen)
        if pkg.name != 'std'
            pkg.depends_on 'std'
            pkg.orogen_options << '--import=std'
        end
    end
end

