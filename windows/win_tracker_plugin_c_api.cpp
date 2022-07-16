#include "include/win_tracker/win_tracker_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "win_tracker_plugin.h"

void WinTrackerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  win_tracker::WinTrackerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
