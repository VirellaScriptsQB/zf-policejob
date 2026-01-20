============================================================
zf-policejob — QBX Police Utility (ox_inventory + ox_lib)
============================================================

zf-policejob is a lightweight police “wrapper” for QBX that provides:
- Police radial menu (ox_lib radial + context)
- Armory via ox_inventory SHOP
- Evidence via multiple ox_inventory STASHES (4 by default)
- Duty toggle (QBX duty)
- Member list (online police)
- Hire / Fire (job management)
- One Police Department blip
- zf-textui prompts (optional)
- Discord webhook logs (optional)

NO:
- fines
- garage / vehicle spawning
- impound
- built-in cuff menu (but client can still listen to cuff/escort events)

------------------------------------------------------------
REQUIREMENTS
------------------------------------------------------------
Required:
- qbx_core
- ox_lib
- ox_inventory

Optional:
- zf-notify (if you want notifications routed through it)
- zf-textui (if you want text UI prompts through it)
- qbx_vehiclekeys (if you want lock toggle from the menu)

------------------------------------------------------------
INSTALLATION
------------------------------------------------------------
1) Folder name MUST be:
   zf-policejob

2) Put the resource in your resources folder:
   resources/[jobs]/zf-policejob

3) Ensure dependencies start BEFORE this resource.

Example server.cfg order:
   ensure ox_lib
   ensure ox_inventory
   ensure qbx_core
   ensure zf-policejob

(Optional)
   ensure zf-notify
   ensure zf-textui
   ensure qbx_vehiclekeys

4) Add to server.cfg:
   ensure zf-policejob

------------------------------------------------------------
OXX INVENTORY ARMORY SHOP SETUP
------------------------------------------------------------
This script opens a shop by ShopId configured in config.lua.

You MUST create the shop in:
  ox_inventory/data/shops.lua
(or the correct file for your ox_inventory version)

Example shop entry (basic):
------------------------------------------------------------
{
  name = 'Police Armory',
  id = 'police_armory',
  groups = { police = 0 },
  inventory = {
    { name = 'weapon_pistol', price = 0 },
    { name = 'ammo-9', price = 0, count = 60 },
    { name = 'weapon_stungun', price = 0 },
    { name = 'armor', price = 0 }
  }
}
------------------------------------------------------------

IMPORTANT:
- The exact shop structure can vary by ox_inventory version.
- If your shop works already, keep your existing format.
- Ensure your ShopId in config.lua matches the shop id in ox_inventory.

------------------------------------------------------------
EVIDENCE STASHES
------------------------------------------------------------
Evidence is handled via ox_inventory stashes.

- You have 4 evidence stashes by default in config.lua.
- Each stash uses:
    stashId = Config.EvidenceStashPrefix .. stash.id
  Example:
    zf_evidence_mrpd
    zf_evidence_sandy
    zf_evidence_paleto
    zf_evidence_vespucci

The server registers stashes on resource start and opens them via events.
Only police can open them.

You can change:
- coords
- label
- slots
- maxWeight

------------------------------------------------------------
MEMBERS LIST (ONLINE POLICE)
------------------------------------------------------------
From the radial you can open:
- Members (Online Police)

This asks the server for a current list of online police and displays:
- Name
- Server ID
- Grade
- Duty status (if available from QBX data)

------------------------------------------------------------
HIRE / FIRE
------------------------------------------------------------
Hire/Fire is enabled for high ranks only.

Permission:
- Uses Config.HRRequiredGrade if present
- Otherwise uses Config.RequiredBossGrade (default 4)

Hire:
- Shows nearby players (3.0 distance)
- Select one to hire into Police job

Fire:
- Opens the Members list
- Selecting a member fires them (quick admin-style)

NOTES:
- Hiring/firing must be supported by your QBX job functions on the server.
- If your QBX build uses different APIs, adjust server/main.lua hire/fire handlers.

------------------------------------------------------------
PD BLIP
------------------------------------------------------------
Only ONE police blip is created (Config.PDBlip).
Option:
- PoliceOnly = true (only police see it)
- Change coords / sprite / color / scale in config.lua

------------------------------------------------------------
TEXT UI PROMPTS
------------------------------------------------------------
Zone prompts display:
  [E] Duty Locker
  [E] Armory
  [E] Evidence
(plus any others you add)

TextUI mode options:
- zf-textui events (recommended if you use zf-textui)
- fallback to ox_lib textui if zf-textui not configured

------------------------------------------------------------
DISCORD LOGS
------------------------------------------------------------
Enable logs in config.lua:
  Config.DiscordLogs.Enabled = true
  Config.DiscordLogs.Webhook = 'YOUR_WEBHOOK'

Logs can be sent for:
- Duty toggles
- Armory shop opens
- Evidence stash opens
- Hire / Fire actions

Make sure your webhook is correct and your server can perform HTTP requests.

------------------------------------------------------------
USAGE (IN GAME)
------------------------------------------------------------
Police job players:
- Open radial menu (ox_lib radial)
- Select:
   - Armory (opens ox_inventory shop)
   - Evidence (shows stashes / opens stash)
   - Members
   - Hire / Fire (if authorized)
   - Vehicle Locks (optional keys toggle)

At locations:
- Walk into zone
- Press E to use (duty / armory / evidence)

------------------------------------------------------------
TROUBLESHOOTING
------------------------------------------------------------
1) "nothing happens when opening menu"
- Ensure ox_lib is running and updated
- Ensure this resource starts AFTER ox_lib
- Check F8 console for errors

2) "ox_inventory not found"
- Ensure ox_inventory is started before zf-policejob
- Ensure resource name is exactly "ox_inventory"

3) "armory shop does not open"
- Your shop must exist in ox_inventory/data/shops.lua
- ShopId in config.lua must match shop id
- Ensure the player is police (job name matches Config.PoliceJobName)

4) "evidence stash does not open"
- Ensure ox_inventory is running
- Ensure stash is registered (server console should show no errors)
- Ensure player is police
- Ensure stash id exists in config.lua EvidenceStashes

5) "hire/fire does nothing"
- Your QBX build may use different functions for setting jobs.
- Adjust the server/main.lua hire/fire code to match your QBX version.

------------------------------------------------------------
CONFIG QUICK NOTES
------------------------------------------------------------
Key config values:
- Config.PoliceJobName = 'police'
- Config.RequiredBossGrade = 4
- Config.HRRequiredGrade = 4 (optional override)
- Config.Armory.ShopId = 'police_armory' (must match ox_inventory shop)
- Config.EvidenceStashPrefix = 'zf_evidence_'
- Config.EvidenceStashes = { ... 4 stashes ... }
- Config.PDBlip = { Enabled=true, coords=vec3(...), ... }
- Config.DiscordLogs = { Enabled=true, Webhook='...' }

------------------------------------------------------------
SUPPORT / EDITS
------------------------------------------------------------
If you want:
- Grade-based armory items
- Grade-based evidence stash access
- Cleaner hire/fire flows (choose grade on hire)
- Separate webhooks per feature (armory/evidence/duty)
Just say what rules you want and I can wire it clean.
