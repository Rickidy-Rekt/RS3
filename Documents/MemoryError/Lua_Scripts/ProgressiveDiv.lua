print("Run Lua script ProgressiveDiv.")

local API = require("api")


local divAnimation = 21228



local wispID = {
    paleWisp = 18150,
    flickeringWisp = 18151,
}

local energyRift = 87306

local Player = API.GetLocalPlayerName()
local SELECTED_WISP = "Pale wisp"

--Exported function list is in API
--main loop
API.Write_LoopyLoop(true)
while(API.Read_LoopyLoop())
do-----------------------------------------------------------------------------------

if API.Invfreecount_() > 0 and not API.IsPlayerAnimating_(Player, 5) then
    print("Inventory free count: " .. tostring(API.Invfreecount_() > 0))
    print("Animating: " .. tostring(API.IsPlayerAnimating_(Player, 5)))

    print("Interacting, then wait")
    API.DoAction_NPC(0xc8,3120,{ wispID.flickeringWisp },50)
    API.RandomSleep2(1200,1200,1200)
    API.WaitUntilMovingandAnimEnds()
    print("Interact wait complete")
    API.PIdle2()
else
    print("Offer, then wait")
    API.DoAction_Object1(0xc8,0,{ energyRift },50,{3120,3215,0},5)
    API.RandomSleep2(1200,1200,1200)
    API.WaitUntilMovingandAnimEnds()
    print("Offer Wait complete")
    API.PIdle2()
end
--[[
    
if API.Invfreecount_() > 0 then


end

]]


API.RandomSleep2(500, 3050, 12000)
end----------------------------------------------------------------------------------

-- Detect enhanced wisps
--Travel from locations
--Select location based from level

--Maybe support boons?
--Div urns
