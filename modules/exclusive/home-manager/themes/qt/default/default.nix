{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;

  in ''
[%General]
author=Tsu Jan
comment=A theme inspired by Enlightenment
comment[eo]=Etoso inspirita de Enlightenment
respect_DE=true
x11drag=true
alt_mnemonic=true
left_tabs=false
joined_inactive_tabs=true
attach_active_tab=false
group_toolbar_buttons=false
composite=true
menu_shadow_depth=6
tooltip_shadow_depth=6
splitter_width=7
scroll_width=12
slider_width=8
slider_handle_width=16
slider_handle_length=16
opaque=kaffeine,kmplayer,subtitlecomposer,kdenlive,vlc,smplayer,smplayer2,avidemux,avidemux2_qt4,avidemux3_qt4,avidemux3_qt5,kamoso,QtCreator,VirtualBox,VirtualBoxVM,trojita,dragon,digikam,lyx

[GeneralColors]
window.color=#${colors.base02}
base.color=#${colors.base02}
alt.base.color=#${colors.base02}
button.color=#${colors.base0E}
light.color=#${colors.base02}
mid.light.color=#${colors.base03}
dark.color=#${colors.base01}
mid.color=#${colors.base00}
highlight.color=#${colors.base03}
inactive.highlight.color=#${colors.base03}
tooltip.base.color=#${colors.base01}
text.color=#${colors.base05}
window.text.color=#${colors.base05}
button.text.color=#${colors.base05}
disabled.text.color=#${colors.base04}
tooltip.text.color=#${colors.base05}
highlight.text.color=#${colors.base05}
link.color=#${colors.base0E}
link.visited.color=#FF6666

[Hacks]
respect_darkness=true

[PanelButtonCommand]
frame=true
frame.element=button
frame.top=3
frame.bottom=3
frame.left=3
frame.right=3
interior=true
interior.element=button
indicator.size=9
text.normal.color=#${colors.base05}
text.focus.color=#80C0FF
text.press.color=#${colors.base05}
text.toggle.color=#${colors.base05}
text.shadow=false
text.margin=1
text.iconspacing=4
indicator.element=arrow
text.margin.top=3
text.margin.bottom=3
text.margin.left=4
text.margin.right=4
text.shadow.xshift=1
text.shadow.yshift=1
text.shadow.color=#000000
text.shadow.alpha=255
text.shadow.depth=1

[PanelButtonTool]
inherits=PanelButtonCommand

[Dock]
inherits=PanelButtonCommand
frame=false
interior=false

[DockTitle]
inherits=PanelButtonCommand
frame=false
interior=true
interior.element=dock
text.focus.color=#${colors.base05}
text.bold=true
text.margin.top=2
text.margin.bottom=2
text.margin.left=3
text.margin.right=3

[IndicatorSpinBox]
inherits=PanelButtonCommand
indicator.element=arrow
frame.element=spin
interior.element=spin
frame.top=3
frame.bottom=3
frame.left=3
frame.right=3
indicator.size=9

[RadioButton]
inherits=PanelButtonCommand
interior.element=radio
text.margin.top=2
text.margin.bottom=2
text.margin.left=3
text.margin.right=3

[CheckBox]
inherits=PanelButtonCommand
interior.element=checkbox
text.margin.top=2
text.margin.bottom=2
text.margin.left=3
text.margin.right=3

[Focus]
inherits=PanelButtonCommand
interior=false
frame=true
frame.element=focus
frame.top=1
frame.bottom=1
frame.left=1
frame.right=1
frame.patternsize=20

[GenericFrame]
inherits=PanelButtonCommand
frame=true
interior=false
frame.element=common
interior.element=common

[LineEdit]
inherits=PanelButtonCommand
frame.element=lineedit
interior.element=lineedit

[DropDownButton]
inherits=PanelButtonCommand
indicator.element=arrow-down

[IndicatorArrow]
indicator.element=arrow
indicator.size=9

[ToolboxTab]
inherits=PanelButtonCommand

[Tab]
inherits=PanelButtonCommand
interior.element=tab
text.margin.left=8
text.margin.right=8
frame.element=tab
indicator.element=tab
frame.top=2
frame.bottom=2
frame.left=2
frame.right=2

[TabFrame]
inherits=PanelButtonCommand
frame.element=tabframe
interior.element=common

[TreeExpander]
inherits=PanelButtonCommand
frame=false
interior=false
indicator.size=9

[HeaderSection]
inherits=PanelButtonCommand

[SizeGrip]
indicator.element=sizegrip

[Toolbar]
inherits=PanelButtonCommand
indicator.element=toolbar
indicator.size=5
frame.element=toolbar
interior.element=toolbar

[Slider]
inherits=PanelButtonCommand
frame.element=slider
interior.element=slider
frame.top=2
frame.bottom=2
frame.left=2
frame.right=2

[SliderCursor]
inherits=PanelButtonCommand
frame=false
interior.element=slidercursor

[Progressbar]
inherits=PanelButtonCommand
frame.element=progress
interior.element=progress
frame.top=2
frame.bottom=2
frame.left=2
frame.right=2
text.focus.color=#${colors.base05}
text.bold=true

[ProgressbarContents]
inherits=PanelButtonCommand
frame=false
interior.element=progress-pattern

[ItemView]
inherits=PanelButtonCommand
text.margin=0
frame.element=itemview
interior.element=itemview
frame.top=2
frame.bottom=2
frame.left=2
frame.right=2

[Splitter]
inherits=PanelButtonCommand
interior.element=splitter
frame.element=splitter
frame.top=0
frame.bottom=0
frame.left=1
frame.right=1
indicator.element=splitter-grip
indicator.size=16

[Scrollbar]
inherits=PanelButtonCommand
indicator.size=8

[ScrollbarSlider]
inherits=PanelButtonCommand
frame.element=scrollbarslider
interior.element=scrollbarslider
frame.top=2
frame.bottom=2
frame.left=2
frame.right=2
indicator.element=grip
indicator.size=13

[ScrollbarGroove]
inherits=PanelButtonCommand
interior.element=slider
frame.element=slider
frame.top=0
frame.bottom=0
frame.left=4
frame.right=4

[MenuItem]
inherits=PanelButtonCommand
frame=false
interior.element=menuitem
indicator.element=menuitem
min_height=22
text.focus.color=#${colors.base00}
text.margin.top=2
text.margin.bottom=2
text.margin.left=3
text.margin.right=3

[MenuBarItem]
inherits=PanelButtonCommand
interior.element=menubaritem
frame.element=menubaritem
frame.top=2
frame.bottom=2
frame.left=2
frame.right=2
text.margin.top=2
text.margin.bottom=2

[MenuBar]
inherits=PanelButtonCommand
frame.top=0
frame.bottom=0
frame.left=2
frame.right=2
frame.element=menuitem
interior.element=menuitem

[TitleBar]
inherits=PanelButtonCommand
frame=false
interior.element=titlebar
indicator.size=12
indicator.element=mdi
text.normal.color=#${colors.base01}
text.focus.color=#${colors.base05}
text.margin.top=2
text.margin.bottom=2
text.margin.left=3
text.margin.right=3

[ComboBox]
inherits=PanelButtonCommand

[Menu]
inherits=PanelButtonCommand
frame.top=3
frame.bottom=3
frame.left=3
frame.right=3
frame.element=menu
interior.element=menu

[GroupBox]
inherits=GenericFrame
frame=true
frame.element=group
interior=true
interior.element=group
text.shadow=false
text.margin=0
frame.top=3
frame.bottom=3
frame.left=3
frame.right=3

[TabBarFrame]
inherits=GenericFrame
frame=false
interior=false
text.shadow=false

[ToolTip]
inherits=GenericFrame
frame.top=3
frame.bottom=3
frame.left=3
frame.right=3
interior=true
text.shadow=false
text.margin=0
interior.element=tooltip
frame.element=tooltip

[Window]
interior=false
''