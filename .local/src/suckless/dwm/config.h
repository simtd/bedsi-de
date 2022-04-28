/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 10;       /* gaps between windows */
static const unsigned int snap      = 16;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */

static const char *fonts[]          = { "Terminus" };
static const char dmenufont[]       = "Terminus";

// static const char col_gray1[]       = "#000000";
// static const char col_gray2[]       = "#444444";
// static const char col_gray3[]       = "#bbbbbb";
// static const char col_gray4[]       = "#eeeeee";
// static const char col_cyan[]        = "#005577";

// CUSTOM COLOR SCHEME

static const char fg_norm[]       = "#000000";
static const char bg_norm[]       = "#F9FAFB";
static const char border_norm[]   = "#696969";
static const char fg_sel[]        = "#000000";
static const char bg_sel[]        = "#bfbfbf";
static const char border_sel[]    = "#343a40";

static const char *colors[][3]      = {
	/*               fg       bg       border   */
	[SchemeNorm] = { fg_norm, bg_norm, border_norm },
	[SchemeSel]  = { fg_sel,  bg_sel,  border_sel  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
// static const char *tags[] = { "一", "二", "三", "四", "五", "六", "七", "八", "九" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class         instance          title       tags mask  iscentered  isfloating   monitor */
	{ "Gimp",        NULL,             NULL,       0,         0,          1,           -1 },
	{ "Firefox",     NULL,             NULL,       1 << 8,    0,          0,           -1 },
	{ "st-256color", "floating st",    NULL,       0,         1,          1,           -1 },
};

/* layout(s) */
static const float mfact        = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster        = 1;    /* number of clients in master area */
static const int resizehints    = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1;    /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", bg_norm, "-nf", fg_norm, "-sb", bg_sel, "-sf", fg_sel, NULL };
static const char *termcmd[]  = { "alacritty", NULL };

/* importing media keys */
#include <X11/XF86keysym.h>

static Key keys[] = {
	/* modifier                     key                       function          argument */

	// WINDOW MANAGER HOTKEYS
	// ----------------------

	// quit graphical environment
	{ MODKEY|Mod5Mask,              XK_q,                     spawn,            SHCMD("exit-graphical-environment") },
	// quit dwm (don't use this!)
	{ MODKEY|Mod5Mask|ShiftMask,    XK_q,                     quit,             {0} },
	// compile-dwm
	{ MODKEY|Mod5Mask,              XK_c,                     spawn,            SHCMD("compile-dwm") },
	// restart statusbar script
	{ MODKEY|Mod5Mask,              XK_p,                     spawn,            SHCMD("rnstatus restart") },
	// close window
	{ MODKEY,                       XK_q,                     killclient,       {0} },
	// swap master window
	{ MODKEY,                       XK_Return,                zoom,             {0} },
	// focus window below
	{ MODKEY,                       XK_j,                     focusstack,       {.i = +1 } },
	// focus window above
	{ MODKEY,                       XK_k,                     focusstack,       {.i = -1 } },
	// toggle fullscreen
	{ MODKEY,                       XK_m,                     togglefullscr,    {0} },
	// toggle panel
	{ MODKEY|ShiftMask,             XK_b,                     togglebar,        {0} },
	// move window split to the left
	{ MODKEY,                       XK_h,                     setmfact,         {.f = -0.05} },
	// move window split to the right
	{ MODKEY,                       XK_l,                     setmfact,         {.f = +0.05} },
	// decrease window gaps size
	{ MODKEY,                       XK_minus,                 setgaps,          {.i = -5 } },
	// increase window gaps size
	{ MODKEY,                       XK_plus,                  setgaps,          {.i = +5 } },
	// add an extra master window
	{ MODKEY,                       XK_i,                     incnmaster,       {.i = +1 } },
	// remove a master window
	{ MODKEY,                       XK_d,                     incnmaster,       {.i = -1 } },
	// toggle floating for active window
	{ MODKEY,                       XK_space,                 togglefloating,   {0} },
	// toggle floating layout
	{ MODKEY|ShiftMask,             XK_space,                 setlayout,        {0} },
	// set layout - tiling
	{ MODKEY|ShiftMask,             XK_t,                     setlayout,        {.v = &layouts[0]} },
	// set layout - floating
	{ MODKEY|ShiftMask,             XK_f,                     setlayout,        {.v = &layouts[1]} },
	// set layout - monocle
	{ MODKEY|ShiftMask,             XK_m,                     setlayout,        {.v = &layouts[2]} },
	// view all windows with any tag
	{ MODKEY,                       XK_0,                     view,             {.ui = ~0 } },
	// go to prevous occupied tag
	{ MODKEY,                       XK_comma,                 shiftviewclients, { .i = -1 } },
	// go to next occupied tag
	{ MODKEY,                       XK_period,                shiftviewclients, { .i = +1 } },
	// tag hotkeys related to number keys (see TAGKEYS above)	
	TAGKEYS(                        XK_1,                     0)
	TAGKEYS(                        XK_2,                     1)
	TAGKEYS(                        XK_3,                     2)
	TAGKEYS(                        XK_4,                     3)
	TAGKEYS(                        XK_5,                     4)
	TAGKEYS(                        XK_6,                     5)
	TAGKEYS(                        XK_7,                     6)
	TAGKEYS(                        XK_8,                     7)
	TAGKEYS(                        XK_9,                     8)
	// focus previous monitor
	{ MODKEY|ShiftMask,             XK_comma,                 focusmon,         {.i = -1 } },
	// focus next monitor
	{ MODKEY|ShiftMask,             XK_period,                focusmon,         {.i = +1 } },
	// send active window to previous monitor
	{ MODKEY|ShiftMask,             XK_h,                     tagmon,           {.i = -1 } },
	// send active window to next monitor
	{ MODKEY|ShiftMask,             XK_l,                     tagmon,           {.i = +1 } },

	// DMENU HOTKEYS
	// -------------

	// desktop app launcher
	{ MODKEY,                       XK_p,                     spawn,            SHCMD("dmenu_run-desktop") },
	// regular dmenu run launcher
	{ MODKEY|ShiftMask,             XK_p,                     spawn,            {.v = dmenucmd } },
	// text editor history script
	{ MODKEY,                       XK_e,                     spawn,            SHCMD("dmenu-editor-history --dmenu=\"fzfmenu --prompt='Hist: '\" --sel") },

	// LAUNCH PROGRAM HOTKEYS
	// -----------------------

	// terminal emulator
	{ MODKEY,                       XK_t,                     spawn,            {.v = termcmd } },
	// web browser
	{ MODKEY,                       XK_b,                     spawn,            SHCMD("$BROWSER") },
	// gui file manager
	{ MODKEY,                       XK_f,                     spawn,            SHCMD("pcmanfm") },	

	// UTILITY HOTKEYS
	// ---------------

	// screenshot desktop
	{ MODKEY,                       XK_Print,                 spawn,            SHCMD("maim -u --delay=0.5 ~/Pictures/$(date -u +'%Y-%m-%dT%H:%M:%S%Z').png") },
	// screenshot active window
	{ MODKEY|Mod5Mask,              XK_Print,                 spawn,            SHCMD("maim --window $(xdotool getactivewindow) ~/Pictures/$(date -u +'%Y-%m-%dT%H:%M:%S%Z').png") },
	// screenshot seleted area to clipboard
	{ MODKEY|ShiftMask,             XK_Print,                 spawn,            SHCMD("maim -u -s | xclip -selection clipboard -target image/png") },
	// screenlocker
	{ MODKEY|Mod5Mask,              XK_l,                     spawn,            SHCMD("slock") },	

	// MEDIA HOTKEYS
	// -------------

	// decrease volume with statusbar update
	{ 0,                            XF86XK_AudioLowerVolume,  spawn,            SHCMD("volume-control down ; rnstatus volume") },
	// increase volume with statusbar update
	{ 0,                            XF86XK_AudioRaiseVolume,  spawn,            SHCMD("volume-control ; rnstatus volume") },
	// slightly decrease volume with statusbar update
	{ ShiftMask,                    XF86XK_AudioLowerVolume,  spawn,            SHCMD("volume-control slight down ; rnstatus volume") },
	// slightly increase volume with statusbar update
	{ ShiftMask,                    XF86XK_AudioRaiseVolume,  spawn,            SHCMD("volume-control slight ; rnstatus volume") },
	// mute/unmute sound with statusbar update
	{ 0,                            XF86XK_AudioMute,         spawn,            SHCMD("volume-control mute ; rnstatus volume") },
	// mute/unmute microphone
	{ 0,                            XF86XK_AudioMicMute,      spawn,            SHCMD("pactl set-source-mute @DEFAULT_SOURCE@ toggle") },
	// decrease screen backlight with statusbar update
	{ 0,                            XF86XK_MonBrightnessDown, spawn,            SHCMD("light -U 5 ; rnstatus backlight") },
	// increase screen backlight with statusbar update
	{ 0,                            XF86XK_MonBrightnessUp,   spawn,            SHCMD("light -A 5 ; rnstatus backlight") },
	// keyboard backlight
	{ MODKEY|Mod5Mask,              XK_space,                 spawn,            SHCMD("keyboard-backlight") },
	// play/pause for media players
	{ 0,                            XF86XK_Favorites,         spawn,            SHCMD("playerctl play-pause") },
	// go backward for media players
	{ MODKEY,                       XF86XK_Favorites,         spawn,            SHCMD("playerctl position 5-") },
	// go forward for media players
	{ MODKEY|ShiftMask,             XF86XK_Favorites,         spawn,            SHCMD("playerctl position 5+") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

