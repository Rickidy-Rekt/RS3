-- Run Lua script BoneRC_V0.

local API = require("api")
local totalRunesCrafted = 0
local totalEstimatedProfit = 0
local medPrice = 562


-- Exported function list is in API

-- Main loop
API.Write_LoopyLoop(true)
while API.Read_LoopyLoop() do
    -- Do I have bone runes?
    if API.InvItemFound1(55338) then
        -- Time to bank
        -- Teleport to bank area
        if not API.PInArea(1148, 30, 1807, 30, 1) then
            API.DoAction_Interface(0x2e, 0xd97c, 1, 1430, 233, -1, 5376)
            API.RandomSleep2(1200,1200,1200)
        else
            -- Sleep until teleport complete?
            API.WaitUntilMovingandAnimEnds()
            print("TeleComplete")

            if not API.BankOpen2() then
                -- Access Bank
                API.DoAction_Object1(0x2e, 80, {127271}, 50, {1150, 1804, 0}, 5)
                API.RandomSleep2(1200,1200,1200)
                API.WaitUntilMovingandAnimEnds()
                print("Bank Move complete")
            end

            -- Check if bank is open
            if API.BankOpen2() then
                print("Bank is open")
                
                -- Fill pouches
                API.DoAction_Interface(0x24, 0xffffffff, 1, 517, 56, -1, 5376)
                API.RandomSleep2(500, 550, 1000)
                -- Fill each pouch
                API.DoAction_Interface(0xffffffff, 0x1585, 8, 517, 15, 0, 6096) -- Small pouch
                API.RandomSleep2(500, 550, 1000)
                API.DoAction_Interface(0xffffffff, 0x1586, 8, 517, 15, 1, 6096) -- Medium pouch
                API.RandomSleep2(500, 550, 1000)
                API.DoAction_Interface(0xffffffff, 0x1588, 8, 517, 15, 2, 6096) -- Large pouch
                API.RandomSleep2(500, 550, 1000)
                API.DoAction_Interface(0xffffffff, 0x158a, 8, 517, 15, 3, 6096) -- Giant pouch
                API.RandomSleep2(500, 550, 1000)
                API.DoAction_Interface(0xffffffff, 0x5e8d, 8, 517, 15, 4, 6096) -- Massive pouch
                API.RandomSleep2(500, 550, 1000)

                -- Fill Eth Body
                API.DoAction_Interface(0x24, 0xffffffff, 1, 517, 60, -1, 5376)
                API.RandomSleep2(500, 550, 1000)
                -- Fill body
                API.DoAction_Interface(0xffffffff, 0x7f45, 2, 517, 28, 4, 5376) -- Infinity Ethereal Body
                API.RandomSleep2(500, 550, 1000)
                
                -- Grab preset
                API.DoAction_Interface(0x24,0xffffffff,1,517,119,1,5376) -- Preset 1
                API.RandomSleep2(500, 550, 1000)

                -- Close bank
                API.BankClose()

                API.RandomSleep2(500, 550, 1000)
            end
        end
    else 
        -- Run to altar
        if not API.PInArea(1164, 15, 1822, 15, 1) then
            print("Moving to portal, then waiting until end animation/movement")
            API.DoAction_Tile(WPOINT.new(1163, 1821, 1))
            -- Wait until movement stops
            API.WaitUntilMovingandAnimEnds()
            print("Waiting complete")
           -- if API.PInArea(1164, 15, 1822, 15, 1) then
                print("Clicking Portal")
                API.DoAction_Object1(0x39,0,{ 127376 },50,{1163,1819,0},5)
                API.WaitUntilMovingandAnimEnds()
            --end
            -- Click Bone Altar
            
                API.DoAction_Object1(0x29,0,{ 127381 },50,{1294,1957,0},5)
            API.RandomSleep2(500, 550, 1000)
            API.WaitUntilMovingandAnimEnds()
            --API.RandomSleep2(1200,1200,1200)
            
            

            totalRunesCrafted = totalRunesCrafted + API.InvStackSize(55338)
            local formattedRunesCrafted = string.format("%0.0f", totalRunesCrafted)
            print("Total Runes")
            print(formattedRunesCrafted)

            totalEstimatedProfit = totalRunesCrafted * medPrice
            print()
            

            local formattedProfit = string.format("%0.0f", totalEstimatedProfit)
            print("Estimated profit: " .. tostring(formattedProfit))
            API.PIdle2()
        end
    end

    API.RandomSleep2(500, 550, 1000)
end
