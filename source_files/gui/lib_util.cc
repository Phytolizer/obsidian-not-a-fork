//------------------------------------------------------------------------
//  Utility functions
//------------------------------------------------------------------------
//
//  Oblige Level Maker
//
//  Copyright (C) 2006-2009 Andrew Apted
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

#include "lib_util.h"
#include <algorithm>
#include <cctype>

#include "headers.h"

#ifdef UNIX
#include <sys/time.h>
#include <time.h>
#include <unistd.h>  // usleep()
#endif

int StringCaseCmp(std::string_view a, std::string_view b) {
    return StringCaseEquals(a, b) ? 0 : a < b ? -1 : 1;
}

int StringCaseCmpPartial(std::string_view a, std::string_view b) {
    return !StringCaseEqualsPartial(a, b);
}

bool StringCaseEquals(std::string_view a, std::string_view b) {
    return a.size() == b.size() &&
           std::equal(a.begin(), a.end(), b.begin(), [](char a, char b) {
               return std::tolower(a) == std::tolower(b);
           });
}

bool StringCaseEqualsPartial(std::string_view a, std::string_view b) {
    return a.size() >= b.size() &&
           std::equal(a.begin(), a.begin() + b.size(), b.begin(),
                      [](char a, char b) {
                          return std::tolower(a) == std::tolower(b);
                      });
}

std::string StringUpper(std::string_view name) {
    std::string copy;
    copy.reserve(name.size());
    std::transform(name.begin(), name.end(), std::back_inserter(copy),
                   [](char c) { return std::toupper(c); });
    return copy;
}

void StringRemoveCRLF(std::string *str) {
    if (str->back() == '\n') {
        str->pop_back();
    }
    if (str->back() == '\r') {
        str->pop_back();
    }
}

void StringReplaceChar(std::string *str, char old_ch, char new_ch) {
    // when 'new_ch' is zero, the character is simply removed

    SYS_ASSERT(old_ch != '\0');

    while (true) {
        auto it = std::find(str->begin(), str->end(), old_ch);
        if (it == str->end()) {
            // found them all
            break;
        }
        if (new_ch == '\0') {
            str->erase(it);
        } else {
            *it = new_ch;
        }
    }
}

char *mem_gets(char *buf, int size, const char **str_ptr) {
    // This is like fgets() but reads lines from a string.
    // The pointer at 'str_ptr' will point to the next line
    // after this call (or the trailing NUL).
    // Lines which are too long will be truncated (silently).
    // Returns NULL when at end of the string.

    SYS_ASSERT(str_ptr && *str_ptr);
    SYS_ASSERT(size >= 4);

    const char *p = *str_ptr;

    if (!*p) {
        return NULL;
    }

    char *dest = buf;
    char *dest_end = dest + (size - 2);

    for (; *p && *p != '\n'; p++) {
        if (dest < dest_end) {
            *dest++ = *p;
        }
    }

    if (*p == '\n') {
        *dest++ = *p++;
    }

    *dest = 0;

    *str_ptr = p;

    return buf;
}

//------------------------------------------------------------------------

/* Thomas Wang's 32-bit Mix function */
u32_t IntHash(u32_t key) {
    key += ~(key << 15);
    key ^= (key >> 10);
    key += (key << 3);
    key ^= (key >> 6);
    key += ~(key << 11);
    key ^= (key >> 16);

    return key;
}

u32_t StringHash(const char *str) {
    u32_t hash = 0;

    if (str) {
        while (*str) {
            hash = (hash << 5) - hash + *str++;
        }
    }

    return hash;
}

double PerpDist(double x, double y, double x1, double y1, double x2,
                double y2) {
    x -= x1;
    y -= y1;
    x2 -= x1;
    y2 -= y1;

    double len = sqrt(x2 * x2 + y2 * y2);

    SYS_ASSERT(len > 0);

    return (x * y2 - y * x2) / len;
}

double AlongDist(double x, double y, double x1, double y1, double x2,
                 double y2) {
    x -= x1;
    y -= y1;
    x2 -= x1;
    y2 -= y1;

    double len = sqrt(x2 * x2 + y2 * y2);

    SYS_ASSERT(len > 0);

    return (x * x2 + y * y2) / len;
}

