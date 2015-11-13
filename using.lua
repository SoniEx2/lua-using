-- lua-using 1.0
local function cleanret(ret)
  collectgarbage()
  collectgarbage()
  return table.unpack(ret, 1, ret.n)
end

local function cleanerr(errmsg)
  collectgarbage()
  collectgarbage()
  error(errmsg)
end

return {
  using = function(...)
    local f = select(-1, ...) -- get the function
    local co = coroutine.create(f) -- make a coroutine
    local ret = table.pack(coroutine.resume(co, ...)) -- we pass the function into itself as the last arg
    while true do
      local status = table.remove(ret, 1)
      if status then
        if coroutine.status(co) == "dead" then return cleanret(ret) end
        ret = table.pack(coroutine.resume(co, coroutine.yield(table.unpack(ret, 1, ret.n))))
      else
        return cleanerr(table.remove(ret, 1))
      end
    end
    error("unreachable")
  end
}
