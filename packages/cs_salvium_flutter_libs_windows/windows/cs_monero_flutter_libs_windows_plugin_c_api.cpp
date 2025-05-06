#include "include/cs_salvium_flutter_libs_windows/cs_salvium_flutter_libs_windows_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "cs_salvium_flutter_libs_windows_plugin.h"

void CsSalviumFlutterLibsWindowsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  cs_salvium_flutter_libs_windows::CsSalviumFlutterLibsWindowsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
