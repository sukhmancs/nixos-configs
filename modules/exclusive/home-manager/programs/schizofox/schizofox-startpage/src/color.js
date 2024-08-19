const root = document.querySelector(':root');

function updateColor(){
    // get css variables
    const computedStyle = getComputedStyle(root);
    let bg_color = computedStyle.getPropertyValue('--background-color');
    let p_color = computedStyle.getPropertyValue('--hex-gradient-1');
    let s_color = computedStyle.getPropertyValue('--hex-gradient-2');
    let i_color = computedStyle.getPropertyValue('--icon-color');
    let b_color = computedStyle.getPropertyValue('--blob-color');

    // set cookies
    localStorage.setItem("bg_color", bg_color);
    localStorage.setItem("p_color", p_color);
    localStorage.setItem("s_color", s_color);
    localStorage.setItem("i_color", i_color);
    localStorage.setItem("b_color", b_color);
}