local using = require"using".using

local mt = { __gc = print }

local function example()
  using(setmetatable({}, mt), function(file, func)
    error("the file should get cleaned up")
  end)
end

xpcall(example, print)
print "did we cleanup? yes!"
