import Cava from "./buttons/Cava"
import Date from "./buttons/Date"
// import Launcher from "./buttons/Launcher"
import Left from "./buttons/Launcher"
import Media from "./buttons/Media"
import PowerMenu from "./buttons/PowerMenu"
import SysTray from "./buttons/SysTray"
import SystemIndicators from "./buttons/SystemIndicators"
import Taskbar from "./buttons/Taskbar"
import Workspaces from "./buttons/Workspaces"
import {RoundedAngleEnd} from "../../roundedCorners/index.js";
import Wallpapers from "./buttons/Wallpapers"
import BatteryBar from "./buttons/BatteryBar"
import options from "options"

const { start, center, end } = options.bar.layout
const pos = options.bar.position.bind()

export type BarWidget = keyof typeof widget

const widget = {
    battery: BatteryBar,
    cava: Cava,
    date: Date,
    // launcher: Launcher,
    media: Media,
    powermenu: PowerMenu,
    systray: SysTray,
    system: SystemIndicators,
    taskbar: Taskbar,
    workspaces: Workspaces,
    wallpapers: Wallpapers,
    expander: () => Widget.Box({ expand: true }),
}

export default (monitor: number) => Widget.Window({
    monitor,
    // class_name: "bar",
    name: `bar${monitor}`,
    exclusivity: "exclusive",
    anchor: ['top', 'left', 'right'],
    // layer: "top",
    margins: [8, 8, 0, 8],
    child: Widget.CenterBox({
        className: "bar",
        // css: "min-width: 2px; min-height: 2px;",
        css: "min-height: 2px; min-width: 1px;",
        // vertical: true,
        startWidget: Widget.Box({
            hexpand: true,
            className: "barLeft",
            // vertical: true,
            // vpack: "start",
            children: [
                Left(),
                Media(monitor, "start"),
                // RoundedAngleEnd("topright", {class_name: "angle"})
            ]
        }),
        centerWidget: Widget.Box({
            // class: "barCenter",
            hpack: "center",
            // vertical: true,
            children: [
                // RoundedAngleEnd("topright", {class_name: "angle"}),
                // BatteryBar(monitor, "end"),
                // SystemIndicators(monitor, "end"),
                Workspaces(),
                // Date(monitor, "last"),
                // SysTray(monitor, "end"),

            ]
        }),
        endWidget: Widget.Box({
            // className: "barRight",
            hexpand: true,
            // vertical: true,
            // vpack: "end",
            children: [
                    // RoundedAngleEnd("topleft", {class_name: "angle", click_through: true}),
                    Cava(monitor, "end"),
                    SysTray(monitor, "end"),
                    BatteryBar(monitor, "end"),
                    SystemIndicators(monitor, "end"),
                    Date(monitor, "last"),
                    Widget.Box({ expand: true }),
                ]
        }),
    }),
})
