function()
    function switch(condition, cases)
        return (cases[condition] or cases.default)()
    end
    
    local res = switch(aura_env.lastMistake,
        {
            [1] = function() return "You pressed DS without 5 stacks" end,
            [2] = function() return "You let your stacks fade" end,
            [3] = function() return "You wasted bone shield stacks" end,
            [4] = function() return "DON'T PRESS DEATH COIL" end,
            default = function() return "" end
    })
    
    return res
end
