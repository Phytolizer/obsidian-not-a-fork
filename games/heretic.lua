----------------------------------------------------------------
-- GAME DEF : Heretic
----------------------------------------------------------------
--
--  Oblige Level Maker (C) 2006-2008 Andrew Apted
--                     (C)      2008 Sam Trenholme
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
----------------------------------------------------------------
--
--  Big thanks to Sam Trenholme who greatly improved the
--  Heretic theme (including lots of new COMBOs).
--
----------------------------------------------------------------

HC_THINGS =
{
  --- special stuff ---
  player1 = { id=1, kind="other", r=16,h=56 },
  player2 = { id=2, kind="other", r=16,h=56 },
  player3 = { id=3, kind="other", r=16,h=56 },
  player4 = { id=4, kind="other", r=16,h=56 },

  dm_player     = { id=11, kind="other", r=16,h=56 },
  teleport_spot = { id=14, kind="other", r=16,h=56 },

  --- monsters ---
  gargoyle   = { id=66, kind="monster", r=16,h=36 },
  fire_garg  = { id=5,  kind="monster", r=16,h=36 },
  mummy      = { id=68, kind="monster", r=22,h=64 },
  mummy_inv  = { id=69, kind="monster", r=22,h=64 },

  leader     = { id=45, kind="monster", r=22,h=64 },
  leader_inv = { id=46, kind="monster", r=22,h=64 },
  knight     = { id=64, kind="monster", r=24,h=80 },
  knight_inv = { id=65, kind="monster", r=24,h=80 },

  disciple   = { id=15, kind="monster", r=16,h=72 },
  sabreclaw  = { id=90, kind="monster", r=20,h=64 },
  weredragon = { id=70, kind="monster", r=34,h=80 },
  ophidian   = { id=92, kind="monster", r=22,h=72 },

  -- bosses
  Ironlich   = { id=6,  kind="monster", r=40,h=72 },
  Maulotaur  = { id=9,  kind="monster", r=28,h=104 },
  D_Sparil   = { id=7,  kind="monster", r=28,h=104 },

  --- pickups ---
  k_yellow   = { id=80, kind="pickup", r=20,h=16, pass=true },
  k_green    = { id=73, kind="pickup", r=20,h=16, pass=true },
  k_blue     = { id=79, kind="pickup", r=20,h=16, pass=true },

  gauntlets  = { id=2005, kind="pickup", r=20,h=16, pass=true },
  crossbow   = { id=2001, kind="pickup", r=20,h=16, pass=true },
  claw       = { id=53,   kind="pickup", r=20,h=16, pass=true },
  hellstaff  = { id=2004, kind="pickup", r=20,h=16, pass=true },
  phoenix    = { id=2003, kind="pickup", r=20,h=16, pass=true },
  firemace   = { id=2002, kind="pickup", r=20,h=16, pass=true },

  crystal    = { id=10, kind="pickup", r=20,h=16, pass=true },
  geode      = { id=12, kind="pickup", r=20,h=16, pass=true },
  arrows     = { id=18, kind="pickup", r=20,h=16, pass=true },
  quiver     = { id=19, kind="pickup", r=20,h=16, pass=true },
  claw_orb1  = { id=54, kind="pickup", r=20,h=16, pass=true },
  claw_orb2  = { id=55, kind="pickup", r=20,h=16, pass=true },
  runes1     = { id=20, kind="pickup", r=20,h=16, pass=true },
  runes2     = { id=21, kind="pickup", r=20,h=16, pass=true },
  flame_orb1 = { id=22, kind="pickup", r=20,h=16, pass=true },
  flame_orb2 = { id=23, kind="pickup", r=20,h=16, pass=true },
  mace_orbs  = { id=13, kind="pickup", r=20,h=16, pass=true },
  mace_pile  = { id=16, kind="pickup", r=20,h=16, pass=true },

  h_vial  = { id=81, kind="pickup", r=20,h=16, pass=true },
  h_flask = { id=82, kind="pickup", r=20,h=16, pass=true },
  h_urn   = { id=32, kind="pickup", r=20,h=16, pass=true },
  shield1 = { id=85, kind="pickup", r=20,h=16, pass=true },
  shield2 = { id=31, kind="pickup", r=20,h=16, pass=true },

  bag     = { id=8,  kind="pickup", r=20,h=16, pass=true },
  wings   = { id=23, kind="pickup", r=20,h=16, pass=true },
  ovum    = { id=30, kind="pickup", r=20,h=16, pass=true },
  torch   = { id=33, kind="pickup", r=20,h=16, pass=true },
  bomb    = { id=34, kind="pickup", r=20,h=16, pass=true },
  map     = { id=35, kind="pickup", r=20,h=16, pass=true },
  chaos   = { id=36, kind="pickup", r=20,h=16, pass=true },
  shadow  = { id=75, kind="pickup", r=20,h=16, pass=true },
  ring    = { id=84, kind="pickup", r=20,h=16, pass=true },
  tome    = { id=86, kind="pickup", r=20,h=16, pass=true },

  --- scenery ---
  wall_torch    = { id=50, kind="scenery", r=10,h=64, light=255, pass=true, add_mode="extend" },
  serpent_torch = { id=27, kind="scenery", r=12,h=54, light=255 },
  fire_brazier  = { id=76, kind="scenery", r=16,h=44, light=255 },
  chandelier    = { id=28, kind="scenery", r=31,h=60, light=255, pass=true, ceil=true, add_mode="island" },

  barrel  = { id=44,   kind="scenery", r=12,h=32 },
  pod     = { id=2035, kind="scenery", r=16,h=54 },

  blue_statue   = { id=94, kind="scenery", r=16,h=54 },
  green_statue  = { id=95, kind="scenery", r=16,h=54 },
  yellow_statue = { id=96, kind="scenery", r=16,h=54 },

  moss1   = { id=48, kind="scenery", r=16,h=24, ceil=true, pass=true },
  moss2   = { id=49, kind="scenery", r=16,h=28, ceil=true, pass=true },
  volcano = { id=87, kind="scenery", r=12,h=32 },
  
  small_pillar = { id=29, kind="scenery", r=16,h=36 },
  brown_pillar = { id=47, kind="scenery", r=16,h=128 },
  glitter_red  = { id=74, kind="scenery", r=20,h=16, pass=true },
  glitter_blue = { id=52, kind="scenery", r=20,h=16, pass=true },

  stal_small_F = { id=37, kind="scenery", r=12,h=36 },
  stal_small_C = { id=39, kind="scenery", r=16,h=36, ceil=true },
  stal_big_F   = { id=38, kind="scenery", r=12,h=72 },
  stal_big_C   = { id=40, kind="scenery", r=16,h=72, ceil=true },

  hang_skull_1 = { id=17, kind="scenery", r=20,h=64, ceil=true, pass=true },
  hang_skull_2 = { id=24, kind="scenery", r=20,h=64, ceil=true, pass=true },
  hang_skull_3 = { id=25, kind="scenery", r=20,h=64, ceil=true, pass=true },
  hang_skull_4 = { id=26, kind="scenery", r=20,h=64, ceil=true, pass=true },
  hang_corpse  = { id=51, kind="scenery", r=12,h=104,ceil=true },

  --- ambient sounds ---
  amb_scream = { id=1200, kind="other", r=20,h=16, pass=true },
  amb_squish = { id=1201, kind="other", r=20,h=16, pass=true },
  amb_drip   = { id=1202, kind="other", r=20,h=16, pass=true },
  amb_feet   = { id=1203, kind="other", r=20,h=16, pass=true },
  amb_heart  = { id=1204, kind="other", r=20,h=16, pass=true },
  amb_bells  = { id=1205, kind="other", r=20,h=16, pass=true },
  amb_growl  = { id=1206, kind="other", r=20,h=16, pass=true },
  amb_magic  = { id=1207, kind="other", r=20,h=16, pass=true },
  amb_laugh  = { id=1208, kind="other", r=20,h=16, pass=true },
  amb_run    = { id=1209, kind="other", r=20,h=16, pass=true },

  env_water  = { id=41, kind="other", r=20,h=16, pass=true },
  env_wind   = { id=42, kind="other", r=20,h=16, pass=true },
}

