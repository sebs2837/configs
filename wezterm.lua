local wezterm = require 'wezterm'
local act = wezterm.action
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

local HALF_CIRCLE_RIGHT = wezterm.nerdfonts.ple_right_half_circle_thick
local HALF_CIRCLE_LEFT = wezterm.nerdfonts.ple_left_half_circle_thick

local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end

wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        local edge_background = '#2E3440'
        local background = '#2E3440'
        local foreground = '#D8DEE9'

        if tab.is_active then
            foreground = '#2b2042'
            background = '#A3BE8C'
        elseif hover then
            background = '#81A1C1'
            foreground = '#2b2042'
        end

        local edge_foreground = background

        local title = tab_title(tab)

        -- ensure that the titles fit in the available space,
        -- and that we have room for the edges.
        title = wezterm.truncate_right(title, max_width - 2)

        return {
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = HALF_CIRCLE_LEFT },
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = title },
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = HALF_CIRCLE_RIGHT },
        }
    end
)


config = {
    color_scheme              = 'nord',
    enable_scroll_bar         = true,
    min_scroll_bar_height = '2cell',
    font                      = wezterm.font_with_fallback({
        { family = "CaskaydiaCove Nerd Font", scale = 1.3 },
        { family = "JetBrainsMono Nerd Font", scale = 1.2 },
        { family = "SauceCodePro Nerd Font",  scale = 1.2 },
    }),
    window_background_opacity = 1.0,
    window_decorations        = "RESIZE",
    scrollback_lines          = 3000,
    default_workspace         = 'code',

    inactive_pane_hsb         = {
        saturation = 0.24,
        brightness = 0.5,
    },
    use_fancy_tab_bar         = false,
    window_frame              = {
        active_titlebar_bg = '#2E3440',
        inactive_titlebar_bg = '#2E3440',
    },
    tab_bar_at_bottom         = true,
    colors                    = {
        tab_bar = {
            -- The color of the inactive tab bar edge/divider
            inactive_tab_edge = '#575757',
            background = '#2E3440',
            active_tab = {
                -- The color of the background area for the tab
                bg_color = '#2E3440',
                -- The color of the text for the tab
                fg_color = '#D8DEE9',

                -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
                -- label shown for this tab.
                -- The default is "Normal"
                intensity = 'Bold',

                -- Specify whether you want "None", "Single" or "Double" underline for
                -- label shown for this tab.
                -- The default is "None"
                underline = 'None',

                -- Specify whether you want the text to be italic (true) or not (false)
                -- for this tab.  The default is false.
                italic = false,

                -- Specify whether you want the text to be rendered with strikethrough (true)
                -- or not for this tab.  The default is false.
                strikethrough = false,
            },
            inactive_tab = {
                bg_color = '#1b1032',
                fg_color = '#808080',
                intensity = 'Half'

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over inactive tabs
            inactive_tab_hover = {
                bg_color = '#3b3052',
                fg_color = '#909090',
                italic = true,

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab_hover`.
            },

            -- The new tab button that let you create new tabs
            new_tab = {
                bg_color = '#3B4252',
                fg_color = '#ECEFF4',
                intensity = 'Half',

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over the new tab button
            new_tab_hover = {
                bg_color = '#3B4252',
                fg_color = '#ECEFF4',
                intensity = 'Bold',
                italic = true,

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab_hover`.
            },
        },
    },

    leader                    = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 },
    keys                      = {
        {
            key = '|',
            mods = 'LEADER|SHIFT',
            action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
            key = '-',
            mods = 'LEADER',
            action = act.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
            key = 'h',
            mods = 'LEADER',
            action = act.ActivatePaneDirection "Left",
        },
        {
            key = 'l',
            mods = 'LEADER',
            action = act.ActivatePaneDirection "Right",
        },
        {
            key = 'j',
            mods = 'LEADER',
            action = act.ActivatePaneDirection "Down",
        },
        {
            key = 'k',
            mods = 'LEADER',
            action = act.ActivatePaneDirection "Up",
        },
        {
            key = 'x',
            mods = 'LEADER',
            action = act.CloseCurrentPane { confirm = true },
        },
        {
            key = 'z',
            mods = 'LEADER',
            action = act.TogglePaneZoomState,
        },
        {
            key = 'l',
            mods = 'LEADER|SHIFT',
            action = act.RotatePanes "Clockwise",
        },
        {
            key = 'p',
            mods = 'LEADER',
            action = act.ActivateCommandPalette,
        },
        {
            key = '[',
            mods = 'CTRL',
            action = act.ActivateTabRelative(-1),
        },
        {
            key = ']',
            mods = 'CTRL',
            action = act.ActivateTabRelative(1),
        },
        {
            key = 't',
            mods = 'LEADER',
            action = wezterm.action.ShowTabNavigator,
        },
        { key = 't', mods = 'SUPER', action = act.SpawnTab 'DefaultDomain' },
        {
            key = 'T',
            mods = 'LEADER',
            action = act.SpawnTab 'CurrentPaneDomain',
        },
    },
}

return config
