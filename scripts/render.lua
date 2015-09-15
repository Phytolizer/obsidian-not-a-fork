------------------------------------------------------------------------
--  RENDER : CONSTRUCT AREAS
------------------------------------------------------------------------
--
--  Oblige Level Maker
--
--  Copyright (C) 2008-2015 Andrew Apted
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


function calc_wall_mat(A1, A2)
  if not A1 then
    return "_ERROR"
  end

  if A2 and A2.mode == "void" then A2 = nil end

  if not A1.is_outdoor then
    return assert(A1.wall_mat)
  end

  if A2 and not A2.is_outdoor then
    return A2.facade_mat
  end

  if not A2 or A1.zone != A2.zone then
    return LEVEL.zone_fence_mat
  end

  -- both A1 and A2 are outdoor
  return assert(A1.zone.fence_mat)
end


function calc_straddle_mat(A1, A2)
  local mat1 = calc_wall_mat(A1, A2)
  local mat2 = calc_wall_mat(A2, A1)

  return mat1, mat2
end


function edge_get_rail(S, dir)
  assert(S.area)

  local N = S:neighbor(dir, "NODIR")

  assert(N != "NODIR")

  if not (N and N.area) then return nil end
  if N.area == S.area then return nil end

  local bord = S.border[dir]

  if bord.kind == "rail" then return bord end

  if bord.kind != nil then return nil end

  local junc = assert(bord.junction)

  if junc.kind == "rail" then return junc end

  return nil
end



function Render_outer_sky(S, dir, floor_h)
  assert(not geom.is_corner(dir))

  local x1, y1 = S.x1, S.y1
  local x2, y2 = S.x2, S.y2

  if dir == 2 then y2 = y1 ; y1 = y1 - 8 end
  if dir == 8 then y1 = y2 ; y2 = y2 + 8 end

  if dir == 4 then x2 = x1 ; x1 = x1 - 8 end
  if dir == 6 then x1 = x2 ; x2 = x2 + 8 end

  local f_brush = brushlib.quad(x1, y1, x2, y2)

  each C in f_brush do
    C.flags = DOOM_LINE_FLAGS.draw_never
  end

  local c_brush = brushlib.copy(f_brush)

  table.insert(f_brush, { t=floor_h, reachable=true })
  table.insert(c_brush, { b=floor_h + 16, delta_z = -16 })

  brushlib.set_mat(f_brush, "_SKY", "_SKY")
  brushlib.set_mat(c_brush, "_SKY", "_SKY")

  Trans.brush(f_brush)
  Trans.brush(c_brush)
end