HC_LINE_TYPES =  -- NOTE: only includes differences to DOOM
{
  A1_scroll_right = { kind=99 },
  W1_secret_exit  = { kind=105 }, -- FIXME: correct?

  P1_green_door = { kind=33 },
  PR_green_door = { kind=28 },
}

HC_SECTOR_TYPES =
{
  secret   = { kind=9 },
  friction = { kind=15 },

  random_off = { kind=1 },
  blink_fast = { kind=2 },
  blink_slow = { kind=3 },
  glow       = { kind=8 },

  damage_5  = { kind=7 },
  damage_10 = { kind=5 },
  damage_20 = { kind=16 },
}


----------------------------------------------------------------

HC_PALETTE =
{
    0,  0,  0,   2,  2,  2,  16, 16, 16,  24, 24, 24,  31, 31, 31,
   36, 36, 36,  44, 44, 44,  48, 48, 48,  55, 55, 55,  63, 63, 63,
   70, 70, 70,  78, 78, 78,  86, 86, 86,  93, 93, 93, 101,101,101,
  108,108,108, 116,116,116, 124,124,124, 131,131,131, 139,139,139,
  146,146,146, 154,154,154, 162,162,162, 169,169,169, 177,177,177,
  184,184,184, 192,192,192, 200,200,200, 207,207,207, 210,210,210,
  215,215,215, 222,222,222, 228,228,228, 236,236,236, 245,245,245,
  255,255,255,  50, 50, 50,  59, 60, 59,  69, 72, 68,  78, 80, 77,
   88, 93, 86,  97,100, 95, 109,112,104, 116,123,112, 125,131,121,
  134,141,130, 144,151,139, 153,161,148, 163,171,157, 172,181,166,
  181,189,176, 189,196,185,  20, 16, 36,  24, 24, 44,  36, 36, 60,
   52, 52, 80,  68, 68, 96,  88, 88,116, 108,108,136, 124,124,152,
  148,148,172, 164,164,184, 180,184,200, 192,196,208, 208,208,216,
  224,224,224,  27, 15,  8,  38, 20, 11,  49, 27, 14,  61, 31, 14,
   65, 35, 18,  74, 37, 19,  83, 43, 19,  87, 47, 23,  95, 51, 27,
  103, 59, 31, 115, 67, 35, 123, 75, 39, 131, 83, 47, 143, 91, 51,
  151, 99, 59, 160,108, 64, 175,116, 74, 180,126, 81, 192,135, 91,
  204,143, 93, 213,151,103, 216,159,115, 220,167,126, 223,175,138,
  227,183,149, 230,190,161, 233,198,172, 237,206,184, 240,214,195,
   62, 40, 11,  75, 50, 16,  84, 59, 23,  95, 67, 30, 103, 75, 38,
  110, 83, 47, 123, 95, 55, 137,107, 62, 150,118, 75, 163,129, 84,
  171,137, 92, 180,146,101, 188,154,109, 196,162,117, 204,170,125,
  208,176,133,  37, 20,  4,  47, 24,  4,  57, 28,  6,  68, 33,  4,
   76, 36,  3,  84, 40,  0,  97, 47,  2, 114, 54,  0, 125, 63,  6,
  141, 75,  9, 155, 83, 17, 162, 95, 21, 169,103, 26, 180,113, 32,
  188,124, 20, 204,136, 24, 220,148, 28, 236,160, 23, 244,172, 47,
  252,187, 57, 252,194, 70, 251,201, 83, 251,208, 97, 251,214,110,
  251,221,123, 250,228,136, 157, 51,  4, 170, 65,  2, 185, 86,  4,
  213,118,  4, 236,164,  3, 248,190,  3, 255,216, 43, 255,255,  0,
   67,  0,  0,  79,  0,  0,  91,  0,  0, 103,  0,  0, 115,  0,  0,
  127,  0,  0, 139,  0,  0, 155,  0,  0, 167,  0,  0, 179,  0,  0,
  191,  0,  0, 203,  0,  0, 215,  0,  0, 227,  0,  0, 239,  0,  0,
  255,  0,  0, 255, 52, 52, 255, 74, 74, 255, 95, 95, 255,123,123,
  255,155,155, 255,179,179, 255,201,201, 255,215,215,  60, 12, 88,
   80,  8,108, 104,  8,128, 128,  0,144, 152,  0,176, 184,  0,224,
  216, 44,252, 224,120,240,  37,  6,129,  60, 33,147,  82, 61,165,
  105, 88,183, 128,116,201, 151,143,219, 173,171,237, 196,198,255,
    2,  4, 41,   2,  5, 49,   6,  8, 57,   2,  5, 65,   2,  5, 79,
    0,  4, 88,   0,  4, 96,   0,  4,104,   2,  5,121,   2,  5,137,
    6,  9,159,  12, 16,184,  32, 40,200,  56, 60,220,  80, 80,253,
   80,108,252,  80,136,252,  80,164,252,  80,196,252,  72,220,252,
   80,236,252,  84,252,252, 152,252,252, 188,252,244,  11, 23,  7,
   19, 35, 11,  23, 51, 15,  31, 67, 23,  39, 83, 27,  47, 99, 35,
   55,115, 43,  63,131, 47,  67,147, 55,  75,159, 63,  83,175, 71,
   91,191, 79,  95,207, 87, 103,223, 95, 111,239,103, 119,255,111,
   23, 31, 23,  27, 35, 27,  31, 43, 31,  35, 51, 35,  43, 55, 43,
   47, 63, 47,  51, 71, 51,  59, 75, 55,  63, 83, 59,  67, 91, 67,
   75, 95, 71,  79,103, 75,  87,111, 79,  91,115, 83,  95,123, 87,
  103,131, 95, 255,223,  0, 255,191,  0, 255,159,  0, 255,127,  0,
  255, 95,  0, 255, 63,  0, 244, 14,  3,  55,  0,  0,  47,  0,  0,
   39,  0,  0,  23,  0,  0,  15, 15, 15,  11, 11, 11,   7,  7,  7,
  255,255,255
}


