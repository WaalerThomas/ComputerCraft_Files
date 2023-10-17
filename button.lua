function create(xPos, yPos, sWdith, sHeight, btnText)
    tempButton = {
        text = btnText,
        position = {x=xPos, y=yPos},
        size = {width=sWidth, height=sHeight}
    }

    return tempButton
end

function draw(button)
    term.setBackgroundColour(colors.green)
    term.setCursorPos(button.pos.x, button.pos.y)

    for y = button.pos.y, button.pos.y + button.size.height - 1, 1 do
        for x = button.pos.x, button.pos.x + button.size.width - 1, 1 do
            term.setCursorPos(x, y)
            term.write(" ")
        end
    end

    term.setCursorPos(button.pos.x, button.pos.y)
    term.write(button.text)

    term.setBackgroundColour(colors.gray)
end