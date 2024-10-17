//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <cs_monero_flutter_libs/cs_monero_flutter_libs_plugin_c_api.h>
#include <stack_wallet_backup/stack_wallet_backup_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  CsMoneroFlutterLibsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CsMoneroFlutterLibsPluginCApi"));
  StackWalletBackupPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("StackWalletBackupPluginCApi"));
}
