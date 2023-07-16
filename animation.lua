local nikoanim = animations.niko
local nikomodel = models.niko.Root
local nikosun = models.niko.sun
local nikofakesun = models.niko.RightArm3

local ts = 0

--animations woaaa
events.TICK:register(function()
    local idle_random = math.random(30)
    if idle_random == 10 then
        nikoanim.idle_whiskers:play()
    end

    --sine
    if ts == 360 then
        ts = 0
    end
    ts = ts + 2

    --scarf
    nikomodel.scarf_float:setRot(vanilla_model.FAKE_CAPE:getOriginRot() + vec(-5 - 10 * math.sin(math.rad(ts)),0,0))

    --check sun
    local rightItem = player:getHeldItem(player:isLeftHanded())
    local leftItem = player:getHeldItem(not player:isLeftHanded())
    local using = player:isUsingItem()
    local swing = (player:getSwingArm() == "MAIN_HAND" or player:getSwingArm() == "OFF_HAND")
    if using or swing or rightItem.id ~= "minecraft:air" or leftItem.id ~= "minecraft:air" then sun = false end
    nikosun:setLight(15)
    nikofakesun:setLight(15)

    if sun then
        local leftrot = vanilla_model.LEFT_ARM:getOriginRot()
        local rightrot = vanilla_model.RIGHT_ARM:getOriginRot()
        nikosun:setVisible(true)
        nikomodel.LeftArm:setRot(30,0,0)
        nikomodel.RightArm:setRot(30,0,0)
        nikosun:offsetRot((leftrot + rightrot) / 2 + vec(0, 0, 0))
    else
        nikosun:setVisible(false)
        nikomodel.LeftArm:setRot(0,0,0)
        nikomodel.RightArm:setRot(0,0,0)
    end

    --fix vehicle
    if player:getVehicle() then
        nikomodel:setPos(0,5,0)
        --print("bleh")
    else
        nikomodel:setPos(0,0,0)
    end
end)

--sleeves
events.TICK:register(function()
    leftrot = vanilla_model.LEFT_ARM:getOriginRot()
    rightrot = vanilla_model.RIGHT_ARM:getOriginRot()
    nikomodel.LeftArm.LeftArmSleeve:setRot(-leftrot.x, 0, -leftrot.z)
    nikomodel.RightArm.RightArmSleeve:setRot(-rightrot.x, 0. -rightrot.z)
end)

--change arm
events.RENDER:register(function (t,ctx)
    local fakesun_swtich = (sun and ctx == "FIRST_PERSON")
    if ctx == "FIRST_PERSON" then
        nikomodel.RightArm:setVisible(false)
        nikomodel.LeftArm:setVisible(false)
    else
        nikomodel.RightArm:setVisible(true)
        nikomodel.LeftArm:setVisible(true)
    end
    models.niko.RightArm2:setVisible(ctx == "FIRST_PERSON" and not fakesun_swtich)
    models.niko.LeftArm2:setVisible(ctx == "FIRST_PERSON" and not fakesun_swtich)
    nikofakesun:setVisible(fakesun_swtich)
end)