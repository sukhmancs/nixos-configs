const blob_switch = document.getElementById("blob-switch");
const rotation_switch = document.getElementById("rotation-switch");
const hexagon = document.getElementsByClassName("hexagon");

if (localStorage.getItem("blob") == "true") {
  blob_switch.checked = true;
  blob.style.display = "block";
} else {
  blob_switch.checked = false;
  blob.style.display = "none";
}

if (
  localStorage.getItem("rotation") == "true" ||
  localStorage.getItem("rotation") == null
) {
  rotation_switch.checked = true;
  for (let i = 0; i < hexagon.length; i++) {
    hexagon[i].classList.remove("no-rotation");
  }
} else {
  rotation_switch.checked = false;
  for (let i = 0; i < hexagon.length; i++) {
    hexagon[i].classList.add("no-rotation");
  }
}

if (localStorage.getItem("bg_color") != null) {
  root.style.setProperty(
    "--background-color",
    localStorage.getItem("bg_color")
  );
  document.getElementById("color-background").value =
    localStorage.getItem("bg_color");
}

if (localStorage.getItem("p_color") != null) {
  root.style.setProperty("--hex-gradient-1", localStorage.getItem("p_color"));
  document.getElementById("color-primary").value =
    localStorage.getItem("p_color");
}

if (localStorage.getItem("s_color") != null) {
  root.style.setProperty("--hex-gradient-2", localStorage.getItem("s_color"));
  document.getElementById("color-secondary").value =
    localStorage.getItem("s_color");
}

if (localStorage.getItem("i_color") != null) {
  root.style.setProperty("--icon-color", localStorage.getItem("i_color"));
  document.getElementById("color-icon").value = localStorage.getItem("i_color");
}

if (localStorage.getItem("b_color") != null) {
  root.style.setProperty("--blob-color", localStorage.getItem("b_color"));
  document.getElementById("color-blob").value = localStorage.getItem("b_color");
}