------------------------------------------------------------------------
--  CELLULAR AUTOMATA (CAVE GENERATION, ETC)
------------------------------------------------------------------------
--
--  Oblige Level Maker
--
--  Copyright (C) 2009-2017 Andrew Apted
--
--  This program is free software; you can redistribute it and/or
--  modify it under the terms of the GNU General Public License
--  as published by the Free Software Foundation; either version 2
--  of the License, or (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
------------------------------------------------------------------------
--
--  The cave algorithm used here in the generate() function was
--  described by Jim Babcock in his article: "Cellular Automata
--  Method for Generating Random Cave-Like Levels".
--
------------------------------------------------------------------------


--class GRID : extends ARRAY_2D
--[[
    -- for caves, each cell is either NIL (unused) or a number,
    -- when > 0 means solid (wall) and < 0 means empty (floor).

    flood : array_2D(number)  -- contiguous areas have the same value
                              -- (positive for solid, negative for empty)

    empty_id  -- the main empty area in the flood_fill
              -- this is set by the validate_conns() method

    islands : list(GRID)

    regions : table[id] -> REGION
--]]


--class REGION
--[[
    id : number

    x1, y1, x2, y2  -- bounding box (in cell coordinates)

    size : number of cells
--]]


GRID_CLASS = {}


function GRID_CLASS.new(w, h)
  local grid = { w=w, h=h }
  table.set_class(grid, GRID_CLASS)
  grid.cells = table.array_2D(w, h)
  return grid
end


function GRID_CLASS.blank_copy(grid)
  return GRID_CLASS.new(grid.w, grid.h)
end


function GRID_CLASS.valid_cell(grid, x, y)
  return (1 <= x and x <= grid.w) and (1 <= y and y <= grid.h)
end


function GRID_CLASS.get(grid, x, y)
  return grid.cells[x][y]
end


function GRID_CLASS.set(grid, x, y, val)
  grid.cells[x][y] = val
end


function GRID_CLASS.fill(grid, x1,y1, x2,y2, val)
  for x = x1, x2 do
  for y = y1, y2 do
    grid.cells[x][y] = val
  end
  end
end


function GRID_CLASS.set_all(grid, val)
  grid:fill(1, 1, grid.w, grid.h, val)
end


function GRID_CLASS.negate(grid, x1,y1, x2,y2)
  if not x1 then
    x1, x2 = 1, grid.w
    y1, y2 = 1, grid.h
  end

  for x = x1, x2 do
  for y = y1, y2 do
    if grid.cells[x][y] then
      grid.cells[x][y] = - grid.cells[x][y]
    end
  end
  end

  return grid
end


function GRID_CLASS.copy(grid)
  -- only copies 'w', 'h' and 'cells' members.
  -- the cells themselves are NOT copied.

  local newbie = grid:blank_copy()

  for x = 1, grid.w do
  for y = 1, grid.h do
    newbie.cells[x][y] = grid.cells[x][y]
  end
  end

  return newbie
end


function GRID_CLASS.dump(grid, title)
  if title then
    gui.debugf("%s\n", title)
  end

  for y = grid.h,1,-1 do
    local line = "| "

    for x = 1,grid.w do
      local ch = " "
      local cell = grid.cells[x][y]

      if  cell == 0      then ch = "/" end
      if (cell or 0) > 0 then ch = "#" end
      if (cell or 0) < 0 then ch = "." end

      line = line .. ch
    end

    line = line .. " |"

    gui.debugf("%s\n", line)
  end

  gui.debugf("\n")
end


function GRID_CLASS.union(grid, other)
  local W = math.min(grid.w, other.w)
  local H = math.min(grid.h, other.h)

  for x = 1, W do
  for y = 1, H do
    if ( grid.cells[x][y] or 0) < 0 and
       (other.cells[x][y] or 0) > 0
    then
      grid.cells[x][y] = other.cells[x][y]
    end
  end
  end
end


function GRID_CLASS.intersection(grid, other)
  local W = math.min(grid.w, other.w)
  local H = math.min(grid.h, other.h)

  for x = 1, W do
  for y = 1, H do
    if ( grid.cells[x][y] or 0) > 0 and
       (other.cells[x][y] or 0) < 0
    then
      grid.cells[x][y] = other.cells[x][y]
    end
  end
  end
end


function GRID_CLASS.subtract(grid, other)
  local W = math.min(grid.w, other.w)
  local H = math.min(grid.h, other.h)

  local empty_id = grid.empty_id or -1

  for x = 1, W do
  for y = 1, H do
    if ( grid.cells[x][y] or 0) > 0 and
       (other.cells[x][y] or 0) > 0
    then
      grid.cells[x][y] = empty_id
    end
  end
  end
end


function GRID_CLASS.generate(grid, solid_prob)

  -- The initial contents of the grid form a map where a cave
  -- will be generated.  The following values can be used:
  --
  --    nil : never touched
  --     -1 : forced off
  --      0 : computed normally
  --     +1 : forced on
  --
  -- Result elements can be: nil, -1 or +1.
  --

-- FIXME: support -2, +2 as 'forced' on, -1,+1 as initial values

  solid_prob = solid_prob or 40

  local W = grid.w
  local H = grid.h

  local map  = grid.cells

  -- these arrays only use 0 and 1 as values
  local work = table.array_2D(W, H)
  local temp = table.array_2D(W, H)

  -- populate initial map
  for x = 1, W do
  for y = 1, H do
    if not map[x][y] or map[x][y] < 0 then
      work[x][y] = 0
    elseif map[x][y] > 0 then
      work[x][y] = 1
    else
      work[x][y] = rand.sel(solid_prob, 1, 0)
    end
  end
  end

  local function calc_new(x, y, loop)
    if not map[x][y] then return 0 end
    if map[x][y] > 0 then return 1 end
    if map[x][y] < 0 then return 0 end

    if x == 1 or x == W or y == 1 or y == H then
      return work[x][y]
    end

    local neighbors = 0
    for nx = x-1,x+1 do
    for ny = y-1,y+1 do
      neighbors = neighbors + work[nx][ny]
    end
    end

    if neighbors >= 5 then return 1 end

    if loop >= 5 then return 0 end

    if x <= 2 or x >= W-1 or y <= 2 or y >= H-1 then return 0 end

    -- check larger area
    local neighbors = 0
    for nx = x-2,x+2 do
    for ny = y-2,y+2 do
      if math.abs(x-nx) == 2 and math.abs(y-ny) == 2 then
        -- skip the corners of the 5x5 block
      else
        neighbors = neighbors + work[nx][ny]
      end
    end
    end

    if neighbors <= 2 then return 1 end

    return 0
  end

  -- perform the cellular automation steps
  for loop = 1,7 do
    for x = 1, W do
    for y = 1, H do
      temp[x][y] = calc_new(x, y, loop)
    end
    end

    work, temp = temp, work
  end

  -- convert values for the result
  for x = 1, W do
  for y = 1, H do
    if map[x][y] == 0 then
      work[x][y] = sel(work[x][y] > 0, 1, -1)
    else
      work[x][y] = map[x][y]
    end
  end
  end

  grid.cells = work
end


function GRID_CLASS.gen_empty(grid)

  -- this is akin to generate(), but making all target cells empty

  local W = grid.w
  local H = grid.h

  local cells = grid.cells

  for x = 1, W do
  for y = 1, H do
    if not cells[x][y] then
      -- skip it
    elseif cells[x][y] > 0 then
      cells[x][y] = 1
    else
      cells[x][y] = -1
    end
  end
  end

  return grid
end


function GRID_CLASS.dump_regions(grid)
  if not grid.regions then
    gui.debugf("No region info (flood_fill not called yet)\n")
    return
  end

  gui.debugf("Regions:\n")

  each id,REG in grid.regions do
    gui.debugf("  %+4d : (%d %d) .. (%d %d) size:%d\n",
               REG.id, REG.x1, REG.y1, REG.x2, REG.y2, REG.size)
  end

  gui.debugf("Empty regions: %d (with %d cells)\n", grid.empty_regions, grid.empty_cells)
  gui.debugf("Solid regions: %d (with %d cells)\n", grid.solid_regions, grid.solid_cells)
end


function GRID_CLASS.flood_fill(grid)
  -- generate the 'flood' member, an array where each contiguous region
  -- has a unique id.  Empty areas are negative, solid areas are positive,
  -- and everything else is NIL.
  --
  -- This also creates the 'regions' table.

  local W = grid.w
  local H = grid.h

  local cells = grid.cells
  local flood = table.array_2D(W, H)

  local solid_id =  1
  local empty_id = -1

  local next_points = {}

  local function flood_point(x, y)
    -- spread value from this cell to neighbors

    local A = flood[x][y]
    assert(A)

    for dir = 2,8,2 do
      local nx, ny = geom.nudge(x, y, dir)
      if nx >= 1 and nx <= W and ny >= 1 and ny <= H then
        local B = flood[nx][ny]

        if B and ((A > 0 and A < B) or (A < 0 and A > B)) then
          flood[nx][ny] = A
          table.insert(next_points, { x=nx, y=ny })
        end
      end
    end
  end


  local function update_info(x, y)
    local id = flood[x][y]

    if not id then return end

    assert(id != 0)

    if id < 0 then
      grid.empty_cells = grid.empty_cells + 1
    else
      grid.solid_cells = grid.solid_cells + 1
    end

    local REG = grid.regions[id]

    if not REG then
      REG =
      {
        id = id
        x1 = x, y1 = y
        x2 = x, y2 = y
        size = 0
      }

      grid.regions[id] = REG

      if id < 0 then
        grid.empty_regions = grid.empty_regions + 1
      else
        grid.solid_regions = grid.solid_regions + 1
      end
    end

    if x < REG.x1 then REG.x1 = x end
    if y < REG.y1 then REG.y1 = y end
    if x > REG.x2 then REG.x2 = x end
    if y > REG.y2 then REG.y2 = y end

    REG.size = REG.size + 1
  end


  -- initial setup

  for x = 1, W do
  for y = 1, H do
    if not cells[x][y] then
      -- ignore it
    elseif cells[x][y] < 0 then
      flood[x][y] = empty_id ; empty_id = empty_id - 1
    else
      flood[x][y] = solid_id ; solid_id = solid_id + 1
    end
  end
  end

  -- perform the flood-fill

  for x = 1, W do
  for y = 1, H do
    if flood[x][y] then
      flood_point(x, y)
    end
  end
  end

  while #next_points > 0 do
    local np_list = next_points ; next_points = {}

    each P in np_list do
      flood_point(P.x, P.y)
    end
  end

  -- create information for each region

  grid.regions = {}

  grid.empty_cells = 0
  grid.solid_cells = 0
  grid.empty_regions = 0
  grid.solid_regions = 0

  for x = 1, W do
  for y = 1, H do
    update_info(x, y)
  end
  end

  grid.flood = flood

  --  grid:dump_regions()
end


function GRID_CLASS.validate_conns(grid, rect_list)

  -- checks that all connections can reach each other.

  local empty_id = nil

  if not grid.flood then
    grid:flood_fill()
  end

  each P in rect_list do
    if (grid.flood[P.cx1][P.cy1] or 0) >= 0 then
      -- not valid : the cell is solid or absent
      return false
    end

    local reg = grid.flood[P.cx1][P.cy1]

    if not empty_id then
      empty_id = reg
    elseif empty_id != reg then
      -- not valid : the empty areas are disjoint
      return false
    end
  end

  grid.empty_id = empty_id

  return true
end


function GRID_CLASS.solidify_pockets(grid)
  -- this removes the empty areas which are surrounded by solid
  -- (i.e. not part of the main walk area).

  local function find_one()
    each id,REG in grid.regions do
      if id < 0 and id != grid.empty_id then
        return id
      end
    end

    -- nothing found
    return nil
  end

  while true do
    local pocket_id = find_one()

    if not pocket_id then break end

    local REG = grid.regions[pocket_id]
    assert(REG)

    -- solidify the cells
    for x = REG.x1, REG.x2 do
    for y = REG.y1, REG.y2 do
      if grid.flood[x][y] == pocket_id then
        grid.cells[x][y] = 1
        grid.flood[x][y] = nil
      end
    end
    end

    -- remove the region info
    grid.regions[pocket_id] = nil
  end
end


function GRID_CLASS.copy_island(grid, reg_id)
  local W = grid.w
  local H = grid.h

  local flood = assert(grid.flood)

  local island = grid:blank_copy()

  for x = 1, W do
  for y = 1, H do
    local val = flood[x][y]
    if val == nil then
      -- nothing to copy
    else
      island.cells[x][y] = sel(val == reg_id, 1, -1)
    end
  end
  end

  island:dump("Island for " .. tostring(reg_id))

  return island
end


function GRID_CLASS.find_islands(grid)

  -- an "island" is contiguous solid area which never touches NIL

  local islands = {}

  local W = grid.w
  local H = grid.h

  if not grid.flood then
    grid:flood_fill()
  end

  local flood = grid.flood

  -- scan the cave, determine which regions are islands

  -- a table mapping region ids to a string value: "maybe" if could be
  -- an island, and "no" when definitely not an island. 
  local potentials = {}

  for x = 1, W do
  for y = 1, H do
    local reg = flood[x][y]
    if (reg or 0) > 0 then

      if not potentials[reg] then
        potentials[reg] = "maybe"
      end

      if x == 1 or x == W or y == 1 or y == H then
        potentials[reg] = "no"
      end

      if potentials[reg] != "no" then
        for side = 2,8,2 do
          local nx, ny = geom.nudge(x, y, side)
          if grid:valid_cell(nx, ny) and flood[nx][ny] == nil then
            potentials[reg] = "no"
            break;
          end
        end
      end

    end
  end -- x, y
  end

  -- create the islands

  for reg,pot in pairs(potentials) do
    if pot == "maybe" then
      table.insert(islands, grid:copy_island(reg))
    end
  end

  grid.islands = islands
end


function GRID_CLASS.validate_size(grid)
  assert(grid.empty_id)

  local empty_reg = grid.regions[grid.empty_id]
  assert(empty_reg)

  local W = grid.w
  local H = grid.h

  local cw = empty_reg.x2 - empty_reg.x1 + 1
  local ch = empty_reg.y2 - empty_reg.y1 + 1

  if cw < W / 2 then return false end
  if ch < H / 2 then return false end

  -- volume check
  if cw * ch < W * H / 2.5 then return false end

  return true  -- OK --
end


function GRID_CLASS.grow(grid, keep_edges)
  -- grow the cave : it will have more solids, less empties.
  -- nil cells are not affected.

  local W = grid.w
  local H = grid.h

  local work = table.array_2D(W, H)
  local cells = grid.cells

  local function value_for_spot(x, y)
    local val = cells[x][y]
    local hit_edge

    for dir = 2,8,2 do
      local nx, ny = geom.nudge(x, y, dir)

      if not grid:valid_cell(nx, ny) or not cells[nx][ny] then
        hit_edge = true
      elseif cells[nx][ny] > 0 then
        val = cells[nx][ny]
      end
    end

    if keep_edges and hit_edge then
      return cells[x][y]
    end

    return val
  end

  for x = 1, W do
  for y = 1, H do
    if cells[x][y] then
      work[x][y] = value_for_spot(x, y)
    end
  end
  end

  grid.cells = work
end


function GRID_CLASS.grow8(grid, keep_edges)
  -- like grow() method but expands in all 8 directions

  local W = grid.w
  local H = grid.h

  local work = table.array_2D(W, H)
  local cells = grid.cells

  local function value_for_spot(x, y)
    local val = cells[x][y]
    local hit_edge

    for dir = 1,9 do if dir != 5 then
      local nx, ny = geom.nudge(x, y, dir)

      if not grid:valid_cell(nx, ny) or not cells[nx][ny] then
        hit_edge = true
      elseif cells[nx][ny] > 0 then
        val = cells[nx][ny]
      end
    end end -- dir

    if keep_edges and hit_edge then
      return cells[x][y]
    end

    return val
  end

  for x = 1, W do
  for y = 1, H do
    if cells[x][y] then
      work[x][y] = value_for_spot(x, y)
    end
  end
  end

  grid.cells = work
end


function GRID_CLASS.shrink(grid, keep_edges)
  -- shrink the cave : it will have more empties, less solids.
  -- when 'keep_edges' is true, cells at edges are not touched.
  -- nil cells are not affected.

  local W = grid.w
  local H = grid.h

  local work = table.array_2D(W, H)
  local cells = grid.cells

  local function value_for_spot(x, y)
    local val = cells[x][y]
    local hit_edge

    for dir = 2,8,2 do
      local nx, ny = geom.nudge(x, y, dir)
    
      if not grid:valid_cell(nx, ny) or not cells[nx][ny] then
        hit_edge = true
      elseif cells[nx][ny] < 0 then
        val = cells[nx][ny]
      end
    end

    if keep_edges and hit_edge then
      return cells[x][y]
    end

    return val
  end

  for x = 1, W do
  for y = 1, H do
    if cells[x][y] then
      work[x][y] = value_for_spot(x, y)
    end
  end
  end

  grid.cells = work
end


function GRID_CLASS.shrink8(grid, keep_edges)
  -- like shrink() method but checks all 8 directions

  local W = grid.w
  local H = grid.h

  local work = table.array_2D(W, H)
  local cells = grid.cells

  local function value_for_spot(x, y)
    local val = cells[x][y]
    local hit_edge

    for dir = 1,9 do if dir != 5 then
      local nx, ny = geom.nudge(x, y, dir)
    
      if not grid:valid_cell(nx, ny) or not cells[nx][ny] then
        hit_edge = true
      elseif cells[nx][ny] < 0 then
        val = cells[nx][ny]
      end
    end end -- dir

    if keep_edges and hit_edge then
      return cells[x][y]
    end

    return val
  end

  for x = 1, W do
  for y = 1, H do
    if cells[x][y] then
      work[x][y] = value_for_spot(x, y)
    end
  end
  end

  grid.cells = work
end


function GRID_CLASS.remove_dots(grid)
  -- removes isolated cells (solid or empty) from the cave.
  -- diagonal cells are NOT checked.

  local W = grid.w
  local H = grid.h

  local cells = grid.cells

  local function is_isolated(x, y, val)
    for dir = 2,8,2 do
      local nx, ny = geom.nudge(x, y, dir)

      if not grid:valid_cell(nx, ny) or not cells[nx][ny] then
        -- ignore it
      elseif cells[nx][ny] == val then
        return false
      end
    end

    return true
  end

  for x = 1, W do
  for y = 1, H do
    local val = cells[x][y]

    if val and val != 0 and is_isolated(x, y, val) then
      local dx = sel(x > W/2, -1, 1)
      cells[x][y] = cells[x+dx][y]
    end
  end
  end
end


function GRID_CLASS.is_land_locked(grid, x, y)
  if x <= 1 or x >= grid.w or y <= 1 or y >= grid.h then
    return false
  end

  local cells = grid.cells

  for dx = -1, 1 do
  for dy = -1, 1 do
    if (cells[x+dx][y+dy] or 0) < 0 then
      return false
    end
  end
  end

  return true
end


function GRID_CLASS.is_empty_locked(grid, x, y)
  if x <= 1 or x >= grid.w or y <= 1 or y >= grid.h then
    return false
  end

  local cells = grid.cells

  for dx = -1,1 do
  for dy = -1,1 do
    if (cells[x+dx][y+dy] or 0) >= 0 then
      return false
    end
  end
  end

  return true
end


function GRID_CLASS.distance_map(grid, ref_points)
  assert(grid.flood)
  assert(grid.empty_id)

  local W = grid.w
  local H = grid.h

  local work = table.array_2D(W, H)
  local flood = grid.flood

  local next_points = {}

  local function flood_point(x, y)

    -- spread this distance into neighbor cells
    local dist = work[x][y] + 1

    for side = 2,8,2 do
      local nx, ny = geom.nudge(x, y, side)
      if nx >= 1 and nx <= W and ny >= 1 and ny <= H then
        local F = flood[nx][ny]
        local W =  work[nx][ny]

        if F == grid.empty_id and (not W or W > dist) then
          flood[nx][ny] = dist
          table.insert(next_points, { x=nx, y=ny })
        end
      end
    end
  end

  -- perform the fill

  for _,P in ipairs(ref_points) do
    work[P.x][P.y] = 0
    flood_point(P.x, P.y)
  end

  while #next_points > 0 do
    local np_list = next_points ; next_points = {}

    for _,P in ipairs(np_list) do
      flood_point(P.x, P.y)
    end
  end

  return work
end


function GRID_CLASS.furthest_point(grid, ref_points)
  local dist_map = grid:distance_map(ref_points)

  local best_x, best_y
  local best_dist = 9e9

  for x = 1, W do
  for y = 1, H do
    local dist = dist_map[x][y]
    if dist and dist < (best_dist+3) then

      -- prefer away from edges
      if x == 1 or x == W then dist = dist + 0.1 end
      if y == 1 or y == H then dist = dist + 0.2 end

      -- prefer a spot away from the wall
      if grid:is_empty_locked(x, y) then
        dist = dist - 2.4
      end

      if dist < best_dist then
        best_x, best_y = x, y
        best_dist = dist
      end

    end
  end  -- x, y
  end

  return best_x, best_y  -- could be nil !
end




----------------------------------------------------------------
--  BLOB STUFF
----------------------------------------------------------------


function GRID_CLASS.merge_blobs(blob_map, id1, id2)
  -- merges the second blob into the first one

  for cx = 1, blob_map.w do
  for cy = 1, blob_map.h do
    if blob_map[cx][cy] == id2 then
       blob_map[cx][cy] = id1
    end
  end
  end
end



function GRID_CLASS.create_blobs(grid, step_x, step_y, min_size)
  --
  -- Divide the given array into "blobs", which are small groups
  -- of contiguous cells.
  --
  -- Returns a new array, where each valid cell will contain a blob
  -- identity number.
  --
  -- NOTE : the input region MUST be contiguous
  --        [ if not, expect unfilled places ]

  local W = grid.w
  local H = grid.h

  local blob_map = table.array_2D(W, H)

  local total_blobs = 0

  local sizes = {}

  local grow_dirs = {}


  local function is_valid(cx, cy)
    if cx < 1 or cx > W then return false end
    if cy < 1 or cy > H then return false end

    if grid.cells[cx][cy] == nil then return false end

    return true
  end


  local function is_free(cx, cy)
    if not is_valid(cx, cy) then return false end

    if blob_map[cx][cy] then return false end

    return true
  end


  local function neighbor_blob(cx, cy, dir)
    cx, cy = geom.nudge(cx, cy, dir)

    if not is_valid(cx, cy) then return nil end

    return blob_map[cx][cy]
  end


  local function set_cell(cx, cy, id)
    assert(is_free(cx, cy))

    blob_map[cx][cy] = id

    sizes[id] = (sizes[id] or 0) + 1
  end


  local function try_set_cell(cx, cy, id)
    if is_free(cx, cy) then
      set_cell(cx, cy, id)
    end
  end


  local function spawn_blobs()
    for cx = 1, W, step_x do
    for cy = 1, H, step_y do
      if rand.odds(5) then continue end

      local dx = rand.irange(0, step_x - 1)
      local dy = rand.irange(0, step_y - 1)

      if not is_free(cx+dx, cy+dy) then
        continue
      end

      total_blobs = total_blobs + 1

      set_cell(cx+dx, cy+dy, total_blobs)
    end
    end

    if total_blobs > 0 then return end

    -- in the unlikely event that no blobs were created, force
    -- the creation of one now

    for cx = 1, W, step_x do
    for cy = 1, H, step_y do
      if is_free(cx, cy) then
        total_blobs = total_blobs + 1
        set_cell(cx, cy, total_blobs)
        return
      end
    end
    end

    error("create_blobs: no usable cells")
  end


  local function growth_spurt_one()
    for cx = 1, W do
    for cy = 1, H do
      local id = blob_map[cx][cy]
      if not id then continue end
      if sizes[id] >= 2 then continue end

      if rand.odds(15) then
        local dx = rand.sel(50, -1, 1)
        local dy = rand.sel(50, -1, 1)

        try_set_cell(cx+dx, cy   , id)
        try_set_cell(cx   , cy+dy, id)
        try_set_cell(cx+dx, cy+dy, id)
        continue
      end

      local x_dir = rand.irange(-2, 2)
      local y_dir = rand.irange(-2, 2)

      if x_dir <=  1 then try_set_cell(cx-1, cy, id) end
      if x_dir >= -1 then try_set_cell(cx+1, cy, id) end

      if y_dir <=  1 then try_set_cell(cx, cy-1, id) end
      if y_dir >= -1 then try_set_cell(cx, cy+1, id) end
    end
    end
  end


  local function try_grow_at_cell(cx, cy, dir)
    if not is_free(cx, cy) then return end

    local id = neighbor_blob(cx, cy, dir)
    if not id then return end

    if grow_dirs[id] != dir then return end

    if rand.odds(15) then return end

    set_cell(cx, cy, id)
  end


  local function directional_pass(dir)
    -- prevent run-on effects by iterating in the correct order
    if dir == 2 or dir == 4 then

      for cx = W, 1, -1 do
      for cy = H, 1, -1 do
        try_grow_at_cell(cx, cy, dir)
      end
      end

    else -- dir == 6 or dir == 8

      for cx = 1, W do
      for cy = 1, H do
        try_grow_at_cell(cx, cy, dir)
      end
      end
    end
  end


  local function check_all_done()
    for cx = 1, W do
    for cy = 1, H do
      if is_valid(cx, cy) and is_free(cx, cy) then
        return false
      end
    end
    end

    return true
  end


  local function normal_grow_pass()
    for i = 1, total_blobs do
      grow_dirs[i] = rand.dir()
    end

    for dir = 2,8,2 do
      directional_pass(dir)
    end
  end


  local function merge_blobs(id1, id2)
    GRID_CLASS.merge_blobs(blob_map, id1, id2)

    sizes[id1] = sizes[id1] + sizes[id2]
    sizes[id2] = -1
  end


  local function candidate_to_merge(id)
    local best
    local best_cost = 9e9

    local seen = {}

    for cx = 1, W do
    for cy = 1, H do
      if blob_map[cx][cy] != id then continue end

      for dir = 2,8,2 do
        local nb = neighbor_blob(cx, cy, dir)

        if nb and nb != id and sizes[nb] > 0 and not seen[nb] then
          seen[nb] = true

          local cost = sizes[nb] + gui.random() * 0.1

          if cost < best_cost then
            best = nb
            best_cost = cost
          end
        end
      end -- dir

    end -- cx, cy
    end

    return best
  end


  local function merge_small_pass()
    for id = 1, total_blobs do
      if sizes[id] < min_size then
        local nb = candidate_to_merge(id)

        if nb then
          merge_blobs(nb, id)
        end
      end
    end
  end


  local function char_for_cell(cx, cy)
    if grid.cells[cx][cy] == nil then return " " end

    local id = blob_map[cx][cy]

    if not id then return "." end

    id = 1 + (id - 1) % 36

    return string.sub("1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ", id, id)
  end


  local function dump_blob_map()
    gui.debugf("Blob map:\n")

    for cy = H, 1, -1 do
      local line = ""

      for cx = 1, W do
        line = line .. char_for_cell(cx, cy)
      end

      gui.debugf("| %s\n", line)
    end

    gui.debugf("\n")
  end


  local function dump_blob_info()
    gui.debugf("Blob sizes:\n")

    for id = 1, total_blobs, 9 do
      local line = ""

      for di = 0, 8 do
        if id + di <= total_blobs then
          line = line .. "  " .. string.format("%2d", sizes[id + di])
        end
      end

      gui.debugf("%s\n", line)
    end

    gui.debugf("\n")
  end


  ---| create_blobs |---

  spawn_blobs()

  growth_spurt_one()

  local MAX_LOOP = 200

  for loop = 1, MAX_LOOP do
    normal_grow_pass()
    normal_grow_pass()
    normal_grow_pass()

    if check_all_done() then
      break;
    end

    if loop >= MAX_LOOP then
      error("blob creation failed!")
    end
  end

  if min_size then
    for loop = 1, 4 do
      merge_small_pass()
    end
  end

  dump_blob_map()
  dump_blob_info()

  return blob_map
end



function GRID_CLASS.walkify_blobs(blob_map, walk_rects)
  --
  -- For each cell rectangle in the walk_rects list,
  -- merge any group of blobs that span that rectangle
  -- (so that afterwards, only a single blob spans it).
  --

  local function handle_chunk(WC)
    local cur_blob

    for cx = WC.cx1, WC.cx2 do
    for cy = WC.cy1, WC.cy2 do
      local id = blob_map[cx][cy]
      assert(id)

      if cur_blob == nil then
         cur_blob = id
         continue
      end

      if cur_blob != id then
        GRID_CLASS.merge_blobs(blob_map, cur_blob, id)
      end
    end
    end
  end


  ---| walkify_blobs |---

  each WC in walk_rects do
    handle_chunk(WC)
  end
end



----------------------------------------------------------------
--  MAZE STUFF
----------------------------------------------------------------


function GRID_CLASS.maze_generate(maze)
  --
  -- Generates a maze in the current object.
  --
  -- The initial contents should form a map where the maze will be
  -- generated.  The cells next to walls should be set to 1 and
  -- areas which must remain clear (in front of doors) set to -1.
  --
  -- These values can be used:
  --
  --    nil : never touched
  --     -1 : forced off
  --      0 : computed normally
  --     +1 : forced on
  --
  -- Result elements can be: nil, -1 or +1.
  --

  local W = maze.w
  local H = maze.h

  local cells = maze.cells


  local function valid_and_free(x, y)
    return maze:valid_cell(x, y) and cells[x][y] == 0
  end


  local function how_far_can_move(x, y, dir)
    -- when start is in open space, require all neighbors to be open too
    if cells[x][y] == 0 then
      for side = 1,9 do
        local nx, ny = geom.nudge(x, y, side)
        if not valid_and_free(nx, ny) then return 0 end
      end
    end

    local len = 0

    while len < 5 do
      -- check the next spot is free, and also the cells on either side
      x, y = geom.nudge(x, y, dir)

      if not valid_and_free(x, y) then break; end
      
      local ax, ay = geom.nudge(x, y, geom.RIGHT[dir])
      local bx, by = geom.nudge(x, y, geom.LEFT [dir])

      if not valid_and_free(ax, ay) then break; end
      if not valid_and_free(bx, by) then break; end

      len = len + 1
    end

    -- don't touch the far wall
    len = len -1

    -- usually move two steps, occasionally more
    if len >= 3 and rand.odds(75) then len = 2 end
    if len >= 4 and rand.odds(95) then len = 3 end

    assert(len <= 4)

    return len
  end


  local function is_edge(x, y, dir)
    x, y = geom.nudge(x, y, 10-dir)

    if not maze:valid_cell(x, y) then return true end

    if not cells[x][y] then return true end

    return false
  end


  local function pick_start()
    -- TODO: optimise this (how ?)

    local middles = {}
    local edges   = {}

    for x = 1, W do
    for y = 1, H do
      if (cells[x][y] or 0) > 0 or 
         (cells[x][y] == 0 and (table.empty(middles) or rand.odds(2)))
      then
        for dir = 2,8,2 do
          local len = how_far_can_move(x, y, dir)

          if len >= 2 then
            local SPOT = { x=x, y=y, dir=dir, len=len }

            if is_edge(x, y, dir) then
              table.insert(edges, SPOT)
            else
              table.insert(middles, SPOT)
            end
          end
        end
      end
    end -- x, y
    end

    -- we much prefer starting at an edge
    if #edges > 0 then
      return rand.pick(edges)
    end

    if #middles > 0 then
      return rand.pick(middles)
    end

    return nil
  end


  local function trace_next(p)
    cells[p.x][p.y] = 1

    for i = 1,p.len do
      p.x, p.y = geom.nudge(p.x, p.y, p.dir)

      cells[p.x][p.y] = 1
    end

    -- set how far we can move in each direction
    local lens = {}

    for dir = 2,8,2 do
      if dir != p.dir then
        local len = how_far_can_move(p.x, p.y, dir)

        if len > 0 then
          lens[dir] = len 
        end
      end
    end

    -- nowhere else to go?
    if table.empty(lens) then return false end

    for loop = 1,20 do
      local dir = rand.dir()

      if dir == p.dir and rand.odds(60) then
        dir = 5  -- i.e. continue
      end

      if lens[dir] then
        p.dir = dir
        p.len = lens[dir]
        return true
      end
    end

    return false
  end


  local function tidy_up()
    for x = 1, W do
    for y = 1, H do
      if cells[x][y] == 0 then
         cells[x][y] = -1
      end
    end
    end
  end


  ---| maze_generate |---

  while true do
    -- choose starting spot for a wall run
    local pos = pick_start()

    -- stop if nothing is possible
    if not pos then break; end

    -- occasionally stop short, but usually go as far as possible
    local max_steps = rand.irange(3, 40)

    for loop = 1,max_steps do
      if not trace_next(pos) then break; end
    end
  end

  tidy_up()
end



function GRID_CLASS.maze_render(maze, brush_func, data)
  local W = maze.w
  local H = maze.h

  local cells = maze.cells


  local function visit_cell(x, y)
    if (cells[x][y] or 0) <= 0 then return; end

    local bx = maze.base_x + (x - 1) * 64
    local by = maze.base_y + (y - 1) * 64

    -- most basic method (mostly for debugging)
    if true then
      brush_func(data,
      {
        { x=bx+64, y=by }
        { x=bx+64, y=by+64 }
        { x=bx,    y=by+64 }
        { x=bx,    y=by }
      })

      return
    end

    -- FIXME: better method, find "wall spans"
  end


  ---| maze_render |---

  for x = 1, W do
  for y = 1, H do
    visit_cell(x, y)
  end
  end
end



function Maze_test()
  local SIZE = 15

  for loop = 1,20 do
    local maze = GRID_CLASS.new(SIZE, SIZE)

    -- solid on outside, empty in middle
    maze:fill(1,1, SIZE,SIZE,     1)
    maze:fill(2,2, SIZE-1,SIZE-1, 0)

    -- doorways at top and bottom
    local d1 = rand.irange(2,SIZE-3)
    local d2 = rand.irange(2,SIZE-3)

    maze:fill(d1,1,      d1+2,3,    -1)
    maze:fill(d2,SIZE-2, d2+2,SIZE, -1)

    maze:maze_generate()

    gui.debugf("MAZE TEST %d\n\n", loop)

    maze:dump()
  end
end

