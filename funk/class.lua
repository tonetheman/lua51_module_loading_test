

print("class.lua is running")

local function __NULL__() end

local function inherit(class, interface, ...)
    if not interface then
        return
    end

    for name, func in pairs(interface) do
        if not class[name] then
            class[name] = func
        end
    end

    for super in pairs(interface.__is_a or {}) do
        class.__is_a[super] = true
    end
end


local function new(args)
    local super = {}
    local name = "<unnamed class>"
    local constructor = args or __NULL__
    if type(args) == "table" then
        super = (args.inherits or {}).__is_a and {args.inherits} or args.inherits or {}
        name = args.name or name
        constructor = args[1] or __NULL__
    end
    local class = {}
    class.__index = class
    class.__tostring = function()
        return ("<instance of %s>"):format(tostring(class))
    end
    class.construct = construct or __NULL__
    class.inherit = inherit
    class.__is_a = {[class] = true}
    class.is_a = function(self, other)
        return not not self.__is_a[other]
    end
    inherit(class, unpack(super))

    local meta = {
        __call = function(self,...)
            local obj = {}
            setmetatable(obj,self)
            self.construct(obj,...)
            return obj
        end,
        __tostring = function()
            return name
        end
    }
    return setmetatable(class,meta)
end


if common_class ~= false and not common then
    common = {}
    function common.class(name, prototype, parent)
        local init = prototype.init or (parent or {}).init
        return new{name=name,inherits={prototype,parent}, init}
    end
    function common.instance(class,...)
        return class(...)
    end
end

return setmetatable({new=new,inherit=inherit},
    {__call = function(_,...) return new(...) end})