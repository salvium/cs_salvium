# `cs_salvium_flutter_libs_platform_interface`
A common platform interface for the 
[`cs_salvium`](https://pub.dev/packages/cs_salvium) plugin.

# Usage
To implement a new platform-specific implementation of `cs_salvium`, extend 
`CsSalviumFlutterLibsPlatform` with an implementation that performs the 
platform-specific behavior, and when you register your plugin, set the default 
`CsSalviumFlutterLibsPlatform` by calling 
`CsSalviumFlutterLibsPlatform.instance = CsSalviumFlutterLibsPlatform()`.
