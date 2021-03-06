//------------------------------------------------------------------------
// ANALYZE : Analyzing level structures
//------------------------------------------------------------------------
//
//  GL-Friendly Node Builder (C) 2000-2007 Andrew Apted
//
//  Based on 'BSP 2.3' by Colin Reed, Lee Killough and others.
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//------------------------------------------------------------------------

#ifndef __GLBSP_ANALYZE_H__
#define __GLBSP_ANALYZE_H__

#include "level.h"
#include "structs.h"

// detection routines
void DetectDuplicateVertices(void);
void DetectDuplicateSidedefs(void);
void DetectPolyobjSectors(void);
void DetectOverlappingLines(void);
void DetectWindowEffects(void);

// pruning routines
void PruneLinedefs(void);
void PruneVertices(void);
void PruneSidedefs(void);
void PruneSectors(void);

// conv_fab
void DoConversions(void);

#endif /* __GLBSP_ANALYZE_H__ */
