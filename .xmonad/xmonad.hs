import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.EZConfig(additionalMouseBindings)
import XMonad.Actions.CycleWS
import XMonad.Hooks.ICCCMFocus
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid
import XMonad.Layout.LayoutCombinators hiding ((|||))
import XMonad.Layout.NoBorders (smartBorders)
import System.IO
import qualified XMonad.StackSet as W

myWorkspaces    = map show [1..9]

myModMask = mod4Mask

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    --, className =? "Stardict"       --> doFloat
    --, className =? "Sonata"         --> doFloat
    , resource  =? "sonatina"         --> doFloat
    --, className =? "Gimp-2.6"       --> doFloat
--    , className =? "Opera"          --> doShift "1"
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "xfdesktop"      --> doIgnore
--    , resource  =? "xfce4-panel"    --> doIgnore
    , resource  =? "xfce4-notifyd"  --> doIgnore
    , className =? "glxgears"       --> doFloat
    , className =? "openjk.x86_64"  --> doFloat
    , className =? "openjk_sp.x86_64" --> doFloat
--    , resource  =? "tint2"          --> doIgnore
    ]

defaultLayout = Tall 1 (3/100) (1/2)

main = do
  xmonad .docks . ewmh $ defaultConfig
    {
      workspaces = myWorkspaces,
      modMask = myModMask,
      --numlockMask = mod2Mask,
 
      terminal = "urxvt",
 
      borderWidth = 2,
      normalBorderColor = "#dddddd",
      focusedBorderColor = "#88aaff",

      focusFollowsMouse = False,
 
      --layoutHook = avoidStruts $ layoutHook defaultConfig,
      layoutHook = avoidStruts . smartBorders $ defaultLayout ||| Mirror defaultLayout ||| Full ||| ThreeCol 1 (3/100) (1/2) ||| GridRatio (4/3),
      --manageHook = manageHook defaultConfig <+> manageDocks
      manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig,
      --logHook = takeTopFocus,

      --startupHook = setWMName "LG3D"

      --logHook = takeTopFocus

      logHook = ewmhDesktopsLogHook >> setWMName "LG3D" -- java workarou

      --logHook            = takeTopFocus >> setWMName "LG3D" -- fix java Bug
 
    } `additionalKeys` (
    -- [ ((myModMask .|. shiftMask, xK_z), spawn "xscreensaver-command --lock"),
    [ ((myModMask .|. shiftMask, xK_z), spawn "xautolock -locknow"),
      --((myModMask,               xK_p     ), spawn "exe=`dmenu_run | dmenu` && eval \"exec $exe\""),
      ((myModMask,               xK_p     ), spawn "dmenu_run -fn 'xos4 Terminus-24'"),
      ((myModMask .|. shiftMask, xK_p     ), spawn "gmrun"),
      ((myModMask,               xK_b     ), spawn "xombrero"),
      ((myModMask,               xK_f     ), spawn "thunar"),
      ((myModMask,               xK_s     ), spawn "sonatina"),
      ((myModMask,               xK_m     ), spawn "evolution"),
      ((myModMask,               xK_d     ), spawn "xfce4-dict"),

      --((myModMask .|. shiftMask, xK_a     ), spawn "/home/kuba/.screenlayout/extern.sh"),
      --((myModMask .|. shiftMask, xK_s     ), spawn "/home/kuba/.screenlayout/doma.sh"),
      --((myModMask .|. shiftMask, xK_d     ), spawn "/home/kuba/.screenlayout/default.sh"),
      ((myModMask .|. shiftMask, xK_s     ), spawn "/home/kuba/bin/screenshot.sh"),

      ((myModMask , xK_Left  ), prevWS ),
      ((myModMask , xK_Right ), nextWS ),
      ((myModMask .|. shiftMask, xK_Left  ), shiftToPrev),     
      ((myModMask .|. shiftMask, xK_Right ), shiftToNext),
      ((myModMask,               xK_Escape), windows W.focusDown)
    ]
    ++
    [
     ((m .|. myModMask, k), windows $ f i)
       | (i, k) <- zip (myWorkspaces) [xK_1..xK_9] -- %! Switch to workspace N
       , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]  -- %! Move client to workspace N
    ]
    ++
    [
     ((m .|. myModMask, k), screenWorkspace sc >>= flip whenJust (windows . f))
       | (k, sc) <- zip [xK_w, xK_e, xK_r] [0,1,2]
       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]
     ) `additionalMouseBindings`
    [
      ((myModMask, button4), (\w -> focus w >> sendMessage Shrink)),
      ((myModMask, button5), (\w -> focus w >> sendMessage Expand))
    ]
