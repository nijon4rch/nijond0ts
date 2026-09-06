-----------------
--- FUNCTIONS ---
-----------------

-- Toggle QWERTY
local qwerty_toggled = false
local function toggle_qwerty()
	if qwerty_toggled then
		hl.exec_cmd('notify-send "Keyboard Layout" "Toggled QWERTY OFF"')

		hl.exec_cmd("hyprctl reload")
	else
		qwerty_toggled = true

		hl.config({
			input = {
				kb_layout = "us",
				kb_variant = "",
			},
		})

		hl.exec_cmd('notify-send "Keyboard Layout" "Toggled QWERTY ON"')
	end
end

-- Save Replay
local function save_replay()
	hl.exec_cmd(
		'notify-send -t 1500 -u low -- "GPU Screen Recorder" "Replay saved" && sleep 0.5 && killall -SIGUSR1 gpu-screen-recorder'
	)
end

----------------
--- MONITORS ---
----------------

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

------------------
--- AUTOSTART ----
------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprctl setcursor simplifydot 24 &")
	hl.exec_cmd("hyprpaper &")
	hl.exec_cmd("hyprnotify -f 18 &")
	hl.exec_cmd("wl-paste --type text --watch cliphist store &")
	hl.exec_cmd("wl-paste --type image --watch cliphist store &")
	hl.exec_cmd("hyprpm reload &")
end)

-----------------
--- VARIABLES ---
-----------------
local terminal = "kitty"
local menu = "fuzzel"

hl.env("EDITOR", "nvim")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GTK_USE_PORTAL", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

---------------------
--- LOOK AND FEEL ---
---------------------

hl.config({
	plugin = {
		hyprexpo = {
			workspace_method = "first 1",
		},
	},

	general = {
		gaps_in = 2,
		gaps_out = 3,
		border_size = 2,
		col = {
			active_border = { colors = { "rgb(fe008a)", "rgb(690036)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		resize_on_border = false,
		allow_tearing = true,
		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		rounding_power = 2,
		dim_inactive = true,
		dim_strength = 0.1,
		active_opacity = 0.95,
		inactive_opacity = 0.85,
		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			new_optimizations = true,
			ignore_opacity = true,
			xray = false,
			vibrancy = 0.4,
			vibrancy_darkness = 0.2,
		},
		shadow = {
			enabled = true,
			range = 20,
			render_power = 3,
			color = "rgba(ff69b444)",
			color_inactive = "rgba(00000033)",
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
		font_family = "Rixlovefool Cyrillic Mono",
	},

	--------------
	---- INPUT ---
	--------------

	input = {
		kb_layout = "us,ru",
		kb_variant = "dvorak,",
		kb_model = "",
		kb_options = "grp:alt_shift_toggle",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},
})

-----------------
--- ANIMATIONS---
-----------------

hl.curve("pinkBounce", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 6,
	bezier = "pinkBounce",
	style = "popin 80%",
})
hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 6,
	bezier = "default",
	style = "popin 80%",
})
hl.animation({
	leaf = "border",
	enabled = true,
	speed = 5,
	bezier = "default",
})
hl.animation({
	leaf = "borderangle",
	enabled = true,
	speed = 100,
	bezier = "linear",
	style = "loop",
})
hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 5,
	bezier = "default",
})
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 5,
	bezier = "pinkBounce",
	style = "slide",
})

-------------------
--- KEYBINDINGS ---
-------------------
local mainMod = "SUPER"

-- Application launching
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + COMMA", hl.dsp.exec_cmd(menu))

-- Utilities
hl.bind("PRINT", hl.dsp.exec_cmd("grim - | wl-copy"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/$(date +'grim_%y%m%d_%H%M%S.png')"))
hl.bind(mainMod .. " + PRINT", save_replay)
hl.bind(mainMod .. " + SLASH", hl.dsp.exec_cmd("hyprpicker -aq"))
hl.bind(
	mainMod .. " + PERIOD",
	hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu --with-nth 2 | cliphist decode | wl-copy")
)
hl.bind(mainMod .. " + F1", toggle_qwerty)
hl.bind(
	mainMod .. " + L",
	hl.dsp.exec_cmd(
		'hyprctl notify -1 5000 "rgb(ff1ea3)" "$(cat /sys/class/power_supply/BAT0/capacity) | $(cat /sys/class/power_supply/BAT0/status)"'
	)
)

-- Window management
hl.bind(mainMod .. " + O", hl.dsp.window.close())
hl.bind(mainMod .. " + H", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + S", hl.dsp.layout("swapsplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.float({ action = "set" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pin())
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mainMod .. " + APOSTROPHE", function()
	hl.plugin.hyprexpo.expo("toggle")
end)
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd("hyprctl kill"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))

hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))

hl.bind(mainMod .. " + CTRL + 1", hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind(mainMod .. " + CTRL + 2", hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind(mainMod .. " + CTRL + 3", hl.dsp.window.move({ workspace = 3, follow = false }))
hl.bind(mainMod .. " + CTRL + 4", hl.dsp.window.move({ workspace = 4, follow = false }))
hl.bind(mainMod .. " + CTRL + 5", hl.dsp.window.move({ workspace = 5, follow = false }))
hl.bind(mainMod .. " + CTRL + 6", hl.dsp.window.move({ workspace = 6, follow = false }))
hl.bind(mainMod .. " + CTRL + 7", hl.dsp.window.move({ workspace = 7, follow = false }))
hl.bind(mainMod .. " + CTRL + 8", hl.dsp.window.move({ workspace = 8, follow = false }))
hl.bind(mainMod .. " + CTRL + 9", hl.dsp.window.move({ workspace = 9, follow = false }))

hl.bind(mainMod .. " + 0", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())
hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 30, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -30, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -30, relative = true }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 30, relative = true }))

-- Misc
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-------------------------------
---- WINDOWS AND WORKSPACES ---
-------------------------------

hl.window_rule({
	name = "game-windows-options",
	match = {
		class = "steam_app.*",
	},
	-- match:title = Minecraft.*
	fullscreen = true,
	immediate = true,
})

hl.window_rule({
	name = "suppress-maximize-events",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})
