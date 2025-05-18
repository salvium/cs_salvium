#ifndef FLUTTER_PLUGIN_CS_MONERO_FLUTTER_LIBS_WINDOWS_PLUGIN_H_
#define FLUTTER_PLUGIN_CS_MONERO_FLUTTER_LIBS_WINDOWS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace cs_salvium_flutter_libs_windows {

class CsMoneroFlutterLibsWindowsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  CsMoneroFlutterLibsWindowsPlugin();

  virtual ~CsMoneroFlutterLibsWindowsPlugin();

  // Disallow copy and assign.
  CsMoneroFlutterLibsWindowsPlugin(const CsMoneroFlutterLibsWindowsPlugin&) = delete;
  CsMoneroFlutterLibsWindowsPlugin& operator=(const CsMoneroFlutterLibsWindowsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace cs_salvium_flutter_libs_windows

#endif  // FLUTTER_PLUGIN_CS_MONERO_FLUTTER_LIBS_WINDOWS_PLUGIN_H_
