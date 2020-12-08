#include <sourcemod>
Handle h_timer = null;
public Plugin myinfo =  {
	name = "Oto rev", 
	description = "Acrophobia mapinde otomatik revlenirsiniz.", 
	author = "phiso", 
	version = "1.31", 
	url = "pluginmerkezi.com"
};
public void OnMapStart() { char mapName[512]; GetCurrentMap(mapName, sizeof(mapName)); if (StrContains(mapName, "mg_acrophobia_", false) == -1) { SetFailState("Bu eklenti sadece acropta çalışmaktadır."); } }
public void OnPluginStart()
{
	HookEvent("round_start", startend);
	HookEvent("round_end", startend);
}
public Action startend(Event event, const char[] name, bool dontBroadcast)
{
	if (StrEqual(name, "round_start", true))
	{
		SetCvar("mp_respawn_on_death_ct", 1);
		PrintToChatAll("[SM] \x04Oto Respawn \x0230 \x04saniye sonra kapanacaktır.");
		h_timer = CreateTimer(29.0, reskapa, _, TIMER_FLAG_NO_MAPCHANGE);
	}
	if (StrEqual(name, "round_end", true)) { delete h_timer; }
}
public Action reskapa(Handle Timer) { SetCvar("mp_respawn_on_death_ct", 0); PrintToChatAll("[SM] \x04Oto Respawn \x02Kapanmıştır."); } stock void SetCvar(char[] cvarName, int value) { ConVar IntCvar = FindConVar(cvarName); if (IntCvar == null)return; int flags = IntCvar.Flags; flags &= ~FCVAR_NOTIFY; IntCvar.Flags = flags; IntCvar.IntValue = value; flags |= FCVAR_NOTIFY; IntCvar.Flags = flags; } 