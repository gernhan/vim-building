local M = {}
-- Function to read the contents of a file
function M.read_file(filename)
  local file = io.open(filename, "r")
  if file then
    local content = file:read("*all")
    file:close()
    return content
  end
  return nil
end

function M.extract_text_using_regex(filename, regexPattern)
    -- Read the original content of the file
    local originalContent = M.read_file(filename)

    if originalContent then
        -- Find the matching text using the provided regex pattern
        local extractedText = originalContent:match(regexPattern)
        return extractedText
    end

    return nil
end
return M
