local nikoanim = animations.niko
--TOGGLES--
--local toggle = action_wheel:newPage()

--EMOTES--
local emotes = action_wheel:newPage()

emotes:newAction()
:title("Wave")
:item("minecraft:lead")
:onLeftClick(function ()
    nikoanim.wave:play()
end)

--ROOT--
local rootPage = action_wheel:newPage()

rootPage:newAction()
:title("Emotes")
:item("minecraft:jukebox")
:onLeftClick(function ()
    action_wheel:setPage(emotes)
end)

rootPage:newAction()
:title("Sun")
:item("minecraft:sunflower")
:onLeftClick(function ()
    pings.change_sun()
end)

function pings.change_sun()
    sun = not sun
end

events.TICK:register(function()
    if not action_wheel:isEnabled() then
       action_wheel:setPage(rootPage)
    end
end)

action_wheel:setPage(rootPage)