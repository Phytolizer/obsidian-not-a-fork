//----------------------------------------------------------------
//  Custom Mod list
//----------------------------------------------------------------
//
//  Oblige Level Maker (C) 2006-2008 Andrew Apted
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
//----------------------------------------------------------------

#include "headers.h"
#include "hdr_fltk.h"
#include "hdr_lua.h"
#include "hdr_ui.h"

#include "lib_util.h"

#include "g_lua.h"


#define MY_PURPLE  fl_rgb_color(208,0,208)


class My_ClipGroup : public Fl_Group
{
public:
  My_ClipGroup(int X, int Y, int W, int H, const char *L = NULL) :
      Fl_Group(X, Y, W, H, L)
  {
    clip_children(1);
  }

  virtual ~My_ClipGroup()
  { }
};


//-----------------------------------------------------------------


UI_Module::UI_Module(int x, int y, int w, int h,
                     const char *id, const char *label) :
    Fl_Group(x, y, w, h),
    id_name(id),
    choice_map()
{
  end(); // cancel begin() in Fl_Group constructor
 
//  box(FL_BORDER_BOX);
  box(FL_THIN_UP_BOX);

  color(BUILD_BG, BUILD_BG);

  resizable(NULL);


  enabled = new Fl_Check_Button(x+5, y+4, w-20, 24, label);

  add(enabled);
 

//!!!!!!  hide();
}


UI_Module::~UI_Module()
{
}


void UI_Module::AddOption(const char *id, const char *label, const char *choices)
{
//return; //!!!!!

  int nw = 120;
  int nh = 28;

  int nx = x() + 192;
  int ny = y() + children() * nh;

  // FIXME: make label with ': ' suffixed

fprintf(stderr, "AddOption: x, y = %d,%d\n", x(), y());
  UI_RChoice *rch = new UI_RChoice(nx, ny, nw, 24, label);

  rch->align(FL_ALIGN_LEFT);
  rch->selection_color(MY_PURPLE);

  add(rch);

  choice_map[id] = rch;
  

  rch->AddPair("foo", "Foo");
  rch->AddPair("bar", "Bar");
  rch->AddPair("jim", "Jimmy");

  rch->ShowOrHide("foo", 1);
  rch->ShowOrHide("bar", 1);
  rch->ShowOrHide("jim", 1);

///  rch->redraw();

  rch->hide();

  redraw();
}


int UI_Module::CalcHeight() const
{
  int h = 4 + 24 + 4;  // check button

  if (enabled->value())
    h += (children() - 1) * 28;

  return h;
}

void UI_Module::update_Enable()
{
  for (int j = 0; j < children(); j++)
  {
    if (child(j) == enabled)
      continue;

    // this is awful
    UI_RChoice *M = (UI_RChoice *)child(j);

    if (enabled->value())
      M->show();
    else
      M->hide();
  }
}


//----------------------------------------------------------------


UI_CustomMods::UI_CustomMods(int x, int y, int w, int h, const char *label) :
    Fl_Group(x, y, w, h, label)
{
  end(); // cancel begin() in Fl_Group constructor
 
//  box(FL_THIN_UP_BOX);
  box(FL_FLAT_BOX);
  color(WINDOW_BG, WINDOW_BG);


  int cy = y; // + 8;

#if 0
  Fl_Box *heading = new Fl_Box(FL_NO_BOX, x+6+w/4, cy, w/2-12, 24, "Custom Mods");
  heading->align(FL_ALIGN_LEFT | FL_ALIGN_INSIDE);
  heading->labeltype(FL_NORMAL_LABEL);
  heading->labelfont(FL_HELVETICA_BOLD);
  heading->labelcolor(FL_WHITE);
//  heading->color(BUILD_BG, BUILD_BG);

  add(heading);
#endif

//  cy += 28;


  // area for module list
  mx = x+0;
  my = cy;
  mw = w-0 - Fl::scrollbar_size();
  mh = y+h-cy;

  offset_y = 0;
  total_h  = 0;

fprintf(stderr, "MLIST AREA: (%d,%d)  %dx%d\n", mx, my, mw, mh);

  sbar = new Fl_Scrollbar(mx+mw, my, Fl::scrollbar_size(), mh);
  sbar->callback(callback_Scroll, this);

  add(sbar);


  mod_pack = new My_ClipGroup(mx, my, mw, mh, "\nCustom Modules");
  mod_pack->end();

  mod_pack->align(FL_ALIGN_INSIDE);
  mod_pack->labeltype(FL_NORMAL_LABEL);
//  mod_pack->labelfont(FL_HELVETICA_BOLD);
  mod_pack->labelsize(20);
//  mod_pack->labelcolor(FL_DARK2);

  mod_pack->box(FL_FLAT_BOX);
  mod_pack->color(WINDOW_BG);  
  mod_pack->resizable(NULL);


  add(mod_pack);
}


