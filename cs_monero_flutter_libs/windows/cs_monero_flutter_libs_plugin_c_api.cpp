#include "include/cs_monero_flutter_libs/cs_monero_flutter_libs_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "cs_monero_flutter_libs_plugin.h"

void CsMoneroFlutterLibsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  cs_monero_flutter_libs::CsMoneroFlutterLibsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
