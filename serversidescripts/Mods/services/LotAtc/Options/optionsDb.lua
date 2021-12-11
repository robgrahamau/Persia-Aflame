local DbOption = require('Options.DbOption')
local Name = DbOption.Item


local user_profiles = lfs.writedir() .. 'Mods\\services\\LotAtc\\profiles'
local profiles = {  }

for file in lfs.dir(user_profiles) do
    local full_path = user_profiles .. "\\" .. file
    if lfs.attributes(full_path,"mode") == "file" then
        local f = assert(loadfile(full_path))
        local profile = {}
        if f then
            profile = f() 
            if profile and profile.profile_name  then
                --net.log("[LotAtc] Profile : load profile " .. file )
                profiles[#profiles+1] = Name(profile.profile_name):Value(file)
            else
                net.log("[LOTATC] ERROR : bad load profile " .. file )
            end
        else
            net.log("[LOTATC] ERROR : cannot load profile " .. file )
        end
    end
end

return {
    enable         = DbOption.new():setValue(false):checkbox():setEnforceable(),
    profile_file   = DbOption.new():setValue("arcade.lua"):setEnforceable():combo(profiles),
}
