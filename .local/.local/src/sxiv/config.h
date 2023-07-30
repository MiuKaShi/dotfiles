#ifdef _WINDOW_CONFIG

/* default window dimensions (overwritten via -g option): */
enum {
	WIN_WIDTH  = 800,
	WIN_HEIGHT = 600
};

/* colors and font are configured with 'background', 'foreground' and
 * 'font' X resource properties.
 * See X(7) section Resources and xrdb(1) for more information.
 */

#endif
#ifdef _IMAGE_CONFIG

/* levels (in percent) to use when zooming via '-' and '+':
 * (first/last value is used as min/max zoom level)
 */
static const float zoom_levels[] = {
	 6.25, 12.5, 18.75, 25.0, 31.25, 37.5, 43.75, 50.0, 62.5, 75.0, 87.5,
	100.0, 125.0, 150.0, 175.0, 200.0, 300.0, 400.0, 600.0, 800.0
};

/* default slideshow delay (in sec, overwritten via -S option): */
enum { SLIDESHOW_DELAY = 5 };

/* gamma correction: the user-visible ranges [-GAMMA_RANGE, 0] and
 * (0, GAMMA_RANGE] are mapped to the ranges [0, 1], and (1, GAMMA_MAX].
 * */
static const double GAMMA_MAX   = 10.0;
static const int    GAMMA_RANGE = 32;

/* command i_scroll pans image 1/PAN_FRACTION of screen width/height */
static const int PAN_FRACTION = 5;

/* if false, pixelate images at zoom level != 100%,
 * toggled with 'a' key binding
 */
static const bool ANTI_ALIAS = true;

/* if true, use a checkerboard background for alpha layer,
 * toggled with 'A' key binding
 */
static const bool ALPHA_LAYER = false;

#if SVG_IMAGE_SUPPORT_PATCH
/* fallback height and width for svg documents,
 * use these values in case svg document does not specify height and width.
 */
enum {
	FB_SVG_HEIGHT = 512,
	FB_SVG_WIDTH  = 512
};
#endif // SVG_IMAGE_SUPPORT_PATCH

#endif
#ifdef _THUMBS_CONFIG

/* thumbnail sizes in pixels (width == height): */
static const int thumb_sizes[] = { 32, 64, 96, 128, 160, 200, 250, 300 };

#if THUMBS_PADDING_PATCH
const int THUMB_BORDERS[]      = { 2,  2,  2,  2,   2,   2,   2,   2   };
const int THUMB_MARGIN = -1;
const int THUMB_PADDING = 2;
#endif // THUMBS_PADDING_PATCH

/* thumbnail size at startup, index into thumb_sizes[]: */
static const int THUMB_SIZE = 4;

#endif
#ifdef _MAPPINGS_CONFIG

