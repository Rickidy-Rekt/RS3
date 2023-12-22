print("Run Lua script GlacorTesting.")

-- Load required modules
local API = require("api")
local Utility = require("Utility")

-- Player information
local player = API.GetLocalPlayerName()
local needsToBank = false

-- IDs for various game elements
local ID = {
    archGlacor = 28241,
    aqueductPortal = 121338,
    glacorPortal = 121378,
    wrBank = 114750
}

-- Animation IDs
local glacorAnim = {
    rAttack1 = 34274,
    rAttack2 = 34275,
    magAttack1 = 34272,
    magAttack2 = 34273
}

-- Item IDs
local foodID = {
    shark = 385
}

-- Buff IDs
local buffID = {
    pRenewalActive = 14695
}

-- Prayer IDs
local prayerRenewal = {
    pRenewal1 = 33176,
    pRenewal2 = 33178,
    pRenewal3 = 33180,
    pRenewal4 = 33182,
    pRenewal5 = 33184,
    pRenewal6 = 33186
}

-- Super Restore IDs
local superRestore = {
    sRestore1 = 23409,
    sRestore2 = 23407,
    sRestore3 = 23405,
    sRestore4 = 23403,
    sRestore5 = 23401,
    sRestore6 = 23399
}

-- Prayer IDs
local prayerID = {
    pMelee = 25961,
    pRange = 25960,
    pMage = 25959
}

local function bank()

end

-- Function to eat food
local function eatFood()
    if API.InvItemFound1(foodID.shark) then
        API.KeyboardPress(4, 100, 0) -- Press key 4
    else
        API.KeyboardPress(8 , 100, 0) -- Press key F, tele to Wars Retreat
    end
end

-- Function to get glacor animation
local function glacorAnimation()
    return API.FindNPCbyName("Arch-Glacor", 100).Anim
end

local function lootAll()
    if API.LootWindowOpen_2() and (API.LootWindow_GetData()[1].itemid1 > 0) then
        print("First Loot All Attempt")
        API.DoAction_LootAll_Button()
        API.RandomSleep2(1000, 250, 250)
    end
end


-- Functions for checking prayer status
local function prayingMage()
    return API.Buffbar_GetIDstatus(prayerID.pMage, false).id > 0
end

local function prayingRange()
    return API.Buffbar_GetIDstatus(prayerID.pRange, false).id > 0
end

-- Functions for praying
local function prayMage()
    if not prayingMage() then
        API.KeyboardPress(1, 100, 0) -- 1
    end
end

local function prayRange()
    if not prayingRange() then
        API.KeyboardPress(2, 100, 0) -- 2
    end
end

-- Function to check for prayer renewal items
local function hasPrayerRenewal()
    for _, value in pairs(prayerRenewal) do
        if API.InvItemcount_1(value) > 0 then
            return true
        end
    end
    return false
end

-- Function to check if prayer renewal is active
local function prayerRenewalActive()
    local buffStatus = API.Buffbar_GetIDstatus(buffID.pRenewalActive, false)
    if buffStatus and buffStatus.id > 0 then
        print("Prayer renewal active")
        return true
    else
        print("Prayer renewal not active")
        return false
    end
end


-- Function to use prayer renewal
local function usePrayerRenewal()
    API.KeyboardPress(6, 100, 0) -- Press 6
end

-- Function to check for super restore items
local function hasSuperRestore()
    for _, value in pairs(superRestore) do
        if API.InvItemcount_1(value) > 0 then
            return true
        end
    end
    return false
end

-- Function to use super restore
local function useSuperRestore()
    if hasSuperRestore() then
        API.KeyboardPress(7, 100, 0) -- Press 7
    end
    print("Player does not have super restore")
    return false
end

-- Main loop
API.Write_LoopyLoop(true)
while API.Read_LoopyLoop() do
    while API.FindNPCbyName("Arch-Glacor", 100) do
        print("In combat")
        --[[
        -- Check HP
        print("Prayer Percent Below 20: " .. tostring(API.GetHPrecent() < 20))
        if API.GetHPrecent() < 20 then
            print("Health below 20%, executing eatFood()")
            eatFood()
        end
        ]]
        -- Check prayer
        
        --Currently implementing banking if no prayer renewals and under 10% hp
       --[[ if not hasPrayerRenewal() and API.GetHPrecent() < 10 then
            API.KeyboardPress(8, 600, 0)
            API.WaitUntilMovingandAnimEnds()
            
    
            needsToBank = true
            while needsToBank do
                if not API.BankOpen2() then
                    API.DoAction_Object1()
                    API.WaitUntilMovingEnds()
                    API.RandomSleep2(600,600,600)
                end
                bank()
            end

        end
]]
        if not prayerRenewalActive() and hasPrayerRenewal() then
            usePrayerRenewal()
        end

        print("Prayer Percent: " .. API.GetPrayPrecent())
        if API.GetPrayMax_() < 20 then
            print("Prayer below 20%, executing prayer-related code")
            

            if prayerRenewalActive() and API.GetPrayMax_() < 20 and hasSuperRestore() then
                print("Using super restore")
                useSuperRestore()
            end
        end

        -- Check glacor animation for mage attack
        print("Checking Glacor Magic Attack Animations")
        if glacorAnimation() == glacorAnim.magAttack1 or glacorAnimation() == glacorAnim.magAttack2 then
            print("Activating mage prayer")
            prayMage()
        end

        -- Check glacor animation for range attack
        print("Checking Glacor Range Attack Animations")
        if glacorAnimation() == glacorAnim.rAttack1 or glacorAnimation() == glacorAnim.rgAttack2 then
            print("Activating range prayer")
            prayRange()
        end
        

        if not API.LootWindowOpen_2() then
            API.KeyboardPress2(0x09, 200, 200)  -- Simulate pressing the Tab key
        else
            lootAll()
        end
    end
    print("Out of Combat")
    API.RandomSleep2(500, 3050, 12000)
end


--[[
    Need to implement:

    Banking
    Traveling to Glacor
    Starting instance
    Checking Augments
    Using Siphons
    Using aura's
    looting -- somewhat done, just loots everything
    xp tracking
    loot tracking
    time tracking
    buying supplies when out 

]]
