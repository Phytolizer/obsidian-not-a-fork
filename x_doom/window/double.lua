--
-- Window with two narrow holes
--

DOOM.SKINS.Window_double =
{
  file   = "window/double.wad"
  where  = "edge"
  long   = 192
  deep   = 32

  bound_z1 = 0
  bound_z2 = 112

  prob = 90
}


--
-- Tall version (expands vertically)
--

DOOM.SKINS.Window_double_tall =
{
  file   = "window/double.wad"
  where  = "edge"
  long   = 192
  deep   = 32

  bound_z1 = 0
  bound_z2 = 112

  z_fit = { 64, 88 }

  prob = 90
}

