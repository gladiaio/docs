// Gladia voice assistant: Mintlify loads every root .js file on every page. This adds the Vox
// website widget, which draws its own launcher and answers from these docs. The key is publishable
// and only accepted from the docs' origin. If the site sets a CSP, it needs
// script-src https://vox.gladia.io and connect-src https://vox.gladia.io wss://rtc.vox.gladia.io.
(function () {
  if (document.getElementById("vox-widget-script")) return;
  var script = document.createElement("script");
  script.id = "vox-widget-script";
  script.src = "https://vox.gladia.io/embed/v1/widget.js";
  script.async = true;
  script.setAttribute("data-key", "vox_pub_9ktiRFEOfz8WaaTBsp-aUm-_-PSi7W0H");
  document.head.appendChild(script);
})();
