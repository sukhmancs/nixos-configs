import App from 'resource:///com/github/Aylur/ags/app.js';
import options from "options"

const { icon } = options.bar.launcher

const Left = () => Widget.EventBox({
  on_primary_click_release: () => {App.toggleWindow('launcher')},
  on_secondary_click_release: () => {App.toggleWindow('sideleft')},
  child: Widget.Box({
    class_name: "launcher panel-button",
    children: [
      Widget.Icon({
        icon: icon.icon.bind(),
    }),
    ]
  }),
});

export default Left;