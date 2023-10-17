term.clear()
term.setCursorPos(1, 1)

print("=====================")
print("Area Clearing v1.0")
print("Made by TomWaa")
print("=====================")
print()

local length = 0
local width = 0
local height = 0
local lengthLeft = 0
local widthLeft = 0
local heightLeft = 0

-- TODO: Add limits on length, width and height

term.write("Length: ")
length = tonumber( read() )
lengthLeft = length

term.write("Height: ")
height = tonumber( read() )
heightLeft = height

term.write("Width: ")
width = tonumber( read() )
widthLeft = width

print()
print("Area Specified: WxHxL " .. width .. "x" .. height .. "x" .. length)
print("Total Area: " .. (width * height * length))

function fuelCheck(steps)
    -- Will sit and wait until can be refueled
    turtle.select(1)
    if turtle.getFuelLevel() <= steps then
        print("[WARNING] - Out of fuel, please add to first slot")
        while not turtle.refuel() do
        end
    end
end

-- Movement functions
function clearTrippleForward(steps)
    fuelCheck(steps)

    for i=1, steps, 1 do
        while not turtle.forward() do
            turtle.dig()
        end
        turtle.digUp()
        turtle.digDown()
    end
end

function clearDoubleForward(steps)
    fuelCheck(steps)

    for i=1, steps, 1 do
        while not turtle.forward() do
            turtle.dig()
        end
        turtle.digUp()
    end
end

function clearForward(steps)
    fuelCheck(steps)

    for i=1, steps, 1 do
        while not turtle.forward() do
            turtle.dig()
        end
    end
end

function turnAround()
    turtle.turnLeft()
    turtle.turnLeft()
end

-- Main mining loop
local digFinished = false
local willTurnRight = true
while not digFinished do
    print("[LOG]: Height left = "..heightLeft)

    if heightLeft >= 3 then
        -- Will position itself to dig a 1x3 tunnel
        -- Only be run once at the start
        if height == heightLeft then
            print("[LOG]: Getting into place")
            turtle.dig()
            turtle.forward()
            turtle.digUp()
            turtle.up()
            turtle.digUp()
        end

        for i=1, width, 1 do
            clearTrippleForward(length - 1)
            if i == width then break end

            if willTurnRight then turtle.turnRight() else turtle.turnLeft() end

            while not turtle.forward() do
                turtle.dig()
            end
            turtle.digUp()
            turtle.digDown()

            if willTurnRight then turtle.turnRight() else turtle.turnLeft() end
            willTurnRight = not willTurnRight
        end

        heightLeft = heightLeft - 3
        turtle.up()
    elseif heightLeft == 2 then
        if height == heightLeft then
            print("[LOG]: Getting into place")
            turtle.dig()
            turtle.forward()
            turtle.digUp()
        end

        for i=1, width, 1 do
            clearDoubleForward(length - 1)
            if i == width then break end

            if willTurnRight then turtle.turnRight() else turtle.turnLeft() end

            while not turtle.forward() do
                turtle.dig()
            end
            turtle.digUp()

            if willTurnRight then turtle.turnRight() else turtle.turnLeft() end
            willTurnRight = not willTurnRight
        end

        heightLeft = heightLeft - 2
        turtle.up()
    else
        if height == heightLeft then
            print("[LOG]: Getting into place")
            turtle.dig()
            turtle.forward()
        end

        for i=1, width, 1 do
            clearForward(length - 1)
            if i == width then break end

            if willTurnRight then turtle.turnRight() else turtle.turnLeft() end

            while not turtle.forward() do
                turtle.dig()
            end

            if willTurnRight then turtle.turnRight() else turtle.turnLeft() end
            willTurnRight = not willTurnRight
        end
        
        heightLeft = heightLeft - 1
        turtle.up()
    end

    if heightLeft <= 0 then digFinished = true
    elseif heightLeft >= 3 then
        turnAround()
        for i=1, 3, 1 do
            while turtle.detectUp() do
                turtle.digUp()
            end
            if i < 3 then
                while not turtle.up() do
                    turtle.digUp()
                end
            end
        end
    elseif heightLeft == 2 then
        turnAround()
        turtle.digUp()
        turtle.up()
        turtle.digUp()
    else
        turnAround()
        turtle.digUp()
        turtle.up()
    end
end

print("Finished!")