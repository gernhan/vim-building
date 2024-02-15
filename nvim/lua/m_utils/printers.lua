local M = {}
-- Function to print all elements in a nested table recursively
function M.print_nested_table(t, indent)
    indent = indent or 0

    for key, value in pairs(t) do
        if type(value) == "table" then
            print(string.rep("  ", indent) .. key .. ":")
            M.print_nested_table(value, indent + 1)
        else
            print(string.rep("  ", indent) .. key .. ":", value)
        end
    end
end

return M
