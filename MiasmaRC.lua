print("Running Ricks MiasmaRC.")

-- Will not check bank for impure essence, and will not stop when out of supplies.
-- Requires infinity ethereal outfit, Ring of imbuing, and Passing bracelet, Tome of Um 2, as well as Small - Massive pouches.
--Setup your preset with pouches and eth outfit filled, passing bracelet in inv, and impure essence. Manually withdraw this preset before starting script.
-- I put Tome of Um 2 on last slot in ability bar 2, passing bracelet to the left slot, and eth gloves to the left of that slot. 
--My surge is on ab bar 5 in the far right slot, however I believe there is an activate_surge() in API you can substitute for my surge() function.

--[[
Stuff to maybe (probably not) be implemented in future

Autostop when no impure essence found in bank
  Resupply through GE
GUI
  Runes made
  Profit
  Runtime
  XP gained & XP/hr
  Other spirit runes
  Bladed dive
Breaks (ha)
]]


local API = require("api")

-- Item/Object/NPC IDs
local impureEss = 55667
local darkPortal = 127376
local miasmaAltar = 127383
local bankChest = 127271

-- Functions
local function equipBracelet()
    print("Wear Bracelet")
    API.DoAction_Interface(0xffffffff, 0xdc60, 2, 1430, 220, -1, 3808)
    API.RandomSleep2(1200,1200,1200)
end

local function teleportHauntHill()
    print("Teleport to Haunt on the Hill")
    API.DoAction_Interface(0xffffffff, 0xdc60, 2, 1430, 220, -1, 3808)
    API.RandomSleep2(1200,1200,1200)
    API.WaitUntilMovingandAnimEnds()
end

local function equipEthGloves()
    print("Wear Eth Gloves")
    API.DoAction_Interface(0xffffffff, 0x7e68, 2, 1430, 207, -1, 3808)
    API.RandomSleep2(1200,1200,1200)
end

local function interactDarkPortal()
    print("Interact with Dark Portal")
    API.DoAction_Object_r(0x39, 0, { darkPortal }, 50, WPOINT.new(1163, 1819, 0), 5)
    API.RandomSleep2(1200,1200,1200)
    API.WaitUntilMovingandAnimEnds()
end

local function walkTowardsMiasmaAltar()
    print("Walk toward Altar")
    API.DoAction_Tile(WPOINT.new(1324, 1952, 0))
end

local function surge()
    print("Surge")
    API.DoAction_Interface(0x2e, 0xffffffff, 1, 1430, 194, -1, 3808)
    API.RandomSleep2(1200,1200,1200)
end

local function craftRunes()
    print("Crafting Runes")
    API.DoAction_Object_r(0x29, 0, { miasmaAltar }, 50, WPOINT.new(1325, 1950, 0), 5)
    API.RandomSleep2(600,600,600)
    API.WaitUntilMovingandAnimEnds()
end

local function bankTeleport()
    print("Teleport to bank area")
    API.DoAction_Interface(0x2e, 0xd97c, 1, 1430, 233, -1, 3808)
    API.RandomSleep2(1200,1200,1200)
    API.WaitUntilMovingandAnimEnds()
end

local function loadLastPreset()
    print("Load Last Preset")
    API.DoAction_Object_r(0x33, 240, { bankChest }, 50, WPOINT.new(1150, 1804, 0), 5)
    API.RandomSleep2(1200,1200,1200)
    API.WaitUntilMovingandAnimEnds()
end

-- Main loop
API.Write_LoopyLoop(true)
while API.Read_LoopyLoop() do
    if API.InvFull_() then
        API.PIdle2()
        -- Make Miasma
        print("Making runes")
        -- Wear Bracelet
        equipBracelet()
        -- Teleport to Haunt on the Hill
        teleportHauntHill()
        -- Wear Eth Gloves
        equipEthGloves()
        -- Click Dark Portal
        interactDarkPortal()
        walkTowardsMiasmaAltar()
        -- Surge
        surge()
        -- Craft Runes
        craftRunes()
    else
        -- Teleport to bank area
        bankTeleport()
        -- Load Last Preset
        loadLastPreset()
        API.PIdle2()
    end
    API.RandomSleep2(500, 3050, 12000)
end

