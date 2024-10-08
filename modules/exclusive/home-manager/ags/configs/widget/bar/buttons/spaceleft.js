import App from 'resource:///com/github/Aylur/ags/app.js';
import PanelButton from "../PanelButton"
import options from "options"
import nix from "service/nix"
import { barAssignPosition } from "lib/utils"

const { icon, label, action } = options.bar.launcher

function Spinner() {
    const child = Widget.Icon({
        icon: icon.icon.bind(),
        class_name: Utils.merge([
            icon.colored.bind(),
            nix.bind("ready"),
        ], (c, r) => `${c ? "colored" : ""} ${r ? "" : "spinning"}`),
        css: `
            @keyframes spin {
                to { -gtk-icon-transform: rotate(1turn); }
            }

            image.spinning:hover {
                animation-name: spin;
                animation-duration: 1s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
            }
        `,
    })

    return Widget.Revealer({
        transition: "slide_left",
        child,
        reveal_child: Utils.merge([
            icon.icon.bind(),
            nix.bind("ready"),
        ], (i, r) => Boolean(i || r)),
    })
}

export default (monitor: number, pos: string) => PanelButton({
    window: "spaceleft",
    on_clicked: App.toggleWindow('sideleft'),
    setup: self => { barAssignPosition(self, pos) },
    child: Widget.Box({
        children: [
            Spinner(),
            Widget.Label({
                class_name: label.colored.bind().as(c => c ? "colored" : ""),
                visible: label.label.bind().as(v => !!v),
                label: label.label.bind(),
            }),
        ]
    }),
})
