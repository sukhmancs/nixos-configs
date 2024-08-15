import App from 'resource:///com/github/Aylur/ags/app.js';
import options from "options"

const { icon } = options.bar.chat

const Chat = () => Widget.EventBox({
  on_primary_click_release: () => {App.toggleWindow('sideleft')},
  child: Widget.Box({
    class_name: "launcher panel-button",
    children: [
      Widget.Icon({
        icon: icon.icon.bind(),
    }),
    ]
  }),
});

export default Chat;