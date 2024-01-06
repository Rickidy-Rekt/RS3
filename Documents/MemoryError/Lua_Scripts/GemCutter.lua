print("Run Lua script GemCutter.")

local API = require("api")

local var1 = 0
local var2 = 0
local geBank = 3418

--Exported function list is in API
--main loop
API.Write_LoopyLoop(true)
while(API.Read_LoopyLoop())
do-----------------------------------------------------------------------------------


    if API.InvItemFound1(1617) then
            print("Gems found: " .. tostring(API.InvItemFound1(1617)))
            print("Abilitybar interaction")
            API.DoAction_Interface(0x2e,0x651,1,1430,77,-1,5376);
            API.RandomSleep2(1200,1200,1200)
            print("Interface interaction")
            API.DoAction_Interface(0xffffffff,0xffffffff,0,1370,30,-1,4496)
            API.RandomSleep2(1200,1200,1200)
            print("Waiting for anim end")
            while API.isProcessing() do
                print("Processing")
                API.RandomSleep2(600,600,600)
            end
            print("Anim end")

        else
            API.DoAction_NPC(0x5,3120,{ geBank },50)
            API.RandomSleep2(1200,1200,1200)
            API.DoAction_Interface(0x24,0xffffffff,1,517,119,1,5376);
            API.RandomSleep2(1200,1200,1200)
        end




API.RandomSleep2(500, 3050, 12000)
end----------------------------------------------------------------------------------