----------------------------------------------------------------

HC_COMBOS =
{
  ---- INDOOR ------------

  GOLD =
  {
    theme_probs = { CITY=20, EGYPT=20 },
    mat_pri = 6,

    wall  = "SANDSQ2",
    floor = "FLOOR06",
    ceil  = "FLOOR11",

--  void = "SNDBLCKS",
    pillar = "SNDCHNKS",

    scenery = "wall_torch",

    wall_fabs = { wall_pic_GLASS1=30, wall_pic_GLASS2=15, other=10 },
  },

  BLOCK =
  {
    theme_probs = { CITY=20 },
    mat_pri = 7,

    wall  = "GRSTNPB",
    floor = "FLOOR03",
    ceil  = "FLOOR03",

    void = "GRSTNPBW",
    pillar = "WOODWL",

    scenery = "barrel",

  },

  MOSSY =
  {
    theme_probs = { CITY=20, DOME=20 },
    mat_pri = 2,

    wall  = "MOSSRCK1",
    floor = "FLOOR00",
    ceil  = "FLOOR04",

    pillar = "SKULLSB1", -- SPINE1

    scenery = "chandelier",

  },

  WOOD =
  {
    theme_probs = { CITY=20, EGYPT=20 },
    mat_pri = 2,

    wall  = "WOODWL",
    floor = "FLOOR10",
    ceil  = "FLOOR12",

--  void = "CTYSTUC3",

    scenery = "hang_skull_1",

  },

  HUT =
  {
    theme_probs = { CITY=20, DOME=20 },
    mat_pri = 1,
    
    wall  = "CTYSTUC3",
    floor = "FLOOR10",
    ceil  = "FLOOR11",

--  void = "CTYSTUC4",

    scenery = "barrel",

  },

  DISCO1 = 
  {
    theme_probs = { EGYPT=20 },
    mat_pri = 1,
    
    wall  = "SPINE2",
    floor = "FLAT522",
    ceil  = "FLOOR06",
    step  = "SNDBLCKS",

--  void = "CTYSTUC4",

  },
 
  --- Grey-walls, pink/brown floors 
  DISCO2 = 
  {
    theme_probs = { DOME=20 },
    mat_pri = 1,
    
    wall  = "SQPEB1",
    floor = "FLAT522",
    ceil  = "FLOOR06",
    step  = "SPINE2",

--  void = "CTYSTUC4",

  },
  
  PYRAMID =
  {
    theme_probs = { EGYPT=20 },
    mat_pri = 1,
    
    wall  = "SNDPLAIN",
    floor = "FLOOR27",
    ceil  = "FLOOR10",
    step  = "SPINE2",

--  void = "CTYSTUC4",

  },

  PHAROAH =
  {
    theme_probs = { EGYPT=15 },
    mat_pri = 1,
    
    wall  = "TRISTON2",
    floor = "FLAT522",
    ceil  = "FLOOR20",
    step  = "SQPEB2",

--  void = "CTYSTUC4",

  },

  PARLOR =
  {
    theme_probs = { EGYPT=15 },
    mat_pri = 1,
    
    wall  = "SQPEB2",
    floor = "FLOOR06",
    ceil  = "FLOOR06",
    step  = "SQPEB2",

--  void = "CTYSTUC4",

    scenery = "wall_torch",
  },

  SBLOCK =
  {
    theme_probs = { EGYPT=20 },
    mat_pri = 1,
    
    wall  = "SNDBLCKS",
    floor = "FLOOR27",
    ceil  = "FLOOR10",
    step  = "SPINE2",

--  void = "CTYSTUC4",

  },


  CAVE1 = 
  {
    theme_probs = { CAVE=20 },
    mat_pri = 1,
    wall = "LOOSERCK",
    floor = "FLAT516",
    ceil = "FLOOR01",

    scenery = "stal_big_C",
 
  }, 

  CAVE2 = 
  {
    theme_probs = { CAVE=20 },
    mat_pri = 1,
    wall = "LAVA1",
    floor = "FLAT516",
    ceil = "FLAT506",

    scenery = "stal_small_C",
 
  }, 

  CAVE3 =  -- Muddy walls, but one of the few outdoor textures
  {
    theme_probs = { CAVE=20, EGYPT=10 },
    mat_pri = 1,
    wall = "BRWNRCKS",
    floor = "FLOOR01",
    ceil = "FLAT516",

    scenery = "stal_small_C",
 
  }, 

  PURPLE =
  {
    theme_probs = { GARISH=20 },
    mat_pri = 1,

    wall  = "BLUEFRAG",
    floor = "FLOOR07",
    ceil  = "FLOOR07",

--  void = "CTYSTCI4",

  },

  BLUE =
  {
    theme_probs = { GARISH=20 },
    mat_pri = 1,

    wall  = "MOSAIC1",
    floor = "FLAT502",
    ceil  = "FLOOR16",

--  void = "CTYSTCI4",

  },

--- The greens don't look that great in Heretic
  GREEN =
  {
    theme_probs = { UNUSED=20 },
    mat_pri = 1,

    wall  = "GRNBLOK1",
    floor = "FLAT513",
    ceil  = "FLOOR18",

--  void = "CTYSTCI4",

  },

  ICE =
  {
    theme_probs = { GARISH=20 },
    mat_pri = 1,

    wall  = "STNGLS1",
    floor = "FLAT502",
    ceil  = "FLAT517",

--  void = "CTYSTCI4",

  },

  ROOT =
  {
    theme_probs = { CAVE=15 },
    mat_pri = 1,

    wall  = "ROOTWALL",
    floor = "FLAT506",
    ceil  = "FLAT506",

--  void = "CTYSTCI4",

  },

  ---- OUTDOOR ------------

  CAVEO1 = 
  {
    theme_probs = { CAVE=20 },
    mat_pri = 2,
    outdoor = true,
    wall = "LOOSERCK",
    floor = "FLAT516",
    ceil = "FLOOR01",

    scenery = "stal_big_F",
 
  }, 

  CAVEO2 = 
  {
    theme_probs = { CAVE=20 },
    mat_pri = 2,
    outdoor = true,
    wall = "LAVA1",
    floor = "FLAT516",
    ceil = "FLAT506",

    scenery = "stal_small_F",
 
  }, 

  CAVEMUD = 
  {
    theme_probs = { CAVE=15 },
    mat_pri = 2,
    outdoor = true,
    wall = "RCKSNMUD",
    floor = "FLAT510",
    ceil = "FLAT510",

    scenery = "stal_small_F",
 
  }, 

  --- Looks obnoxious outdoors; disabled
  ROOTO =
  {
    theme_probs = { UNUSED=15 },
    mat_pri = 2,
    outdoor = true,

    wall  = "ROOTWALL",
    floor = "FLAT506",
    ceil  = "FLAT506",

--  void = "CTYSTCI4",

  },


  ODISCO1 = 
  {
    theme_probs = { EGYPT=20 },
    mat_pri = 1,
    outdoor = true,
    
    wall  = "SPINE2",
    floor = "FLAT522",
    ceil  = "FLOOR06",
    step  = "SNDBLCKS",

--  void = "CTYSTUC4",

  },
  
  ODISCO2 = 
  {
    theme_probs = { DOME=20 },
    mat_pri = 1,
    outdoor = true,
    
    wall  = "SQPEB1",
    floor = "FLAT522",
    ceil  = "FLOOR06",
    step  = "SPINE2",

--  void = "CTYSTUC4",

  },

  PYRAMIDO =
  {
    theme_probs = { EGYPT=20 },
    mat_pri = 1,
    outdoor = true,
    
    wall  = "SNDPLAIN",
    floor = "FLOOR27",
    ceil  = "FLOOR27",
    step  = "SPINE2",

--  void = "CTYSTUC4",

  },

  PHAROAHO =
  {
    theme_probs = { EGYPT=15 },
    mat_pri = 1,
    outdoor = true,
    
    wall  = "TRISTON2",
    floor = "FLAT521",
    ceil  = "FLAT503",
    step  = "SQPEB2",

--  void = "CTYSTUC4",

  },
  
  WATER =
  {
    theme_probs = { GARISH=20 },
    outdoor = true,
    mat_pri = 1,

    wall  = "WATRWAL1",
    floor = "FLTWAWA1",
    ceil  = "FLTWAWA1",

--  void = "CTYSTCI4",

    liquid_prob = 0,
  },

  PURPLEO =
  {
    theme_probs = { GARISH=20 },
    outdoor = true,
    mat_pri = 1,

    wall  = "REDWALL",
    floor = "FLOOR07",
    ceil  = "FLOOR07",

--  void = "CTYSTCI4",

  },

  GREENO =
  {
    theme_probs = { UNUSED=20 },
    outdoor = true,
    mat_pri = 1,

    wall  = "GRNBLOK1",
    floor = "FLOOR18",
    ceil  = "FLOOR18",

--  void = "CTYSTCI4",

  },

  STONY =
  {
    theme_probs = { CITY=20 },
    outdoor = true,
    mat_pri = 3,

    wall  = "GRSTNPB",
    floor = "FLOOR00",
    ceil  = "FLOOR00",

--  void = "GRSTNPBV",
    scenery = "serpent_torch",
  },

  MUDDY =
  {
    theme_probs = { CITY=20, DOME=20 },
    outdoor = true,
    mat_pri = 3,

    wall  = "CSTLRCK",
    floor = "FLOOR17",
    ceil  = "FLOOR17",

--  void = "SQPEB1",
    pillar = "SPINE1",

    scenery = "fire_brazier",

  },
  
  SANDZ =
  {
    theme_probs = { EGYPT=20 },
    outdoor = true,
    mat_pri = 1,

    wall  = "SNDBLCKS",
    floor = "FLOOR27",
    ceil  = "FLOOR27",

--  void = "CTYSTCI4",

    liquid_prob = 0,
  },

  SANDY =
  {
    theme_probs = { CITY=20, DOME=20 },
    outdoor = true,
    mat_pri = 2,
    
    wall  = "CTYSTUC2",
    floor = "FLOOR27",
    ceil  = "FLOOR27",

--  void = "CTYSTUC3",
    pillar = "SPINE2",

    scenery = "small_pillar",
  },
  
}

