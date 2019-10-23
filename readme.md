

# trying to figure out lua class loading

Had to change the LUA_PATH export to this

```bash
export LUA_PATH="./?/init.lua;./?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua"
```

The part I added (the interesting bit) on the front looks like this

```bash
"./?/init.lua"
```

That says that when you run this type of code in lua

```lua
local HC = require("funk)
```

That you should look in the directory
```
./funk/init.lua
```

To load that module.

I was really doing this trying to figure out why/how to use hardoncollider in a love2d project. That projects looks to only come in a luarocks spec and everything I read indicated that using luarocks and love2d projects is not a good combination.


## more stuff on loading once in init.lua

The other interesting thing is that in the file init.lua the variable

```lua _NAME ```

Is set to the module (in my case funk),
At that point you can be super selective about loading other modules and they will come from your directory.

```lua
require(_NAME .. ".class")
```

That require needs to be in the init.lua file. That will load another file from here on disk

``` ./funk/class.lua ```

The point here is that you can control your names (you namespace) with this loading mechanism.

## class
Lua out of the box at least for 5.1 does not have a traditional OO class builtin. You must provide it. I usually write this myself and I skip the parts that generally do not matter to me.

HardonCollider has more strict requirements in that area and wants to use something called class commons. See the next section.

## common class loading?

https://github.com/bartbes/Class-Commons 