UI_CustomMods::~UI_CustomMods()
{
}


void UI_CustomMods::AddModule(const char *id, const char *label)
{
  UI_Module *M = new UI_Module(mx, my, mw-4, 130, id, label);

  M->enabled->callback(callback_ModEnable, M);

  mod_pack->add(M);


  M->AddOption("a", "Dead Cacodemons: ", "Bleh");
  M->AddOption("b", "Lots of Cyberdemons: ", "Bleh");
  M->AddOption("c", "Do not add crates: ", "Bleh");
//  M->AddOption("d", "Foundation: ", "Bleh");


  total_h = PositionAll(my - offset_y);
  sbar->value(0, mh, 0, total_h);

  M->redraw();
  mod_pack->redraw();
}


bool UI_CustomMods::ShowOrHide(const char *id, bool new_shown)
{
  SYS_ASSERT(id);

  UI_Module *M = FindID(id);

  if (! M)
    return false;

  if ( (M->visible()?1:0) == (new_shown ? 1:0) )
    return true;

  // visibility definitely changed

  if (new_shown)
    M->show();
  else
    M->hide();

  total_h = PositionAll(my - offset_y);
  sbar->value(0, mh, 0, total_h);

  M->redraw();
  mod_pack->redraw();

  return true;
}


int UI_CustomMods::PositionAll(int start_y)
{
  int cur_y = start_y;
fprintf(stderr, "PositionAll:\n");

  for (int j = 0; j < mod_pack->children(); j++)
  {
    UI_Module *M = (UI_Module *) mod_pack->child(j);
    SYS_ASSERT(M);

    int ny = cur_y;
    int nh = M->visible() ? M->CalcHeight() : 0; //!!!!!!!
  
    if (ny != M->y() || nh != M->h())
    {
fprintf(stderr, "  SETTING WIDGET TO: (%d,%d) %dx%d\n", M->x(), ny, M->w(), MAX(1, nh));
      M->resize(M->x(), ny, M->w(), MAX(1, nh));

//      if (M->y() <= my+mh && M->y()+M->h() >= my)
//        M->redraw();
    }
fprintf(stderr, "  %p : %s (%d,%d) %dx%d\n", M, M->visible() ? "SHOW" : "hide", M->x(), M->y(), M->w(), M->h());

    cur_y += nh + (nh ? 4 : 0);
  }

  mod_pack->redraw();

  return cur_y - start_y;
}


void UI_CustomMods::callback_Scroll(Fl_Widget *w, void *data)
{
  Fl_Scrollbar *sbar = (Fl_Scrollbar *)w;

  UI_CustomMods *that = (UI_CustomMods *)data;


fprintf(stderr, "scrollbar pos: %d\n", sbar->value());
  
  that->offset_y = sbar->value();

#if 1
  int new_total_h = that->PositionAll(that->my - that->offset_y);

  if (new_total_h != that->total_h)
    fprintf(stderr, "WARNING: total_h CHANGED!!!\n");
#endif
}


void UI_CustomMods::callback_ModEnable(Fl_Widget *w, void *data)
{
  UI_Module *M = (UI_Module *)data;

  M->update_Enable();

  UI_CustomMods *that = main_win->mod_box;

that->offset_y=0;

  int old_total_h = that->total_h;
  int new_total_h = that->PositionAll(that->my - that->offset_y);

  that->total_h = new_total_h;
  that->sbar->value(0, that->mh, 0, that->total_h);

  fprintf(stderr, "HEIGHT CHANGE: %d --> %d\n", old_total_h, new_total_h);
}


UI_Module * UI_CustomMods::FindID(const char *id) const
{
  // this is awful
  for (int j = 0; j < mod_pack->children(); j++)
  {
    UI_Module *M = (UI_Module *) mod_pack->child(j);
    SYS_ASSERT(M);

    if (strcmp(M->id_name.c_str(), id) == 0)
      return M;
  }

  return NULL;
}


void UI_CustomMods::Locked(bool value)
{
  if (value)
  {
    mod_pack->deactivate();
  }
  else
  {
    mod_pack->activate();
  }
}


//--- editor settings ---
// vi:ts=2:sw=2:expandtab