HC_EXITS =
{
  METAL =
  {
    mat_pri = 9,

    wall  = "METL2",
    floor = "FLOOR03",
    ceil  = "FLOOR19",

    switch =
    {
      prefab="SWITCH_NICHE_TINY_DEEP",
      add_mode="wall",
      skin =
      {
        switch_w="SW2OFF", wall="METL2",
--      switch_f="FLOOR28",

        switch_h=32, x_offset=16, y_offset=48,
        kind=11, tag=0,
      }
    },
  },
  BLOODY = -- name hardcoded in planner.lua for secret exit
  {
    secret_exit = true,
    mat_pri = 9,

    wall  = "METL2",
    floor = "FLOOR03",
    ceil  = "FLOOR19",

    switch =
    {
      prefab="SWITCH_NICHE_TINY_DEEP",
      add_mode="wall",
      skin =
      {
        switch_w="SW1OFF", wall="METL2",
--      switch_f="FLOOR28",

        switch_h=32, x_offset=16, y_offset=48,
        kind=51, tag=0,
      }
    },
  },
}

HC_HALLWAYS =
{
 
  -- Hall with set stone walls 
  RCKHALL = {
        mat_pri = 0,
	theme_probs = { CITY=20, DOME=20 },
    	wall = "GRSTNPB",
	void = "GRSTNPB",
    	step  = "GRSTNPB",
	pillar = "WOODWL",
	
    floor = "FLOOR03",
    ceil  = "FLOOR03",
	trim_mode = "guillotine",	
	
  },

  -- Hall with natural stone walls
  STHALL = {
        mat_pri = 0,
	theme_probs = { CITY=20, CAVE=20 },
    	wall = "LOOSERCK",
	void = "LOOSERCK",
    	step  = "GRSTNPB",
	pillar = "GRSTNPB",
	
    floor = "FLOOR00",
    ceil  = "FLOOR00",
	trim_mode = "guillotine",	
	
  },

  -- Hall with roots on the walls
  RTHALL = {
        mat_pri = 0,
	theme_probs = { CAVE=20 },
    	wall = "ROOTWALL",
	void = "ROOTWALL",
    	step  = "ROOTWALL",
	pillar = "ROOTWALL",
	
    floor = "FLAT506",
    ceil  = "FLAT506",
	trim_mode = "guillotine",	
	
  },

  -- Hall with sandy walls
  SDHALL = {
        mat_pri = 0,
	theme_probs = { EGYPT=20 },
    	wall = "SNDPLAIN",
	void = "SNDPLAIN",
    	step  = "SPINE2",
	pillar = "SPINE2",
	
    floor = "FLOOR27",
    ceil  = "FLOOR10",
	trim_mode = "guillotine",	
	
  },

  -- Hall with wooden walls
  WDHALL = {
        mat_pri = 0,
	theme_probs = { CITY=20, EGYPT=20 },
    	wall = "SQPEB2",
	void = "SQPEB2",
    	step  = "SQPEB2",
	pillar = "SQPEB2",
	
    floor = "FLOOR06",
    ceil  = "FLOOR06",
	trim_mode = "guillotine",	
	
  },

  -- Garish blue watery hall
  WHALL = {
        mat_pri = 0,
	theme_probs = { GARISH=20, DOME=20 },
    	wall = "MOSAIC1",
	void = "MOSAIC1",
    	step  = "WATRWAL1",
	pillar = "WATRWAL1",
	
    floor = "FLTWAWA1",
    ceil  = "FLAT502",
	trim_mode = "guillotine",	
	
  }
}


