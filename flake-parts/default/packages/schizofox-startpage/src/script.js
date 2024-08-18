const blob = document.getElementById("blob");
const sideMenu = document.getElementById("sidemenu");
const settings_button = document.getElementById("settings-button");
const blur = document.getElementById("blur");
// const hexagon = document.getElementsByClassName("hexagon");

window.addEventListener("pointermove", ({ clientX, clientY }) => {
  if (!blob_switch.checked) return;

  blob.animate(
    {
      left: `${clientX}px`,
      top: `${clientY}px`,
    },
    { duration: 3000, fill: "forwards" }
  );
});

settings_button.addEventListener("click", () => sideMenu.classList.add("active"));
blur.addEventListener("click", () => sideMenu.classList.remove("active"));

blob_switch.addEventListener("click", () => {
    blob.style.display = blob_switch.checked ? "block" : "none";
    localStorage.setItem("blob", blob_switch.checked);
});

rotation_switch.addEventListener("click", () => {
    if (rotation_switch.checked) {
        for (let i = 0; i < hexagon.length; i++) {
            hexagon[i].classList.remove("no-rotation");
        };
    } else {
        for (let i = 0; i < hexagon.length; i++) {
            hexagon[i].classList.add("no-rotation");
        };
    }

    localStorage.setItem("rotation", rotation_switch.checked);
});