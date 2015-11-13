# lua-using
using() function for Lua.

## Examples

Program:
```lua
local using = require"using".using

local mt = { __gc = print }

local function example()
  using(setmetatable({}, mt), function(file, func)
    error("the file should get cleaned up")
  end)
end

xpcall(example, print)
print "did we cleanup? yes!"
```

Output:
```
table: 0xe5d010
./using.lua:11: example.lua:7: the file should get cleaned up
did we cleanup? yes!
```