---- BASE MATERIALS ------------

HC_MATS =
{
  METAL =
  {
    mat_pri = 5,

    wall  = "METL2",
    void  = "METL1",
    floor = "FLOOR28",
    ceil  = "FLOOR28",
  },

  STEP =
  {
    wall  = "SNDPLAIN",
    floor = "FLOOR27",
  },

  LIFT =
  {
    wall = "DOORSTON",
    floor = "FLOOR08"
  },

  TRACK =
  {
    wall  = "METL2",
    floor = "FLOOR28",
  },

  DOOR_FRAME =
  {
    wall  = nil,  -- this means: use plain wall
    floor = "FLOOR04",
    ceil  = "FLOOR04",
  },
}

--- PEDESTALS --------------

HC_PEDESTALS =
{
  PLAYER =
  {
    wall  = "CTYSTCI4", void = "CTYSTCI4",
    floor = "FLOOR11",   ceil = "FLOOR11",
    h = 8,
  },

  QUEST = -- FIXME
  {
    wall  = "CTYSTCI4", void = "CTYSTCI4",
    floor = "FLOOR11",   ceil = "FLOOR11",
    h = 8,
  },

  WEAPON = -- FIXME
  {
    wall  = "CTYSTCI4", void = "CTYSTCI4",
    floor = "FLOOR11",  ceil = "FLOOR11",
    h = 8,
  },
}

---- OVERHANGS ------------

HC_OVERHANGS =
{
  WOOD =
  {
    ceil = "FLOOR10",
    upper = "CTYSTUC3",
    thin = "WOODWL",
  },
}

---- MISC STUFF ------------

HC_LIQUIDS =
{
  water  = { floor="FLTFLWW1", wall="WATRWAL1" },
  lava   = { floor="FLATHUH1", wall="LAVAFL1", sec_kind=16 },
  magma  = { floor="FLTLAVA1", wall="LAVA1",   sec_kind=5 },
  sludge = { floor="FLTSLUD1", wall="LAVA1",   sec_kind=7 },
}

HC_SWITCHES =
{
  sw_demon =
  {
    switch =
    {
      prefab = "SWITCH_NICHE_TINY",
      add_mode = "island",
      skin =
      {
        wall="GRSKULL1",
        switch_w="SW1OFF", switch_h=32,
        x_offset=16, y_offset=48, kind=103,
      }
    },

    door =
    {
      w=128, h=128,
      prefab = "DOOR",
      skin =
      {
        door_w="DMNMSK", door_c="FLOOR10",
        track_w="METL2",
        door_h=128,
        door_kind=0, tag=0,
      }
    },
  },

  sw_celtic =
  {
    switch =
    {
      prefab="SWITCH_NICHE_TINY",
      add_mode = "island",
      skin =
      {
        wall="CELTIC",
        switch_w="SW1OFF", switch_h=32,
        x_offset=16, y_offset=48, kind=103,
      }
    },

    door =
    {
      w=128, h=128,
      prefab = "DOOR",
      skin =
      {
        door_w="CELTIC", door_c="FLAT522",
        track_w="METL2",
        door_h=128,
        door_kind=0, tag=0,
      }
    },
  },

  sw_green =
  {
    switch =
    {
      prefab = "SWITCH_NICHE_TINY",
      add_mode = "island",
      skin =
      {
        wall="GRNBLOK1",
        switch_w="SW1OFF", switch_h=32,
        x_offset=16, y_offset=48, kind=103,
      }
    },

    door =
    {
      w=128, h=128,
      prefab = "DOOR",
      skin =
      {
        door_w="GRNBLOK4", door_c="FLOOR18",
        track_w="METL2",
        door_h=128,
        door_kind=0, tag=0,
      }
    },
  },
}