function Render_edge(A, S, dir)

  local info = S.border[dir]
  local LOCK = info.lock

  local NA  -- neighbor area

  local DIAG_DIR_MAP = { [1]=2, [9]=8, [3]=6, [7]=4 }


  local function raw_wall_brush()
    local TK = 16

    local x1, y1 = S.x1, S.y1
    local x2, y2 = S.x2, S.y2

    if dir == 2 then y2 = y1 + TK end
    if dir == 8 then y1 = y2 - TK end

    if dir == 4 then x2 = x1 + TK end
    if dir == 6 then x1 = x2 - TK end


    if dir == 2 or dir == 4 or dir == 6 or dir == 8 then
      return brushlib.quad(x1, y1, x2, y2)

    elseif dir == 1 then
      return
      {
        { x=x1,      y=y2      }
        { x=x2,      y=y1      }
        { x=x2,      y=y1 + TK }
        { x=x1 + TK, y=y2      }
      }

    elseif dir == 9 then
      return
      {
        { x=x1,      y=y2      }
        { x=x1,      y=y2 - TK }
        { x=x2 - TK, y=y1      }
        { x=x2,      y=y1      }
      }

    elseif dir == 3 then
      return
      {
        { x=x1,      y=y1 }
        { x=x2,      y=y2 }
        { x=x2 - TK, y=y2 }
        { x=x1,      y=y1 + TK }
      }

    elseif dir == 7 then
      return
      {
        { x=x1,      y=y1 }
        { x=x1 + TK, y=y1 }
        { x=x2,      y=y2 - TK }
        { x=x2,      y=y2 }
      }

    else
      error("edge_wall : bad dir")
    end
  end


  local function edge_wall(mat)
    local brush = raw_wall_brush()

    brushlib.set_mat(brush, mat, mat)

    Trans.brush(brush)
  end


  local function edge_trap_wall(mat)
    if NA.mode != "trap" then return end

    assert(info.trigger)

    local brush = raw_wall_brush()

    -- don't want to reveal trap on automap
    each C in brush do
      C.draw_secret = true
    end

    table.insert(brush, { b=A.floor_h + 2, delta_z=-2, tag=info.trigger.tag })

    brushlib.set_mat(brush, mat, mat)

    Trans.brush(brush)
  end


  local function edge_inner_sky()
    local floor_h = assert(A.floor_h)

    assert(not geom.is_corner(dir))

    local x1, y1 = S.x1, S.y1
    local x2, y2 = S.x2, S.y2

    if dir == 2 then y2 = y1 + 8 end
    if dir == 8 then y1 = y2 - 8 end

    if dir == 4 then x2 = x1 + 8 end
    if dir == 6 then x1 = x2 - 8 end

    local brush = brushlib.quad(x1, y1, x2, y2)

    each C in brush do
      C.flags = DOOM_LINE_FLAGS.draw_never
    end

    table.insert(brush, { b=floor_h + 16, delta_z = -16 })

    brushlib.set_mat(brush, "_SKY", "_SKY")

    Trans.brush(brush)
  end


  local function straddle_fence()
    local mat = assert(info.fence_mat)
    local top_z = assert(info.fence_top_z)
    local TK = info.fence_thick or 16

    local x1, y1 = S.x1, S.y1
    local x2, y2 = S.x2, S.y2

    if dir == 2 then y2 = y1 end
    if dir == 8 then y1 = y2 end

    if dir == 4 then x2 = x1 end
    if dir == 6 then x1 = x2 end

    local brush

    if dir == 2 or dir == 4 or dir == 6 or dir == 8 then
      brush = brushlib.quad(x1 - TK, y1 - TK, x2 + TK, y2 + TK)

    elseif dir == 3 or dir == 7 then
      brush =
      {
        { x=x1 - TK, y=y1 + TK }
        { x=x1 - TK, y=y1 - TK }
        { x=x1 + TK, y=y1 - TK }

        { x=x2 + TK, y=y2 - TK }
        { x=x2 + TK, y=y2 + TK }
        { x=x2 - TK, y=y2 + TK }
      }
    else
      brush =
      {
        { x=x2 - TK, y=y1 - TK }
        { x=x2 + TK, y=y1 - TK }
        { x=x2 + TK, y=y1 + TK }

        { x=x1 + TK, y=y2 + TK }
        { x=x1 - TK, y=y2 + TK }
        { x=x1 - TK, y=y2 - TK }
      }
    end

    table.insert(brush, { t=top_z })

    brushlib.set_mat(brush, mat, mat)

    Trans.brush(brush)
  end


  local function seed_touches_junc(S, junc)
    each dir in geom.ALL_DIRS do
      if S.border[dir].junction == junc then return true end
    end

    return false
  end


  local function calc_step_A_mode(S, dir)
    local junc = S.border[dir].junction
    if not junc or junc.kind != "steps" then return "narrow" end

    local N, bord

    if geom.is_straight(dir) then
      N = S:neighbor(geom.LEFT[dir])
      if not (N and N.area == S.area) then return "" end

      N = N:neighbor(dir)
      if not (N and N.area == S.area) then return "" end

      bord = N.border[geom.RIGHT[dir]]
      if bord.junction == junc then return "wide" end

      return "xx"

    else  -- corner

      local dir2 = geom.ROTATE[5][dir]
      local dir3 = geom.RIGHT[dir2]

      N = S:neighbor(dir2)
      if not (N and N.area == S.area) then return "" end

      N = N:neighbor(dir3)
      if not (N and N.area == S.area) then return "" end

      if seed_touches_junc(N, junc) then return "wide" end

      N = N:neighbor(10 - dir2)
      if not (N and N.area == S.area) then return "" end

      if seed_touches_junc(N, junc) then return "wide" end

      return "xx"
    end
  end


  local function calc_step_B_mode(S, dir)
    local junc = S.border[dir].junction
    if not junc or junc.kind != "steps" then return "narrow" end

    local N, bord

    if geom.is_straight(dir) then
      N = S:neighbor(geom.RIGHT[dir])
      if not (N and N.area == S.area) then return "" end

      N = N:neighbor(dir)
      if not (N and N.area == S.area) then return "" end

      bord = N.border[geom.LEFT[dir]]
      if bord.junction == junc then return "wide" end

      return "xx"

    else  -- corner

      local dir2 = geom.ROTATE[3][dir]
      local dir3 = geom.LEFT[dir2]

      N = S:neighbor(dir2)
      if not (N and N.area == S.area) then return "" end

      N = N:neighbor(dir3)
      if not (N and N.area == S.area) then return "" end

      if seed_touches_junc(N, junc) then return "wide" end

      N = N:neighbor(10 - dir2)
      if not (N and N.area == S.area) then return "" end

      if seed_touches_junc(N, junc) then return "wide" end

      return "wide"
    end
  end


  local function make_step_brush(S, dir, a_mode, b_mode, TK)
    -- define points A and B

    local ax, ay = S.x1, S.y1
    local bx, by = S.x2, S.y2

    if dir == 2 then by = ay ; ax,bx = bx,ax end
    if dir == 8 then ay = by end
    if dir == 4 then bx = ax end
    if dir == 6 then ax = bx ; ay,by = by,ay end

    if dir == 1 or dir == 9 then
      ax,bx = bx,ax
    end

    if dir == 3 or dir == 9 then
      ax,bx = bx,ax
      ay,by = by,ay
    end

    -- compute vectors of points A and B

    local adx, ady = 0, 0
    local bdx, bdy = 0, 0

    if dir == 8 then
      ady, bdy = -1, -1
      if a_mode == "narrow" then adx =  0.5 elseif a_mode == "wide" then adx = -1 end
      if b_mode == "narrow" then bdx = -0.5 elseif b_mode == "wide" then bdx =  1 end
    elseif dir == 2 then
      ady, bdy = 1, 1
      if a_mode == "narrow" then adx = -0.5 elseif a_mode == "wide" then adx =  1 end
      if b_mode == "narrow" then bdx =  0.5 elseif b_mode == "wide" then bdx = -1 end
    elseif dir == 4 then
      adx, bdx = 1, 1
      if a_mode == "narrow" then ady =  0.5 elseif a_mode == "wide" then ady = -1 end
      if b_mode == "narrow" then bdy = -0.5 elseif b_mode == "wide" then bdy =  1 end
    elseif dir == 6 then
      adx, bdx = -1, -1
      if a_mode == "narrow" then ady = -0.5 elseif a_mode == "wide" then ady =  1 end
      if b_mode == "narrow" then bdy =  0.5 elseif b_mode == "wide" then bdy = -1 end

    elseif dir == 1 then
      if a_mode != "wide" then ady = 1 else adx = 1 end
      if b_mode != "wide" then bdx = 1 else bdy = 1 end
    elseif dir == 9 then
      if a_mode != "wide" then ady = -1 else adx = -1 end
      if b_mode != "wide" then bdx = -1 else bdy = -1 end
    elseif dir == 3 then
      if a_mode != "wide" then adx = -1 else ady =  1 end
      if b_mode != "wide" then bdy =  1 else bdx = -1 end
    elseif dir == 7 then
      if a_mode != "wide" then adx =  1 else ady = -1 end
      if b_mode != "wide" then bdy = -1 else bdx =  1 end
    else
      error("bad dir in make_step_brush")
    end

