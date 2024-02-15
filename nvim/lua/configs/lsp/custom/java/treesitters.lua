--[[
Implements 4 methods:
  get_current_method_name() - return a method name.
  get_class_name() - return a class name where the cursor is
  get_current_package_name() - return a package name of the current file
  get_current_full_class_name() - return a full class name (package + class name)
  get_current_full_method_name(delimiter) - return a full method name (package + class + [delimiter] + method name)
--]]

local ts_utils = require 'nvim-treesitter.ts_utils'
local printers = require 'm_utils.printers'

local M = {}

-- Find nodes by type
function M.find_node_by_type(expr, type_name)
  while expr do
    if expr:type() == type_name then
      break
    end
    expr = expr:parent()
  end
  return expr
end

function M.get_current_node()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then return nil end
  return current_node
end

function M.get_root_node(node)
  local current_node = node or ts_utils.get_node_at_cursor()
  if not current_node then return nil end

  local root_node = ts_utils.get_root_for_node(current_node)
  if root_node then
    return root_node
  end
  return nil -- If the given node is already the root node
end

function M.get_class_name()
  local class_declaration = M.find_child_by_type(M.get_root_node(), "class_declaration")

  local child = M.find_child_by_type(class_declaration, 'identifier')
  if not child then
    print("Cannot found any class_declaration's identifier")
    return nil
  end
  local node_text = ts_utils.get_node_text(child, 0)
  local className = node_text[1]
  print("Found class: " .. className)

  return className
end

function M.find_children_given_type(node, targetType, results)
  results = results or {}
  if node:type() == targetType then
    table.insert(results, node)
  end
  for i = 0, node:child_count() - 1 do
    M.find_children_given_type(node:child(i), targetType, results)
  end
  return results
end

-- Find child nodes by type
function M.find_child_by_type(expr, type_name)
  local id = 0
  local expr_child = expr:child(id)
  while expr_child do
    if expr_child:type() == type_name then
      break
    end
    id = id + 1
    expr_child = expr:child(id)
  end

  return expr_child
end

-- Get Current Method Name
function M.get_current_method_name()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then return nil end

  local expr = M.find_node_by_type(current_node, 'method_declaration')
  if not expr then return nil end

  local child = M.find_child_by_type(expr, 'identifier')
  if not child then
    print("Cannot found any method name")
    return nil
  end

  local node_text = ts_utils.get_node_text(child, 0)
  local name = node_text[1]
  print("Found function name: " .. name)
  return name
end

-- Get Current Package Name
function M.get_current_package_name()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then return nil end

  local program_expr = M.find_node_by_type(current_node, 'program')
  if not program_expr then return nil end
  local package_expr = M.find_child_by_type(program_expr, 'package_declaration')
  if not package_expr then return nil end

  local child = M.find_child_by_type(package_expr, 'scoped_identifier')
  if not child then
    print("Cannot found any package name")
    return nil
  end
  local node_text = ts_utils.get_node_text(child, 0)
  local package = node_text[1]
  print("Found package: " .. package)
  return package
end

-- Get Current Full Class Name
function M.get_current_full_class_name()
  local package = M.get_current_package_name()
  local class = M.get_class_name()
  local full_name = package .. '.' .. class
  print(full_name)
  return full_name
end

-- Get Current Full Method Name with delimiter or default '.'
function M.get_current_full_method_name(delimiter)
  delimiter = delimiter or '.'
  local full_class_name = M.get_current_full_class_name()
  print("Current full class name: " .. full_class_name)
  local method_name = M.get_current_method_name()
  print("Current method name: " .. method_name)

  local value = full_class_name .. delimiter .. method_name
  print("Current full method name: " .. value)
  return value
end

function M.healthy()
  print("healthy")
end

return M