HC_DOORS =
{
  d_demon = { prefab="DOOR", w=128, h=128,

               skin =
               {
                 door_w="DMNMSK", door_c="FLOOR10",
                 track_w="METL2",
                 door_h=128,

---              lite_w="LITE5", step_w="STEP1",
---              frame_f="FLAT1", frame_c="TLITE6_6",
               }
             },
  
 d_wood   = { wall="DOORWOOD", w=64,  h=128, ceil="FLOOR10" },
  
--  d_stone  = { wall="DOORSTON", w=64,  h=128 },
}

HC_KEY_DOORS =
{
  k_blue =
  {
    w=128, h=128,

    prefab = "DOOR", -- DOOR_LOCKED

    skin =
    {
      door_w="DOORSTON", door_c="FLOOR28",
      track_w="METL2",
      frame_f="FLOOR04",
      door_h=128, 
      door_kind=32, tag=0,  -- kind_rep=26
    },

    thing = "blue_statue",
  },

  k_green =
  {
    w=128, h=128,

    prefab = "DOOR", -- DOOR_LOCKED

    skin =
    {
      door_w="DOORSTON", door_c="FLOOR28",
      track_w="METL2",
      frame_f="FLOOR04",
      door_h=128, 
      door_kind=33, tag=0, -- kind_rep=28,
    },

    thing = "green_statue",
  },

  k_yellow =
  {
    w=128, h=128,

    prefab = "DOOR", -- DOOR_LOCKED

    skin =
    {
      door_w="DOORSTON", door_c="FLOOR28",
      track_w="METL2",
      frame_f="FLOOR04",
      door_h=128, 
      door_kind=34, tag=0, -- kind_rep=27,
    },

    thing = "yellow_statue",
  },
}

HC_LIFTS =
{
  slow = { kind=62,  walk=88 },
}

HC_DOOR_PREFABS =
{
  d_wood =
  {
    w=128, h=128, prefab="DOOR",

    skin =
    {
      door_w="DOORWOOD", door_c="FLOOR10",
      track_w="METL2",
      frame_f="FLOOR04",
      door_h=128,
      door_kind=1, tag=0,
    },

  theme_probs = { CITY=20 },
  },
}

HC_WALL_PREFABS =
{
  wall_pic_GLASS1 =
  {
    prefab = "WALL_PIC_SHALLOW",
    min_height = 160,
    skin = { pic_w="STNGLS1", pic_h=128 },
  },

  wall_pic_GLASS2 =
  {
    prefab = "WALL_PIC_SHALLOW",
    min_height = 160,
    skin = { pic_w="STNGLS2", pic_h=128 },
  },
}

HC_MISC_PREFABS =
{
  pedestal_PLAYER =
  {
    prefab = "PEDESTAL",
    skin = { wall="TMBSTON2", floor="FLOOR26", ped_h=8 },
  },

  pedestal_ITEM =
  {
    prefab = "PEDESTAL",
    skin = { wall="SAINT1", floor="FLAT500", ped_h=12 },
  },

  image_1 =
  {
    prefab = "CRATE",
    add_mode = "island",
    skin = { crate_h=64, crate_w="CHAINSD", crate_f="FLOOR27" },
  },

  image_2 =
  {
    prefab = "WALL_PIC_SHALLOW",
    add_mode = "wall",
    min_height = 144,
    skin = { pic_w="GRSKULL2", pic_h=128 },
  },

  exit_DOOR =
  {
    w=64, h=96, prefab = "DOOR_NARROW",

    skin =
    {
      door_w="DOOREXIT",
      door_h=96,
      door_kind=1, tag=0,
    },
  },

  secret_DOOR =
  {
    w=128, h=128, prefab = "DOOR",

    skin =
    {
      track_w="METL2",
      door_h=128, door_kind=31, tag=0
    },
  },
}

HC_DEATHMATCH_EXITS =
{
  exit_dm_METAL =
  {
    prefab = "EXIT_DEATHMATCH",

    skin = { wall="METL2", front_w="METL2",
             floor="FLAT502", ceil="FLAT502",
             switch_w="SW2OFF", side_w="METL2", switch_f="FLOOR03",
             frame_f="FLAT504", frame_c="FLAT504", -- step_w="STEP1",
             door_w="DOOREXIT", door_c="FLOOR08", -- track_w="DOORTRAK",

             inside_h=128, door_h=96,
             switch_yo=32,
             door_kind=1, tag=0, switch_kind=11
           },
  },
}

HC_RAILS =
{
  r_1 = { wall="WDGAT64", w=128, h=64  },
  r_2 = { wall="WDGAT64", w=128, h=128 },  -- FIXME!!
}

HC_IMAGES =
{
  { wall = "GRSKULL2", w=128, h=128, glow=true },
  { wall = "GRSKULL1", w=64,  h=64,  floor="FLOOR27" }
}

HC_LIGHTS =
{
  round = { floor="FLOOR26",  side="ORNGRAY" },
}

HC_WALL_LIGHTS =
{
  redwall = { wall="REDWALL", w=32 },
}

HC_PICS =
{
  skull3 = { wall="GRSKULL3", w=128, h=128 },
  glass1 = { wall="STNGLS1",  w=128, h=128 },
}

---- QUEST STUFF ----------------

HC_QUESTS =
{
  key =
  {
    k_blue=30, k_green=45, k_yellow=60
  },

  switch =
  {
    sw_demon=60, sw_green=45, sw_celtic=30,
  },

  weapon =
  {
    claw=60, hellstaff=40,
    phoenix=40, firemace=20
  },

  item =
  {
    shadow=60, bag=50, wings=40, ovum=30,
    bomb=25, tome=20, chaos=15,
  },
}

HC_ROOMS =
{
  PLAIN =
  {
  },

  HALLWAY =
  {
    room_heights = { [96]=50, [128]=50 },
    door_probs   = { out_diff=75, combo_diff=50, normal=5 },
    window_probs = { out_diff=1, combo_diff=1, normal=1 },
    space_range  = { 20, 65 },
  },
 
  SCENIC =
  {
  },

  -- TODO: check in-game level names for ideas
}

