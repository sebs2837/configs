local random = math.random
local uuid = function()
    local template = 'xxxxxxxx_xxxx_4xxx_yxxx_xxxxxxxxxxxx'
    local uuid_str = string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%X', v)
    end)
    local guard = { "#ifndef GUARD_" .. uuid_str,
        "#define GUARD_" .. uuid_str,
        "#endif /* GUARD_" .. uuid_str .. " */"
    }
    return guard
end

return {
    s({ trig = 'guard', regTrig = false, wordTrig = false }, {
        f(uuid),
        i(1, ""),
        t("", ""),
    }),
    s("cr", f(function()
        return "/* Copyright " .. os.date("%Y") .. " CARIAD SE */"
    end
    ))

}
