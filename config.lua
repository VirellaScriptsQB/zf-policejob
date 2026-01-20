-- config.lua (SIMPLIFIED + ARMORY = ox_inventory SHOP)
-- Keeps ONLY what your script needs:
-- - Job name + boss grade
-- - Radial
-- - zf-notify + zf-textui
-- - qbx_vehiclekeys toggle (optional)
-- - ONE PD blip
-- - 4 evidence stashes
-- - Armory opens an ox_inventory SHOP (not giving items from this script)
-- - Discord logs (single webhook)

Config = {}

Config.PoliceJobName = 'police'
Config.RequiredBossGrade = 4

Config.Radial = { id = 'zf_police_radial', label = 'Police', icon = 'shield-halved' }

-- Notify
Config.Notify = { Mode = 'event', EventName = 'zf-notify:client:notify' }

-- TextUI
Config.TextUI = { Mode = 'event', ShowEvent = 'zf-textui:client:show', HideEvent = 'zf-textui:client:hide' }

-- Vehicle Locks (optional)
Config.VehicleKeys = { Mode = 'event', ToggleLocksEvent = 'qbx_vehiclekeys:client:toggleLocks' }

-- One PD blip
Config.PDBlip = {
    Enabled = true,
    PoliceOnly = true,
    coords = vec3(441.2, -981.9, 30.7),
    label = 'Police Department',
    sprite = 60,
    color = 29,
    scale = 0.85,
    shortRange = true
}

-- Interaction points used by client
Config.Locations = {
    Duty = { vec3(441.2, -981.9, 30.7) },
    Armory = { vec3(446.6939, -1004.4064, 30.7074) },
    Boss = { vec3(448.4, -973.2, 30.7) },
}

-- Evidence stashes (4)
Config.EvidenceStashPrefix = 'zf_evidence_'
Config.EvidenceStashes = {
    { id = 'mrpd',     label = 'Evidence (MRPD)',     coords = vec3(449.6194, -1005.5266, 30.7074), slots = 120, maxWeight = 250000 },
    { id = 'sandy',    label = 'Evidence (Sandy)',    coords = vec3(1853.2, 3686.9, 34.2),          slots = 120, maxWeight = 250000 },
    { id = 'paleto',   label = 'Evidence (Paleto)',   coords = vec3(-446.2, 6012.9, 31.7),          slots = 120, maxWeight = 250000 },
    { id = 'vespucci', label = 'Evidence (Vespucci)', coords = vec3(-1098.3, -829.3, 14.3),         slots = 120, maxWeight = 250000 },
}

-- ✅ Armory = ox_inventory SHOP
-- Your client should call: TriggerServerEvent('zf-policejob:server:openArmoryShop')
-- Server should do: exports.ox_inventory:OpenInventory(src, 'shop', Config.Armory.ShopId)
Config.Armory = {
    ShopId = 'zf_police_armory', -- unique shop name/id

    -- Optional job restriction (recommended)
    Jobs = { [Config.PoliceJobName] = 0 }, -- 0 = any police grade

    -- Items sold in the shop (set prices how you want)
    Items = {
        { name = 'weapon_pistol',      price = 0 },
        { name = 'weapon_stungun',     price = 0 },
        { name = 'weapon_nightstick',  price = 0 },
        { name = 'weapon_flashlight',  price = 0 },
        { name = 'pistol_ammo',        price = 0, count = 60 },
        { name = 'radio',              price = 0 },
        { name = 'armor',              price = 0 },
        { name = 'bandage',            price = 0, count = 5 },
    }
}

-- Discord logs (simple)
Config.DiscordLogs = {
    Enabled = true,
    Webhook = 'PUT_DISCORD_WEBHOOK_HERE'
}