--[[ HANDY DEBUG
stderrf("dir = %d\n", dir)
stderrf("A = (%d %d)  B = (%d %d)\n", ax - S.x1, ay - S.y1, bx - S.x1, by - S.y1)
stderrf("dA = (%1.1f %1.1f)  dB = (%1.1f %1.1f)\n", adx, ady, bdx, bdy)
--]] 

    local brush =
    {
      { x = bx, y = by }
      { x = ax, y = ay }
      { x = ax + adx * TK, y = ay + ady * TK }
      { x = bx + bdx * TK, y = by + bdy * TK }
    }

    return brush
  end


  local function edge_steps()
    local mat = assert(info.steps_mat)
    local steps_z1 =  A.floor_h
    local steps_z2 = NA.floor_h
    local thick = info.steps_thick or 48

    -- wrong side?
    if steps_z2 < steps_z1 then return end

    local diff_h = steps_z2 - steps_z1
    assert(diff_h > 8)
    assert(diff_h <= 96)

    local num_steps = 1

    if diff_h > 32 then num_steps = 2 end
    if diff_h > 64 then num_steps = 3 end

    -- determine A and B modes
    local a_mode = calc_step_A_mode(S, dir)
    local b_mode = calc_step_B_mode(S, dir)

    for i = 1, num_steps do
      local z = steps_z1 + i * diff_h / (num_steps + 1)
      local TK = thick * (num_steps + 1 - i) / num_steps

      local brush = make_step_brush(S, dir, a_mode, b_mode, TK)

      table.insert(brush, { t=z })

      brushlib.set_mat(brush, mat, mat)

      Trans.brush(brush)
    end
  end


  local function straddle_door()
    local z = A.floor_h

    if info.conn then z = assert(info.conn.door_h) end

    local inner_mat, outer_mat = calc_straddle_mat(A, NA)

    local def
    local skin1 = { wall=inner_mat, outer=outer_mat }


    -- FIXME : find it properly
    local fab_name

    if info.kind == "arch" then
      fab_name = "Arch_plain"
    else
      fab_name = "Door_manual_big"
    end


    if geom.is_corner(dir) then
      fab_name = fab_name .. "_diag"

      local def = Fab_lookup(fab_name)

      local dir2 = DIAG_DIR_MAP[dir]

      local T = Trans.box_transform(S.x1, S.y1, S.x2, S.y2, z, dir2)

      Fabricate(R, def, T, { skin1 })

    else  -- axis-aligned edge

      local def = Fab_lookup(fab_name)

      local S2 = S
      local seed_w = 1

      local T = Trans.edge_transform(S.x1, S.y1, S2.x2, S2.y2, z,
                                     dir, 0, seed_w * 192, def.deep, def.over)

      Fabricate(R, def, T, { skin1 })

---???    do_door_base(S, dir, z, w_tex, o_tex)
    end
  end


  local function straddle_locked_door()
    local z = A.floor_h

    if info.conn then z = assert(info.conn.door_h) end

    assert(LOCK)

    local inner_mat, outer_mat = calc_straddle_mat(A, NA)


    -- ensure it faces the correct direction
    if LOCK.conn.A1 != A then
      assert(LOCK.conn.A2 == A)

      if not geom.is_corner(dir) then
        S = S:neighbor(dir)
      end

      dir = 10 - dir

      inner_mat, outer_mat = outer_mat, inner_mat
    end


    local skin1 = { wall=inner_mat, outer=outer_mat }

    if LOCK.goals[1].kind == "SWITCH" then
      skin1.lock_tag = assert(LOCK.goals[1].tag)
    end


    -- FIXME : find it properly
    local fab_name

    if #LOCK.goals == 2 then
      fab_name = "Locked_double"
    elseif #LOCK.goals == 3 then
      fab_name = "Locked_ks_ALL"
    elseif string.sub(LOCK.goals[1].item, 1, 2) == "ks" then
      fab_name = "Locked_small_" .. LOCK.goals[1].item
    else
      fab_name = "Locked_" .. LOCK.goals[1].item
    end

    local def


    if geom.is_corner(dir) then
      fab_name = fab_name .. "_diag"

      local def = Fab_lookup(fab_name)

      local dir2 = DIAG_DIR_MAP[dir]

      local T = Trans.box_transform(S.x1, S.y1, S.x2, S.y2, z, dir2)

      Fabricate(R, def, T, { skin1 })

    else  -- axis-aligned edge

      local def = Fab_lookup(fab_name)

      local S2 = S
      local seed_w = 1

      local T = Trans.edge_transform(S.x1, S.y1, S2.x2, S2.y2, z,
                                     dir, 0, seed_w * 192, def.deep, def.over)

      Fabricate(R, def, T, { skin1 })