HC_THEMES =
{
  --- City (E1 Castle) is both indoors and outdoors
  CITY =
  {
    room_probs=
    {
      PLAIN=50,
    },
    has_outdoors = true,
  },
  --- Cave (used in Hell) is both outdoors and indoors
  CAVE =
  {
    room_probs=
    {
      PLAIN=50,
    },
    has_outdoors = true,
  },
  --- Dome is a variation on City used in E3
  DOME =
  {
    room_probs=
    {
      PLAIN=50,
    },
    has_outdoors = true,
  },
  --- Egypt is a sandy-looking theme used in E4
  EGYPT =
  {
    room_probs=
    {
      PLAIN=50,
    },
    has_outdoors = true,
  },
  --- Garish is a surrealistic very garish theme of blue and some red;
  --- used in E5
  GARISH =
  {
    room_probs=
    {
      PLAIN=50,
    },
    has_outdoors = true,
  },

}

HC_QUEST_LEN_PROBS =
{
  ----------  2   3   4   5   6   7   8  9  10  -------

  key    = {  0, 25, 50, 90, 65, 30, 10, 2 },
  exit   = {  0, 25, 50, 90, 65, 30, 10, 2 },

  switch = {  0, 50, 90, 50, 25, 5, 1 },

  weapon = { 25, 90, 50, 10, 2 },
  item   = { 15, 70, 70, 15, 2 },
}


------------------------------------------------------------

HC_MONSTERS =
{
  gargoyle   = { prob=30, hp=20,  dm= 5, cage_fallback=10, float=true, melee=true },
  fire_garg  = { prob=10, hp=80,  dm= 8, float=true },
  mummy      = { prob=60, hp=80,  dm= 8, melee=true },
  mummy_inv  = { prob=10, hp=80,  dm= 8, melee=true, invis=true },
  sabreclaw  = { prob=25, hp=150, dm=12, melee=true },

  knight     = { prob=70, hp=200, dm=12, },
  knight_inv = { prob=10, hp=200, dm=14, invis=true },
  leader     = { prob=70, hp=100, dm=16, },
  leader_inv = { prob=10, hp=100, dm=16, invis=true },

  disciple   = { prob=25, hp=180, dm=20, float=true },
  weredragon = { prob=30, hp=220, dm=25, },
  ophidian   = { prob=30, hp=280, dm=25, },

  -- FIXME: not really a monster [MOVE OUTTA HERE]
  pod = { prob=5, hp=45, dm=2, melee=true, passive=true },
}

HC_BOSSES =
{
  -- dm values are crap
  Ironlich    = { prob= 4, hp=700,  dm=99, float=true },
  Maulotaur   = { prob= 1, hp=3000, dm=99, },
  D_Sparil    = { prob= 1, hp=2000, dm=99, },
}

HC_WEAPONS =
{
  staff      = { rate=2.5, dm=12, pref= 1, melee=true, held=true },
  gauntlets  = { rate=5.2, dm= 8, pref= 7, melee=true, },

  wand       = { rate=3.1, dm=10, pref=15, ammo="crystal",   per=1, held=true },
  crossbow   = { rate=1.3, dm=20, pref=90, ammo="arrow",     per=1, give=4, splash={0,5} },
  claw       = { rate=2.9, dm=16, pref=60, ammo="claw_orb",  per=1, give=4, },

  hellstaff  = { rate=8.7, dm=12, pref=50, ammo="runes",     per=1, give=4, },
  phoenix    = { rate=1.7, dm=80, pref=50, ammo="flame_orb", per=1, give=4, },
  firemace   = { rate=8.7, dm= 8, pref=35, ammo="mace_orb",  per=1, give=4, },

  -- Notes:
  --
  -- No information here about weapons when the Tome-Of-Power is
  -- being used (such as different firing rates and ammo usage).
  -- Since that artifact can be used at any time by the player,
  -- OBLIGE cannot properly model it.
}

HC_PICKUPS =
{
  -- FIXME: the ammo 'give' numbers are CRAP!
  crystal = { stat="crystal", give=5,  },
  geode   = { stat="crystal", give=20, },
  arrows  = { stat="arrow",   give=5,  },
  quiver  = { stat="arrow",   give=20, },

  claw_orb1 = { stat="claw_orb", give=5,  },
  claw_orb2 = { stat="claw_orb", give=20, },
  runes1    = { stat="runes",    give=5,  },
  runes2    = { stat="runes",    give=20, },

  flame_orb1 = { stat="flame_orb", give=5,  },
  flame_orb2 = { stat="flame_orb", give=20, },
  mace_orbs  = { stat="mace_orb",  give=5,  },
  mace_pile  = { stat="mace_orb",  give=20, },

  h_vial  = { stat="health", give=10,  prob=70 },
  h_flask = { stat="health", give=25,  prob=25 },
  h_urn   = { stat="health", give=100, prob=5, clu_max=1 },

  shield1 = { stat="armor", give=100, prob=70 },
  shield2 = { stat="armor", give=200, prob=10 },
}

HC_NICENESS =
{
  w1 = { weapon="crossbow",  quest=1, prob=70, always=true  },

  w3 = { weapon="gauntlets", quest=1, prob=33, always=false },
  w4 = { weapon="gauntlets", quest=3, prob=50, always=false },

  a1 = { pickup="shield1", prob=2.0 },
  a2 = { pickup="shield2", prob=0.7 },

  p1 = { pickup="torch",   prob=2.0 },
}

HC_DEATHMATCH =
{
  weapons =
  {
    gauntlets=10, crossbow=60,
    claw=30, hellstaff=30, phoenix=30
  },

  health =
  { 
    h_vial=70, h_flask=25, h_urn=5
  },

  ammo =
  { 
    crystal=10, geode=20,
    arrows=20, quiver=60,
    claw_orb1=10, claw_orb2=40,
    runes1=10, runes2=30,
    flame_orb1=10, flame_orb2=30,
  },

  items =
  {
    shield1=70, shield2=10,
    bag=10, torch=10,
    wings=50, ovum=50,
    bomb=30, chaos=30,
    shadow=50, tome=30,
  },

  cluster = {}
}

HC_INITIAL_MODEL =
{
  cleric =
  {
    health=100, armor=0,
    crystal=30, arrow=0, runes=0,
    claw_orb=0, flame_orb=0, mace_orb=0,
    staff=true, wand=true,
  }
}


------------------------------------------------------------

