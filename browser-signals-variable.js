// Companion Custom JavaScript variable for the "GA4 Bot Traffic Detector" template.
// GTM > Variables > New > Custom JavaScript. Name it: JS - Browser Signals
function() {
  try {
    var n = window.navigator || {};
    var s = window.screen || {};
    var brands = [];
    if (n.userAgentData && n.userAgentData.brands) {
      for (var i = 0; i < n.userAgentData.brands.length; i++) {
        brands.push(n.userAgentData.brands[i].brand);
      }
    }
    return {
      userAgent: n.userAgent || '',
      webdriver: n.webdriver === true,
      brands: brands,
      languages: n.languages ? n.languages.length : undefined,
      outerWidth: window.outerWidth,
      outerHeight: window.outerHeight,
      screenWidth: s.width,
      screenHeight: s.height
    };
  } catch (e) {
    return undefined;
  }
}