double CalcAngle(double sx, double sy, double ex, double ey) {
    // result is Degrees (0 <= angle < 360).
    // East  (increasing X) -->  0 degrees
    // North (increasing Y) --> 90 degrees

    ex -= sx;
    ey -= sy;

    if (fabs(ex) < 0.0001) {
        return (ey > 0) ? 90.0 : 270.0;
    }

    if (fabs(ey) < 0.0001) {
        return (ex > 0) ? 0.0 : 180.0;
    }

    double angle = atan2(ey, ex) * 180.0 / M_PI;

    if (angle < 0) {
        angle += 360.0;
    }

    return angle;
}

double DiffAngle(double A, double B) {
    // A + result = B
    // result ranges from -180 to +180

    double D = B - A;

    while (D > 180.0) {
        D = D - 360.0;
    }
    while (D < -180.0) {
        D = D + 360.0;
    }

    return D;
}

double ComputeDist(double sx, double sy, double ex, double ey) {
    return sqrt((ex - sx) * (ex - sx) + (ey - sy) * (ey - sy));
}

double ComputeDist(double sx, double sy, double sz, double ex, double ey,
                   double ez) {
    return sqrt((ex - sx) * (ex - sx) + (ey - sy) * (ey - sy) +
                (ez - sz) * (ez - sz));
}

double PointLineDist(double x, double y, double x1, double y1, double x2,
                     double y2) {
    x -= x1;
    y -= y1;
    x2 -= x1;
    y2 -= y1;

    double len_squared = (x2 * x2 + y2 * y2);

    SYS_ASSERT(len_squared > 0);

    double along_frac = (x * x2 + y * y2) / len_squared;

    // three cases:
    //   (a) off the "left" side (closest to start point)
    //   (b) off the "right" side (closest to end point)
    //   (c) in-between : use the perpendicular distance

    if (along_frac <= 0) {
        return sqrt(x * x + y * y);

    } else if (along_frac >= 1) {
        return ComputeDist(x, y, x2, y2);

    } else {
        // perp dist
        return fabs(x * y2 - y * x2) / sqrt(len_squared);
    }
}

void CalcIntersection(double nx1, double ny1, double nx2, double ny2,
                      double px1, double py1, double px2, double py2, double *x,
                      double *y) {
    // NOTE: lines are extended to infinity to find the intersection

    double a = PerpDist(nx1, ny1, px1, py1, px2, py2);
    double b = PerpDist(nx2, ny2, px1, py1, px2, py2);

    // BIG ASSUMPTION: lines are not parallel or colinear
    SYS_ASSERT(fabs(a - b) > 1e-6);

    // determine the intersection point
    double along = a / (a - b);

    *x = nx1 + along * (nx2 - nx1);
    *y = ny1 + along * (ny2 - ny1);
}

void AlongCoord(double along, double px1, double py1, double px2, double py2,
                double *x, double *y) {
    double len = ComputeDist(px1, py1, px2, py2);

    *x = px1 + along * (px2 - px1) / len;
    *y = py1 + along * (py2 - py1) / len;
}

bool VectorSameDir(double dx1, double dy1, double dx2, double dy2) {
    return (dx1 * dx2 + dy1 * dy2) >= 0;
}

//------------------------------------------------------------------------

u32_t TimeGetMillies() {
    // Note: you *MUST* handle overflow (it *WILL* happen)

#ifdef WIN32
    unsigned long ticks = GetTickCount();

    return (u32_t)ticks;

#else  // UNIX or MacOSX
    struct timeval tm;

    gettimeofday(&tm, NULL);

    return (u32_t)((tm.tv_sec * 1000) + (tm.tv_usec / 1000));
#endif
}

void TimeDelay(u32_t millies) {
#ifdef WIN32
    ::Sleep(millies);

#else  // LINUX or MacOSX

    usleep(millies * 1000);
#endif
}

//--- editor settings ---
// vi:ts=4:sw=4:noexpandtab
