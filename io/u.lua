local io = require ((...):gsub("%.[^%.]+$", ""))
local u = {}

function u.unpack(_, buf)
    local n = 0
    local e = io("endianness", "get")
    
    local sof,eof,step
    if e == "big" then
        sof,eof,step = 1,#buf,1
    else
        sof,eof,step = #buf,1,-1
    end
    
    for i=sof,eof,step do
        n = n * 256 + buf:sub(i,i):byte()
    end
    
    return n
end

function u.pack(_, data, width)
    local s = ""
    local e = io("endianness", "get")
    
    for i=1,width do
        if e == "big" then
            s = string.char(data % 256) .. s
        else
            s = s .. string.char(data % 256)
        end
        data = math.trunc(data/256)
    end
    
    return s
end

return u
