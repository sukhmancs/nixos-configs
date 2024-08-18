{config, ...}:
let inherit (config) modules;
inherit (modules.themes) colors;
in ''
  /*define root variables */
  :root {
    --background-color: #${colors.base00};
    --icon-color: #${colors.base00};
    --hex-gradient-1: #${colors.base0E};
    --hex-gradient-2: #${colors.base0E};
    --blob-color: #${colors.base0E};
  }

  body {
    background-color: var(--background-color);
    overflow: hidden;
  }

  .hexagon {
    width: 70px;
    height: 100px;
    background-image: linear-gradient(
      90deg,
      var(--hex-gradient-1),
      var(--hex-gradient-2)
    );
    border-radius: 15px;
    transition: transform 400ms ease;
    position: fixed;
  }

  .no-rotation:hover{
    transform: rotate(0deg) !important;
  }
  .hexagon:hover {
    transform: rotate(30deg);
  }
  .hexagon:before,
  .hexagon:after {
    content: "";
    display: block;
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    width: inherit;
    height: inherit;
    background-image: inherit;
    border-radius: inherit;
  }
  .hexagon:before {
    transform: rotate(60deg);
  }
  .hexagon:after {
    transform: rotate(-60deg);
  }

  /* 5x2 grid */
  .grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    grid-template-rows: repeat(2, 1fr);
    grid-gap: 20px;
    width: 500px;
    height: 150px;
    padding: 20px;
    box-sizing: border-box;
    /* align in center of screen */
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }

  .center {
    /* align in center */
    display: flex;
    justify-content: center;
    align-items: center;
    height: 10px;
  }

  .hex-icon {
    /* align vertically in center */
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 100%;
    font-size: 35px;
    position: relative;
    z-index: 1;
    text-decoration: none;
    color: var(--icon-color);
  }

  #blob {
    background-color: white;
    height: 20vmax;
    aspect-ratio: 1;
    position: absolute;
    left: 50%;
    top: 50%;
    translate: -50% -50%;
    border-radius: 50%;
    background: linear-gradient(to right, var(--blob-color), var(--hex-gradient-1));
    animation: rotate 20s infinite;
    opacity: 0.8;
    display: none;
  }

  /* #blur covers entire screen */
  #blur {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    /* background: linear-gradient(to right, aquamarine, mediumpurple); */
    backdrop-filter: blur(100px);
    z-index: 0;
  }

  .settings {
    position: absolute;
    top: 0;
    right: 0;
    padding: 20px;
    box-sizing: border-box;
    z-index: 1;
    color: var(--hex-gradient-1);
  }

  .sidemenu {
    position: absolute;
    top: 0;
    right: 0;
    width: 300px;
    height: 99%;
    background-color: var(--background-color);
    border: 3px solid var(--hex-gradient-1);
    border-radius: 15px 0 0 15px;
    z-index: 1;
    transform: translateX(+100%);
    transition: transform 400ms ease;
  }

  .sidemenu.active {
    transform: translateX(0);
  }

  .close-button {
    position: absolute;
    top: 0;
    right: 0;
    padding: 10px;
    box-sizing: border-box;
    color: var(--hex-gradient-1);
    cursor: pointer;
    z-index: -1;
  }

  .settings-options {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 100%;
  }

  .setting {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    padding: 10px;
    box-sizing: border-box;
    color: var(--hex-gradient-1);
  }

  .setting-name {
    font-size: 20px;
    font-family: 'Encode Sans', sans-serif;
  }

  input[type=checkbox]{
    height: 0;
    width: 0;
    visibility: hidden;
  }

  label {
    cursor: pointer;
    text-indent: -9999px;
    width: 50px;
    height: 30px;
    background: grey;
    display: block;
    border-radius: 100px;
    position: relative;
  }

  label:after {
    content: '';
    position: absolute;
    top: 2.5px;
    left: 2.5px;
    width: 25px;
    height: 25px;
    background: #fff;
    border-radius: 90px;
    transition: 0.3s;
  }

  input:checked + label {
    background: var(--hex-gradient-1);
  }

  input:checked + label:after {
    left: calc(100% - 5px);
    transform: translateX(-100%);
  }

  label:active:after {
    width: 40px;
  }

  .update-button {
    display:inline-block;
    padding:0.35em 1.2em;
    border:0.1em solid var(--hex-gradient-2);
    margin:0 0.3em 0.3em 0;
    border-radius:0.12em;
    box-sizing: border-box;
    text-decoration:none;
    font-family:'Roboto',sans-serif;
    font-weight:300;
    color: var(--hex-gradient-2);
    text-align:center;
    transition: all 0.2s;
  }

  .update-button:hover {
    color: var(--background-color);
    background-color: var(--hex-gradient-1);
  }
'';