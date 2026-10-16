# GA4 Bot Traffic Detector (GTM variable template)

GA4 already drops traffic from known bots on the IAB list. This template catches what gets through: AI agents (GPTBot, ClaudeBot, PerplexityBot, ChatGPT-User), SEO crawlers, uptime monitors, Lighthouse/PageSpeed, and headless or automated browsers (Puppeteer, Playwright, Selenium). It labels each hit so you can segment or exclude that traffic in GA4.

## How it works

GTM's sandbox can't read `navigator` or `screen`, so browser data comes from a small companion Custom JavaScript variable. The template scores these signals:

| Signal | Score | Reason value |
|---|---|---|
| User agent contains a bot pattern (about 50 built in, plus your own) | 100 | `ua:<pattern>` |
| `navigator.webdriver === true` | 100 | `webdriver` |
| "HeadlessChrome" in User-Agent Client Hints brands | 100 | `headless:ua-data` |
| Empty `navigator.languages` | 40 | `headless:no-languages` |
| 0×0 browser window | 40 | `headless:zero-window` |
| 0×0 screen | 40 | `headless:zero-screen` |
| Your own "force bot" variable is true | 100 | `custom` |

A hit is a bot when its total score (capped at 100) is at or above the threshold (default 50). Any strong signal is enough on its own, but at least two weak signals are needed.

"cubot" (an Android phone brand) is always allowlisted, and you can add your own allowlist patterns.

## Setup

1. **Add the companion variable.** Go to Variables > New > Custom JavaScript, name it `JS - Browser Signals`, and paste in [`browser-signals-variable.js`](browser-signals-variable.js).
2. **Add the template variable.** Go to Variables > New > GA4 Bot Traffic Detector and set **Browser signals** to `{{JS - Browser Signals}}`. Name it `Bot Status`.
   - You can pass a plain user-agent variable instead. Only the user-agent check runs in that case.
3. **Send it to GA4.** In your Google tag (GA4 configuration), add `bot_status` = `{{Bot Status}}` as a configuration parameter or shared event setting, so every event carries it. You can also send it as a user property.
4. **Register it in GA4.** Go to Admin > Custom definitions > Create custom dimension, with parameter `bot_status` and scope Event (or User for a user property).
5. **Optional: exclude bots.** Use the `bot_status` dimension in segments, comparisons, or Explorations.
   - For hard exclusion, GA4 data filters only act on the `traffic_type` parameter. You can set `traffic_type` = `{{Bot Status}}` (with bot label `bot`), then create an Internal traffic data filter that excludes the value `bot`. Always start the filter in **Testing** state, because active data filters permanently remove data.
   - If you already use `traffic_type` for internal-IP filtering, don't overwrite it; stick with the custom dimension.

## Outputs

- **Label**: `bot` / `human` (both labels can be changed)
- **Boolean**: `true` / `false`
- **Score**: 0–100
- **Matched signals**: for example `ua:bot|webdriver`, or `none`. Useful while debugging in Preview mode.

## Limitations

- Most server-side crawlers don't run JavaScript, so they never reach GA4. This template targets bots that do.
- Advanced bots can fake their user agent and hide automation flags. Treat the output as a strong heuristic, not a guarantee.
- This is a client-side check. For stronger protection, combine it with server-side GTM or CDN bot management.

## Submitting to the Community Template Gallery

1. Create a public GitHub repo containing `template.tpl`, `metadata.yaml`, `LICENSE` (Apache 2.0), and this README.
2. Commit, then put that commit's full SHA in `metadata.yaml` (and fix the GitHub URLs). Commit again.
3. Go to tagmanager.google.com/gallery and use **Submit template** with the repo URL.
4. For later releases, export the updated `template.tpl` from GTM, commit it, and add a new entry at the top of `versions` in `metadata.yaml`.

## License

Apache 2.0
