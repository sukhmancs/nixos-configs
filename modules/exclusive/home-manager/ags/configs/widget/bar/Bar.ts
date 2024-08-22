import Cava from "./buttons/Cava";
import Date from "./buttons/Date";
import Launcher from "./buttons/Launcher";
import Chat from "./buttons/Chat";
import Media from "./buttons/Media";
import PowerMenu from "./buttons/PowerMenu";
import SysTray from "./buttons/SysTray";
import SystemIndicators from "./buttons/SystemIndicators";
import Taskbar from "./buttons/Taskbar";
import Workspaces from "./buttons/Workspaces";
import Wallpapers from "./buttons/Wallpapers";
import BatteryBar from "./buttons/BatteryBar";

export default (monitor: number) =>
    Widget.Window({
        monitor,
        class_name: "bar",
        name: `bar${monitor}`,
        exclusivity: "exclusive",
        anchor: ["top", "left", "right"],
        // layer: "top",
        margins: [8, 8, 0, 8],
        child: Widget.CenterBox({
            // css: "min-height: 1px; min-width: 1px;",
            startWidget: Widget.Box({
                hexpand: true,
                children: [
                    Widget.Box({
                        className: "barLeft",
                        children: [Launcher(), Chat(), Media(monitor, "start")],
                    }),
                ],
            }),
            centerWidget: Widget.Box({
                hpack: "center",
                children: [
                    Widget.Box({
                        className: "barCenter",
                        children: [Workspaces()],
                    }),
                ],
            }),
            endWidget: Widget.Box({
                hexpand: true,
                children: [
                    Widget.Box({ expand: true }),
                    Widget.Box({
                        className: "barRight",
                        children: [
                            Cava(monitor, "end"),
                            SysTray(monitor, "end"),
                            BatteryBar(monitor, "end"),
                            SystemIndicators(monitor, "end"),
                            Date(monitor, "last"),
                        ],
                    }),
                ],
            }),
        }),
    });
