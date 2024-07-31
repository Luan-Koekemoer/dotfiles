local AwesomeWMColourPalette = {}
function AwesomeWMColourPalette:new(o, text_primary, text_secondary, text_focus, text_contrast, window_primary, window_secondary, window_alternative, taskbar_primary, taskbar_active, taskbar_inactive, taskbar_alert)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.text = {
    primary = text_primary,
    secondary = text_secondary,
    focus = text_focus,
    contrast = text_contrast,
  }
  self.window = {
    primary = window_primary,
    secondary = window_secondary,
    alternative = window_alternative,
  }
  self.taskbar = {
    primary = taskbar_primary,
    active = taskbar_active,
    inactive = taskbar_inactive,
    alert = taskbar_alert
  }
  return o
end

Sunrise = AwesomeWMColourPalette:new(
  nil,
  "#FFFFFF",
  "#FFFFFF",
  "#FFFFFF",
  "#FFFFFF",

  "#FFBB5C",
  "#FF9B50",
  "#FF6000",

  "#C63D2F",
  "#161616",
  "#454545",
  "#FF6000"
)

return {Sunrise = Sunrise}
