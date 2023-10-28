<div align="center">
  <h1><code>MapDeleter</code></h1>
  <p>
    <strong>Short Description</strong>
  </p>
  <p style="margin-bottom: 0.5ex;">
    <img
        src="https://img.shields.io/github/downloads/Tolfx/MapDeleter/total"
    />
    <img
        src="https://img.shields.io/github/last-commit/Tolfx/MapDeleter"
    />
    <img
        src="https://img.shields.io/github/issues/Tolfx/MapDeleter"
    />
    <img
        src="https://img.shields.io/github/issues-closed/Tolfx/MapDeleter"
    />
    <img
        src="https://img.shields.io/github/repo-size/Tolfx/MapDeleter"
    />
    <img
        src="https://img.shields.io/github/workflow/status/Tolfx/MapDeleter/Compile%20and%20release"
    />
  </p>
</div>


## Requirements
- Sourcemod and Metamod


## Installation
1. Grab the latest release from the release page and unzip it in your sourcemod folder.
2. Restart the server or type `sm plugins load MapDeleter` in the console to load the plugin.
3. The config file will be automatically generated in cfg/sourcemod/

## Configuration
- You can modify the phrases in addons/sourcemod/translations/MapDeleter.phrases.txt.
- Once the plugin has been loaded, you can modify the cvars in cfg/sourcemod/MapDeleter.cfg.


## Usage

Delete maps for your community server when TF2 install default maps.

### ConVars
| ConVar | Default Value | Description |
|--------|---------------|-------------|
| sm_mapdeleter_regex | "[Regex](https://github.com/Tolfx/MapDeleter/blob/main/scripting/MapDeleter.sp#L26)" | Regex to match maps to delete on start up. |
| sm_mapdeleter_enabled | "0" | Enables or disables the plugin. |