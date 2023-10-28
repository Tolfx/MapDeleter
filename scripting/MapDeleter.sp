#include <sdkhooks>
#include <sdktools>
#include <sourcemod>
#include <regex>

#pragma newdecls required
#pragma semicolon 1

/**
 * ConVar to set the regex to match maps to delete on start up.
 */
ConVar MapDeleterRegex;
ConVar PluginEnabled;

public Plugin myinfo =
{
	name				= "MapDeleter",
	author			= "Tolfx",
	description = "Deletes maps on start up based on regex.",
	version			= "1.0.0",
	url					= "https://github.com/Tolfx/MapDeleter"
};

public void OnPluginStart()
{
	MapDeleterRegex = CreateConVar("sm_mapdeleter_regex", "^(plr_|rd_|tr_|cp_|pl_|ctf_|arena_|koth_|mvm_|pd_|sd_|tc_|vsh_|zi_|pass_|itemtest|background01).*", "Regex to match maps to delete on start up.");
	PluginEnabled		= CreateConVar("sm_mapdeleter_enabled", "0", "Enables or disables the plugin.", _, true, 0.0, true, 1.0);

	PluginEnabled.AddChangeHook(OnPluginEnabledChanged);

	DeleteMaps();
}

void OnPluginEnabledChanged(ConVar convar, char[] oldValue, char[] newValue)
{
	if (PluginEnabled.BoolValue)
		DeleteMaps();
}

void DeleteMaps()
{
	if (!PluginEnabled.BoolValue)
		return;

	char mapsDir[PLATFORM_MAX_PATH];
	Format(mapsDir, sizeof(mapsDir), "maps");

	DirectoryListing dir = OpenDirectory(mapsDir);
	if (dir == null)
	{
		LogError("Failed to open directory %s", mapsDir);
		return;
	}

	// Loop through all files in /tf/maps folder
	char		 filename[PLATFORM_MAX_PATH];
	FileType type;
	char		 regexStr[PLATFORM_MAX_PATH];
	MapDeleterRegex.GetString(regexStr, sizeof(regexStr));
	Regex regex = new Regex(regexStr);
	while (dir.GetNext(filename, sizeof(filename), type))
	{
		// If the file is a directory, skip it
		if (type == FileType_Directory || type == FileType_Unknown)
			continue;

		// If the file doesn't match the regex, skip it
		if (!regex.Match(filename))
			continue;

		// Delete file
		char path[PLATFORM_MAX_PATH];
		Format(path, sizeof(path), "%s/%s", mapsDir, filename);
		if (!DeleteFile(path))
			LogError("Failed to delete file %s", path);

		LogMessage("Deleted file %s", path);
	}

	delete regex;
	delete dir;

	LogMessage("Finished deleting maps");
}