-- Start setup
print("Opening network and hosting from mainServerComs")
rednet.open("top")
rednet.host("mainServerComs", "main_server")

local computers = {}

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end 

while true do
    local eventValues = { os.pullEvent() }

    if eventValues[1] == "key_up" then
        if eventValues[2] == keys.q then
            -- TODO: Broadcast that server is shutting down
            break
        end
    
    elseif eventValues[1] == "rednet_message" and eventValues[4] == "mainServerComs" then
        if tostring(eventValues[3]) == "connected" then
            print("Computer "..eventValues[2].." connected!")
            table.insert(computers, eventValues[2])
        
        elseif tostring(eventValues[3]) == "disconnected" then
            print("Computer "..eventValues[2].." disconnected!")
            for index, comp in pairs(computers) do
                if comp == eventValues[2] then
                    table.remove(computers, index)
                    break
                end
            end

        elseif tostring(eventValues[3]) == "lights" then
            if rs.getOutput("right") then
                rs.setOutput("right", false)
            else
                rs.setOutput("right", true)
            end
        end

        print()
        print(#computers.." connected computers")
        print(dump(computers))
    end
end

-- Cleanup
print("Unhosting from mainServerComs and closing network")
rednet.unhost("mainServerComs", "main_server")
rednet.close("top")