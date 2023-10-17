protocol = "mainServerComs"

-- Start setup
rednet.open("top")
serverID = rednet.lookup(protocol, "main_server")
if serverID == nil then
    error("Can't connect to the main server")
end

rednet.send(serverID, "connected", protocol)

while true do
    local eventValues = { os.pullEvent() }

    if eventValues[1] == "key_up" then
        if eventValues[2] == keys.q then
            break
        
        elseif eventValues[2] == keys.l then
            rednet.send(serverID, "lights", protocol)
            print("Toggling lights")
        end
    end
end

-- Cleanup
rednet.send(serverID, "disconnected", protocol)
rednet.close("top")