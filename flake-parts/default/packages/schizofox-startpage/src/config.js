// ╔╗ ╔═╗╔╗╔╔╦╗╔═╗
// ╠╩╗║╣ ║║║ ║ ║ ║
// ╚═╝╚═╝╝╚╝ ╩ ╚═╝
// ┌─┐┌─┐┌┐┌┌─┐┬┌─┐┬ ┬┬─┐┌─┐┌┬┐┬┌─┐┌┐┌
// │  │ ││││├┤ ││ ┬│ │├┬┘├─┤ │ ││ ││││
// └─┘└─┘┘└┘└  ┴└─┘└─┘┴└─┴ ┴ ┴ ┴└─┘┘└┘

const CONFIG = {
  // ┌┐ ┌─┐┌─┐┬┌─┐┌─┐
  // ├┴┐├─┤└─┐││  └─┐
  // └─┘┴ ┴└─┘┴└─┘└─┘

  // General
  name: "X I L A I N",
  openInNewTab: false,
  twelveHourFormat: false,
  title: "Home",

  // Theme
  theme: "latte-mocha",
  imageBackground: false,
  imageUrl: "./assets/background.jpg", // Set custom background image URL. If the page is served insecurely, you may have issues loading images from pages over https.

  // Greetings
  greetingMorning: "Good morning!",
  greetingAfternoon: "Good afternoon,",
  greetingEvening: "Good evening,",
  greetingNight: "Go to Sleep!",

  // Layout
  bentoLayout: "lists", // 'bento', 'lists', 'buttons'

  // Weather
  weatherKey: "InsertYourAPIKeyHere123456", // Write here your API Key
  weatherIcons: "OneDark", // 'Onedark', 'Nord', 'Dark', 'White'
  weatherUnit: "C", // 'F', 'C'
  language: "en", // More languages in https://openweathermap.org/current#multi

  trackLocation: true, // If false or an error occurs, the app will use the lat/lon below
  defaultLatitude: "37.775",
  defaultLongitude: "-122.419",

  // Autochange
  autoChangeTheme: true,

  // Autochange by OS
  changeThemeByOS: true,

  // Autochange by hour options (24hrs format, string must be in: hh:mm)
  changeThemeByHour: false,
  hourDarkThemeActive: "18:30",
  hourDarkThemeInactive: "07:00",

  // Autochange automatically based on location (sunrise/sunset). Openweathermap API key required.
  changeThemeByLocation: false,

  // ┌┐ ┬ ┬┌┬┐┌┬┐┌─┐┌┐┌┌─┐
  // ├┴┐│ │ │  │ │ ││││└─┐
  // └─┘└─┘ ┴  ┴ └─┘┘└┘└─┘

  firstButtonsContainer: [
    {
      id: "1",
      name: "Github",
      icon: "github",
      link: "https://github.com/",
    },
    {
      id: "2",
      name: "Mail",
      icon: "mail",
      link: "https://webmail.xilain.dev/",
    },
    {
      id: "3",
      name: "Todoist",
      icon: "trello",
      link: "https://todoist.com",
    },
    {
      id: "4",
      name: "Calendar",
      icon: "calendar",
      link: "https://calendar.google.com/calendar/r",
    },
    {
      id: "5",
      name: "Reddit",
      icon: "glasses",
      link: "https://reddit.com",
    },
    {
      id: "6",
      name: "Odysee",
      icon: "youtube",
      link: "https://odysee.com/",
    },
    {
      id: "7",
      name: "Monkeytype",
      icon: "type",
      link: "https://monkeytype.com/",
    },
  ],

  secondButtonsContainer: [
    {
      id: "1",
      name: "Music",
      icon: "headphones",
      link: "https://open.spotify.com",
    },
    {
      id: "2",
      name: "twitter",
      icon: "twitter",
      link: "https://twitter.com/",
    },
    {
      id: "3",
      name: "bot",
      icon: "bot",
      link: "https://discord.com/app",
    },
    {
      id: "4",
      name: "Amazon",
      icon: "shopping-bag",
      link: "https://amazon.com/",
    },
    {
      id: "5",
      name: "Hashnode",
      icon: "pen-tool",
      link: "https://hashnode.com/",
    },
    {
      id: "6",
      name: "Figma",
      icon: "figma",
      link: "https://figma.com/",
    },
  ],

  // ┬  ┬┌─┐┌┬┐┌─┐
  // │  │└─┐ │ └─┐
  // ┴─┘┴└─┘ ┴ └─┘

  // First Links Container
  firstlistsContainer: [
    {
      icon: "lollipop",
      id: "1",
      links: [
        // 4chan
        {
          name: "/a/",
          link: "https://www.4chan.org/a/",
        },
        {
          name: "/ck/",
          link: "https://www.4chan.org/ck/",
        },
        {
          name: "/g/",
          link: "https://www.4chan.org/g/",
        },
        {
          name: "/w/",
          link: "https://www.4chan.org/w/",
        },
        {
          name: "/wg/",
          link: "https://www.4chan.org/wg/",
        },
      ],
    },
    {
      icon: "fingerprint",
      id: "2",
      links: [
        // Reddit
        {
          name: "r/android",
          link: "https://www.reddit.com/r/android",
        },
        {
          name: "r/sysadmin",
          link: "https://www.reddit.com/r/sysadmin",
        },
        {
          name: "r/linux",
          link: "https://www.reddit.com/r/linux",
        },
        {
          name: "r/unixporn",
          link: "https://www.reddit.com/r/unixporn",
        },
        {
          name: "r/hyprland",
          link: "https://www.reddit.com/r/hyprland",
        },
      ],
    },
  ],

  // Second Links Container
  secondListsContainer: [
    {
      icon: "binary",
      id: "1",
      links: [
        // NixOS
        {
          name: "NixOS Manual",
          link: "https://nixos.org/manual/nixos/unstable/",
        },
        {
          name: "Nixpkgs Manual",
          link: "https://nixos.org/manual/nixpkgs/unstable/",
        },
        {
          name: "Nix Manual",
          link: "https://nixos.org/manual/nix/unstable/",
        },
        {
          name: "noogle",
          link: "https://noogle.dev/",
        },
        {
          name: "Cool NixOS",
          link: "https://github.com/mikeroyal/NixOS-Guide",
        },
      ],
    },
    {
      icon: "dribbble",
      id: "2",
      links: [
        // Youtube, Monkeytype
        {
          name: "Odysee",
          link: "https://odysee.com/",
        },
        {
          name: "Monkeytype",
          link: "https://monkeytype.com/",
        },
      ],
    },
  ],
};