HC_EPISODE_THEMES =
{
  { CITY=5 },
  { CAVE=5 },
  { DOME=5 },

  { EGYPT=5 },
  { GARISH=5 },
  { CITY=5, EGYPT=5 },
}

HC_SECRET_EXITS =
{
  E1M6 = true,
  E2M4 = true,
  E3M4 = true,

  E4M4 = true,
  E5M3 = true,
}

HC_EPISODE_BOSSES =
{
  "Ironlich",
  "Maulotaur",
  "D_sparil",
  "Ironlich",
  "Maulotaur",
  "Maulotaur",
}

HC_SKY_INFO =
{
  { color="gray",  light=176 },
  { color="red",   light=192 },
  { color="blue",  light=176 },

  { color="gray",  light=176 },
  { color="blue",  light=176 },
  { color="gray",  light=176 },
}


------------------------------------------------------------

function Heretic1_get_levels()
  local list = {}

  local EP_NUM  = sel(OB_CONFIG.length == "full", 5, 1)
  local MAP_NUM = sel(OB_CONFIG.length == "single", 1, 9)

  if OB_CONFIG.length == "few" then MAP_NUM = 4 end

  for episode = 1,EP_NUM do
    local theme_probs = HC_EPISODE_THEMES[episode]

    -- If we only make a single map or episode, use the castle or hell theme
    if OB_CONFIG.length ~= "full" then
      theme_probs = HC_EPISODE_THEMES[rand_irange(1,4)]
    end

    for map = 1,MAP_NUM do
      local LEV =
      {
        name = string.format("E%dM%d", episode, map),

        ep_along = map / MAP_NUM,

        theme_probs = theme_probs,
        sky_info = HC_SKY_INFO[episode],

        boss_kind   = (map == 8) and HC_EPISODE_BOSSES[episode],
        secret_kind = (map == 9) and "plain",

        toughness_factor = sel(map==9, 1.2, 1 + (map-1) / 7),
      }

      if HC_SECRET_EXITS[LEV.name] then
        LEV.secret_exit = true
      end

      table.insert(list, LEV)
    end -- for map

  end -- for episode

  return list
end


function Heretic1_setup()

  GAME.classes  = { "cleric" },

  Game_merge_tab("things",   HC_THINGS)
  Game_merge_tab("monsters", HC_MONSTERS)
  Game_merge_tab("bosses",   HC_BOSSES)

  Game_merge_tab("weapons",  HC_WEAPONS)
  Game_merge_tab("pickups",  HC_PICKUPS)
  Game_merge_tab("niceness", HC_NICENESS)

  GAME.pickup_stats = { "health", "crystal", "arrow", "claw_orb",
                        "runes", "flame_orb", "mace_orb" },

  Game_merge_tab("initial_model", HC_INITIAL_MODEL)

  Game_merge_tab("quests", HC_QUESTS)

  Game_merge_tab("dm", HC_DEATHMATCH)
  Game_merge_tab("dm_exits", HC_DEATHMATCH_EXITS)

  Game_merge_tab("combos", HC_COMBOS)
  Game_merge_tab("exits", HC_EXITS)
  Game_merge_tab("hallways", HC_HALLWAYS)

  Game_merge_tab("rooms",  HC_ROOMS)
  Game_merge_tab("themes", HC_THEMES)

  Game_merge_tab("hangs", HC_OVERHANGS)
  Game_merge_tab("pedestals", HC_PEDESTALS)
  Game_merge_tab("mats",  HC_MATS)
  Game_merge_tab("rails", HC_RAILS)

  Game_merge_tab("liquids", HC_LIQUIDS)
  Game_merge_tab("switches", HC_SWITCHES)
  Game_merge_tab("doors", HC_DOORS)
  Game_merge_tab("key_doors", HC_KEY_DOORS)
  Game_merge_tab("lifts", HC_LIFTS)

  Game_merge_tab("pics", HC_PICS)
  Game_merge_tab("images", HC_IMAGES)
  Game_merge_tab("lights", HC_LIGHTS)
  Game_merge_tab("wall_lights", HC_WALL_LIGHTS)

  Game_merge_tab("door_fabs", HC_DOOR_PREFABS)
  Game_merge_tab("wall_fabs", HC_WALL_PREFABS)
  Game_merge_tab("misc_fabs", HC_MISC_PREFABS)

  GAME.toughness_factor = 0.80  -- FIXME: PARAMS

  GAME.depot_info  = { teleport_kind=97 }

  GAME.room_heights = { [96]=5, [128]=25, [192]=70, [256]=70, [320]=12 }
  GAME.space_range  = { 20, 90 }
    
  GAME.diff_probs = { [0]=20, [16]=40, [32]=80, [64]=30, [96]=5 }
  GAME.bump_probs = { [0]=30, [16]=30, [32]=20, [64]=5 }
    
  GAME.door_probs   = { out_diff=75, combo_diff=50, normal=15 }
  GAME.hallway_probs = { 20, 30, 41, 53, 66 }
  GAME.window_probs = { out_diff=80, combo_diff=50, normal=30 }
end


------------------------------------------------------------

UNFINISHED["heretic"] =
{
  label = "Heretic",

  format = "doom",

  setup_func = Heretic1_setup,

  caps =
  {
    rails = true,
    switches = true,
    liquids = true,
    teleporters = true,
    infighting  =  true,
    prefer_stairs = true,
    noblaze_door = true,

    custom_flats = true,
  },

  params =
  {
    seed_size = 256,

    sky_tex    = "-",
    sky_flat   = "F_SKY1",
    error_tex  = "DRIPWALL",
    error_flat = "FLOOR09",

    max_level_desc = 28,

    palette_mons = 3,
  },

  hooks =
  {
    get_levels = Heretic1_get_levels,
  },
}


OB_THEMES["hc_city"] =
{
  ref = "CITY",
  label = "City",
  for_games = { heretic=1 },
}

OB_THEMES["hc_cave"] =
{
  ref = "CAVE",
  label = "Cave",
  for_games = { heretic=1 },
}

OB_THEMES["hc_dome"] =
{
  ref = "DOME",
  label = "Dome",
  for_games = { heretic=1 },
}

OB_THEMES["hc_egypt"] =
{
  ref = "EGYPT",
  label = "Egypt",
  for_games = { heretic=1 },
}

OB_THEMES["hc_garish"] =
{
  ref = "GARISH",
  label = "Garish",
  for_games = { heretic=1 },
}