---???    do_door_base(S, dir, z, w_tex, o_tex)
    end
  end


  local function straddle_window()
    -- FIXME: window_z1 in JUNC/BORD
    local z = math.max(A.floor_h or 0, NA.floor_h or 0)

    local inner_mat, outer_mat = calc_straddle_mat(A, NA)

    local skin1 = { wall=inner_mat, outer=outer_mat }


    -- FIXME : find it properly
    local fab_name = "Window_wide"

    local def


    if geom.is_corner(dir) then
      fab_name = fab_name .. "_diag"

      local def = Fab_lookup(fab_name)

      local dir2 = DIAG_DIR_MAP[dir]

      local T = Trans.box_transform(S.x1, S.y1, S.x2, S.y2, z, dir2)

      Fabricate(R, def, T, { skin1 })

    else  -- axis-aligned edge

      local def = Fab_lookup(fab_name)

      local S2 = S
      local seed_w = 1

      local T = Trans.edge_transform(S.x1, S.y1, S2.x2, S2.y2, z,
                                     dir, 0, seed_w * 192, def.deep, def.over)

      Fabricate(R, def, T, { skin1 })
    end
  end


  local function add_edge_line()
    local x1, y1 = S.x1, S.y1
    local x2, y2 = S.x2, S.y2

    if dir == 2 then y2 = y1 end
    if dir == 8 then y1 = y2 end

    if dir == 4 then x2 = x1 end
    if dir == 6 then x1 = x2 end

    if dir == 3 or dir == 7 then
      -- no change necessary
    end

    if dir == 1 or dir == 9 then
      y1, y2 = y2, y1
    end

    local E = { x1=x1, y1=y1, x2=x2, y2=y2 }

    table.insert(A.side_edges, E)
  end


  ---| Render_edge |---

  local N = S:neighbor(dir, "NODIR")

  if N == "NODIR" then return end


  -- same area?  nothing needed
  NA = N and N.area

  if NA and NA == A then return end


  add_edge_line()


  -- border[] entry overrides, junction is the fallback
  if info.kind == nil then
    info = info.junction
  end


  if not info or info.kind == nil or info.kind == "nothing" then
    return

  elseif info.kind == "wall" then
    assert(A)
    edge_wall(calc_wall_mat(A, NA))

  elseif info.kind == "trap_wall" then
    edge_trap_wall(calc_wall_mat(A, NA))

  elseif info.kind == "sky_edge" and A.floor_h then
    edge_inner_sky()

  elseif info.kind == "steps" then
    edge_steps()

  elseif info.kind == "fence" then
    straddle_fence()

  elseif info.kind == "arch" or info.kind == "door" then
    straddle_door(S, dir)

  elseif info.kind == "lock_door" then
    straddle_locked_door()

  elseif info.kind == "window" then
    straddle_window()

  end
end



