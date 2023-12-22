print("Run Lua script GlacorTesting.")

local API = require("api")
local Utility = require("Utility")

local player = API.GetLocalPlayerName()

local ID = {
    archGlacor = 28241,
    aqueductPortal = 121338,
    glacorPortal = 121378,
    wrBank = 114750

}

local glacorAnim = {
    rAttack1 = 34274,
    rAttack2 = 34275,
    magAttack1 = 34272,
    magAttack2 = 34273
}

local foodID = {
    shark = 385
}

local buffID = {
    pRenewalActive = 14695
}

local prayerRenewal = {
    pRenewal1 = 33176,
    pRenewal2 = 33178,
    pRenewal3 = 33180,
    pRenewal4 = 33182,
    pRenewal5 = 33184,
    pRenewal6 = 33186
}

local superRestore = {
    sRestore1 = 23409,
    sRestore2 = 23407,
    sRestore3 = 23405,
    sRestore4 = 23403,
    sRestore5 = 23401,
    sRestore6 = 23399
}

local prayerID = {
    pMelee = 25961,
    pRange = 25960,
    pMage =  25959
}

--eatFood only works with sharks right now -> add more later
local function eatFood()
    if API.InvItemFound1(foodID.shark) then
        API.KeyboardPress(0x34, 600, 0) -- Press key 4
    else
        API.KeyboardPress(0x46, 600, 0) -- Press key F
    end
end



local function glacorAnimation()
    return API.FindNPCbyName("Arch-Glacor", 100).Anim
end

local function prayingMage()
    return
    API.Buffbar_GetIDstatus(prayerID.pMage,true).id > 0
end

local function prayingRange()
    return
    API.Buffbar_GetIDstatus(prayerID.pRange,true).id > 0
end
--[[
local function prayingMelee()
    return
    API.Buffbar_GetIDstatus(prayerID.pMelee,true).id > 0
end
]]
local function prayMage()
    if not prayingMage() then
        API.KeyboardPress(0x31, 600, 0) -- 1
    end
end

local function prayRange()
    if not prayingRange() then
        API.KeyboardPress(0x32, 600, 0) -- 2
    end
end

--[[
    local function prayMelee()
    if not prayingMelee() then
        API.KeyboardPress(0x33, 600, 0) -- 3
    end
end
--]]

local function hasPrayerRenewal()
    for _, value in pairs(prayerRenewal) do
        if API.InvItemcount_1(value) > 0 then
            return true
        end
    end

    return false
end

local function prayerRenewalActive()
    if API.Buffbar_GetIDstatus(buffID.pRenewalActive, false) > 0 then
        return true
    end
end



local function usePrayerRenewal()
    API.KeyboardPress(0x36,600,0) -- Press 6
end

local function hasSuperRestore()
    for _, value in pairs(superRestore) do
        if API.InvItemcount_1(value) > 0 then
            return true
        end
    end

    return false
end

local function useSuperRestore()
    if hasSuperRestore() then
        API.KeyboardPress(0x37, 600, 0)
    end
end



--main loop
API.Write_LoopyLoop(true)
while(API.Read_LoopyLoop())
do-----------------------------------------------------------------------------------

while API.IsInCombat_(player) do
    print(API.GetPray_())
    print(API.GetHP_())

    if API.GetHPrecent < 20 then
        eatFood()
    end

    -- Implement these functions below
    if API.GetPrayMax_() < 20 then
        if not prayerRenewalActive() and hasPrayerRenewal() then
            usePrayerRenewal()
        end

        if prayerRenewalActive() 
        and API.GetPrayMax_() < 20 then
            useSuperRestore()
        end
    end
-----------------------------------------

    if glacorAnimation() == glacorAnim.magAttack1 or
       glacorAnimation() == glacorAnim.magAttack2 then
        prayMage()
    
    end

    if glacorAnimation() == glacorAnim.rAttack1 or
       glacorAnimation() == glacorAnim.rgAttack2 then
        prayRange()
    end

    --if glacorAnimation() == '' then
    --    prayMelee()
    --end


end





API.RandomSleep2(500, 3050, 12000)
end----------------------------------------------------------------------------------


-- Plan
-- If not at Wars retreat -> Tele wars retreat
-- Withdraw Preset 1
--  Check Fury ammy
--      Check augment levels
    --      If augment lvl 9 -> use siphon
        --  If no siphon buy more
    
    -- Check prayer
        --If > PrayerMax -> click Altar of War
            -- Check Inv for
            -- Super Ranging, Super pray renewal, & Super restore flask
                -- If none in bank, buy more
            -- Check for sharks
                -- If none in bank, buy more
    -- Check Health
        --If health > maxHealth -> Stand @ war retreat bank until maxHealth

    --Check aura's
        -- if Vamp available, use
            -- Check if vamp/penance currently in use
            -- If Vamp not available, but penance is, use penance
                --if Neither, continue to combat

    -- Go to Arch Glacor Portal -> DoAction_Object1(0x39,0,{ ID.glacorPortal },50,{3290,10154,0},5)
    -- Aqueduct Portal -> DoAction_Object1(0x39,0,{ aqueductPortal },50,{1751,1102,0},5)
    -- Start instance -> DoAction_Interface(0x24,0xffffffff,1,1591,60,-1,5376) 
        -- While inInstance() do
            --If glacorAnimation = mageAttack -> prayMage
            --If glacorAnimation = rangeAttack -> prayRange
            --If glacorAnimation = meleeAttack -> prayMelee