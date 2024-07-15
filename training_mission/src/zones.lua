Z_RRCCA = ZONE:New("RRCCA")
Z_RRCCA_A = false
Z_R446 = ZONE:New("R446")
Z_R446_A = false
Z_R441 = ZONE:New("R441")
Z_R441_A = false
Z_KRANGE = ZONE:New("KRANGE")
Z_KRANGE_A = false
Z_R551A = ZONE:New("R551A")
Z_R551A_A = false
Z_R552 = ZONE:New("R552")
Z_R552_A = false
Z_R550 = ZONE:New("R550")
Z_R550_A = false
Z_WISKA = ZONE:New("WISKA")
Z_WISKA_A = false
Z_KOBDEF = ZONE:New("KOB_DEF_ZONE")

function clean(_zone)
    local cleanup = trigger.misc.getZone(_zone)
    cleanup.point.y = land.getHeight({x = cleanup.point.x, y = cleanup.point.z})
    local volS = {
        id = world.VolumeType.SPHERE,
        params= {
            point = cleanup.point,
            radius = cleanup.radius
        }
    }
    world.removeJunk(volS)
  
end


function ACTIVATE_R446()
    if Z_R446_A == false then
        Z_R446:DrawZone(-1,{1,0,0},1,{1,0,0},0.25,2)
        Z_R441_A = true
    end
end

function ACTIVATE_R441()
    if Z_R441_A == false then
        Z_R441:DrawZone(-1,{1,0,0},1,{1,0,0},0.25,2)
        Z_R441_A = true
    end
end

function ACTIVATE_KRANGE()
    if Z_KRANGE_A == false then
        Z_KRANGE:DrawZone(-1,{1,0,0},1,{1,0,0},0.25,2)
        Z_KRANGE_A = true
    end
end


function ACTIVATE_R550()
    if Z_R550_A == false then
        Z_R550:DrawZone(-1,{1,0,0},1,{1,0,0},0.25,2)
        Z_R550_A = true
    end
end


function ACTIVATE_R551A()
    if Z_R551A_A == false then
        Z_R551A:DrawZone(-1,{1,0,0},1,{1,0,0},0.25,2)
        Z_R551A_A = true

    end
end

function ACTIVATE_R552()
    if Z_R552_A == false then
        Z_R552:DrawZone(-1,{1,0,0},1,{1,0,0},0.25,2)
        Z_R552_A = true
    end
end


function DEACTIVATE_R446()
    if Z_R446_A == true then
        Z_R446:UndrawZone(5)
        Z_R446_A = false
        clean('R446')
    end
end

function DEACTIVATE_R441()
    if Z_R441_A == true then
        Z_R441:UndrawZone(5)
        Z_R441_A = false
        clean('R441')
    end
end

function DEACTIVATE_KRANGE()
    if Z_KRANGE_A == true then
        Z_KRANGE:UndrawZone(5)
        Z_KRANGE_A = false
    end
end

function DEACTIVATE_R550()
    if Z_R550_A == true then
        Z_R550:UndrawZone(5)
        Z_R550_A = false
        clean('R550')
    end
end


function DEACTIVATE_R551A()
    if Z_R551A_A == true then
        Z_R551A:UndrawZone(5)
        Z_R551A_A = false
        clean('R551A')
    end
end

function DEACTIVATE_R552()
    if Z_R552_A == true then
        Z_R552:UndrawZone(5)
        Z_R552_A = false
        clean('R552')
    end
end

