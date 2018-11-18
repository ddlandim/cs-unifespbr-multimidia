import xbmcaddon
import xbmcgui
 
addon       = xbmcaddon.Addon()
addonname   = addon.getAddonInfo('name')
 
line1 = "SEMINÁRIO - KODI"
line2 = "MULTIMIDIA"
line3 = "EM PYTHON"
 
xbmcgui.Dialog().ok(addonname, line1, line2, line3)
