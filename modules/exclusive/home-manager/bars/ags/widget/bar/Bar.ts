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
    class_name: "bar",
    name: `bar${monitor}`,
    exclusivity: "exclusive",
    anchor: ['top', 'left', 'right'],
    margins: [8, 8, 0, 8],
    child: Widget.CenterBox({
        css: "min-height: 1px; min-width: 1px;",
        startWidget: Widget.Box({
            hexpand: true,
            children: [
                Widget.Box({
                    className: "barLeft",
                    children: [
                        Left(),
                        Media(monitor, "start"),
                        // RoundedAngleEnd("topright", {class_name: "angle"})
                    ]
                }),
            ]
        }),
        centerWidget: Widget.Box({
            hpack: "center",
            children: [
                Widget.Box({
                    className: "barCenter",
                    children: [
                        Workspaces(),
                    ]
                }),
            ]
        }),
        endWidget: Widget.Box({
            hexpand: true,
            children: [
                Widget.Box({ expand: true }),
                Widget.Box({
                    className: "barRight",
                    children: [
                        // RoundedAngleEnd("topleft", {class_name: "angle", click_through: true}),
                        // Cava(monitor, "end"),
                        SysTray(monitor, "end"),
                        BatteryBar(monitor, "end"),
                        SystemIndicators(monitor, "end"),
                        Date(monitor, "last"),
                        ]
                    }),
                ]
        }),
    }),
})
