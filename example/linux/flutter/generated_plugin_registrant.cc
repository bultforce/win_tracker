//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <win_tracker/win_tracker_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) win_tracker_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "WinTrackerPlugin");
  win_tracker_plugin_register_with_registrar(win_tracker_registrar);
}
