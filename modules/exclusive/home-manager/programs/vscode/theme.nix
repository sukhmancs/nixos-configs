{
  linkFarm,
  pkgs,
  lib,
}: {
  base00,
  base01,
  base02,
  base03,
  base04,
  base05,
  base06,
  base07,
  base08,
  base09,
  base0A,
  base0B,
  base0C,
  base0D,
  base0E,
  base0F,
  scheme,
  author,
}: let
  pname = "theme";
  publisher = "Xi";
  version = "0.0.0"; # Define the version of your extension

  vscodeExtName = "${publisher}.${pname}";
  vscodeExtUniqueId = "${publisher}.${pname}";
  vscodeExtPublisher = "${publisher}";

  theme = {
    "theme/generated.json" = __toJSON {
      name = "${publisher}'s ${pname}";
      type = "dark";
      "$schema" = "vscode://schemas/color-theme";
      colors = {
        "focusBorder" = "#${base0E}";
        "foreground" = "#${base05}";
        "disabledForeground" = "#a6adc8";
        "widget.shadow" = "#${base01}80";
        "selection.background" = "#${base0E}66";
        "descriptionForeground" = "#${base05}";
        "errorForeground" = "#${base08}";
        "icon.foreground" = "#${base0E}";
        "sash.hoverBorder" = "#${base0E}";
        "window.activeBorder" = "#00000000";
        "window.inactiveBorder" = "#00000000";
        "textBlockQuote.background" = "#${base01}";
        "textBlockQuote.border" = "#${base01}";
        "textCodeBlock.background" = "#${base00}";
        "textLink.activeForeground" = "#${base0C}";
        "textLink.foreground" = "#${base0D}";
        "textPreformat.foreground" = "#${base05}";
        "textSeparator.foreground" = "#${base0E}";
        "activityBar.background" = "#${base01}";
        "activityBar.foreground" = "#${base0E}";
        "activityBar.dropBorder" = "#${base0E}33";
        "activityBar.inactiveForeground" = "#6c7086";
        "activityBar.border" = "#00000000";
        "activityBarBadge.background" = "#${base0E}";
        "activityBarBadge.foreground" = "#${base01}";
        "activityBar.activeBorder" = "#00000000";
        "activityBar.activeBackground" = "#00000000";
        "activityBar.activeFocusBorder" = "#00000000";
        "activityBarTop.foreground" = "#${base0E}";
        "activityBarTop.activeBorder" = "#00000000";
        "activityBarTop.inactiveForeground" = "#6c7086";
        "activityBarTop.dropBorder" = "#${base0E}33";
        "badge.background" = "#${base03}";
        "badge.foreground" = "#${base05}";
        "breadcrumb.activeSelectionForeground" = "#${base0E}";
        "breadcrumb.background" = "#${base00}";
        "breadcrumb.focusForeground" = "#${base0E}";
        "breadcrumb.foreground" = "#${base05}cc";
        "breadcrumbPicker.background" = "#${base01}";
        "button.background" = "#${base0E}";
        "button.foreground" = "#${base01}";
        "button.border" = "#00000000";
        "button.separator" = "#00000000";
        "button.hoverBackground" = "#${base0E}";
        "button.secondaryForeground" = "#${base05}";
        "button.secondaryBackground" = "#${base04}";
        "button.secondaryHoverBackground" = "#686b84";
        "checkbox.background" = "#${base03}";
        "checkbox.border" = "#00000000";
        "checkbox.foreground" = "#${base0E}";
        "dropdown.background" = "#${base01}";
        "dropdown.listBackground" = "#${base04}";
        "dropdown.border" = "#${base0E}";
        "dropdown.foreground" = "#${base05}";
        "debugToolBar.background" = "#${base01}";
        "debugToolBar.border" = "#00000000";
        "debugExceptionWidget.background" = "#${base01}";
        "debugExceptionWidget.border" = "#${base0E}";
        "debugTokenExpression.number" = "#${base09}";
        "debugTokenExpression.boolean" = "#${base0E}";
        "debugTokenExpression.string" = "#${base0B}";
        "debugTokenExpression.error" = "#${base08}";
        "debugIcon.breakpointForeground" = "#${base08}";
        "debugIcon.breakpointDisabledForeground" = "#${base08}99";
        "debugIcon.breakpointUnverifiedForeground" = "#a6738c";
        "debugIcon.breakpointCurrentStackframeForeground" = "#${base04}";
        "debugIcon.breakpointStackframeForeground" = "#${base04}";
        "debugIcon.startForeground" = "#${base0B}";
        "debugIcon.pauseForeground" = "#${base0D}";
        "debugIcon.stopForeground" = "#${base08}";
        "debugIcon.disconnectForeground" = "#${base04}";
        "debugIcon.restartForeground" = "#${base0C}";
        "debugIcon.stepOverForeground" = "#${base0E}";
        "debugIcon.stepIntoForeground" = "#${base05}";
        "debugIcon.stepOutForeground" = "#${base05}";
        "debugIcon.continueForeground" = "#${base0B}";
        "debugIcon.stepBackForeground" = "#${base04}";
        "debugConsole.infoForeground" = "#${base0D}";
        "debugConsole.warningForeground" = "#${base09}";
        "debugConsole.errorForeground" = "#${base08}";
        "debugConsole.sourceForeground" = "#${base0F}";
        "debugConsoleInputIcon.foreground" = "#${base05}";
        "diffEditor.border" = "#${base04}";
        "diffEditor.insertedTextBackground" = "#${base0B}1a";
        "diffEditor.removedTextBackground" = "#${base08}1a";
        "diffEditor.insertedLineBackground" = "#${base0B}26";
        "diffEditor.removedLineBackground" = "#${base08}26";
        "diffEditor.diagonalFill" = "#${base04}99";
        "diffEditorOverview.insertedForeground" = "#${base0B}cc";
        "diffEditorOverview.removedForeground" = "#${base08}cc";
        "editor.background" = "#${base00}";
        "editor.findMatchBackground" = "#5e3f53";
        "editor.findMatchBorder" = "#${base08}33";
        "editor.findMatchHighlightBackground" = "#3e5767";
        "editor.findMatchHighlightBorder" = "#${base0C}33";
        "editor.findRangeHighlightBackground" = "#3e5767";
        "editor.findRangeHighlightBorder" = "#${base0C}33";
        "editor.foldBackground" = "#${base0C}40";
        "editor.foreground" = "#${base05}";
        "editor.hoverHighlightBackground" = "#${base0C}40";
        "editor.lineHighlightBackground" = "#${base05}12";
        "editor.lineHighlightBorder" = "#00000000";
        "editor.rangeHighlightBackground" = "#${base0C}40";
        "editor.rangeHighlightBorder" = "#00000000";
        "editor.selectionBackground" = "#9399b240";
        "editor.selectionHighlightBackground" = "#9399b233";
        "editor.selectionHighlightBorder" = "#9399b233";
        "editor.wordHighlightBackground" = "#9399b233";
        "editorBracketMatch.background" = "#9399b21a";
        "editorBracketMatch.border" = "#9399b2";
        "editorCodeLens.foreground" = "#7f849c";
        "editorCursor.background" = "#${base00}";
        "editorCursor.foreground" = "#${base0F}";
        "editorGroup.border" = "#${base04}";
        "editorGroup.dropBackground" = "#${base0E}33";
        "editorGroup.emptyBackground" = "#${base00}";
        "editorGroupHeader.tabsBackground" = "#${base01}";
        "editorGutter.addedBackground" = "#${base0B}";
        "editorGutter.background" = "#${base00}";
        "editorGutter.commentRangeForeground" = "#${base02}";
        "editorGutter.commentGlyphForeground" = "#${base0E}";
        "editorGutter.deletedBackground" = "#${base08}";
        "editorGutter.foldingControlForeground" = "#9399b2";
        "editorGutter.modifiedBackground" = "#${base0A}";
        "editorHoverWidget.background" = "#${base01}";
        "editorHoverWidget.border" = "#${base04}";
        "editorHoverWidget.foreground" = "#${base05}";
        "editorIndentGuide.activeBackground" = "#${base04}";
        "editorIndentGuide.background" = "#${base03}";
        "editorInlayHint.foreground" = "#${base04}";
        "editorInlayHint.background" = "#${base01}bf";
        "editorInlayHint.typeForeground" = "#bac2de";
        "editorInlayHint.typeBackground" = "#${base01}bf";
        "editorInlayHint.parameterForeground" = "#a6adc8";
        "editorInlayHint.parameterBackground" = "#${base01}bf";
        "editorLineNumber.activeForeground" = "#${base0E}";
        "editorLineNumber.foreground" = "#7f849c";
        "editorLink.activeForeground" = "#${base0E}";
        "editorMarkerNavigation.background" = "#${base01}";
        "editorMarkerNavigationError.background" = "#${base08}";
        "editorMarkerNavigationInfo.background" = "#${base0D}";
        "editorMarkerNavigationWarning.background" = "#${base09}";
        "editorOverviewRuler.background" = "#${base01}";
        "editorOverviewRuler.border" = "#${base05}12";
        "editorOverviewRuler.modifiedForeground" = "#${base0A}";
        "editorRuler.foreground" = "#${base04}";
        "editor.stackFrameHighlightBackground" = "#${base0A}26";
        "editor.focusedStackFrameHighlightBackground" = "#${base0B}26";
        "editorStickyScrollHover.background" = "#${base02}";
        "editorSuggestWidget.background" = "#${base01}";
        "editorSuggestWidget.border" = "#${base04}";
        "editorSuggestWidget.foreground" = "#${base05}";
        "editorSuggestWidget.highlightForeground" = "#${base0E}";
        "editorSuggestWidget.selectedBackground" = "#${base02}";
        "editorWhitespace.foreground" = "#9399b266";
        "editorWidget.background" = "#${base01}";
        "editorWidget.foreground" = "#${base05}";
        "editorWidget.resizeBorder" = "#${base04}";
        "editorLightBulb.foreground" = "#${base0A}";
        "editorError.foreground" = "#${base08}";
        "editorError.border" = "#00000000";
        "editorError.background" = "#00000000";
        "editorWarning.foreground" = "#${base09}";
        "editorWarning.border" = "#00000000";
        "editorWarning.background" = "#00000000";
        "editorInfo.foreground" = "#${base0D}";
        "editorInfo.border" = "#00000000";
        "editorInfo.background" = "#00000000";
        "problemsErrorIcon.foreground" = "#${base08}";
        "problemsInfoIcon.foreground" = "#${base0D}";
        "problemsWarningIcon.foreground" = "#${base09}";
        "extensionButton.prominentForeground" = "#${base01}";
        "extensionButton.prominentBackground" = "#${base0E}";
        "extensionButton.separator" = "#${base00}";
        "extensionButton.prominentHoverBackground" = "#${base0E}";
        "extensionBadge.remoteBackground" = "#${base0D}";
        "extensionBadge.remoteForeground" = "#${base01}";
        "extensionIcon.starForeground" = "#${base0A}";
        "extensionIcon.verifiedForeground" = "#${base0B}";
        "extensionIcon.preReleaseForeground" = "#${base04}";
        "extensionIcon.sponsorForeground" = "#${base0F}";
        "gitDecoration.addedResourceForeground" = "#${base0B}";
        "gitDecoration.conflictingResourceForeground" = "#${base0E}";
        "gitDecoration.deletedResourceForeground" = "#${base08}";
        "gitDecoration.ignoredResourceForeground" = "#6c7086";
        "gitDecoration.modifiedResourceForeground" = "#${base0A}";
        "gitDecoration.stageDeletedResourceForeground" = "#${base08}";
        "gitDecoration.stageModifiedResourceForeground" = "#${base0A}";
        "gitDecoration.submoduleResourceForeground" = "#${base0D}";
        "gitDecoration.untrackedResourceForeground" = "#${base0B}";
        "input.background" = "#${base02}";
        "input.border" = "#00000000";
        "input.foreground" = "#${base05}";
        "input.placeholderForeground" = "#${base05}73";
        "inputOption.activeBackground" = "#${base04}";
        "inputOption.activeBorder" = "#${base0E}";
        "inputOption.activeForeground" = "#${base05}";
        "inputValidation.errorBackground" = "#${base08}";
        "inputValidation.errorBorder" = "#${base01}33";
        "inputValidation.errorForeground" = "#${base01}";
        "inputValidation.infoBackground" = "#${base0D}";
        "inputValidation.infoBorder" = "#${base01}33";
        "inputValidation.infoForeground" = "#${base01}";
        "inputValidation.warningBackground" = "#${base09}";
        "inputValidation.warningBorder" = "#${base01}33";
        "inputValidation.warningForeground" = "#${base01}";
        "list.activeSelectionBackground" = "#${base02}";
        "list.activeSelectionForeground" = "#${base05}";
        "list.dropBackground" = "#${base0E}33";
        "list.focusBackground" = "#${base02}";
        "list.focusForeground" = "#${base05}";
        "list.focusOutline" = "#00000000";
        "list.highlightForeground" = "#${base0E}";
        "list.hoverBackground" = "#${base02}80";
        "list.hoverForeground" = "#${base05}";
        "list.inactiveSelectionBackground" = "#${base02}";
        "list.inactiveSelectionForeground" = "#${base05}";
        "list.warningForeground" = "#${base09}";
        "listFilterWidget.background" = "#${base03}";
        "listFilterWidget.noMatchesOutline" = "#${base08}";
        "listFilterWidget.outline" = "#00000000";
        "tree.indentGuidesStroke" = "#9399b2";
        "tree.inactiveIndentGuidesStroke" = "#${base03}";
        "menu.background" = "#${base00}";
        "menu.border" = "#${base00}80";
        "menu.foreground" = "#${base05}";
        "menu.selectionBackground" = "#${base04}";
        "menu.selectionBorder" = "#00000000";
        "menu.selectionForeground" = "#${base05}";
        "menu.separatorBackground" = "#${base04}";
        "menubar.selectionBackground" = "#${base03}";
        "menubar.selectionForeground" = "#${base05}";
        "merge.commonContentBackground" = "#${base03}";
        "merge.commonHeaderBackground" = "#${base04}";
        "merge.currentContentBackground" = "#${base0B}33";
        "merge.currentHeaderBackground" = "#${base0B}66";
        "merge.incomingContentBackground" = "#${base0D}33";
        "merge.incomingHeaderBackground" = "#${base0D}66";
        "minimap.background" = "#${base01}80";
        "minimap.findMatchHighlight" = "#${base0C}4d";
        "minimap.selectionHighlight" = "#${base04}bf";
        "minimap.selectionOccurrenceHighlight" = "#${base04}bf";
        "minimap.warningHighlight" = "#${base09}bf";
        "minimap.errorHighlight" = "#${base08}bf";
        "minimapSlider.background" = "#${base0E}33";
        "minimapSlider.hoverBackground" = "#${base0E}66";
        "minimapSlider.activeBackground" = "#${base0E}99";
        "minimapGutter.addedBackground" = "#${base0B}bf";
        "minimapGutter.deletedBackground" = "#${base08}bf";
        "minimapGutter.modifiedBackground" = "#${base0A}bf";
        "notificationCenter.border" = "#${base0E}";
        "notificationCenterHeader.foreground" = "#${base05}";
        "notificationCenterHeader.background" = "#${base01}";
        "notificationToast.border" = "#${base0E}";
        "notifications.foreground" = "#${base05}";
        "notifications.background" = "#${base01}";
        "notifications.border" = "#${base0E}";
        "notificationLink.foreground" = "#${base0D}";
        "notificationsErrorIcon.foreground" = "#${base08}";
        "notificationsWarningIcon.foreground" = "#${base09}";
        "notificationsInfoIcon.foreground" = "#${base0D}";
        "panel.background" = "#${base00}";
        "panel.border" = "#${base04}";
        "panelSection.border" = "#${base04}";
        "panelSection.dropBackground" = "#${base0E}33";
        "panelTitle.activeBorder" = "#${base0E}";
        "panelTitle.activeForeground" = "#${base05}";
        "panelTitle.inactiveForeground" = "#a6adc8";
        "peekView.border" = "#${base0E}";
        "peekViewEditor.background" = "#${base01}";
        "peekViewEditorGutter.background" = "#${base01}";
        "peekViewEditor.matchHighlightBackground" = "#${base0C}4d";
        "peekViewEditor.matchHighlightBorder" = "#00000000";
        "peekViewResult.background" = "#${base01}";
        "peekViewResult.fileForeground" = "#${base05}";
        "peekViewResult.lineForeground" = "#${base05}";
        "peekViewResult.matchHighlightBackground" = "#${base0C}4d";
        "peekViewResult.selectionBackground" = "#${base02}";
        "peekViewResult.selectionForeground" = "#${base05}";
        "peekViewTitle.background" = "#${base00}";
        "peekViewTitleDescription.foreground" = "#bac2deb3";
        "peekViewTitleLabel.foreground" = "#${base05}";
        "pickerGroup.border" = "#${base0E}";
        "pickerGroup.foreground" = "#${base0E}";
        "progressBar.background" = "#${base0E}";
        "scrollbar.shadow" = "#${base01}";
        "scrollbarSlider.activeBackground" = "#${base02}66";
        "scrollbarSlider.background" = "#${base04}80";
        "scrollbarSlider.hoverBackground" = "#6c7086";
        "settings.focusedRowBackground" = "#${base04}33";
        "settings.headerForeground" = "#${base05}";
        "settings.modifiedItemIndicator" = "#${base0E}";
        "settings.dropdownBackground" = "#${base03}";
        "settings.dropdownListBorder" = "#00000000";
        "settings.textInputBackground" = "#${base03}";
        "settings.textInputBorder" = "#00000000";
        "settings.numberInputBackground" = "#${base03}";
        "settings.numberInputBorder" = "#00000000";
        "sideBar.background" = "#${base01}";
        "sideBar.dropBackground" = "#${base0E}33";
        "sideBar.foreground" = "#${base05}";
        "sideBar.border" = "#00000000";
        "sideBarSectionHeader.background" = "#${base01}";
        "sideBarSectionHeader.foreground" = "#${base05}";
        "sideBarTitle.foreground" = "#${base0E}";
        "banner.background" = "#${base03}";
        "banner.foreground" = "#${base05}";
        "banner.iconForeground" = "#${base05}";
        "statusBar.background" = "#${base01}";
        "statusBar.foreground" = "#${base05}";
        "statusBar.border" = "#00000000";
        "statusBar.noFolderBackground" = "#${base01}";
        "statusBar.noFolderForeground" = "#${base05}";
        "statusBar.noFolderBorder" = "#00000000";
        "statusBar.debuggingBackground" = "#${base09}";
        "statusBar.debuggingForeground" = "#${base01}";
        "statusBar.debuggingBorder" = "#00000000";
        "statusBarItem.remoteBackground" = "#${base0D}";
        "statusBarItem.remoteForeground" = "#${base01}";
        "statusBarItem.activeBackground" = "#${base04}66";
        "statusBarItem.hoverBackground" = "#${base04}33";
        "statusBarItem.prominentForeground" = "#${base0E}";
        "statusBarItem.prominentBackground" = "#00000000";
        "statusBarItem.prominentHoverBackground" = "#${base04}33";
        "statusBarItem.errorForeground" = "#${base08}";
        "statusBarItem.errorBackground" = "#00000000";
        "statusBarItem.warningForeground" = "#${base09}";
        "statusBarItem.warningBackground" = "#00000000";
        "commandCenter.foreground" = "#bac2de";
        "commandCenter.inactiveForeground" = "#bac2de";
        "commandCenter.activeForeground" = "#${base0E}";
        "commandCenter.background" = "#${base01}";
        "commandCenter.activeBackground" = "#${base04}33";
        "commandCenter.border" = "#00000000";
        "commandCenter.inactiveBorder" = "#00000000";
        "commandCenter.activeBorder" = "#${base0E}";
        "tab.activeBackground" = "#${base00}";
        "tab.activeBorder" = "#00000000";
        "tab.activeBorderTop" = "#${base0E}";
        "tab.activeForeground" = "#${base0E}";
        "tab.activeModifiedBorder" = "#${base0A}";
        "tab.border" = "#${base01}";
        "tab.hoverBackground" = "#28283d";
        "tab.hoverBorder" = "#00000000";
        "tab.hoverForeground" = "#${base0E}";
        "tab.inactiveBackground" = "#${base01}";
        "tab.inactiveForeground" = "#6c7086";
        "tab.inactiveModifiedBorder" = "#${base0A}4d";
        "tab.lastPinnedBorder" = "#${base0E}";
        "tab.unfocusedActiveBackground" = "#${base01}";
        "tab.unfocusedActiveBorder" = "#00000000";
        "tab.unfocusedActiveBorderTop" = "#${base0E}4d";
        "tab.unfocusedInactiveBackground" = "#0e0e16";
        "terminal.foreground" = "#${base05}";
        "terminal.ansiBlack" = "#a6adc8";
        "terminal.ansiRed" = "#${base08}";
        "terminal.ansiGreen" = "#${base0B}";
        "terminal.ansiYellow" = "#${base0A}";
        "terminal.ansiBlue" = "#${base0D}";
        "terminal.ansiMagenta" = "#${base0F}";
        "terminal.ansiCyan" = "#${base0C}";
        "terminal.ansiWhite" = "#bac2de";
        "terminal.ansiBrightBlack" = "#${base04}";
        "terminal.ansiBrightRed" = "#${base08}";
        "terminal.ansiBrightGreen" = "#${base0B}";
        "terminal.ansiBrightYellow" = "#${base0A}";
        "terminal.ansiBrightBlue" = "#${base0D}";
        "terminal.ansiBrightMagenta" = "#${base0F}";
        "terminal.ansiBrightCyan" = "#${base0C}";
        "terminal.ansiBrightWhite" = "#${base03}";
        "terminal.selectionBackground" = "#${base04}";
        "terminal.inactiveSelectionBackground" = "#${base04}80";
        "terminalCursor.background" = "#${base00}";
        "terminalCursor.foreground" = "#${base0F}";
        "terminal.border" = "#${base04}";
        "terminal.dropBackground" = "#${base0E}33";
        "terminal.tab.activeBorder" = "#${base0E}";
        "terminalCommandDecoration.defaultBackground" = "#${base04}";
        "terminalCommandDecoration.successBackground" = "#${base0B}";
        "terminalCommandDecoration.errorBackground" = "#${base08}";
        "titleBar.activeBackground" = "#${base01}";
        "titleBar.activeForeground" = "#${base05}";
        "titleBar.inactiveBackground" = "#${base01}";
        "titleBar.inactiveForeground" = "#${base05}80";
        "titleBar.border" = "#00000000";
        "welcomePage.tileBackground" = "#${base01}";
        "welcomePage.progress.background" = "#${base01}";
        "welcomePage.progress.foreground" = "#${base0E}";
        "walkThrough.embeddedEditorBackground" = "#${base00}4d";
        "symbolIcon.textForeground" = "#${base05}";
        "symbolIcon.arrayForeground" = "#${base09}";
        "symbolIcon.booleanForeground" = "#${base0E}";
        "symbolIcon.classForeground" = "#${base0A}";
        "symbolIcon.colorForeground" = "#${base0F}";
        "symbolIcon.constantForeground" = "#${base09}";
        "symbolIcon.constructorForeground" = "#${base07}";
        "symbolIcon.enumeratorForeground" = "#${base0A}";
        "symbolIcon.enumeratorMemberForeground" = "#${base0A}";
        "symbolIcon.eventForeground" = "#${base0F}";
        "symbolIcon.fieldForeground" = "#${base05}";
        "symbolIcon.fileForeground" = "#${base0E}";
        "symbolIcon.folderForeground" = "#${base0E}";
        "symbolIcon.functionForeground" = "#${base0D}";
        "symbolIcon.interfaceForeground" = "#${base0A}";
        "symbolIcon.keyForeground" = "#${base0C}";
        "symbolIcon.keywordForeground" = "#${base0E}";
        "symbolIcon.methodForeground" = "#${base0D}";
        "symbolIcon.moduleForeground" = "#${base05}";
        "symbolIcon.namespaceForeground" = "#${base0A}";
        "symbolIcon.nullForeground" = "#${base08}";
        "symbolIcon.numberForeground" = "#${base09}";
        "symbolIcon.objectForeground" = "#${base0A}";
        "symbolIcon.operatorForeground" = "#${base0C}";
        "symbolIcon.packageForeground" = "#${base06}";
        "symbolIcon.propertyForeground" = "#${base08}";
        "symbolIcon.referenceForeground" = "#${base0A}";
        "symbolIcon.snippetForeground" = "#${base06}";
        "symbolIcon.stringForeground" = "#${base0B}";
        "symbolIcon.structForeground" = "#${base0C}";
        "symbolIcon.typeParameterForeground" = "#${base08}";
        "symbolIcon.unitForeground" = "#${base05}";
        "symbolIcon.variableForeground" = "#${base05}";
        "charts.foreground" = "#${base05}";
        "charts.lines" = "#bac2de";
        "charts.red" = "#${base08}";
        "charts.blue" = "#${base0D}";
        "charts.yellow" = "#${base0A}";
        "charts.orange" = "#${base09}";
        "charts.green" = "#${base0B}";
        "charts.purple" = "#${base0E}";
        "errorLens.errorBackground" = "#${base08}26";
        "errorLens.errorBackgroundLight" = "#${base08}26";
        "errorLens.errorForeground" = "#${base08}";
        "errorLens.errorForegroundLight" = "#${base08}";
        "errorLens.errorMessageBackground" = "#${base08}26";
        "errorLens.hintBackground" = "#${base0B}26";
        "errorLens.hintBackgroundLight" = "#${base0B}26";
        "errorLens.hintForeground" = "#${base0B}";
        "errorLens.hintForegroundLight" = "#${base0B}";
        "errorLens.hintMessageBackground" = "#${base0B}26";
        "errorLens.infoBackground" = "#${base0D}26";
        "errorLens.infoBackgroundLight" = "#${base0D}26";
        "errorLens.infoForeground" = "#${base0D}";
        "errorLens.infoForegroundLight" = "#${base0D}";
        "errorLens.infoMessageBackground" = "#${base0D}26";
        "errorLens.statusBarErrorForeground" = "#${base08}";
        "errorLens.statusBarHintForeground" = "#${base0B}";
        "errorLens.statusBarIconErrorForeground" = "#${base08}";
        "errorLens.statusBarIconWarningForeground" = "#${base09}";
        "errorLens.statusBarInfoForeground" = "#${base0D}";
        "errorLens.statusBarWarningForeground" = "#${base09}";
        "errorLens.warningBackground" = "#${base09}26";
        "errorLens.warningBackgroundLight" = "#${base09}26";
        "errorLens.warningForeground" = "#${base09}";
        "errorLens.warningForegroundLight" = "#${base09}";
        "errorLens.warningMessageBackground" = "#${base09}26";
        "issues.closed" = "#${base0E}";
        "issues.newIssueDecoration" = "#${base0F}";
        "issues.open" = "#${base0B}";
        "pullRequests.closed" = "#${base08}";
        "pullRequests.draft" = "#9399b2";
        "pullRequests.merged" = "#${base0E}";
        "pullRequests.notification" = "#${base05}";
        "pullRequests.open" = "#${base0B}";
        "gitlens.gutterBackgroundColor" = "#${base02}4d";
        "gitlens.gutterForegroundColor" = "#${base05}";
        "gitlens.gutterUncommittedForegroundColor" = "#${base0E}";
        "gitlens.trailingLineBackgroundColor" = "#00000000";
        "gitlens.trailingLineForegroundColor" = "#${base05}4d";
        "gitlens.lineHighlightBackgroundColor" = "#${base0E}26";
        "gitlens.lineHighlightOverviewRulerColor" = "#${base0E}cc";
        "gitlens.openAutolinkedIssueIconColor" = "#${base0B}";
        "gitlens.closedAutolinkedIssueIconColor" = "#${base0E}";
        "gitlens.closedPullRequestIconColor" = "#${base08}";
        "gitlens.openPullRequestIconColor" = "#${base0B}";
        "gitlens.mergedPullRequestIconColor" = "#${base0E}";
        "gitlens.unpublishedChangesIconColor" = "#${base0B}";
        "gitlens.unpublishedCommitIconColor" = "#${base0B}";
        "gitlens.unpulledChangesIconColor" = "#${base09}";
        "gitlens.decorations.branchAheadForegroundColor" = "#${base0B}";
        "gitlens.decorations.branchBehindForegroundColor" = "#${base09}";
        "gitlens.decorations.branchDivergedForegroundColor" = "#${base0A}";
        "gitlens.decorations.branchUnpublishedForegroundColor" = "#${base0B}";
        "gitlens.decorations.branchMissingUpstreamForegroundColor" = "#${base09}";
        "gitlens.decorations.statusMergingOrRebasingConflictForegroundColor" = "#${base08}";
        "gitlens.decorations.statusMergingOrRebasingForegroundColor" = "#${base0A}";
        "gitlens.decorations.workspaceRepoMissingForegroundColor" = "#a6adc8";
        "gitlens.decorations.workspaceCurrentForegroundColor" = "#${base0E}";
        "gitlens.decorations.workspaceRepoOpenForegroundColor" = "#${base0E}";
        "gitlens.decorations.worktreeHasUncommittedChangesForegroundColor" = "#${base09}";
        "gitlens.decorations.worktreeMissingForegroundColor" = "#${base08}";
        "gitlens.graphLane1Color" = "#${base0E}";
        "gitlens.graphLane2Color" = "#${base0A}";
        "gitlens.graphLane3Color" = "#${base0D}";
        "gitlens.graphLane4Color" = "#${base06}";
        "gitlens.graphLane5Color" = "#${base0B}";
        "gitlens.graphLane6Color" = "#${base07}";
        "gitlens.graphLane7Color" = "#${base0F}";
        "gitlens.graphLane8Color" = "#${base08}";
        "gitlens.graphLane9Color" = "#${base0C}";
        "gitlens.graphLane10Color" = "#${base0F}";
        "gitlens.graphChangesColumnAddedColor" = "#${base0B}";
        "gitlens.graphChangesColumnDeletedColor" = "#${base08}";
        "gitlens.graphMinimapMarkerHeadColor" = "#${base0B}";
        "gitlens.graphScrollMarkerHeadColor" = "#${base0B}";
        "gitlens.graphMinimapMarkerUpstreamColor" = "#${base0B}";
        "gitlens.graphScrollMarkerUpstreamColor" = "#${base0B}";
        "gitlens.graphMinimapMarkerHighlightsColor" = "#${base0A}";
        "gitlens.graphScrollMarkerHighlightsColor" = "#${base0A}";
        "gitlens.graphMinimapMarkerLocalBranchesColor" = "#${base0D}";
        "gitlens.graphScrollMarkerLocalBranchesColor" = "#${base0D}";
        "gitlens.graphMinimapMarkerRemoteBranchesColor" = "#${base0D}";
        "gitlens.graphScrollMarkerRemoteBranchesColor" = "#${base0D}";
        "gitlens.graphMinimapMarkerStashesColor" = "#${base0E}";
        "gitlens.graphScrollMarkerStashesColor" = "#${base0E}";
        "gitlens.graphMinimapMarkerTagsColor" = "#${base06}";
        "gitlens.graphScrollMarkerTagsColor" = "#${base06}";
        "editorBracketHighlight.foreground1" = "#${base08}";
        "editorBracketHighlight.foreground2" = "#${base09}";
        "editorBracketHighlight.foreground3" = "#${base0A}";
        "editorBracketHighlight.foreground4" = "#${base0B}";
        "editorBracketHighlight.foreground5" = "#${base0D}";
        "editorBracketHighlight.foreground6" = "#${base0E}";
        "editorBracketHighlight.unexpectedBracket.foreground" = "#${base08}";
        "button.secondaryBorder" = "#${base0E}";
        "table.headerBackground" = "#${base02}";
        "table.headerForeground" = "#${base05}";
        "list.focusAndSelectionBackground" = "#${base03}";
      };
      "semanticHighlighting" = true;

      "semanticTokenColors" = {
        "enumMember" = {
          "foreground" = "#${base0C}";
        };
        "selfKeyword" = {
          "foreground" = "#${base08}";
        };
        "boolean" = {
          "foreground" = "#${base09}";
        };
        "number" = {
          "foreground" = "#${base09}";
        };
        "variable.defaultLibrary" = {
          "foreground" = "#${base08}";
        };
        "class:python" = {
          "foreground" = "#${base0A}";
        };
        "class.builtin:python" = {
          "foreground" = "#${base0E}";
        };
        "variable.typeHint:python" = {
          "foreground" = "#${base0A}";
        };
        "function.decorator:python" = {
          "foreground" = "#${base09}";
        };
        "variable.readonly:javascript" = {
          "foreground" = "#${base05}";
        };
        "variable.readonly:typescript" = {
          "foreground" = "#${base05}";
        };
        "property.readonly:javascript" = {
          "foreground" = "#${base05}";
        };
        "property.readonly:typescript" = {
          "foreground" = "#${base05}";
        };
        "variable.readonly:javascriptreact" = {
          "foreground" = "#${base05}";
        };
        "variable.readonly:typescriptreact" = {
          "foreground" = "#${base05}";
        };
        "property.readonly:javascriptreact" = {
          "foreground" = "#${base05}";
        };
        "property.readonly:typescriptreact" = {
          "foreground" = "#${base05}";
        };
        "variable.readonly:scala" = {
          "foreground" = "#${base05}";
        };
        "type.defaultLibrary:go" = {
          "foreground" = "#${base0E}";
        };
        "variable.readonly.defaultLibrary:go" = {
          "foreground" = "#${base0E}";
        };
        "tomlArrayKey" = {
          "foreground" = "#${base0D}";
          "fontStyle" = "";
        };
        "tomlTableKey" = {
          "foreground" = "#${base0D}";
          "fontStyle" = "";
        };
        "builtinAttribute.attribute.library:rust" = {
          "foreground" = "#${base0D}";
        };
        "generic.attribute:rust" = {
          "foreground" = "#${base05}";
        };
        "constant.builtin.readonly:nix" = {
          "foreground" = "#${base0E}";
        };
        "heading" = {
          "foreground" = "#${base08}";
        };
        "text.emph" = {
          "foreground" = "#${base08}";
          "fontStyle" = "italic";
        };
        "text.strong" = {
          "foreground" = "#${base08}";
          "fontStyle" = "bold";
        };
        "text.math" = {
          "foreground" = "#${base06}";
        };
        "pol" = {
          "foreground" = "#${base06}";
        };
      };
      "tokenColors" = [
        {
          "name" = "Basic text & variable names (incl. leading punctuation)";
          "scope" = [
            "text"
            "source"
            "variable.other.readwrite"
            "punctuation.definition.variable"
          ];
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "Parentheses, Brackets, Braces";
          "scope" = "punctuation";
          "settings" = {
            "foreground" = "#9399b2";
            "fontStyle" = "";
          };
        }
        {
          "name" = "Comments";
          "scope" = [
            "comment"
            "punctuation.definition.comment"
          ];
          "settings" = {
            "foreground" = "#6c7086";
            "fontStyle" = "italic";
          };
        }
        {
          "scope" = [
            "string"
            "punctuation.definition.string"
          ];
          "settings" = {
            "foreground" = "#${base0B}";
          };
        }
        {
          "scope" = "constant.character.escape";
          "settings" = {
            "foreground" = "#${base0F}";
          };
        }
        {
          "name" = "Booleans, constants, numbers";
          "scope" = [
            "constant.numeric"
            "variable.other.constant"
            "entity.name.constant"
            "constant.language.boolean"
            "constant.language.false"
            "constant.language.true"
            "keyword.other.unit.user-defined"
            "keyword.other.unit.suffix.floating-point"
          ];
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "scope" = [
            "keyword"
            "keyword.operator.word"
            "keyword.operator.new"
            "variable.language.super"
            "support.type.primitive"
            "storage.type"
            "storage.modifier"
            "punctuation.definition.keyword"
          ];
          "settings" = {
            "foreground" = "#${base0E}";
            "fontStyle" = "";
          };
        }
        {
          "scope" = "entity.name.tag.documentation";
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "name" = "Punctuation";
          "scope" = [
            "keyword.operator"
            "punctuation.accessor"
            "punctuation.definition.generic"
            "meta.function.closure punctuation.section.parameters"
            "punctuation.definition.tag"
            "punctuation.separator.key-value"
          ];
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "scope" = [
            "entity.name.function"
            "meta.function-call.method"
            "support.function"
            "support.function.misc"
            "variable.function"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Classes";
          "scope" = [
            "entity.name.class"
            "entity.other.inherited-class"
            "support.class"
            "meta.function-call.constructor"
            "entity.name.struct"
          ];
          "settings" = {
            "foreground" = "#${base0A}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Enum";
          "scope" = "entity.name.enum";
          "settings" = {
            "foreground" = "#${base0A}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Enum member";
          "scope" = [
            "meta.enum variable.other.readwrite"
            "variable.other.enummember"
          ];
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Object properties";
          "scope" = "meta.property.object";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Types";
          "scope" = [
            "meta.type"
            "meta.type-alias"
            "support.type"
            "entity.name.type"
          ];
          "settings" = {
            "foreground" = "#${base0A}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Decorators";
          "scope" = [
            "meta.annotation variable.function"
            "meta.annotation variable.annotation.function"
            "meta.annotation punctuation.definition.annotation"
            "meta.decorator"
            "punctuation.decorator"
          ];
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "scope" = [
            "variable.parameter"
            "meta.function.parameters"
          ];
          "settings" = {
            "foreground" = "#${base08}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Built-ins";
          "scope" = [
            "constant.language"
            "support.function.builtin"
          ];
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "scope" = "entity.other.attribute-name.documentation";
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "name" = "Preprocessor directives";
          "scope" = [
            "keyword.control.directive"
            "punctuation.definition.directive"
          ];
          "settings" = {
            "foreground" = "#${base0A}";
          };
        }
        {
          "name" = "Type parameters";
          "scope" = "punctuation.definition.typeparameters";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Namespaces";
          "scope" = "entity.name.namespace";
          "settings" = {
            "foreground" = "#${base0A}";
          };
        }
        {
          "name" = "Property names (left hand assignments in json/yaml/css)";
          "scope" = "support.type.property-name.css";
          "settings" = {
            "foreground" = "#${base0D}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "This/Self keyword";
          "scope" = [
            "variable.language.this"
            "variable.language.this punctuation.definition.variable"
          ];
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "name" = "Object properties";
          "scope" = "variable.object.property";
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "String template interpolation";
          "scope" = [
            "string.template variable"
            "string variable"
          ];
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "`new` as bold";
          "scope" = "keyword.operator.new";
          "settings" = {
            "fontStyle" = "bold";
          };
        }
        {
          "name" = "C++ extern keyword";
          "scope" = "storage.modifier.specifier.extern.cpp";
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "name" = "C++ scope resolution";
          "scope" = [
            "entity.name.scope-resolution.template.call.cpp"
            "entity.name.scope-resolution.parameter.cpp"
            "entity.name.scope-resolution.cpp"
            "entity.name.scope-resolution.function.definition.cpp"
          ];
          "settings" = {
            "foreground" = "#${base0A}";
          };
        }
        {
          "name" = "C++ doc keywords";
          "scope" = "storage.type.class.doxygen";
          "settings" = {
            "fontStyle" = "";
          };
        }
        {
          "name" = "C++ operators";
          "scope" = [
            "storage.modifier.reference.cpp"
          ];
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "C# Interpolated Strings";
          "scope" = "meta.interpolation.cs";
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "C# xml-style docs";
          "scope" = "comment.block.documentation.cs";
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "Classes, reflecting the className color in JSX";
          "scope" = [
            "source.css entity.other.attribute-name.class.css"
            "entity.other.attribute-name.parent-selector.css punctuation.definition.entity.css"
          ];
          "settings" = {
            "foreground" = "#${base0A}";
          };
        }
        {
          "name" = "Operators";
          "scope" = "punctuation.separator.operator.css";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Pseudo classes";
          "scope" = "source.css entity.other.attribute-name.pseudo-class";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "scope" = "source.css constant.other.unicode-range";
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "scope" = "source.css variable.parameter.url";
          "settings" = {
            "foreground" = "#${base0B}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "CSS vendored property names";
          "scope" = [
            "support.type.vendored.property-name"
          ];
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Less/SCSS right-hand variables (@/$-prefixed)";
          "scope" = [
            "source.css meta.property-value variable"
            "source.css meta.property-value variable.other.less"
            "source.css meta.property-value variable.other.less punctuation.definition.variable.less"
            "meta.definition.variable.scss"
          ];
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "name" = "CSS variables (--prefixed)";
          "scope" = [
            "source.css meta.property-list variable"
            "meta.property-list variable.other.less"
            "meta.property-list variable.other.less punctuation.definition.variable.less"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
          };
        }
        {
          "name" = "CSS Percentage values, styled the same as numbers";
          "scope" = "keyword.other.unit.percentage.css";
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "CSS Attribute selectors, styled the same as strings";
          "scope" = "source.css meta.attribute-selector";
          "settings" = {
            "foreground" = "#${base0B}";
          };
        }
        {
          "name" = "JSON/YAML keys, other left-hand assignments";
          "scope" = [
            "keyword.other.definition.ini"
            "punctuation.support.type.property-name.json"
            "support.type.property-name.json"
            "punctuation.support.type.property-name.toml"
            "support.type.property-name.toml"
            "entity.name.tag.yaml"
            "punctuation.support.type.property-name.yaml"
            "support.type.property-name.yaml"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "JSON/YAML constants";
          "scope" = [
            "constant.language.json"
            "constant.language.yaml"
          ];
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "YAML anchors";
          "scope" = [
            "entity.name.type.anchor.yaml"
            "variable.other.alias.yaml"
          ];
          "settings" = {
            "foreground" = "#${base0A}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "TOML tables / ini groups";
          "scope" = [
            "support.type.property-name.table"
            "entity.name.section.group-title.ini"
          ];
          "settings" = {
            "foreground" = "#${base0A}";
          };
        }
        {
          "name" = "TOML dates";
          "scope" = "constant.other.time.datetime.offset.toml";
          "settings" = {
            "foreground" = "#${base0F}";
          };
        }
        {
          "name" = "YAML anchor puctuation";
          "scope" = [
            "punctuation.definition.anchor.yaml"
            "punctuation.definition.alias.yaml"
          ];
          "settings" = {
            "foreground" = "#${base0F}";
          };
        }
        {
          "name" = "YAML triple dashes";
          "scope" = "entity.other.document.begin.yaml";
          "settings" = {
            "foreground" = "#${base0F}";
          };
        }
        {
          "name" = "Markup Diff";
          "scope" = "markup.changed.diff";
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "Diff";
          "scope" = [
            "meta.diff.header.from-file"
            "meta.diff.header.to-file"
            "punctuation.definition.from-file.diff"
            "punctuation.definition.to-file.diff"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
          };
        }
        {
          "name" = "Diff Inserted";
          "scope" = "markup.inserted.diff";
          "settings" = {
            "foreground" = "#${base0B}";
          };
        }
        {
          "name" = "Diff Deleted";
          "scope" = "markup.deleted.diff";
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "name" = "dotenv left-hand side assignments";
          "scope" = [
            "variable.other.env"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
          };
        }
        {
          "name" = "dotenv reference to existing env variable";
          "scope" = [
            "string.quoted variable.other.env"
          ];
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "GDScript functions";
          "scope" = "support.function.builtin.gdscript";
          "settings" = {
            "foreground" = "#${base0D}";
          };
        }
        {
          "name" = "GDScript constants";
          "scope" = "constant.language.gdscript";
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "Comment keywords";
          "scope" = "comment meta.annotation.go";
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "name" = "go:embed, go:build, etc.";
          "scope" = "comment meta.annotation.parameters.go";
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "Go constants (nil, true, false)";
          "scope" = "constant.language.go";
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "GraphQL variables";
          "scope" = "variable.graphql";
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "GraphQL aliases";
          "scope" = "string.unquoted.alias.graphql";
          "settings" = {
            "foreground" = "#${base06}";
          };
        }
        {
          "name" = "GraphQL enum members";
          "scope" = "constant.character.enum.graphql";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "GraphQL field in types";
          "scope" = "meta.objectvalues.graphql constant.object.key.graphql string.unquoted.graphql";
          "settings" = {
            "foreground" = "#${base06}";
          };
        }
        {
          "name" = "HTML/XML DOCTYPE as keyword";
          "scope" = [
            "keyword.other.doctype"
            "meta.tag.sgml.doctype punctuation.definition.tag"
            "meta.tag.metadata.doctype entity.name.tag"
            "meta.tag.metadata.doctype punctuation.definition.tag"
          ];
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "name" = "HTML/XML-like <tags/>";
          "scope" = [
            "entity.name.tag"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "Special characters like &amp;";
          "scope" = [
            "text.html constant.character.entity"
            "text.html constant.character.entity punctuation"
            "constant.character.entity.xml"
            "constant.character.entity.xml punctuation"
            "constant.character.entity.js.jsx"
            "constant.charactger.entity.js.jsx punctuation"
            "constant.character.entity.tsx"
            "constant.character.entity.tsx punctuation"
          ];
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "name" = "HTML/XML tag attribute values";
          "scope" = [
            "entity.other.attribute-name"
          ];
          "settings" = {
            "foreground" = "#${base0A}";
          };
        }
        {
          "name" = "Components";
          "scope" = [
            "support.class.component"
            "support.class.component.jsx"
            "support.class.component.tsx"
            "support.class.component.vue"
          ];
          "settings" = {
            "foreground" = "#${base0F}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "Annotations";
          "scope" = [
            "punctuation.definition.annotation"
            "storage.type.annotation"
          ];
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "Java enums";
          "scope" = "constant.other.enum.java";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Java imports";
          "scope" = "storage.modifier.import.java";
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "Javadoc";
          "scope" = "comment.block.javadoc.java keyword.other.documentation.javadoc.java";
          "settings" = {
            "fontStyle" = "";
          };
        }
        {
          "name" = "Exported Variable";
          "scope" = "meta.export variable.other.readwrite.js";
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "name" = "JS/TS constants & properties";
          "scope" = [
            "variable.other.constant.js"
            "variable.other.constant.ts"
            "variable.other.property.js"
            "variable.other.property.ts"
          ];
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "JSDoc; these are mainly params, so styled as such";
          "scope" = [
            "variable.other.jsdoc"
            "comment.block.documentation variable.other"
          ];
          "settings" = {
            "foreground" = "#${base08}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "JSDoc keywords";
          "scope" = "storage.type.class.jsdoc";
          "settings" = {
            "fontStyle" = "";
          };
        }
        {
          "scope" = "support.type.object.console.js";
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "Node constants as keywords (module, etc.)";
          "scope" = [
            "support.constant.node"
            "support.type.object.module.js"
          ];
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "name" = "implements as keyword";
          "scope" = "storage.modifier.implements";
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "name" = "Builtin types";
          "scope" = [
            "constant.language.null.js"
            "constant.language.null.ts"
            "constant.language.undefined.js"
            "constant.language.undefined.ts"
            "support.type.builtin.ts"
          ];
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "scope" = "variable.parameter.generic";
          "settings" = {
            "foreground" = "#${base0A}";
          };
        }
        {
          "name" = "Arrow functions";
          "scope" = [
            "keyword.declaration.function.arrow.js"
            "storage.type.function.arrow.ts"
          ];
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Decorator punctuations (decorators inherit from blue functions, instead of styleguide peach)";
          "scope" = "punctuation.decorator.ts";
          "settings" = {
            "foreground" = "#${base0D}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Extra JS/TS keywords";
          "scope" = [
            "keyword.operator.expression.in.js"
            "keyword.operator.expression.in.ts"
            "keyword.operator.expression.infer.ts"
            "keyword.operator.expression.instanceof.js"
            "keyword.operator.expression.instanceof.ts"
            "keyword.operator.expression.is"
            "keyword.operator.expression.keyof.ts"
            "keyword.operator.expression.of.js"
            "keyword.operator.expression.of.ts"
            "keyword.operator.expression.typeof.ts"
          ];
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "name" = "Julia macros";
          "scope" = "support.function.macro.julia";
          "settings" = {
            "foreground" = "#${base0C}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Julia language constants (true, false)";
          "scope" = "constant.language.julia";
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "Julia other constants (these seem to be arguments inside arrays)";
          "scope" = "constant.other.symbol.julia";
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "name" = "LaTeX preamble";
          "scope" = "text.tex keyword.control.preamble";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "LaTeX be functions";
          "scope" = "text.tex support.function.be";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "LaTeX math";
          "scope" = "constant.other.general.math.tex";
          "settings" = {
            "foreground" = "#${base06}";
          };
        }
        {
          "name" = "Lua docstring keywords";
          "scope" = "comment.line.double-dash.documentation.lua storage.type.annotation.lua";
          "settings" = {
            "foreground" = "#${base0E}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "Lua docstring variables";
          "scope" = [
            "comment.line.double-dash.documentation.lua entity.name.variable.lua"
            "comment.line.double-dash.documentation.lua variable.lua"
          ];
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "scope" = [
            "heading.1.markdown punctuation.definition.heading.markdown"
            "heading.1.markdown"
            "heading.1.quarto punctuation.definition.heading.quarto"
            "heading.1.quarto"
            "markup.heading.atx.1.mdx"
            "markup.heading.atx.1.mdx punctuation.definition.heading.mdx"
            "markup.heading.setext.1.markdown"
            "markup.heading.heading-0.asciidoc"
          ];
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "scope" = [
            "heading.2.markdown punctuation.definition.heading.markdown"
            "heading.2.markdown"
            "heading.2.quarto punctuation.definition.heading.quarto"
            "heading.2.quarto"
            "markup.heading.atx.2.mdx"
            "markup.heading.atx.2.mdx punctuation.definition.heading.mdx"
            "markup.heading.setext.2.markdown"
            "markup.heading.heading-1.asciidoc"
          ];
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "scope" = [
            "heading.3.markdown punctuation.definition.heading.markdown"
            "heading.3.markdown"
            "heading.3.quarto punctuation.definition.heading.quarto"
            "heading.3.quarto"
            "markup.heading.atx.3.mdx"
            "markup.heading.atx.3.mdx punctuation.definition.heading.mdx"
            "markup.heading.heading-2.asciidoc"
          ];
          "settings" = {
            "foreground" = "#${base0A}";
          };
        }
        {
          "scope" = [
            "heading.4.markdown punctuation.definition.heading.markdown"
            "heading.4.markdown"
            "heading.4.quarto punctuation.definition.heading.quarto"
            "heading.4.quarto"
            "markup.heading.atx.4.mdx"
            "markup.heading.atx.4.mdx punctuation.definition.heading.mdx"
            "markup.heading.heading-3.asciidoc"
          ];
          "settings" = {
            "foreground" = "#${base0B}";
          };
        }
        {
          "scope" = [
            "heading.5.markdown punctuation.definition.heading.markdown"
            "heading.5.markdown"
            "heading.5.quarto punctuation.definition.heading.quarto"
            "heading.5.quarto"
            "markup.heading.atx.5.mdx"
            "markup.heading.atx.5.mdx punctuation.definition.heading.mdx"
            "markup.heading.heading-4.asciidoc"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
          };
        }
        {
          "scope" = [
            "heading.6.markdown punctuation.definition.heading.markdown"
            "heading.6.markdown"
            "heading.6.quarto punctuation.definition.heading.quarto"
            "heading.6.quarto"
            "markup.heading.atx.6.mdx"
            "markup.heading.atx.6.mdx punctuation.definition.heading.mdx"
            "markup.heading.heading-5.asciidoc"
          ];
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "scope" = "markup.bold";
          "settings" = {
            "foreground" = "#${base08}";
            "fontStyle" = "bold";
          };
        }
        {
          "scope" = "markup.italic";
          "settings" = {
            "foreground" = "#${base08}";
            "fontStyle" = "italic";
          };
        }
        {
          "scope" = "markup.strikethrough";
          "settings" = {
            "foreground" = "#a6adc8";
            "fontStyle" = "strikethrough";
          };
        }
        {
          "name" = "Markdown auto links";
          "scope" = [
            "punctuation.definition.link"
            "markup.underline.link"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
          };
        }
        {
          "name" = "Markdown links";
          "scope" = [
            "text.html.markdown punctuation.definition.link.title"
            "text.html.quarto punctuation.definition.link.title"
            "string.other.link.title.markdown"
            "string.other.link.title.quarto"
            "markup.link"
            "punctuation.definition.constant.markdown"
            "punctuation.definition.constant.quarto"
            "constant.other.reference.link.markdown"
            "constant.other.reference.link.quarto"
            "markup.substitution.attribute-reference"
          ];
          "settings" = {
            "foreground" = "#${base07}";
          };
        }
        {
          "name" = "Markdown code spans";
          "scope" = [
            "punctuation.definition.raw.markdown"
            "punctuation.definition.raw.quarto"
            "markup.inline.raw.string.markdown"
            "markup.inline.raw.string.quarto"
            "markup.raw.block.markdown"
            "markup.raw.block.quarto"
          ];
          "settings" = {
            "foreground" = "#${base0B}";
          };
        }
        {
          "name" = "Markdown triple backtick language identifier";
          "scope" = "fenced_code.block.language";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Markdown triple backticks";
          "scope" = [
            "markup.fenced_code.block punctuation.definition"
            "markup.raw support.asciidoc"
          ];
          "settings" = {
            "foreground" = "#9399b2";
          };
        }
        {
          "name" = "Markdown quotes";
          "scope" = [
            "markup.quote"
            "punctuation.definition.quote.begin"
          ];
          "settings" = {
            "foreground" = "#${base0F}";
          };
        }
        {
          "name" = "Markdown separators";
          "scope" = "meta.separator.markdown";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Markdown list bullets";
          "scope" = [
            "punctuation.definition.list.begin.markdown"
            "punctuation.definition.list.begin.quarto"
            "markup.list.bullet"
          ];
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Quarto headings";
          "scope" = "markup.heading.quarto";
          "settings" = {
            "fontStyle" = "bold";
          };
        }
        {
          "name" = "Nix attribute names";
          "scope" = [
            "entity.other.attribute-name.multipart.nix"
            "entity.other.attribute-name.single.nix"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
          };
        }
        {
          "name" = "Nix parameter names";
          "scope" = "variable.parameter.name.nix";
          "settings" = {
            "foreground" = "#${base05}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "Nix interpolated parameter names";
          "scope" = "meta.embedded variable.parameter.name.nix";
          "settings" = {
            "foreground" = "#${base07}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "Nix paths";
          "scope" = "string.unquoted.path.nix";
          "settings" = {
            "foreground" = "#${base0F}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "PHP Attributes";
          "scope" = [
            "support.attribute.builtin"
            "meta.attribute.php"
          ];
          "settings" = {
            "foreground" = "#${base0A}";
          };
        }
        {
          "name" = "PHP Parameters (needed for the leading dollar sign)";
          "scope" = "meta.function.parameters.php punctuation.definition.variable.php";
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "name" = "PHP Constants (null, __FILE__, etc.)";
          "scope" = "constant.language.php";
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "name" = "PHP functions";
          "scope" = "text.html.php support.function";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "PHPdoc keywords";
          "scope" = "keyword.other.phpdoc.php";
          "settings" = {
            "fontStyle" = "";
          };
        }
        {
          "name" = "Python argument functions reset to text, otherwise they inherit blue from function-call";
          "scope" = [
            "support.variable.magic.python"
            "meta.function-call.arguments.python"
          ];
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "Python double underscore functions";
          "scope" = [
            "support.function.magic.python"
          ];
          "settings" = {
            "foreground" = "#${base0C}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Python `self` keyword";
          "scope" = [
            "variable.parameter.function.language.special.self.python"
            "variable.language.special.self.python"
          ];
          "settings" = {
            "foreground" = "#${base08}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "python keyword flow/logical (for ... in)";
          "scope" = [
            "keyword.control.flow.python"
            "keyword.operator.logical.python"
          ];
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "name" = "python storage type";
          "scope" = "storage.type.function.python";
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "name" = "python function support";
          "scope" = [
            "support.token.decorator.python"
            "meta.function.decorator.identifier.python"
          ];
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "python function calls";
          "scope" = [
            "meta.function-call.python"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
          };
        }
        {
          "name" = "python function decorators";
          "scope" = [
            "entity.name.function.decorator.python"
            "punctuation.definition.decorator.python"
          ];
          "settings" = {
            "foreground" = "#${base09}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "python placeholder reset to normal string";
          "scope" = "constant.character.format.placeholder.other.python";
          "settings" = {
            "foreground" = "#${base0F}";
          };
        }
        {
          "name" = "Python exception & builtins such as exit()";
          "scope" = [
            "support.type.exception.python"
            "support.function.builtin.python"
          ];
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "entity.name.type";
          "scope" = [
            "support.type.python"
          ];
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "python constants (True/False)";
          "scope" = "constant.language.python";
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "name" = "Arguments accessed later in the function body";
          "scope" = [
            "meta.indexed-name.python"
            "meta.item-access.python"
          ];
          "settings" = {
            "foreground" = "#${base08}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Python f-strings/binary/unicode storage types";
          "scope" = "storage.type.string.python";
          "settings" = {
            "foreground" = "#${base0B}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Python type hints";
          "scope" = "meta.function.parameters.python";
          "settings" = {
            "fontStyle" = "";
          };
        }
        {
          "name" = "Regex string begin/end in JS/TS";
          "scope" = [
            "string.regexp punctuation.definition.string.begin"
            "string.regexp punctuation.definition.string.end"
          ];
          "settings" = {
            "foreground" = "#${base0F}";
          };
        }
        {
          "name" = "Regex anchors (^, $)";
          "scope" = "keyword.control.anchor.regexp";
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "name" = "Regex regular string match";
          "scope" = "string.regexp.ts";
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "Regex group parenthesis & backreference (\\1, \\2, \\3, ...)";
          "scope" = [
            "punctuation.definition.group.regexp"
            "keyword.other.back-reference.regexp"
          ];
          "settings" = {
            "foreground" = "#${base0B}";
          };
        }
        {
          "name" = "Regex character class []";
          "scope" = "punctuation.definition.character-class.regexp";
          "settings" = {
            "foreground" = "#${base0A}";
          };
        }
        {
          "name" = "Regex character classes (\\d, \\w, \\s)";
          "scope" = "constant.other.character-class.regexp";
          "settings" = {
            "foreground" = "#${base0F}";
          };
        }
        {
          "name" = "Regex range";
          "scope" = "constant.other.character-class.range.regexp";
          "settings" = {
            "foreground" = "#${base0F}";
          };
        }
        {
          "name" = "Regex quantifier";
          "scope" = "keyword.operator.quantifier.regexp";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Regex constant/numeric";
          "scope" = "constant.character.numeric.regexp";
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "Regex lookaheads, negative lookaheads, lookbehinds, negative lookbehinds";
          "scope" = [
            "punctuation.definition.group.no-capture.regexp"
            "meta.assertion.look-ahead.regexp"
            "meta.assertion.negative-look-ahead.regexp"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
          };
        }
        {
          "name" = "Rust attribute";
          "scope" = [
            "meta.annotation.rust"
            "meta.annotation.rust punctuation"
            "meta.attribute.rust"
            "punctuation.definition.attribute.rust"
          ];
          "settings" = {
            "foreground" = "#${base0A}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Rust attribute strings";
          "scope" = [
            "meta.attribute.rust string.quoted.double.rust"
            "meta.attribute.rust string.quoted.single.char.rust"
          ];
          "settings" = {
            "fontStyle" = "";
          };
        }
        {
          "name" = "Rust keyword";
          "scope" = [
            "entity.name.function.macro.rules.rust"
            "storage.type.module.rust"
            "storage.modifier.rust"
            "storage.type.struct.rust"
            "storage.type.enum.rust"
            "storage.type.trait.rust"
            "storage.type.union.rust"
            "storage.type.impl.rust"
            "storage.type.rust"
            "storage.type.function.rust"
            "storage.type.type.rust"
          ];
          "settings" = {
            "foreground" = "#${base0E}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "Rust u/i32, u/i64, etc.";
          "scope" = "entity.name.type.numeric.rust";
          "settings" = {
            "foreground" = "#${base0E}";
            "fontStyle" = "";
          };
        }
        {
          "name" = "Rust generic";
          "scope" = "meta.generic.rust";
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "Rust impl";
          "scope" = "entity.name.impl.rust";
          "settings" = {
            "foreground" = "#${base0A}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Rust module";
          "scope" = "entity.name.module.rust";
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "Rust trait";
          "scope" = "entity.name.trait.rust";
          "settings" = {
            "foreground" = "#${base0A}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Rust struct";
          "scope" = "storage.type.source.rust";
          "settings" = {
            "foreground" = "#${base0A}";
          };
        }
        {
          "name" = "Rust union";
          "scope" = "entity.name.union.rust";
          "settings" = {
            "foreground" = "#${base0A}";
          };
        }
        {
          "name" = "Rust enum member";
          "scope" = "meta.enum.rust storage.type.source.rust";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Rust macro";
          "scope" = [
            "support.macro.rust"
            "meta.macro.rust support.function.rust"
            "entity.name.function.macro.rust"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Rust lifetime";
          "scope" = [
            "storage.modifier.lifetime.rust"
            "entity.name.type.lifetime"
          ];
          "settings" = {
            "foreground" = "#${base0D}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Rust string formatting";
          "scope" = "string.quoted.double.rust constant.other.placeholder.rust";
          "settings" = {
            "foreground" = "#${base0F}";
          };
        }
        {
          "name" = "Rust return type generic";
          "scope" = "meta.function.return-type.rust meta.generic.rust storage.type.rust";
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "Rust functions";
          "scope" = "meta.function.call.rust";
          "settings" = {
            "foreground" = "#${base0D}";
          };
        }
        {
          "name" = "Rust angle brackets";
          "scope" = "punctuation.brackets.angle.rust";
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Rust constants";
          "scope" = "constant.other.caps.rust";
          "settings" = {
            "foreground" = "#${base09}";
          };
        }
        {
          "name" = "Rust function parameters";
          "scope" = [
            "meta.function.definition.rust variable.other.rust"
          ];
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "name" = "Rust closure variables";
          "scope" = "meta.function.call.rust variable.other.rust";
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
        {
          "name" = "Rust self";
          "scope" = "variable.language.self.rust";
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "name" = "Rust metavariable names";
          "scope" = [
            "variable.other.metavariable.name.rust"
            "meta.macro.metavariable.rust keyword.operator.macro.dollar.rust"
          ];
          "settings" = {
            "foreground" = "#${base0F}";
          };
        }
        {
          "name" = "Shell shebang";
          "scope" = [
            "comment.line.shebang"
            "comment.line.shebang punctuation.definition.comment"
            "comment.line.shebang"
            "punctuation.definition.comment.shebang.shell"
            "meta.shebang.shell"
          ];
          "settings" = {
            "foreground" = "#${base0F}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Shell shebang command";
          "scope" = "comment.line.shebang constant.language";
          "settings" = {
            "foreground" = "#${base0C}";
            "fontStyle" = "italic";
          };
        }
        {
          "name" = "Shell interpolated command";
          "scope" = [
            "meta.function-call.arguments.shell punctuation.definition.variable.shell"
            "meta.function-call.arguments.shell punctuation.section.interpolation"
            "meta.function-call.arguments.shell punctuation.definition.variable.shell"
            "meta.function-call.arguments.shell punctuation.section.interpolation"
          ];
          "settings" = {
            "foreground" = "#${base08}";
          };
        }
        {
          "name" = "Shell interpolated command variable";
          "scope" = "meta.string meta.interpolation.parameter.shell variable.other.readwrite";
          "settings" = {
            "foreground" = "#${base09}";
            "fontStyle" = "italic";
          };
        }
        {
          "scope" = [
            "source.shell punctuation.section.interpolation"
            "punctuation.definition.evaluation.backticks.shell"
          ];
          "settings" = {
            "foreground" = "#${base0C}";
          };
        }
        {
          "name" = "Shell EOF";
          "scope" = "entity.name.tag.heredoc.shell";
          "settings" = {
            "foreground" = "#${base0E}";
          };
        }
        {
          "name" = "Shell quoted variable";
          "scope" = "string.quoted.double.shell variable.other.normal.shell";
          "settings" = {
            "foreground" = "#${base05}";
          };
        }
      ];
    };
    "package.json" = __toJSON {
      name = "${pname}";
      displayName = "${publisher}'s ${pname}";
      version = "${version}";
      publisher = "${publisher}";
      engines.vscode = "^1.22.0";
      contributes.themes = [
        {
          label = "${publisher}'s ${pname}"; # Xi's theme
          uiTheme = "vs-dark";
          path = "./theme/generated.json";
        }
      ];
      capabilities = {
        untrustedWorkspaces.supported = true;
        virtualWorkspaces = true;
      };
    };
  };

  src = linkFarm "${publisher}.${pname}" (builtins.attrValues (builtins.mapAttrs (name: value: {
      name = "${name}";
      path = builtins.toFile (baseNameOf name) value;
    })
    theme));
in
  pkgs.stdenv.mkDerivation {
    name = "${publisher}-${pname}-${version}";
    version = version;

    passthru = {
      inherit vscodeExtPublisher vscodeExtName vscodeExtUniqueId;
    };

    src = src;

    configurePhase = ''
      runHook preConfigure
      runHook postConfigure
    '';

    buildPhase = ''
      runHook preBuild
      runHook postBuild
    '';

    dontPatchELF = true;

    dontStrip = true;

    # Some .vsix files contain other directories (e.g., `package`) that we don't use.
    # If other directories are present but `sourceRoot` is unset, the unpacker phase fails.
    # sourceRoot = "extension";

    installPrefix = "share/vscode/extensions/${vscodeExtUniqueId}";

    nativeBuildInputs = [pkgs.unzip];

    installPhase = ''

      runHook preInstall

      mkdir -p "$out/$installPrefix"
      find . -mindepth 1 -maxdepth 1 | xargs -d'\n' mv -t "$out/$installPrefix/"

      runHook postInstall
    '';
  }
