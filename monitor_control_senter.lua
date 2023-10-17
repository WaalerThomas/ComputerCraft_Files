os.loadAPI("loUI")

-- TODO: Look into using the window api
-- TODO: Make the drawing part look better

-- Function decleration
function getMonitorSide()
    local available = peripheral.getNames()
    for index, peri in pairs(available) do
        if peripheral.getType(peri) == "monitor" then
            return peri
        end
    end
    return nil
end

term.clear()
term.setCursorPos(1, 1)

-- Find the monitor and wrap it
mon = peripheral.wrap( tostring(getMonitorSide()) )
if mon == nil then
    error("Could not find the monitor!")
end

print("Monitor found!")
print("[Q]: Quit, [R]: Restart")

-- Redirect the terminal to the wrapped monitor and set everything up
local oldTerm = term.redirect(mon)
term.setBackgroundColour(colors.gray)
term.setTextColour(colors.white)
--mon.setTextScale(0.75)
term.clear()

-- UI variables
local guiList = {}
local timerTime = 3
local someNum = 0

function btnClicked(args)
    loUI.updateTextLabel(guiList["lbl_1"], args[1].." has been clicked")
end

guiList["btn_1"] = loUI.createButton(2, 2, 12, 3, "Button", colors.blue, colors.white)
guiList["btn_2"] = loUI.createButton(5, 7, 6, 3, "OK", colors.green, colors.white)
guiList["lbl_1"] = loUI.createLabel(10, 10, 30, "Nothing", colors.gray, colors.white)
guiList["lbl_2"] = loUI.createLabel(1, 1, 10, tostring(someNum).." s", colors.gray, colors.white)
guiList["tglbtn_1"] = loUI.createToggleButton(35, 2, 12, 3, "Off", "On", colors.red, colors.white)

loUI.addClickedCallback(guiList["btn_1"], btnClicked, "Button")
loUI.addClickedCallback(guiList["btn_2"], btnClicked, "Ok bruh")

-- Main program loop
os.startTimer(timerTime) -- 1 second long
while true do
    local eventValues = { os.pullEvent() }

    if eventValues[1] == "monitor_touch" then
        for index, element in pairs(guiList) do
            if element.clickable == true then
                if loUI.clicked(element, eventValues[3], eventValues[4]) then
                    if element["type"] == "togglebutton" then
                        element.current_state = (element.current_state == 1) and 2 or 1
                    end
                    
                    if element["func_clicked"] ~= nil then
                        element.func_clicked(element.clicked_args)
                    end
                    break
                end
            end
        end
    
    elseif eventValues[1] == "key_up" then
        if eventValues[2] == keys.q then -- Breaks out of the loop and stops the program
            break
        elseif eventValues[2] == keys.r then -- Restart the computer
            os.reboot()
        end

    elseif eventValues[1] == "timer" then
        someNum = someNum + timerTime
        loUI.updateTextLabel(guiList["lbl_2"], tostring(someNum).." s")

        os.startTimer(timerTime) -- Restarts timer
    end

    -- Draw Elements
    for index, element in pairs(guiList) do
        if element["type"] == "button" then
            loUI.drawButton(element)
        elseif element["type"] == "togglebutton" then
            loUI.drawToggleButton(element)
        elseif element["type"] == "label" then
            loUI.drawLabel(element)
        end
    end
end

-- Revert to default after use
term.setCursorPos(1, 1)
term.setBackgroundColour(colors.black)
term.setTextColour(colors.white)
mon.setTextScale(1)
term.clear()
term.redirect(oldTerm)