/* keyboard mappings for image and thumbnail mode: */
static const keymap_t keys[] = {
	/* modifiers    key               function              argument */
	{ 0,            XK_q,             g_quit,               None },
	#if DMENU_LIKE_BEHAVIOUR_PATCH
	{ 0,            XK_Return,        g_switch_mode,        0 },
	{ ControlMask,  XK_Return,        g_switch_mode,        1 },
	#else
	{ 0,            XK_Return,        g_switch_mode,        None },
	#endif // DMENU_LIKE_BEHAVIOUR_PATCH
	{ 0,            XK_f,             g_toggle_fullscreen,  None },
	{ 0,            XK_b,             g_toggle_bar,         None },
	{ ControlMask,  XK_x,             g_prefix_external,    None },
	{ 0,            XK_g,             g_first,              None },
	{ 0,            XK_G,             g_n_or_last,          None },
	{ 0,            XK_r,             g_reload_image,       None },
	{ 0,            XK_D,             g_remove_image,       None },
	{ ControlMask,  XK_h,             i_scroll_to_edge,     DIR_LEFT },
	{ ControlMask,  XK_j,             i_scroll_to_edge,     DIR_DOWN },
	{ ControlMask,  XK_k,             i_scroll_to_edge,     DIR_UP },
	{ ControlMask,  XK_l,             i_scroll_to_edge,     DIR_RIGHT },
	{ 0,            XK_m,             g_toggle_image_mark,  None },
	{ 0,            XK_M,             g_mark_range,         None },
	{ ControlMask,  XK_m,             g_reverse_marks,      None },
	{ ControlMask,  XK_M,             g_unmark_all,         None },
	{ 0,            XK_N,             i_navigate,           +10 },
	{ 0,            XK_P,             i_navigate,           -10 },
	{ ControlMask,  XK_n,             g_navigate_marked,    +1 },
	{ ControlMask,  XK_p,             g_navigate_marked,    -1 },
	{ 0,            XK_bracketleft,   g_change_gamma,       -1 },
	{ 0,            XK_bracketright,  g_change_gamma,       +1 },
	{ 0,            XK_braceleft,     g_change_gamma,        0 },
	{ 0,            XK_braceright,    g_change_gamma,        0 },

	{ 0,            XK_h,             t_move_sel,           DIR_LEFT },
	{ 0,            XK_j,             t_move_sel,           DIR_DOWN },
	{ 0,            XK_k,             t_move_sel,           DIR_UP },
	{ 0,            XK_l,             t_move_sel,           DIR_RIGHT },
	{ 0,            XK_Left,          t_move_sel,           DIR_LEFT },
	{ 0,            XK_Down,          t_move_sel,           DIR_DOWN },
	{ 0,            XK_Right,         t_move_sel,           DIR_RIGHT },
	{ 0,            XK_Up,            t_move_sel,           DIR_UP },
	{ ControlMask,  XK_h,             t_jump_sel,           DIR_LEFT },
	{ ControlMask,  XK_j,             t_jump_sel,           DIR_DOWN },
	{ ControlMask,  XK_k,             t_jump_sel,           DIR_UP },
	{ ControlMask,  XK_l,             t_jump_sel,           DIR_RIGHT },
	{ ControlMask,  XK_Left,          t_jump_sel,           DIR_LEFT },
	{ ControlMask,  XK_Down,          t_jump_sel,           DIR_DOWN },
	{ ControlMask,  XK_Right,         t_jump_sel,           DIR_RIGHT },
	{ ControlMask,  XK_Up,            t_jump_sel,           DIR_UP },
    { ControlMask,  XK_u,             t_jump_sel,           DIR_UP },
    { ControlMask,  XK_d,             t_jump_sel,           DIR_DOWN },
    { 0,            XK_Page_Up,       t_jump_sel,           DIR_UP },
    { 0,            XK_Page_Down,     t_jump_sel,           DIR_DOWN },
	{ 0,            XK_R,             t_reload_all,         None },

	{ 0,            XK_n,             i_navigate,           +1 },
	{ 0,            XK_space,         i_navigate,           +1 },
	{ 0,            XK_p,             i_navigate,           -1 },
	{ 0,            XK_BackSpace,     i_navigate,           -1 },
	{ ControlMask,  XK_6,             i_alternate,          None },
	{ ControlMask,  XK_space,         i_toggle_animation,   None },
	#if NAVIGATE_IF_NOT_SCROLL_PATCH
	{ 0,            XK_h,             i_scroll_or_navigate, DIR_LEFT },
	{ 0,            XK_Left,          i_scroll_or_navigate, DIR_LEFT },
	{ 0,            XK_j,             i_scroll_or_navigate, DIR_DOWN },
	{ 0,            XK_Down,          i_scroll_or_navigate, DIR_DOWN },
	{ 0,            XK_k,             i_scroll_or_navigate, DIR_UP },
	{ 0,            XK_Up,            i_scroll_or_navigate, DIR_UP },
	{ 0,            XK_l,             i_scroll_or_navigate, DIR_RIGHT },
	{ 0,            XK_Right,         i_scroll_or_navigate, DIR_RIGHT },
	#else
	{ 0,            XK_h,             i_scroll,             DIR_LEFT },
	{ 0,            XK_Left,          i_scroll,             DIR_LEFT },
	{ 0,            XK_j,             i_scroll,             DIR_DOWN },
	{ 0,            XK_Down,          i_scroll,             DIR_DOWN },
	{ 0,            XK_k,             i_scroll,             DIR_UP },
	{ 0,            XK_Up,            i_scroll,             DIR_UP },
	{ 0,            XK_l,             i_scroll,             DIR_RIGHT },
	{ 0,            XK_Right,         i_scroll,             DIR_RIGHT },
	#endif // NAVIGATE_IF_NOT_SCROLL_PATCH
	{ 0,            XK_J,             g_zoom,               -1 },
	{ 0,            XK_K,             g_zoom,               +1 },
	{ ControlMask,  XK_f,             i_set_zoom,           100 },
	{ 0,            XK_w,             i_fit_to_win,         SCALE_DOWN },
	{ 0,            XK_W,             i_fit_to_win,         SCALE_FIT },
	#if SCALE_FILL_MODE_PATCH
	{ 0,            XK_F,             i_fit_to_win,         SCALE_FILL },
	#endif // SCALE_FILL_MODE_PATCH
	{ 0,            XK_e,             i_fit_to_win,         SCALE_WIDTH },
	{ 0,            XK_E,             i_fit_to_win,         SCALE_HEIGHT },
	{ 0,            XK_comma,         i_rotate,             DEGREE_270 },
	{ 0,            XK_period,        i_rotate,             DEGREE_90 },
	{ 0,            XK_less,          i_flip,               FLIP_HORIZONTAL },
	{ 0,            XK_greater,       i_flip,               FLIP_VERTICAL },
	{ 0,            XK_a,             i_toggle_antialias,   None },
	{ 0,            XK_A,             i_toggle_alpha,       None },
	{ 0,            XK_s,             i_slideshow,          None },
};

/* mouse button mappings for image mode: */
static const button_t buttons[] = {
	/* modifiers    button            function              argument */
	{ 0,            1,                i_cursor_navigate,    None },
	{ 0,            2,                i_drag,               DRAG_ABSOLUTE },
	{ 0,            3,                g_switch_mode,        None },
	{ 0,            4,                g_zoom,               +1 },
	{ 0,            5,                g_zoom,               -1 },
};

#if ALLOW_ESCAPE_KEY_IN_EXTERNAL_KEY_HANDLER_PATCH
/* If false, sxiv will send all key combos to the external keyhandler until the keyhandler
 * returns 1 as its exit status.
 * The example external keyhandler uses the escape key for this.
 */
static const bool one_extkeyhandler_cmd = true;
#endif // ALLOW_ESCAPE_KEY_IN_EXTERNAL_KEY_HANDLER_PATCH

#endif
