local M = {}
-- Function to print all elements in a nested table recursively
function M.printNestedTable(t, indent)
    indent = indent or 0

    for key, value in pairs(t) do
        if type(value) == "table" then
            print(string.rep("  ", indent) .. key .. ":")
            M.printNestedTable(value, indent + 1)
        else
            print(string.rep("  ", indent) .. key .. ":", value)
        end
    end
end

return M
