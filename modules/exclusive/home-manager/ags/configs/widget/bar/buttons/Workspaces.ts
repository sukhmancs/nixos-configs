// import PanelButton from "../PanelButton"
// import options from "options"
// import { sh, range } from "lib/utils"
// import { barAssignPosition } from "lib/utils"

// const hyprland = await Service.import("hyprland")
// const { workspaces, isJapanese } = options.bar.workspaces

// const dispatch = (arg: string | number) => {
//     sh(`hyprctl dispatch workspace ${arg}`)
// }

// const arrLabelsInJapanese = [
//   '一',
//   '二',
//   '三',
//   '四',
//   '五',
//   '六',
//   '七',
//   '八',
//   '九',
//   '十',
//   '十一',
//   '十二',
//   '十三',
//   '十四',
//   '十五',
//   '十六',
//   '十七',
//   '十八',
//   '十九',
//   '二十',
// ]

// const Workspaces = (ws: number, monitor: number) => Widget.Box({
//     children: range(ws || 20).map(i => Widget.Label({
//         attribute: i,
//         vpack: "center",
//         label: isJapanese.bind().as(j => j ? `${arrLabelsInJapanese[i - 1]}`: `${i}`),
//         no_show_all: true,
//         setup: self => self.hook(hyprland, () => {
//             self.toggleClassName("active", hyprland.active.workspace.id === i)
//             self.toggleClassName("occupied", (hyprland.getWorkspace(i)?.windows || 0) > 0)
//             self.visible = Boolean(hyprland.getWorkspace(i)) && hyprland.getWorkspace(i).monitorID === monitor
//         }),
//     })),
//     setup: box => {
//         if (ws === 0) {
//             box.hook(hyprland.active.workspace, () => box.children.map(btn => {
//                 btn.visible = hyprland.workspaces.some(ws => ws.id === btn.attribute)
//             }))
//         }
//     },
// })

// export default (monitor: number, pos: string) => {
//     return PanelButton({
//         window: "overview",
//         class_name: "workspaces",
//         on_scroll_up: () => dispatch("r-1"),
//         on_scroll_down: () => dispatch("r+1"),
//         on_clicked: () => App.toggleWindow("overview"),
//         setup: self => { barAssignPosition(self, pos) },
//         // child: workspaces.bind().as(Workspaces),
//         child: Workspaces(workspaces, monitor),
//     })
// }

import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Gdk from "gi://Gdk";

export const hideEmptyWorkspaces = Variable(false);

function wsVisible(i, button) {
  const display = Gdk.Display.get_default();
  const hlMonID = Hyprland.getWorkspace(i)?.monitorID;
  if(hlMonID !== undefined) {
    const hlMon = JSON.parse(Hyprland.message("j/monitors")).find(mon => mon.id === hlMonID);
    const gdkMon = display?.get_monitor_at_window(button.get_window());
    return hlMon.name === Utils.getMonitorName(gdkMon);
  }
  return false;
}

function applyCssToWs(box) {
  box.children.forEach((button, i) => {
    const ws = Hyprland.getWorkspace(i + 1);
    const ws_before = Hyprland.getWorkspace(i);
    const ws_after = Hyprland.getWorkspace(i + 2);
    button.toggleClassName("occupied", ws?.windows > 0 || hideEmptyWorkspaces.value);
    const occLeft = hideEmptyWorkspaces.value
      ? box.children.findIndex(button => button.visible) === i
      : (!ws_before || ws_before?.windows <= 0);
    const occRight = hideEmptyWorkspaces.value
      ? box.children.reverse().findIndex(button => button.visible) === box .children.length - i - 1
      : !ws_after || ws_after?.windows <= 0;
    button.toggleClassName("occupied-left", occLeft);
    button.toggleClassName("occupied-right", occRight);
  });
}

/** @param {number} i */
const WorkspaceButton = (i) => Widget.EventBox({
  class_name: "ws-button active-left active-right",
  on_primary_click_release: () => Hyprland.messageAsync(`dispatch workspace ${i}`)
    .catch(logError),
  child: Widget.Label({
    label: `${i}`,
    class_name: "ws-button-label"
  })
})
  .hook(hideEmptyWorkspaces, (button) => {
    button.visible = !hideEmptyWorkspaces.value || wsVisible(i, button);
  })
  .hook(Hyprland, (button) => {
    button.visible = !hideEmptyWorkspaces.value || wsVisible(i, button);
  }, "notify::workspaces")
  .hook(Hyprland.active.workspace, (button) => {
    const active = JSON.parse(Hyprland.message("j/monitors")).map(mon => mon.activeWorkspace.id).includes(i);
    button.toggleClassName("active", active);
  });

export const Workspaces = () => Widget.EventBox({
  child: Widget.Box({
    class_name: "ws-container",
    children: Array.from({length: 10}, (_, i) => i + 1).map(i => WorkspaceButton(i)),
  })
    .hook(Hyprland, applyCssToWs, "notify::workspaces")
    .hook(hideEmptyWorkspaces, applyCssToWs)
});


export default Workspaces;