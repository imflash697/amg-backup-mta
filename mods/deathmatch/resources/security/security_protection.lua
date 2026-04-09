-- Security Protection System for SQL Injection and Lua Execution Attacks

local Security = {}

-- Function to validate and sanitize input
function Security.validateInput(input)
    if type(input) ~= "string" then
        return nil, "Input must be a string."
    end
    -- Remove leading and trailing whitespace
    input = input:match("^%s*(.-)%s*$")
    -- Escape special characters
    input = input:gsub("["'&<>%$%^%*%(%);!{}%[%]", "")
    return input
end

-- Function to check for SQL injection patterns
function Security.isHealthySQL(input)
    local sqlInjectionPatterns = {
        "%.%s*%=%s*",  -- =
        "%.%s*%'%s*",  -- '
        "%.%s*%-%-%s*",  -- --
        "%.%s*%*%s*",  -- *
        -- Add more patterns as needed
    }
    for _, pattern in ipairs(sqlInjectionPatterns) do
        if input:find(pattern) then
            return false, "Potential SQL injection detected."
        end
    end
    return true
end

-- Function to validate Lua code input
function Security.validateLuaCode(input)
    -- Simple check for common dangerous patterns like `os.execute`, `loadfile`, etc.
    local dangerousPatterns = {
        "os%.execute",  -- os.execute
        "loadfile",  -- loadfile
        "dofile",  -- dofile
        "require",  -- require
        "io%.write",  -- io.write
        -- More dangerous functions
    }
    for _, pattern in ipairs(dangerousPatterns) do
        if input:find(pattern) then
            return false, "Unsafe Lua code detected."
        end
    end
    return true
end

return Security
