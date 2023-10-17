-- UI elements to be added:
--      Link ??
--      Progress bar
--          Vertical and Horizontal
--      Groups
--      Graph ??
--      List
--          Scrollable ??

--[[
======================================
=============== Button ===============
======================================
]]
function createButton(xPos, yPos, sWidth, sHeight, btnText, bgColor, fgColor)
    tempButton = {
        type = "button",
        text = btnText,
        clickable = true,
        pos = {x=xPos, y=yPos},
        size = {width=sWidth, height=sHeight},
        color = {bg=bgColor, fg=fgColor},
        func_clicked = nil,
        clicked_args = {}
    }

    return tempButton
end

function drawButton(button)
    local orgBgColor = term.getBackgroundColor()
    local orgFgColor = term.getTextColor()
    
    term.setBackgroundColor(button.color.bg)
    term.setTextColor(button.color.fg)

    term.setCursorPos(button.pos.x, button.pos.y)

    for y = button.pos.y, button.pos.y + button.size.height - 1, 1 do
        for x = button.pos.x, button.pos.x + button.size.width - 1, 1 do
            term.setCursorPos(x, y)
            term.write(" ")
        end
    end

    term.setCursorPos(button.pos.x + (button.size.width - #button.text) / 2, button.pos.y + (button.size.height / 2))
    term.write(button.text)

    term.setBackgroundColor(orgBgColor)
    term.setTextColor(orgFgColor)
end
-- =====================================================================================

--[[
=============================================
=============== Toggle Button ===============
=============================================
]]
function createToggleButton(xPos, yPos, sWidth, sHeight, st1Text, st2Text, bgColor, fgColor)
    tempToggleButton = {
        type = "togglebutton",
        state_1 = st1Text,
        state_2 = st2Text,
        current_state = 1,
        clickable = true,
        pos = {x=xPos, y=yPos},
        size = {width=sWidth, height=sHeight},
        color = {bg=bgColor, fg=fgColor},
        func_clicked = nil,
        clicked_args = {}
    }

    return tempToggleButton
end

function drawToggleButton(tglButton)
    local orgBgColor = term.getBackgroundColor()
    local orgFgColor = term.getTextColor()
    
    term.setBackgroundColor(colors.lightGray)
    term.setTextColor(tglButton.color.fg)

    -- Draw the background of the toggle button
    for y = tglButton.pos.y, tglButton.pos.y + tglButton.size.height - 1, 1 do
        for x = tglButton.pos.x, tglButton.pos.x + tglButton.size.width - 1, 1 do
            term.setCursorPos(x, y)
            term.write(" ")
        end
    end

    local halfWidth = tglButton.size.width / 2
    local startX, btnText, activeBG
    if tglButton.current_state == 1 then
        startX = tglButton.pos.x
        btnText = tglButton.state_1
        activeBG = tglButton.color.bg
    else
        startX = tglButton.pos.x + halfWidth
        btnText = tglButton.state_2
        activeBG = colors.green
    end
    term.setBackgroundColor(activeBG)

    -- Draw the "button" part
    for y = tglButton.pos.y, tglButton.pos.y + tglButton.size.height - 1, 1 do
        for x = startX, startX + halfWidth - 1, 1 do
            term.setCursorPos(x, y)
            term.write(" ")
        end
    end

    -- Draw text
    term.setCursorPos(startX + (halfWidth - #btnText) / 2, tglButton.pos.y + (tglButton.size.height / 2))
    term.write(btnText)

    term.setBackgroundColor(orgBgColor)
    term.setTextColor(orgFgColor)
end
-- =====================================================================================

--[[
===========================================
=============== ProgressBar ===============
===========================================
]]
function createProgressBar()
end

function drawProgressBar()
end
-- =====================================================================================


--[[
=====================================
=============== Label ===============
=====================================
]]
function createLabel(xPos, yPos, maxLength, lbText, bgColor, fgColor)
    tempLabel = {
        type = "label",
        text = lbText,
        clickable = false,
        pos = {x=xPos, y=yPos},
        length = maxLength,
        color = {bg=bgColor, fg=fgColor}
    }

    return tempLabel
end

function clearLabel(label)
    local orgBgColor = term.getBackgroundColor()
    local orgFgColor = term.getTextColor()

    term.setBackgroundColor(label.color.bg)
    term.setTextColor(label.color.fg)

    term.setCursorPos(label.pos.x, label.pos.y)
    
    for i=label.pos.x, label.pos.x + label.length, 1 do
        term.write(" ")
    end

    term.setBackgroundColor(orgBgColor)
    term.setTextColor(orgFgColor)
end

function drawLabel(label)
    local orgBgColor = term.getBackgroundColor()
    local orgFgColor = term.getTextColor()

    term.setBackgroundColor(label.color.bg)
    term.setTextColor(label.color.fg)

    term.setCursorPos(label.pos.x, label.pos.y)
    term.write(label.text)
    for i=label.pos.x + #label.text, label.pos.x + label.length, 1 do
        term.write(" ")
    end

    term.setBackgroundColor(orgBgColor)
    term.setTextColor(orgFgColor)
end

function updateTextLabel(label, newText)
    label.text = newText
    clearLabel(label)
end
-- =====================================================================================

--[[
======================================
=============== Shared ===============
======================================
]]
function clicked(element, mouseX, mouseY)
    if not element.clickable then return false end
    
    if mouseX >= element.pos.x and mouseX <= element.pos.x + element.size.width and
    mouseY >= element.pos.y and mouseY <= element.pos.y + element.size.height then
        return true
    end

    return false
end

function addClickedCallback(element, func, ...)
    element.func_clicked = func
    element.clicked_args = { ... }
end
-- =====================================================================================