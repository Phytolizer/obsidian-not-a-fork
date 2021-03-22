//----------------------------------------------------------------------------
//
// File:        endoom.cpp
// Date:        05.12.2016
// Programmer:  Kim Roar Foldøy Hauge.
//
// Description: This module contains the logic for the ENDOOM generator.
//
// Copyright (c) 2016-2017 Kim Roar Foldøy Hauge. All Rights Reserved.
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307, USA.
//
// Revision History:
//
//----------------------------------------------------------------------------


#include <string.h>
#include "common.hpp"
#include "logger.hpp"
#include "wad.hpp"
#include "level.hpp"

// Artwork by Kim Roar 'Zokum' Foldøy Hauge. Drawn in PabloDraw.

unsigned char endoomzbsp_bin[4000] = {
  0x99, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x20, 0x00, 0x20, 0x00, 0x20, 0x00, 0x20, 0x00, 0x20, 0x00, 0x20, 0x00,
  0xdc, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdf, 0x08,
  0xdf, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdf, 0x08,
  0xdc, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0x20, 0x08,
  0x20, 0x08, 0xb0, 0x08, 0xb0, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08,
  0xb0, 0x08, 0xb0, 0x08, 0xb1, 0x08, 0xb1, 0x08, 0xb1, 0x08, 0xb0, 0x08,
  0xb1, 0x08, 0xb1, 0x08, 0xb1, 0x08, 0x20, 0x08, 0xb0, 0x08, 0x20, 0x08,
  0xfe, 0x08, 0xdc, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdf, 0x08,
  0xdf, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08,
  0xdc, 0x08, 0xdc, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdc, 0x08,
  0xdf, 0x08, 0xdf, 0x08, 0xdc, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdf, 0x08,
  0xdf, 0x08, 0xdc, 0x08, 0x20, 0x08, 0xfe, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x20, 0x08, 0xb2, 0x08, 0xde, 0x0b, 0xdb, 0x3b, 0xb2, 0x3b,
  0xdb, 0x3b, 0xdb, 0x3b, 0xdb, 0x0f, 0xdb, 0x0f, 0xdb, 0x3f, 0xdb, 0x3b,
  0xdf, 0x0b, 0xdf, 0x0b, 0x20, 0x0b, 0xdb, 0x3b, 0xdb, 0x0f, 0xdc, 0x0b,
  0x20, 0x0b, 0xdb, 0x08, 0x20, 0x08, 0x20, 0x08, 0xdc, 0x08, 0xdc, 0x08,
  0xdf, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08,
  0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0x20, 0x08, 0x20, 0x08, 0xfe, 0x08,
  0x20, 0x08, 0xdc, 0x08, 0xb1, 0x08, 0xb2, 0x08, 0xde, 0x0b, 0xdb, 0x3f,
  0xdb, 0x3f, 0xdb, 0x3f, 0xdb, 0x3b, 0xdb, 0x3b, 0xdb, 0x0f, 0xdc, 0x0f,
  0x20, 0x0f, 0x20, 0x0f, 0xdc, 0x0b, 0xdc, 0x0b, 0xdb, 0x0f, 0xdb, 0x0f,
  0xdb, 0x0f, 0xdc, 0x0b, 0xde, 0x0b, 0xdb, 0x3f, 0xdc, 0x0f, 0xdb, 0x0f,
  0xdb, 0x0b, 0xb2, 0x3b, 0xdb, 0x3b, 0xdc, 0x0f, 0xdf, 0x08, 0xdc, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0xb1, 0x08, 0x20, 0x08,
  0xdf, 0x0b, 0x20, 0x0b, 0x20, 0x0b, 0xdc, 0x0b, 0xdb, 0x3b, 0xdb, 0x0f,
  0xdf, 0x0b, 0x20, 0x0b, 0x20, 0x0b, 0xdf, 0x08, 0x20, 0x08, 0xde, 0x0b,
  0xdb, 0x0f, 0xdb, 0x0f, 0x20, 0x0f, 0xb2, 0x08, 0xdc, 0x08, 0xdf, 0x08,
  0x20, 0x08, 0xdc, 0x0f, 0xdf, 0x0b, 0x20, 0x0b, 0xdc, 0x0b, 0x20, 0x0b,
  0x20, 0x0b, 0xdc, 0x0f, 0x20, 0x0f, 0x20, 0x0f, 0xdc, 0x0f, 0xdf, 0x08,
  0xdc, 0x08, 0xdc, 0x08, 0xdf, 0x08, 0xdc, 0x0b, 0xdf, 0x08, 0xde, 0x08,
  0x20, 0x08, 0xdb, 0x3f, 0xdb, 0x3b, 0x20, 0x0b, 0xdc, 0x08, 0xdc, 0x08,
  0xdf, 0x0f, 0xdb, 0x3b, 0xdd, 0x0f, 0xdb, 0x0b, 0xdb, 0x0f, 0xdb, 0x0f,
  0xdf, 0x0b, 0xfe, 0x08, 0xdf, 0x0b, 0xdb, 0x3b, 0x20, 0x0b, 0xdb, 0x3f,
  0xdb, 0x3b, 0xdf, 0x0b, 0xdc, 0x08, 0x20, 0x08, 0xdf, 0x0f, 0xdb, 0x0f,
  0xdd, 0x0f, 0xb2, 0x08, 0x20, 0x08, 0x5a, 0x07, 0x6f, 0x07, 0x6b, 0x07,
  0x75, 0x07, 0x6d, 0x07, 0x42, 0x07, 0x53, 0x07, 0x50, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07,
  0xb2, 0x08, 0xdc, 0x08, 0xfe, 0x08, 0x20, 0x08, 0xdb, 0x3b, 0xb2, 0x3b,
  0xdb, 0x3b, 0x20, 0x0b, 0x20, 0x0b, 0xdc, 0x0b, 0xdb, 0x0b, 0xdb, 0x0f,
  0xdc, 0x0b, 0x20, 0x0b, 0xdb, 0x3b, 0xdb, 0x3b, 0x20, 0x0b, 0xb2, 0x08,
  0x20, 0x08, 0xdc, 0x0b, 0xdb, 0x0f, 0xdd, 0x0b, 0x20, 0x0b, 0xdb, 0x0f,
  0xdb, 0x3b, 0x20, 0x0b, 0xdb, 0x0b, 0xdd, 0x0b, 0x20, 0x0b, 0xdc, 0x0b,
  0xdb, 0x0f, 0xdc, 0x0b, 0x20, 0x0b, 0x20, 0x0b, 0xb2, 0x3b, 0xdb, 0x3b,
  0xdb, 0x0f, 0xde, 0x08, 0x20, 0x08, 0xdb, 0x3b, 0xdb, 0x3b, 0xdc, 0x03,
  0xdf, 0x08, 0x20, 0x08, 0xdc, 0x03, 0xdb, 0x3b, 0xdd, 0x0b, 0xde, 0x0b,
  0xdb, 0x3b, 0xb2, 0x3b, 0xdc, 0x0b, 0x20, 0x0b, 0xdf, 0x0b, 0x20, 0x0b,
  0x20, 0x0b, 0xdb, 0x3b, 0xdb, 0x3b, 0xdc, 0x03, 0xdf, 0x08, 0xdf, 0x08,
  0x20, 0x08, 0xdb, 0x3b, 0xdd, 0x0b, 0xb1, 0x08, 0x20, 0x08, 0x31, 0x08,
  0x2e, 0x08, 0x30, 0x08, 0x2e, 0x08, 0x39, 0x08, 0x72, 0x08, 0x63, 0x08,
  0x2d, 0x08, 0x31, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x20, 0x08, 0xde, 0x08, 0xdd, 0x08, 0x20, 0x08, 0xb1, 0x3b,
  0xb2, 0x3b, 0xdb, 0x3b, 0x20, 0x0b, 0x20, 0x0b, 0xdb, 0x03, 0xdf, 0x0b,
  0x20, 0x0b, 0xdf, 0x0b, 0xdb, 0x3b, 0xdd, 0x0b, 0xb2, 0x3b, 0xdb, 0x3b,
  0xdd, 0x03, 0xdc, 0x0b, 0xdb, 0x0b, 0xdb, 0x0b, 0xdf, 0x0b, 0x20, 0x0b,
  0x20, 0x0b, 0xdb, 0x3b, 0xdb, 0x3b, 0x20, 0x0b, 0xde, 0x0b, 0xdb, 0x3b,
  0x20, 0x0b, 0xb2, 0x3b, 0xdb, 0x3b, 0xdb, 0x3b, 0xdd, 0x0b, 0xb2, 0x3b,
  0xdb, 0x3b, 0xdf, 0x0b, 0xdb, 0x3b, 0xdd, 0x0b, 0x20, 0x0b, 0xb2, 0x3b,
  0xdb, 0x3b, 0xb2, 0x3b, 0xdb, 0x3b, 0xdb, 0x3b, 0xb2, 0x3b, 0xdc, 0x0b,
  0x20, 0x0b, 0xdc, 0x08, 0xdf, 0x0b, 0xb1, 0x3b, 0xb2, 0x3b, 0xb1, 0x3b,
  0xdc, 0x0b, 0xdf, 0x08, 0x20, 0x08, 0xb2, 0x3b, 0xdb, 0x3b, 0xb2, 0x3b,
  0xdb, 0x3b, 0xb1, 0x3b, 0xb2, 0x3b, 0xdf, 0x0b, 0x20, 0x0b, 0xb2, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0xb2, 0x08, 0x20, 0x08,
  0x20, 0x38, 0xb1, 0x73, 0xb1, 0x3b, 0x20, 0x0b, 0xfe, 0x08, 0xde, 0x03,
  0x20, 0x33, 0x20, 0x03, 0xfe, 0x08, 0x20, 0x08, 0x20, 0x38, 0xdd, 0x0b,
  0x20, 0x3b, 0xb1, 0x3b, 0xb0, 0x3b, 0xdb, 0x3b, 0xb1, 0x3b, 0xdd, 0x0b,
  0x20, 0x0b, 0xfe, 0x08, 0xde, 0x03, 0xb2, 0x3b, 0xdd, 0x0b, 0x20, 0x0b,
  0x20, 0x3b, 0xb1, 0x3b, 0x20, 0x0b, 0xb1, 0x3b, 0xdf, 0x0b, 0x20, 0x0b,
  0xb1, 0x3b, 0xdd, 0x0b, 0xfe, 0x08, 0x20, 0x08, 0xb0, 0x3b, 0xdb, 0x3b,
  0x20, 0x0b, 0xb1, 0x3b, 0xb2, 0x3b, 0x20, 0x0b, 0xdc, 0x08, 0xdc, 0x08,
  0xdf, 0x0b, 0xb1, 0x3b, 0xdd, 0x0b, 0xdd, 0x08, 0xdc, 0x03, 0x20, 0x03,
  0xdf, 0x0b, 0xb0, 0x3b, 0xb1, 0x3b, 0xdb, 0x03, 0x20, 0x03, 0xb1, 0x3b,
  0xb2, 0x3b, 0xdd, 0x03, 0x20, 0x03, 0xfe, 0x08, 0x20, 0x08, 0xdc, 0x08,
  0xdf, 0x08, 0x20, 0x08, 0x20, 0x08, 0x57, 0x07, 0x41, 0x07, 0x44, 0x07,
  0x20, 0x07, 0x64, 0x07, 0x61, 0x07, 0x74, 0x07, 0x61, 0x07, 0x20, 0x07,
  0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0x20, 0x07, 0xde, 0x08,
  0xdd, 0x08, 0x20, 0x38, 0xb1, 0x73, 0x20, 0x33, 0x20, 0x03, 0xdc, 0x03,
  0xdb, 0x03, 0xdc, 0x03, 0xdf, 0x03, 0x20, 0x33, 0xdc, 0x03, 0x20, 0x03,
  0xb0, 0x38, 0x20, 0x08, 0x20, 0x38, 0x20, 0x38, 0xdd, 0x03, 0x20, 0x03,
  0x20, 0x33, 0xb2, 0x3b, 0x20, 0x0b, 0x20, 0x0b, 0x20, 0x3b, 0x20, 0x3b,
  0x20, 0x0b, 0x20, 0x0b, 0xb0, 0x38, 0xb1, 0x38, 0x20, 0x08, 0x20, 0x38,
  0xdd, 0x03, 0x20, 0x03, 0x20, 0x33, 0xb1, 0x3b, 0x20, 0x0b, 0x20, 0x0b,
  0x20, 0x3b, 0x20, 0x3b, 0x20, 0x0b, 0x20, 0x3b, 0xb1, 0x73, 0xdc, 0x03,
  0xdf, 0x08, 0x20, 0x08, 0xdc, 0x03, 0xb0, 0x38, 0xdd, 0x03, 0xde, 0x03,
  0xb0, 0x38, 0xb0, 0x38, 0xdc, 0x03, 0xdc, 0x03, 0xb1, 0x38, 0xdb, 0x03,
  0xdd, 0x03, 0x20, 0x33, 0xb1, 0x73, 0xdd, 0x03, 0xfe, 0x08, 0xdf, 0x08,
  0xdf, 0x08, 0xb2, 0x08, 0xdf, 0x08, 0xfe, 0x08, 0x20, 0x08, 0x33, 0x08,
  0x36, 0x08, 0x20, 0x08, 0x6d, 0x08, 0x61, 0x08, 0x70, 0x08, 0x73, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x20, 0x08, 0xb2, 0x08, 0xde, 0x03, 0xb0, 0x38, 0xb0, 0x38, 0xb1, 0x38,
  0xb1, 0x38, 0xb1, 0x38, 0xb2, 0x38, 0xb1, 0x38, 0xdc, 0x03, 0xdf, 0x03,
  0xb2, 0x38, 0xb2, 0x38, 0xdd, 0x03, 0xde, 0x03, 0xb1, 0x38, 0xb1, 0x38,
  0xb2, 0x38, 0x20, 0x08, 0x20, 0x08, 0xb2, 0x38, 0xb2, 0x38, 0xde, 0x03,
  0xb2, 0x38, 0xb2, 0x38, 0xb1, 0x38, 0xb2, 0x38, 0xb2, 0x38, 0xdd, 0x03,
  0xde, 0x03, 0xb1, 0x38, 0xb1, 0x38, 0x20, 0x08, 0xb1, 0x38, 0xb1, 0x38,
  0xdd, 0x03, 0xde, 0x03, 0xb2, 0x38, 0xb2, 0x38, 0xde, 0x03, 0xb0, 0x38,
  0xb2, 0x38, 0xb2, 0x38, 0xb1, 0x38, 0xb2, 0x38, 0xdf, 0x03, 0xdf, 0x03,
  0xdc, 0x08, 0xdc, 0x08, 0xdf, 0x03, 0xb2, 0x38, 0xb1, 0x38, 0xb0, 0x38,
  0xdf, 0x03, 0x20, 0x03, 0xde, 0x03, 0xb0, 0x38, 0xb2, 0x38, 0xb1, 0x38,
  0xdc, 0x03, 0x20, 0x03, 0xfe, 0x08, 0xb1, 0x08, 0x20, 0x08, 0xb1, 0x08,
  0x20, 0x08, 0x31, 0x08, 0x38, 0x08, 0x39, 0x08, 0x39, 0x08, 0x31, 0x08,
  0x4b, 0x08, 0x62, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x20, 0x08, 0xb0, 0x08, 0xb2, 0x08, 0xdc, 0x08, 0xdc, 0x08,
  0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08,
  0xdc, 0x08, 0xdf, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdf, 0x08,
  0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdc, 0x08,
  0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08,
  0xdc, 0x08, 0xdf, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdf, 0x08,
  0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdf, 0x08, 0xdc, 0x08, 0xdc, 0x08,
  0xdf, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08,
  0xdf, 0x08, 0xdf, 0x08, 0x20, 0x08, 0x20, 0x08, 0xdf, 0x08, 0xdc, 0x08,
  0xdc, 0x08, 0xdc, 0x08, 0xdf, 0x08, 0xdf, 0x08, 0xdc, 0x08, 0xdc, 0x08,
  0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xdc, 0x08, 0xb2, 0x08, 0x20, 0x08,
  0xb1, 0x08, 0xb0, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x4d, 0x0f, 0x61, 0x0f, 0x70, 0x0f, 0x20, 0x0f, 0x20, 0x0f,
  0x4c, 0x0b, 0x69, 0x0b, 0x6e, 0x0b, 0x65, 0x0b, 0x73, 0x0b, 0x20, 0x0b,
  0x53, 0x07, 0x65, 0x07, 0x63, 0x07, 0x74, 0x07, 0x20, 0x07, 0x42, 0x0b,
  0x6c, 0x0b, 0x6f, 0x0b, 0x63, 0x0b, 0x6b, 0x0b, 0x6d, 0x0b, 0x61, 0x0b,
  0x70, 0x0b, 0x20, 0x0b, 0xfe, 0x0f, 0x20, 0x0f, 0x4d, 0x0f, 0x61, 0x0f,
  0x70, 0x0f, 0x20, 0x0f, 0x20, 0x0f, 0x4c, 0x0b, 0x69, 0x0b, 0x6e, 0x0b,
  0x65, 0x0b, 0x73, 0x0b, 0x20, 0x0b, 0x53, 0x07, 0x65, 0x07, 0x63, 0x07,
  0x74, 0x07, 0x20, 0x07, 0x42, 0x0b, 0x6c, 0x0b, 0x6f, 0x0b, 0x63, 0x0b,
  0x6b, 0x0b, 0x6d, 0x0b, 0x61, 0x0b, 0x70, 0x0b, 0x20, 0x0b, 0xfe, 0x0f,
  0x20, 0x0f, 0x4d, 0x07, 0x61, 0x07, 0x70, 0x07, 0x20, 0x07, 0x20, 0x07,
  0x4c, 0x0b, 0x69, 0x0b, 0x6e, 0x0b, 0x65, 0x0b, 0x73, 0x0b, 0x20, 0x0b,
  0x53, 0x07, 0x65, 0x07, 0x63, 0x07, 0x74, 0x07, 0x20, 0x07, 0x42, 0x0b,
  0x6c, 0x0b, 0x6f, 0x0b, 0x63, 0x0b, 0x6b, 0x0b, 0x6d, 0x0b, 0x61, 0x0b,
  0x70, 0x0b, 0x20, 0x0b, 0x20, 0x0b, 0x65, 0x0f, 0x31, 0x0f, 0x6d, 0x0f,
  0x31, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x35, 0x03, 0x35, 0x03, 0x33, 0x03,
  0x36, 0x03, 0x20, 0x03, 0x20, 0x03, 0x33, 0x08, 0x34, 0x08, 0x35, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x36, 0x03, 0x35, 0x03, 0x2e, 0x03, 0x34, 0x03,
  0x35, 0x03, 0x36, 0x03, 0x4b, 0x03, 0x20, 0x03, 0xb3, 0x0f, 0x20, 0x0f,
  0x65, 0x0f, 0x32, 0x0f, 0x6d, 0x0f, 0x34, 0x0f, 0x20, 0x0f, 0x36, 0x03,
  0x35, 0x03, 0x35, 0x03, 0x33, 0x03, 0x36, 0x03, 0x20, 0x03, 0x20, 0x03,
  0x33, 0x08, 0x34, 0x08, 0x35, 0x08, 0x20, 0x08, 0x20, 0x08, 0x36, 0x03,
  0x35, 0x03, 0x2e, 0x03, 0x34, 0x03, 0x35, 0x03, 0x36, 0x03, 0x4b, 0x03,
  0x20, 0x03, 0xb3, 0x0f, 0x20, 0x0f, 0x65, 0x0f, 0x33, 0x0f, 0x6d, 0x0f,
  0x37, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x35, 0x03, 0x35, 0x03, 0x33, 0x03,
  0x36, 0x03, 0x20, 0x03, 0x20, 0x03, 0x33, 0x08, 0x34, 0x08, 0x35, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x36, 0x03, 0x35, 0x03, 0x2e, 0x03, 0x34, 0x03,
  0x35, 0x03, 0x36, 0x03, 0x4b, 0x03, 0x20, 0x03, 0x20, 0x03, 0x65, 0x0f,
  0x31, 0x0f, 0x6d, 0x0f, 0x32, 0x0f, 0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03,
  0x37, 0x03, 0x38, 0x03, 0x31, 0x03, 0x20, 0x03, 0x20, 0x03, 0x34, 0x08,
  0x39, 0x08, 0x30, 0x08, 0x20, 0x08, 0x20, 0x08, 0x34, 0x03, 0x35, 0x03,
  0x2e, 0x03, 0x38, 0x03, 0x31, 0x03, 0x31, 0x03, 0x4b, 0x03, 0x20, 0x03,
  0xb3, 0x0f, 0x20, 0x0f, 0x65, 0x0f, 0x32, 0x0f, 0x6d, 0x0f, 0x35, 0x0f,
  0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x37, 0x03, 0x38, 0x03, 0x31, 0x03,
  0x20, 0x03, 0x20, 0x03, 0x34, 0x08, 0x39, 0x08, 0x30, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x34, 0x03, 0x35, 0x03, 0x2e, 0x03, 0x38, 0x03, 0x31, 0x03,
  0x31, 0x03, 0x4b, 0x03, 0x20, 0x03, 0xb3, 0x0f, 0x20, 0x0f, 0x65, 0x0f,
  0x33, 0x0f, 0x6d, 0x0f, 0x38, 0x0f, 0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03,
  0x37, 0x03, 0x38, 0x03, 0x31, 0x03, 0x20, 0x03, 0x20, 0x03, 0x34, 0x08,
  0x39, 0x08, 0x30, 0x08, 0x20, 0x08, 0x20, 0x08, 0x34, 0x03, 0x35, 0x03,
  0x2e, 0x03, 0x38, 0x03, 0x31, 0x03, 0x31, 0x03, 0x4b, 0x03, 0x20, 0x03,
  0x20, 0x03, 0x65, 0x0f, 0x31, 0x0f, 0x6d, 0x0f, 0x33, 0x0f, 0x20, 0x0f,
  0x20, 0x0f, 0x36, 0x03, 0x37, 0x03, 0x38, 0x03, 0x38, 0x03, 0x20, 0x03,
  0x20, 0x03, 0x38, 0x08, 0x39, 0x08, 0x30, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x32, 0x03, 0x32, 0x03, 0x2e, 0x03, 0x37, 0x03, 0x38, 0x03, 0x31, 0x03,
  0x4b, 0x03, 0x20, 0x03, 0xb3, 0x07, 0x20, 0x07, 0x65, 0x0f, 0x32, 0x0f,
  0x6d, 0x0f, 0x36, 0x0f, 0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x37, 0x03,
  0x38, 0x03, 0x38, 0x03, 0x20, 0x03, 0x20, 0x03, 0x38, 0x08, 0x39, 0x08,
  0x30, 0x08, 0x20, 0x08, 0x20, 0x08, 0x32, 0x03, 0x32, 0x03, 0x2e, 0x03,
  0x37, 0x03, 0x38, 0x03, 0x31, 0x03, 0x4b, 0x03, 0x20, 0x03, 0xb3, 0x07,
  0x20, 0x07, 0x65, 0x0f, 0x33, 0x0f, 0x6d, 0x0f, 0x39, 0x0f, 0x20, 0x0f,
  0x20, 0x0f, 0x36, 0x03, 0x37, 0x03, 0x38, 0x03, 0x38, 0x03, 0x20, 0x03,
  0x20, 0x03, 0x38, 0x08, 0x39, 0x08, 0x30, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x32, 0x03, 0x32, 0x03, 0x2e, 0x03, 0x37, 0x03, 0x38, 0x03, 0x31, 0x03,
  0x4b, 0x03, 0x20, 0x03, 0x20, 0x03, 0x65, 0x0f, 0x31, 0x0f, 0x6d, 0x0f,
  0x34, 0x0f, 0x20, 0x0f, 0x38, 0x03, 0x39, 0x03, 0x30, 0x03, 0x31, 0x03,
  0x31, 0x03, 0x20, 0x03, 0x31, 0x08, 0x32, 0x08, 0x30, 0x08, 0x31, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x32, 0x03, 0x38, 0x03, 0x2e, 0x03, 0x34, 0x03,
  0x38, 0x03, 0x36, 0x03, 0x4b, 0x03, 0x20, 0x03, 0xb3, 0x07, 0x20, 0x07,
  0x65, 0x0f, 0x32, 0x0f, 0x6d, 0x0f, 0x37, 0x0f, 0x20, 0x0f, 0x38, 0x03,
  0x39, 0x03, 0x30, 0x03, 0x31, 0x03, 0x31, 0x03, 0x20, 0x03, 0x31, 0x08,
  0x32, 0x08, 0x30, 0x08, 0x31, 0x08, 0x20, 0x08, 0x20, 0x08, 0x32, 0x03,
  0x38, 0x03, 0x2e, 0x03, 0x34, 0x03, 0x38, 0x03, 0x36, 0x03, 0x4b, 0x03,
  0x20, 0x03, 0xb3, 0x07, 0x20, 0x07, 0x65, 0x0f, 0x34, 0x0f, 0x6d, 0x0f,
  0x31, 0x0f, 0x20, 0x0f, 0x38, 0x03, 0x39, 0x03, 0x30, 0x03, 0x31, 0x03,
  0x31, 0x03, 0x20, 0x03, 0x31, 0x08, 0x32, 0x08, 0x30, 0x08, 0x31, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x32, 0x03, 0x38, 0x03, 0x2e, 0x03, 0x34, 0x03,
  0x38, 0x03, 0x36, 0x03, 0x4b, 0x03, 0x20, 0x03, 0x20, 0x03, 0x65, 0x0f,
  0x31, 0x0f, 0x6d, 0x0f, 0x35, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x35, 0x03,
  0x35, 0x03, 0x33, 0x03, 0x36, 0x03, 0x20, 0x03, 0x20, 0x03, 0x33, 0x08,
  0x34, 0x08, 0x35, 0x08, 0x20, 0x08, 0x20, 0x08, 0x36, 0x03, 0x35, 0x03,
  0x2e, 0x03, 0x34, 0x03, 0x35, 0x03, 0x36, 0x03, 0x4b, 0x03, 0x20, 0x03,
  0xb3, 0x08, 0x20, 0x08, 0x65, 0x0f, 0x32, 0x0f, 0x6d, 0x0f, 0x38, 0x0f,
  0x20, 0x0f, 0x36, 0x03, 0x35, 0x03, 0x35, 0x03, 0x33, 0x03, 0x36, 0x03,
  0x20, 0x03, 0x20, 0x03, 0x33, 0x08, 0x34, 0x08, 0x35, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x36, 0x03, 0x35, 0x03, 0x2e, 0x03, 0x34, 0x03, 0x35, 0x03,
  0x36, 0x03, 0x4b, 0x03, 0x20, 0x03, 0xb3, 0x08, 0x20, 0x08, 0x65, 0x0f,
  0x34, 0x0f, 0x6d, 0x0f, 0x32, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x35, 0x03,
  0x35, 0x03, 0x33, 0x03, 0x36, 0x03, 0x20, 0x03, 0x20, 0x03, 0x33, 0x08,
  0x34, 0x08, 0x35, 0x08, 0x20, 0x08, 0x20, 0x08, 0x36, 0x03, 0x35, 0x03,
  0x2e, 0x03, 0x34, 0x03, 0x35, 0x03, 0x36, 0x03, 0x4b, 0x03, 0x20, 0x03,
  0x20, 0x03, 0x65, 0x0f, 0x31, 0x0f, 0x6d, 0x0f, 0x36, 0x0f, 0x20, 0x0f,
  0x36, 0x03, 0x35, 0x03, 0x35, 0x03, 0x33, 0x03, 0x36, 0x03, 0x20, 0x03,
  0x20, 0x03, 0x33, 0x08, 0x34, 0x08, 0x35, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x36, 0x03, 0x35, 0x03, 0x2e, 0x03, 0x34, 0x03, 0x35, 0x03, 0x36, 0x03,
  0x4b, 0x03, 0x20, 0x03, 0xb3, 0x08, 0x20, 0x08, 0x65, 0x0f, 0x32, 0x0f,
  0x6d, 0x0f, 0x39, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x35, 0x03, 0x35, 0x03,
  0x33, 0x03, 0x36, 0x03, 0x20, 0x03, 0x20, 0x03, 0x33, 0x08, 0x34, 0x08,
  0x35, 0x08, 0x20, 0x08, 0x20, 0x08, 0x36, 0x03, 0x35, 0x03, 0x2e, 0x03,
  0x34, 0x03, 0x35, 0x03, 0x36, 0x03, 0x4b, 0x03, 0x20, 0x03, 0xb3, 0x08,
  0x20, 0x08, 0x65, 0x0f, 0x34, 0x0f, 0x6d, 0x0f, 0x33, 0x0f, 0x20, 0x0f,
  0x36, 0x03, 0x35, 0x03, 0x35, 0x03, 0x33, 0x03, 0x36, 0x03, 0x20, 0x03,
  0x20, 0x03, 0x33, 0x08, 0x34, 0x08, 0x35, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x36, 0x03, 0x35, 0x03, 0x2e, 0x03, 0x34, 0x03, 0x35, 0x03, 0x36, 0x03,
  0x4b, 0x03, 0x20, 0x03, 0x20, 0x03, 0x65, 0x0f, 0x31, 0x0f, 0x6d, 0x0f,
  0x37, 0x0f, 0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x37, 0x03, 0x38, 0x03,
  0x31, 0x03, 0x20, 0x03, 0x20, 0x03, 0x34, 0x08, 0x39, 0x08, 0x30, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x34, 0x03, 0x35, 0x03, 0x2e, 0x03, 0x38, 0x03,
  0x31, 0x03, 0x31, 0x03, 0x4b, 0x03, 0x20, 0x03, 0xb3, 0x08, 0x20, 0x08,
  0x65, 0x0f, 0x33, 0x0f, 0x6d, 0x0f, 0x31, 0x0f, 0x20, 0x0f, 0x20, 0x0f,
  0x36, 0x03, 0x37, 0x03, 0x38, 0x03, 0x31, 0x03, 0x20, 0x03, 0x20, 0x03,
  0x34, 0x08, 0x39, 0x08, 0x30, 0x08, 0x20, 0x08, 0x20, 0x08, 0x34, 0x03,
  0x35, 0x03, 0x2e, 0x03, 0x38, 0x03, 0x31, 0x03, 0x31, 0x03, 0x4b, 0x03,
  0x20, 0x03, 0xb3, 0x08, 0x20, 0x08, 0x65, 0x0f, 0x34, 0x0f, 0x6d, 0x0f,
  0x34, 0x0f, 0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x37, 0x03, 0x38, 0x03,
  0x31, 0x03, 0x20, 0x03, 0x20, 0x03, 0x34, 0x08, 0x39, 0x08, 0x30, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x34, 0x03, 0x35, 0x03, 0x2e, 0x03, 0x38, 0x03,
  0x31, 0x03, 0x31, 0x03, 0x4b, 0x03, 0x20, 0x03, 0x20, 0x03, 0x65, 0x0f,
  0x31, 0x0f, 0x6d, 0x0f, 0x38, 0x0f, 0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03,
  0x37, 0x03, 0x38, 0x03, 0x38, 0x03, 0x20, 0x03, 0x20, 0x03, 0x38, 0x08,
  0x39, 0x08, 0x30, 0x08, 0x20, 0x08, 0x20, 0x08, 0x32, 0x03, 0x32, 0x03,
  0x2e, 0x03, 0x37, 0x03, 0x38, 0x03, 0x31, 0x03, 0x4b, 0x03, 0x20, 0x03,
  0xb3, 0x07, 0x20, 0x07, 0x65, 0x0f, 0x33, 0x0f, 0x6d, 0x0f, 0x32, 0x0f,
  0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x37, 0x03, 0x38, 0x03, 0x38, 0x03,
  0x20, 0x03, 0x20, 0x03, 0x38, 0x08, 0x39, 0x08, 0x30, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x32, 0x03, 0x32, 0x03, 0x2e, 0x03, 0x37, 0x03, 0x38, 0x03,
  0x31, 0x03, 0x4b, 0x03, 0x20, 0x03, 0xb3, 0x07, 0x20, 0x07, 0x65, 0x0f,
  0x34, 0x0f, 0x6d, 0x0f, 0x35, 0x0f, 0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03,
  0x37, 0x03, 0x38, 0x03, 0x38, 0x03, 0x20, 0x03, 0x20, 0x03, 0x38, 0x08,
  0x39, 0x08, 0x30, 0x08, 0x20, 0x08, 0x20, 0x08, 0x32, 0x03, 0x32, 0x03,
  0x2e, 0x03, 0x37, 0x03, 0x38, 0x03, 0x31, 0x03, 0x4b, 0x03, 0x20, 0x03,
  0x20, 0x03, 0x65, 0x0f, 0x31, 0x0f, 0x6d, 0x0f, 0x39, 0x0f, 0x20, 0x0f,
  0x38, 0x03, 0x39, 0x03, 0x30, 0x03, 0x31, 0x03, 0x31, 0x03, 0x20, 0x03,
  0x31, 0x08, 0x32, 0x08, 0x30, 0x08, 0x31, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x32, 0x03, 0x38, 0x03, 0x2e, 0x03, 0x34, 0x03, 0x38, 0x03, 0x36, 0x03,
  0x4b, 0x03, 0x20, 0x03, 0xb3, 0x07, 0x20, 0x07, 0x65, 0x0f, 0x33, 0x0f,
  0x6d, 0x0f, 0x33, 0x0f, 0x20, 0x0f, 0x38, 0x03, 0x39, 0x03, 0x30, 0x03,
  0x31, 0x03, 0x31, 0x03, 0x20, 0x03, 0x31, 0x08, 0x32, 0x08, 0x30, 0x08,
  0x31, 0x08, 0x20, 0x08, 0x20, 0x08, 0x32, 0x03, 0x38, 0x03, 0x2e, 0x03,
  0x34, 0x03, 0x38, 0x03, 0x36, 0x03, 0x4b, 0x03, 0x20, 0x03, 0xb3, 0x07,
  0x20, 0x07, 0x65, 0x0f, 0x34, 0x0f, 0x6d, 0x0f, 0x36, 0x0f, 0x20, 0x0f,
  0x38, 0x03, 0x39, 0x03, 0x30, 0x03, 0x31, 0x03, 0x31, 0x03, 0x20, 0x03,
  0x31, 0x08, 0x32, 0x08, 0x30, 0x08, 0x31, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x32, 0x03, 0x38, 0x03, 0x2e, 0x03, 0x34, 0x03, 0x38, 0x03, 0x36, 0x03,
  0x4b, 0x03, 0x20, 0x03, 0x20, 0x03, 0x65, 0x0f, 0x32, 0x0f, 0x6d, 0x0f,
  0x31, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x35, 0x03, 0x35, 0x03, 0x33, 0x03,
  0x36, 0x03, 0x20, 0x03, 0x20, 0x03, 0x33, 0x08, 0x34, 0x08, 0x35, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x36, 0x03, 0x35, 0x03, 0x2e, 0x03, 0x34, 0x03,
  0x35, 0x03, 0x36, 0x03, 0x4b, 0x03, 0x20, 0x03, 0xb3, 0x0f, 0x20, 0x0f,
  0x65, 0x0f, 0x33, 0x0f, 0x6d, 0x0f, 0x34, 0x0f, 0x20, 0x0f, 0x36, 0x03,
  0x35, 0x03, 0x35, 0x03, 0x33, 0x03, 0x36, 0x03, 0x20, 0x03, 0x20, 0x03,
  0x33, 0x08, 0x34, 0x08, 0x35, 0x08, 0x20, 0x08, 0x20, 0x08, 0x36, 0x03,
  0x35, 0x03, 0x2e, 0x03, 0x34, 0x03, 0x35, 0x03, 0x36, 0x03, 0x4b, 0x03,
  0x20, 0x03, 0xb3, 0x0f, 0x20, 0x0f, 0x65, 0x0f, 0x34, 0x0f, 0x6d, 0x0f,
  0x37, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x35, 0x03, 0x35, 0x03, 0x33, 0x03,
  0x36, 0x03, 0x20, 0x03, 0x20, 0x03, 0x33, 0x08, 0x34, 0x08, 0x35, 0x08,
  0x20, 0x08, 0x20, 0x08, 0x36, 0x03, 0x35, 0x03, 0x2e, 0x03, 0x34, 0x03,
  0x35, 0x03, 0x36, 0x03, 0x4b, 0x03, 0x20, 0x03, 0x20, 0x03, 0x65, 0x0f,
  0x32, 0x0f, 0x6d, 0x0f, 0x32, 0x0f, 0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03,
  0x37, 0x03, 0x38, 0x03, 0x31, 0x03, 0x20, 0x03, 0x20, 0x03, 0x34, 0x08,
  0x39, 0x08, 0x30, 0x08, 0x20, 0x08, 0x20, 0x08, 0x34, 0x03, 0x35, 0x03,
  0x2e, 0x03, 0x38, 0x03, 0x31, 0x03, 0x31, 0x03, 0x4b, 0x03, 0x20, 0x03,
  0xb3, 0x0f, 0x20, 0x0f, 0x65, 0x0f, 0x33, 0x0f, 0x6d, 0x0f, 0x35, 0x0f,
  0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x37, 0x03, 0x38, 0x03, 0x31, 0x03,
  0x20, 0x03, 0x20, 0x03, 0x34, 0x08, 0x39, 0x08, 0x30, 0x08, 0x20, 0x08,
  0x20, 0x08, 0x34, 0x03, 0x35, 0x03, 0x2e, 0x03, 0x38, 0x03, 0x31, 0x03,
  0x31, 0x03, 0x4b, 0x03, 0x20, 0x03, 0xb3, 0x0f, 0x20, 0x0f, 0x65, 0x0f,
  0x34, 0x0f, 0x6d, 0x0f, 0x38, 0x0f, 0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03,
  0x37, 0x03, 0x38, 0x03, 0x31, 0x03, 0x20, 0x03, 0x20, 0x03, 0x34, 0x08,
  0x39, 0x08, 0x30, 0x08, 0x20, 0x08, 0x20, 0x08, 0x34, 0x03, 0x35, 0x03,
  0x2e, 0x03, 0x38, 0x03, 0x31, 0x03, 0x31, 0x03, 0x4b, 0x03, 0x20, 0x03,
  0x20, 0x03, 0x65, 0x0f, 0x32, 0x0f, 0x6d, 0x0f, 0x33, 0x0f, 0x20, 0x0f,
  0x20, 0x0f, 0x36, 0x03, 0x37, 0x03, 0x38, 0x03, 0x38, 0x03, 0x20, 0x03,
  0x20, 0x03, 0x38, 0x08, 0x39, 0x08, 0x30, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x32, 0x03, 0x32, 0x03, 0x2e, 0x03, 0x37, 0x03, 0x38, 0x03, 0x31, 0x03,
  0x4b, 0x03, 0x20, 0x03, 0xfe, 0x0f, 0x20, 0x0f, 0x65, 0x0f, 0x33, 0x0f,
  0x6d, 0x0f, 0x36, 0x0f, 0x20, 0x0f, 0x20, 0x0f, 0x36, 0x03, 0x37, 0x03,
  0x38, 0x03, 0x38, 0x03, 0x20, 0x03, 0x20, 0x03, 0x38, 0x08, 0x39, 0x08,
  0x30, 0x08, 0x20, 0x08, 0x20, 0x08, 0x32, 0x03, 0x32, 0x03, 0x2e, 0x03,
  0x37, 0x03, 0x38, 0x03, 0x31, 0x03, 0x4b, 0x03, 0x20, 0x03, 0xfe, 0x0f,
  0x20, 0x0f, 0x65, 0x0f, 0x34, 0x0f, 0x6d, 0x0f, 0x39, 0x0f, 0x20, 0x0f,
  0x20, 0x0f, 0x36, 0x03, 0x37, 0x03, 0x38, 0x03, 0x38, 0x03, 0x20, 0x03,
  0x20, 0x03, 0x38, 0x08, 0x39, 0x08, 0x30, 0x08, 0x20, 0x08, 0x20, 0x08,
  0x32, 0x03, 0x32, 0x03, 0x2e, 0x03, 0x37, 0x03, 0x38, 0x03, 0x31, 0x03,
  0x4b, 0x03, 0x20, 0x03
};
unsigned int endoomzbsp_bin_len = 4000;

// const wadDirEntry *WAD::FindDir ( const char *name, const wadDirEntry *start, const wadDirEntry *end ) const
WAD * MakeENDOOMLump(wadList *myList, char *wadFileName) {

	return NULL;

	const wadListDirEntry *dir = myList->FindWAD ("ENDOOM2");

	if (dir) {
		printf("ENDOOM found!\n");
	} else {
		// myList->AddDirectory ( WAD *wad, bool check )

		printf("ENDOOM not found\n");
		
		void *ptr = ( void * ) &endoomzbsp_bin;

		// bool WAD::InsertBefore ( const wLumpName *name, UINT32 newSize, void *newStuff, bool owner, const wadDirEntry *entry )
		
		const wadListDirEntry *dir = myList->FindWAD ( wadFileName );
		
		// int ret = myList->InsertAfter (( const wLumpName * ) "ENDOOM", (UINT32) 4000, ptr, false, NULL);

		int ret = 0;

		dir = myList->FindWAD ("ENDOOM");

		if (dir) { 
			printf("ENDOOM found now!\n");
	        } else {
			printf("NO ENDOOM!!!!\n");
		}


		// delete newWad;
		printf("ret %d", ret);
	}
	printf("\n");
	
	return NULL;
	
}