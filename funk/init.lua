local _NAME,common_local = ...,common

print("_NAME: " .. _NAME)

--[[
print("common_local: " .. common_local)
print("common: " .. common)
]]

if not (type(common) == "table" and common.class) then
    print(common_class)
    assert(common_class ~= false, "no class common avail")
    print("about to require " .. _NAME .. ".class")
    require(_NAME .. ".class")
end