function Render_sink_part(A, S, where, sink)
 

  local function check_inner_point(cx, cy)
    local corner = Corner_lookup(cx, cy)

    if corner and corner.inner_point then
      return true
    else
      return false
    end
  end


  local function corner_coord(C)
    local x, y = S.x1, S.y1

    if C == 3 or C == 9 then x = S.x2 end
    if C == 7 or C == 9 then y = S.y2 end

    return x, y
  end


  local function apply_brush(brush, is_trim)
    local mul

    if where == "floor" then
      mul = -1 ; brushlib.add_top(brush, A.floor_h + 2)
    else
      mul =  1 ; brushlib.add_bottom(brush, A.ceil_h - 2)
    end

    local T = brush[#brush]

    if is_trim then
      if not sink.trim_mat then return end

      T.delta_z = (2 + sink.trim_dz) * mul
      brushlib.set_mat(brush, sink.trim_mat, sink.trim_mat)
    else
      T.delta_z = (2 + sink.dz) * mul
      brushlib.set_mat(brush, sink.mat, sink.mat)
    end

    Trans.brush(brush)
  end


  local function do_whole_square()
    local brush =
    {
      { x = S.x1, y = S.y1 }
      { x = S.x2, y = S.y1 }
      { x = S.x2, y = S.y2 }
      { x = S.x1, y = S.y2 }
    }

    apply_brush(brush)
  end


  local function do_whole_triangle(A, C, B)
    local cx, cy = corner_coord(C)
    local ax, ay = corner_coord(A)
    local bx, by = corner_coord(B)

    local brush =
    {
      { x = ax, y = ay }
      { x = cx, y = cy }
      { x = bx, y = by }
    }

    apply_brush(brush)
  end


  local function do_triangle(A, C, B, away)
    -- A, B, C are corner numbers
    -- C is the corner either near or away from where the sink goes
    -- the brush formed by A->C->B should be valid (anti-clockwise)

    local cx, cy = corner_coord(C)
    local ax, ay = corner_coord(A)
    local bx, by = corner_coord(B)

    local ax2, ay2 = (ax + cx) / 2, (ay + cy) / 2
    local bx2, by2 = (bx + cx) / 2, (by + cy) / 2

    local k1 = 0.41666
    local k2 = 1 - k1

    if away then k1, k2 = k2, k1 end

    local ax3, ay3 = ax * k1 + cx * k2, ay * k1 + cy * k2
    local bx3, by3 = bx * k1 + cx * k2, by * k1 + cy * k2

--[[ DEBUG
stderrf("C = (%d %d)\n", cx, cy)
stderrf("A = (%d %d)  | (%d %d)  | (%d %d)\n", ax,ay, ax2,ay2, ax3,ay3)
stderrf("B = (%d %d)  | (%d %d)  | (%d %d)\n", bx,by, bx2,by2, bx3,by3)
stderrf("away = %s\n\n", string.bool(away))
--]]

    local brush, trim

    if away then
      brush =
      {
        { x = ax,  y = ay  }
        { x = ax3, y = ay3 }
        { x = bx3, y = by3 }
        { x = bx,  y = by  }
      }

      trim =
      {
        { x = bx2, y = by2 }
        { x = bx3, y = by3 }
        { x = ax3, y = ay3 }
        { x = ax2, y = ay2 }
      }

    else -- near
      brush =
      {
        { x = ax3, y = ay3 }
        { x = cx,  y = cy  }
        { x = bx3, y = by3 }
      }

      trim =
      {
        { x = ax2, y = ay2 }
        { x = ax3, y = ay3 }
        { x = bx3, y = by3 }
        { x = bx2, y = by2 }
      }
    end

    apply_brush(brush)
    apply_brush(trim, "is_trim")
  end


  -- categorize corners
  local p1 = check_inner_point(S.sx    , S.sy)
  local p3 = check_inner_point(S.sx + 1, S.sy)
  local p7 = check_inner_point(S.sx    , S.sy + 1)
  local p9 = check_inner_point(S.sx + 1, S.sy + 1)


  if S.diagonal == 1 then
    local p_val = sel(p1,1,0) + sel(p3,2,0) + sel(p7,4,0)

    if p_val == 7 then do_whole_triangle(1,3,7) end

    if p_val == 1 then do_triangle(7,1,3, false) end
    if p_val == 2 then do_triangle(1,3,7, false) end
    if p_val == 4 then do_triangle(3,7,1, false) end

    if p_val == 6 then do_triangle(7,1,3, true) end
    if p_val == 5 then do_triangle(1,3,7, true) end
    if p_val == 3 then do_triangle(3,7,1, true) end

  elseif S.diagonal == 3 then
    local p_val = sel(p1,1,0) + sel(p3,2,0) + sel(p9,4,0)

    if p_val == 7 then do_whole_triangle(1,3,9) end

    if p_val == 1 then do_triangle(9,1,3, false) end
    if p_val == 2 then do_triangle(1,3,9, false) end
    if p_val == 4 then do_triangle(3,9,1, false) end

    if p_val == 6 then do_triangle(9,1,3, true) end
    if p_val == 5 then do_triangle(1,3,9, true) end
    if p_val == 3 then do_triangle(3,9,1, true) end

  elseif S.diagonal == 9 then
    local p_val = sel(p9,1,0) + sel(p7,2,0) + sel(p3,4,0)

    if p_val == 7 then do_whole_triangle(9,7,3) end

    if p_val == 1 then do_triangle(3,9,7, false) end
    if p_val == 2 then do_triangle(9,7,3, false) end
    if p_val == 4 then do_triangle(7,3,9, false) end

    if p_val == 6 then do_triangle(3,9,7, true) end
    if p_val == 5 then do_triangle(9,7,3, true) end
    if p_val == 3 then do_triangle(7,3,9, true) end

  elseif S.diagonal == 7 then

    local p_val = sel(p9,1,0) + sel(p7,2,0) + sel(p1,4,0)

    if p_val == 7 then do_whole_triangle(9,7,1) end

    if p_val == 1 then do_triangle(1,9,7, false) end
    if p_val == 2 then do_triangle(9,7,1, false) end
    if p_val == 4 then do_triangle(7,1,9, false) end

    if p_val == 6 then do_triangle(1,9,7, true) end
    if p_val == 5 then do_triangle(9,7,1, true) end
    if p_val == 3 then do_triangle(7,1,9, true) end

  else  -- Square --

    local p_val = sel(p1,1,0) + sel(p3,2,0) + sel(p7,4,0) + sel(p9,8,0)

    -- nothing open
    if p_val == 0 then return end

    -- all corners open
    if p_val == 15 then do_whole_square() end

    -- one corner open

    if p_val ==  1 then do_triangle(7,1,9, false) ; do_triangle(9,1,3, false) end
    if p_val ==  2 then do_triangle(1,3,7, false) ; do_triangle(7,3,9, false) end

    if p_val ==  4 then do_triangle(3,7,1, false) ; do_triangle(9,7,3, false) end
    if p_val ==  8 then do_triangle(1,9,7, false) ; do_triangle(3,9,1, false) end

    -- two open, two closed

    if p_val == 3  then do_triangle(7,1,9, false) ; do_triangle(3,9,1, true)  end
    if p_val == 12 then do_triangle(7,1,9, true)  ; do_triangle(3,9,1, false) end

    if p_val == 5  then do_triangle(1,3,7, true)  ; do_triangle(9,7,3, false) end
    if p_val == 10 then do_triangle(1,3,7, false) ; do_triangle(9,7,3, true)  end

    -- the "proper" way
    --if p_val ==  9 then do_triangle(7,1,3, false) ; do_triangle(3,9,7, false) end
    --if p_val ==  6 then do_triangle(9,7,1, false) ; do_triangle(1,3,9, false) end

    -- the "alternative" way : connects the two sub-areas
    if p_val ==  6 then do_triangle(7,1,3, true) ; do_triangle(3,9,7, true) end
    if p_val ==  9 then do_triangle(9,7,1, true) ; do_triangle(1,3,9, true) end
    
    -- three corners open

    if p_val == 14 then do_triangle(7,1,9, true)  ; do_triangle(9,1,3, true)  end
    if p_val == 13 then do_triangle(1,3,7, true)  ; do_triangle(7,3,9, true)  end

    if p_val == 11 then do_triangle(3,7,1, true)  ; do_triangle(9,7,3, true)  end
    if p_val ==  7 then do_triangle(1,9,7, true)  ; do_triangle(3,9,1, true)  end
  end
end



function Render_void(A, S)
  -- used for VOID areas and prefabs occupying whole seed

  local w_brush = S:make_brush()

  brushlib.set_mat(w_brush, A.wall_mat)

  Trans.brush(w_brush)
end



function Render_floor(A, S)
  local f_brush = S:make_brush()

  local f_h = S.floor_h or A.floor_h

  local f_mat = S.floor_mat or A.floor_mat
  local f_side = S.floor_side or S.floor_mat or A.floor_side or f_mat

  local tag = S.tag
-- tag = A.id
-- if A.conn_group then tag = A.conn_group end
-- if A.quest and A.quest.id < 2 then tag = 1 end
-- if A.is_boundary then tag = 1000 + A.id end


  -- handle railings [ must be done here ]
  each C in f_brush do
    local info = edge_get_rail(S, C.__dir)
    if info then
      C.rail = assert(info.rail_mat)
      C.v1 = 0
      C.back_rail = C.rail
      C.back_v1 = 0
      C.blocked = info.blocked
    end
  end


  table.insert(f_brush, { t=f_h, light=S.light, tag=tag })

  brushlib.set_mat(f_brush, f_side, f_mat)

  Trans.brush(f_brush)

  -- remember floor brush for the spot logic
  table.insert(A.floor_brushes, f_brush)

  if A.floor_sink then
    Render_sink_part(A, S, "floor",   A.floor_sink)
  end
end



function Render_ceiling(A, S)
  local c_h = S.ceil_h or A.ceil_h

  local c_mat  = S.ceil_mat  or A.ceil_mat
  local c_side = S.ceil_side or S.ceil_mat or A.ceil_side or c_mat

  local c_brush = S:make_brush()

  table.insert(c_brush, { b=c_h })

  brushlib.set_mat(c_brush, c_side, c_mat)

  Trans.brush(c_brush)

  if A.ceil_sink then
    Render_sink_part(A, S, "ceiling", A.ceil_sink)
  end
end



function Render_hallway(A, S)
  local R = A.room

  -- determine common part of prefab name
  local fab_common

  if S.hall_piece then
    if S.hall_piece.shape == "I" then
      fab_common = "stair_"
    else
      fab_common = "curve_"
    end

    -- append "big" or "small"
    fab_common = fab_common .. S.hall_piece.z_size
  end

  local skin = {}

--- if A.room.hallway.parent then skin.floor = "FLAT14" end


  if S.hall_piece then
    local fab_name = "Hall_f_" .. fab_common
    local def = Fab_lookup(fab_name)

    local z = S.floor_h + S.hall_piece.z_offset
    local T = Trans.box_transform(S.x1, S.y1, S.x2, S.y2, z, S.hall_piece.dir)

    if S.hall_piece.mirror then T.mirror_x = 96 end

    Fabricate(A.room, def, T, { skin })

  else
    Render_floor(A, S)
  end


  if S.hall_piece and not A.is_outdoor and not R.hallway.parent then
    local fab_name = "Hall_c_" .. fab_common
    local def = Fab_lookup(fab_name)

    local z = S.ceil_h + S.hall_piece.z_offset
    local T = Trans.box_transform(S.x1, S.y1, S.x2, S.y2, z, S.hall_piece.dir)

    if S.hall_piece.mirror then T.mirror_x = 96 end

    Fabricate(A.room, def, T, { skin })
  else
    Render_ceiling(A, S)
  end
end



function Render_seed(A, S)
  assert(S.area == A)

  -- FIXME : closets

  if S.kind == "void" then
    Render_void(A, S)
    return
  end

  if A.mode == "void" then
--stderrf("Void area: %s @ %s\n", A.name, A.seeds[1]:tostr())
    return
  end

---###  -- scenic done elsewhere (in Layout_build_mountains)
---###  if A.mode == "scenic" then
---###    return
---###  end

  if A.mode == "hallway" then
    Render_hallway(A, S)
    return
  end

  Render_floor  (A, S)
  Render_ceiling(A, S)
end



function Render_walls(A, S)
  each dir in geom.ALL_DIRS do
    Render_edge(A, S, dir)
  end
end



function Render_area(A)
  -- stairwells are special little butterflies...
  if A.is_stairwell then
    Layout_build_stairwell(A)
    return
  end

  A.floor_brushes = {}
  A.side_edges = {}

  each S in A.seeds do
    Render_seed(A, S)
    Render_walls(A, S)
  end
end



function Render_depot(depot)
  -- dest_R is the room which gets the trap spots
  local dest_R = assert(depot.room)

  local x1 = depot.x1
  local y1 = depot.y1

  local z = assert(LEVEL.player1_z)


  local def = Fab_lookup("Depot")

  local x2 = x1 + def.seed_w * SEED_SIZE
  local y2 = y1 + def.seed_h * SEED_SIZE

  local skin1 =
  {
    wall = "COMPSPAN"
  }

  assert(depot.skin)


  local T = Trans.box_transform(x1, y1, x2, y2, z, 2)

  Fabricate(dest_R, def, T, { skin1, depot.skin })
end



function Render_all_areas()
  each A in LEVEL.areas do
    Render_area(A)
  end

  each depot in LEVEL.depots do
    Render_depot(depot)
  end

---###  each Z in LEVEL.zones do
---###    Layout_build_mountains(Z)
---###  end
end


------------------------------------------------------------------------


function Render_properties_for_area(A)

  -- scenic borders done elsewhere...
  if A.mode == "scenic" then
    return
  end


  local R = A.room
  if not R then R = A.face_room end

if not R then
  A.mode = "void"
end


  if A.mode == "void" then
    A.facade_mat = A.zone.facade_mat
    A.wall_mat   = A.facade_mat
    A.floor_mat  = A.wall_mat
    return
  end


  if not A.floor_h then
    A.floor_h = -7
  end

  if A.is_porch then
    A.ceil_h = A.floor_h + 144

  elseif not A.ceil_h then
    A.ceil_h = A.floor_h + rand.pick({ 128, 192,192,192, 256,320 })
  end


  if A.kind == "building" then
    A.wall_mat  = assert(R.main_tex)

    if R.theme and R.theme.floors then
      A.floor_mat = rand.key_by_probs(R.theme.floors)
    end

    if R.theme and R.theme.ceilings then
      A.ceil_mat  = rand.key_by_probs(R.theme.ceilings)
    end

    A.facade_mat = A.zone.facade_mat

  elseif A.kind == "courtyard" then
    A.floor_mat = "BROWN1"

  elseif A.kind == "landscape" then
    A.floor_mat = "RROCK19"
    if THEME.base_skin and THEME.base_skin.grass then
      A.floor_mat = THEME.base_skin.grass
    end

  elseif A.kind == "cave" then
    A.wall_mat  = "ASHWALL4"
    A.floor_mat = "RROCK04"
    A.facade_mat = A.wall_mat

  else
    A.floor_mat = "_ERROR"
  end

  if A.mode == "hallway" then
    A.floor_mat = "FLAT5_1"
    A.wall_mat  = "WOOD1"
    A.ceil_mat  = "WOOD1"

    -- TEMP CRUD to match 'hall_piece' texture usage
    if A.room and A.room.skin and A.room.skin.wall then
      A.floor_mat = A.room.skin.wall
      A. ceil_mat = A.room.skin.wall
    end

    if not A.is_outdoor then
      A.facade_mat = A.zone.facade_mat
    end

    if A.ceil_h then
      -- done already
    elseif A.is_porch then
      A.ceil_h = A.floor_h + 128
    elseif not A.is_outdoor then
      A.ceil_h = A.floor_h + 80
    end
  end


  if A.mode == "pool" or A.pool_hack then
    A.floor_mat = "_LIQUID"
--    A.wall_mat  = "ASHWALL7"
  end


  if A.mode == "trap" and not A.is_outdoor then
    A.ceil_h = A.floor_h + 144
  end


  if A.is_outdoor and not A.is_porch then
    A.ceil_mat = "_SKY"
  end

  A.wall_mat = A.wall_mat or A.floor_mat
  A.ceil_mat = A.ceil_mat or A.wall_mat

  A.facade_mat = A.facade_mat or A.wall_mat

  --DEBUG FOR SECRETS
  if A.room and A.room.is_secret then
---  A.floor_mat = "REDWALL"
  end

--[[ ZONE TESTING
if A.mode != "hallway" then
if A.zone.id == 1 then A.floor_mat = "FWATER1" end
if A.zone.id == 2 then A.floor_mat = "NUKAGE1" end
if A.zone.id == 3 then A.floor_mat = "LAVA1" end
if A.zone.id == 4 then A.floor_mat = "CEIL5_2" end
end
--]]

  assert(A.wall_mat)
end



function Render_set_all_properties()
  each A in LEVEL.areas do
    Render_properties_for_area(A)
  end
end



------------------------------------------------------------------------


function Render_importants()

  local R  -- the current room


  local function player_dir(spot)
    -- FIXME : analyse all 4 directions, pick one which can see the most
    --         [ or opposite of one which can see the least ]

    local S = Seed_from_coord(spot.x, spot.y)

    if R.sh > R.sw then
      if S.sy > (R.sy1 + R.sy2) / 2 then 
        return 2
      else
        return 8
      end
    else
      if S.sx > (R.sx1 + R.sx2) / 2 then 
        return 4
      else
        return 6
      end
    end
  end


  local function content_big_item(spot, item)
    local fab_name = "Item_pedestal"

    -- FIXME: TEMP RUBBISH
    if string.sub(item, 1, 2) == "kc" or
       string.sub(item, 1, 2) == "ks" then
      fab_name = "Item_podium"
    end

    local def = Fab_lookup(fab_name)

    local skin1 = { object=item }

    local T = Trans.spot_transform(spot.x, spot.y, spot.z, spot.dir)

    Fabricate(R, def, T, { skin1 })

    Trans.entity("light", spot.x, spot.y, spot.z+112, { cave_light=176 })
  end


  local function content_very_big_item(spot, item, is_weapon)
--[[  FIXME : LOWERING PEDESTALS

    -- sometimes make a lowering pedestal
    local prob = sel(is_weapon, 40, 20)

    if rand.odds(prob) and
       THEME.lowering_pedestal_skin and
       not S.chunk[2]
    then
      local mx, my = spot.x, spot.y
      local z1 = spot.z

      local z_top

      if R.kind == "cave" then
        z_top = z1 + rand.pick({ 64, 96 })

      else
        local z2 = S.ceil_h or S.room.ceil_h or (z1 + 256)

        if z2 < z1 + 170 then
          z_top = z1 + 64
        else
          z_top = z1 + 128
        end
      end

      Build.lowering_pedestal(S, z_top, THEME.lowering_pedestal_skin)

      Trans.entity(item, mx, my, z_top)
      Trans.entity("light", mx, my, z_top + 24, { cave_light=176 })

      return
    end
--]]

    content_big_item(spot, item)
  end


  local function content_start_pad(spot, dir)
    local def = Fab_lookup("Start_basic")

    local T = Trans.spot_transform(spot.x, spot.y, spot.z, 10 - dir)

    Fabricate(R, def, T, { })
  end


  local function content_coop_pair(spot, dir)
    -- no prefab for this : add player entities directly

    local mx = spot.x
    local my = spot.y
    local  z = spot.z

    local angle = geom.ANGLES[dir]

    local dx, dy = geom.delta(dir)

    dx = dx * 24 ; dy = dy * 24

    Trans.entity(R.player_set[1], mx - dy, my + dx, z, { angle=angle })
    Trans.entity(R.player_set[2], mx + dy, my - dx, z, { angle=angle })

    if GAME.ENTITIES["player8"] then
      mx = mx - dx * 2
      my = my - dy * 2

      Trans.entity(R.player_set[3], mx - dy, my + dx, z, { angle=angle })
      Trans.entity(R.player_set[4], mx + dy, my - dx, z, { angle=angle })
    end
  end


  local function content_start(spot)
    local dir = player_dir(spot)

---???    if OB_CONFIG.game == "quake" then
---???      local skin = { floor="SLIP2", wall="SLIPSIDE" }
---???
---???      Build.quake_exit_pad(S, z1 + 16, skin, LEVEL.next_map)

    if R.player_set then
      content_coop_pair(spot, dir)

--[[
    elseif false and PARAM.raising_start and R.svolume >= 20 and
       R.kind != "cave" and
       THEME.raising_start_switch and rand.odds(25)
    then
      -- TODO: fix this
      gui.debugf("Raising Start made\n")

      local skin =
      {
        f_tex = S.f_tex or R.main_tex,
        switch_w = THEME.raising_start_switch,
      }

      Build.raising_start(S, 6, z1, skin)
      angle = 0

      S.no_floor = true
      S.raising_start = true
      R.has_raising_start = true
--]]
    else

      content_start_pad(spot, dir)
    end
  end


  local function content_exit(spot, secret_exit)
    local fab_name = "Exit_switch"

    if secret_exit then fab_name = "Exit_pillar_secret" end

    local def = Fab_lookup(fab_name)

    local skin1 = { }

    local dir = spot.dir or 2

    local T = Trans.spot_transform(spot.x, spot.y, spot.z, 10 - dir)

    Fabricate(R, def, T, { skin1 })
  end


  local function content_switch(spot)
    -- TODO: find it properly
    local fab_name = "Switch_small_" .. spot.goal.item

    local def = Fab_lookup(fab_name)

    local skin1 = { }

    skin1.lock_tag = assert(spot.goal.tag)

    skin1.action = spot.goal.action  -- can be NIL

    local T = Trans.spot_transform(spot.x, spot.y, spot.z, spot.dir)

    Fabricate(R, def, T, { skin1 })
  end


  local function content_weapon(spot)
    local weapon = assert(spot.content_item)

    if R.is_start or R.kind == "hallway" then
      -- bare item
      Trans.entity(weapon, spot.x, spot.y, spot.z)
    else
      content_very_big_item(spot, weapon, "is_weapon")
    end

    gui.debugf("Placed weapon '%s' @ (%d,%d,%d)\n", weapon, spot.x, spot.y, spot.z)
  end


  local function content_item(spot)
    local item = assert(spot.content_item)

    if R.is_start or R.kind == "hallway" then
      -- bare item
      Trans.entity(item, spot.x, spot.y, spot.z)
    else
      content_big_item(spot, item)
    end
  end


  local function content_flag(spot)
    -- TODO : prefab for flag base

    content_big_item(spot, assert(spot.item))
  end


  local function content_teleporter(spot)
    local C = assert(spot.conn)

    local def = Fab_lookup("Teleporter1")

    local skin1 = {}

    if C.A1.room == R then
      skin1. in_tag = C.tele_tag2
      skin1.out_tag = C.tele_tag1
    else
      skin1. in_tag = C.tele_tag1
      skin1.out_tag = C.tele_tag2
    end

    skin1. in_target = string.format("tele%d", skin1. in_tag)
    skin1.out_target = string.format("tele%d", skin1.out_tag)

    local spot_dir = 2  --!!! FIXME  10 - dir_for_wotsit(S)

    local T = Trans.spot_transform(spot.x, spot.y, spot.z, spot_dir)

    Fabricate(R, def, T, { skin1 })
  end


  local function content_mon_teleport(spot)
    -- creates a small sector with a tag and teleportman entity

    -- ignore unused spots [ can validly happen ]
    if not spot.tag then return end

    local r = 16

    local brush = brushlib.quad(spot.x - r, spot.y - r, spot.x + r, spot.y + r)

    -- mark as "no draw"
    each C in brush do
      C.draw_never = 1
    end

    local A = assert(spot.area)

    -- make it higher to ensure it doesn't get eaten by the floor brush
    -- (use delta_z to lower to real height)

    local top =
    {
      t = A.floor_h + 1
      delta_z = -1
      tag = assert(spot.tag)
    }

    table.insert(brush, top)

    brushlib.set_mat(brush, A.floor_mat, A.floor_mat)

    Trans.brush(brush)

    -- add teleport entity
    Trans.entity("teleport_spot", spot.x, spot.y, top.t + 1)
  end


  local function build_important(spot)
    if spot.content_kind == "START" then
      content_start(spot)

    elseif spot.content_kind == "LEVEL_EXIT" then
      content_exit(spot)

    elseif spot.content_kind == "SECRET_EXIT" then
      content_exit(spot, "secret_exit")

    elseif spot.content_kind == "KEY" then
      content_very_big_item(spot, assert(spot.item))

    elseif spot.content_kind == "SWITCH" then
      content_switch(spot)

    elseif spot.content_kind == "WEAPON" then
      content_weapon(spot)

    elseif spot.content_kind == "ITEM" then
      content_item(spot)

    elseif spot.content_kind == "FLAG" then
      content_flag(spot)

    elseif spot.content_kind == "TELEPORTER" then
      content_teleporter(spot)

    elseif spot.content_kind == "MON_TELEPORT" then
      content_mon_teleport(spot)
    else
      error("unknown important: " .. tostring(spot.content_kind))
    end
  end


  local function build_trigger(spot)
    local r = spot.trigger.r

    local action = assert(spot.trigger.action)
    local tag    = assert(spot.trigger.tag)

    local brush = brushlib.quad(spot.x - r, spot.y - r, spot.x + r, spot.y + r)

    each C in brush do
      C.special = action
      C.tag     = tag
    end

    brushlib.set_kind(brush, "trigger")

    Trans.brush(brush)
  end


  ---| Render_importants |---

  each room in LEVEL.rooms do
    R = room

    each spot in R.importants do
      build_important(spot)

      if spot.trigger then
        build_trigger(spot)
      end
    end
  end
end

