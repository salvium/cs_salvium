//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <cs_salvium_flutter_libs_linux/cs_salvium_flutter_libs_linux_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) cs_salvium_flutter_libs_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "CsSalviumFlutterLibsLinuxPlugin");
  cs_monero_flutter_libs_linux_plugin_register_with_registrar(cs_monero_flutter_libs_linux_registrar);
}
