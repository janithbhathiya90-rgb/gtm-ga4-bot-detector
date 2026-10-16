___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "GA4 Bot Traffic Detector",
  "categories": [
    "ANALYTICS",
    "UTILITY"
  ],
  "brand": {
    "id": "brand_dummy",
    "displayName": "Janith",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAABvklEQVR4nO1bS04DMQwdEFdAIIrELbgAbDgPPUZ7nm44AbdAAkTFEVjAakoVJfGM82w3Y79Vm0xivzf+ZKrpMAQCAc844yy6ef76RTuCwuf2ehanWRefMvEUU4WYdFFPxFNQQpxTG/RMfhho/6vqSJN/e7o9fL7bvUuaKkZCUQBJ8sfEU0gKkROBTIGlIyuA1d2fMt+CHK+IgHSg96pPIeWnHgFUkZPuBincp8CFhdHxLmueA0owEeBg/OHn/8tub+KD+xQIAawdsIZ7AeBF8GNzJb5utcYVTGgEcMlb2oEJoEUebQ8igDZ5pN1mAazIo+y77wLuBRB/FjhuWdxWJ5lmYgLkevU4ViPEXceF+xQQEYA6qZXmuetaEBFg7YA1RASgilVpnruuBe4jQKwNjndrbj/nruNC/CCk8ftAC9yngHsBxFPg+/G+eY/Ll1eAJ3m4j4AQwNoBazTXgNV6X21Zkvk72m8BJAIkntK07MJSQFsElD1oDdASAWkHfg6wSgcu3HeBECAdmPu+fW9I+UUE5AaXGgXxsnQGRQGWFgUlPtUIWIoINR5kCvQuAuV//GuMs/kpC9F7xAYCyvgDAZGZf+lTAzIAAAAASUVORK5CYII="
  },
  "description": "Flags bot, crawler, AI-agent and headless-browser traffic for GA4. Returns a bot/human label, true/false, a 0-100 score or the matched signals.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "browserSignals",
    "displayName": "Browser signals",
    "simpleValueType": true,
    "valueHint": "{{JS - Browser Signals}}",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Select the companion Custom JavaScript variable that returns browser signals (see the template documentation), or any variable that returns the user agent string. GTM templates cannot read navigator or screen directly."
  },
  {
    "type": "SELECT",
    "name": "outputType",
    "displayName": "Return value",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "label",
        "displayValue": "Label (e.g. \"bot\" / \"human\")"
      },
      {
        "value": "boolean",
        "displayValue": "Boolean (true = bot)"
      },
      {
        "value": "score",
        "displayValue": "Bot score (0-100)"
      },
      {
        "value": "reason",
        "displayValue": "Matched signals (for debugging)"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "label",
    "help": "Use <strong>Label</strong> for a GA4 custom dimension or the <code>traffic_type</code> parameter. Use <strong>Matched signals</strong> to see why a hit was flagged."
  },
  {
    "type": "TEXT",
    "name": "botLabel",
    "displayName": "Bot label",
    "simpleValueType": true,
    "defaultValue": "bot",
    "enablingConditions": [
      {
        "paramName": "outputType",
        "paramValue": "label",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "humanLabel",
    "displayName": "Human label",
    "simpleValueType": true,
    "defaultValue": "human",
    "enablingConditions": [
      {
        "paramName": "outputType",
        "paramValue": "label",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "threshold",
    "displayName": "Bot score threshold (0-100)",
    "simpleValueType": true,
    "defaultValue": "50",
    "valueValidators": [
      {
        "type": "NON_NEGATIVE_NUMBER"
      }
    ],
    "help": "A browser is classified as a bot when its score is at least this value. Strong signals (user agent, webdriver, headless brand) score 100; weak headless heuristics score 40 each, so two are needed with the default of 50."
  },
  {
    "type": "GROUP",
    "name": "detectionGroup",
    "displayName": "Detection checks",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "checkUserAgent",
        "checkboxText": "Match user-agent against bot patterns",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Matches crawlers, AI agents (GPTBot, ClaudeBot, PerplexityBot...), SEO tools, uptime monitors and automation libraries."
      },
      {
        "type": "CHECKBOX",
        "name": "useDefaultPatterns",
        "checkboxText": "Use built-in bot pattern list",
        "simpleValueType": true,
        "defaultValue": true
      },
      {
        "type": "CHECKBOX",
        "name": "checkWebdriver",
        "checkboxText": "Flag navigator.webdriver = true",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Set by Selenium, Puppeteer, Playwright and other automation tools."
      },
      {
        "type": "CHECKBOX",
        "name": "checkHeadless",
        "checkboxText": "Use headless-browser heuristics",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "HeadlessChrome brand in User-Agent Client Hints (score 100), plus weak signals: empty navigator.languages, 0x0 window, 0x0 screen (40 each)."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "customGroup",
    "displayName": "Custom rules",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "customPatterns",
        "displayName": "Additional bot patterns",
        "help": "Extra user-agent substrings to treat as bots, e.g. your own monitoring tool.",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "User agent contains (case-insensitive)",
            "name": "pattern",
            "type": "TEXT"
          }
        ]
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "allowPatterns",
        "displayName": "Allowlist patterns",
        "help": "Substrings removed from the user agent before matching, to prevent false positives. \"cubot\" (a phone brand) is always allowlisted.",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "User agent contains (case-insensitive)",
            "name": "pattern",
            "type": "TEXT"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "customSignal",
        "displayName": "Force bot when this value is true",
        "simpleValueType": true,
        "help": "Optional. Select a variable (e.g. a QA cookie or a dataLayer flag). The values true, \"true\" or \"1\" classify the hit as a bot."
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "debug",
    "checkboxText": "Log detection result to the console (Preview mode only)",
    "simpleValueType": true,
    "defaultValue": false
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// GA4 Bot Traffic Detector - Google Tag Manager variable template.
// Classifies the current browser as bot or human from user-agent patterns
// and automation/headless-browser signals.
//
// GTM's sandbox cannot read navigator/screen directly, so browser data comes
// in through the "Browser signals" field: either a user-agent string, or an
// object from the companion Custom JavaScript variable (see README).

const makeString = require('makeString');
const makeNumber = require('makeNumber');
const getType = require('getType');
const logToConsole = require('logToConsole');

// Known crawlers, monitoring tools, AI agents, SEO tools and automation
// frameworks. Matched case-insensitively as substrings of the user agent.
const DEFAULT_UA_PATTERNS = [
  'bot', 'crawl', 'spider', 'slurp', 'headless', 'phantomjs', 'lighthouse',
  'pagespeed', 'gtmetrix', 'pingdom', 'uptime', 'facebookexternalhit',
  'meta-externalagent', 'google-inspectiontool', 'googleother',
  'mediapartners-google', 'apis-google', 'feedfetcher', 'bingpreview',
  'chatgpt-user', 'claude-user', 'claude-web', 'anthropic-ai',
  'perplexity-user', 'cohere-ai', 'ahrefs', 'semrush', 'mj12', 'screaming frog',
  'sitebulb', 'dataforseo', 'prerender', 'puppeteer', 'playwright', 'selenium',
  'webdriver', 'cypress', 'scrapy', 'python-', 'curl/', 'wget', 'go-http-client',
  'java/', 'httpclient', 'axios', 'node-fetch', 'undici'
];

// Legitimate user agents that contain a bot-like substring.
// 'cubot' is an Android phone brand ("CUBOT" contains "bot").
const DEFAULT_ALLOW_PATTERNS = ['cubot'];

const lower = (value) => makeString(value === undefined || value === null ? '' : value).toLowerCase();

const tableToList = (table) => {
  const out = [];
  if (getType(table) !== 'array') return out;
  table.forEach((row) => {
    const p = lower(row && row.pattern).trim();
    if (p) out.push(p);
  });
  return out;
};

// Normalise the input: a string is treated as the user agent.
const input = data.browserSignals;
const inputType = getType(input);
const src = inputType === 'object' ? input : {};
const userAgent = lower(inputType === 'string' ? input : src.userAgent);

const signals = [];
let score = 0;
const addSignal = (name, weight) => {
  signals.push(name);
  score += weight;
};

// 1. User-agent patterns
if (data.checkUserAgent && userAgent) {
  // Strip allowlisted terms first so they can't trigger a match.
  let ua = userAgent;
  DEFAULT_ALLOW_PATTERNS.concat(tableToList(data.allowPatterns)).forEach((term) => {
    ua = ua.split(term).join(' ');
  });
  const patterns = (data.useDefaultPatterns ? DEFAULT_UA_PATTERNS : [])
    .concat(tableToList(data.customPatterns));
  for (let i = 0; i < patterns.length; i++) {
    if (ua.indexOf(patterns[i]) > -1) {
      addSignal('ua:' + patterns[i], 100);
      break;
    }
  }
}

// 2. WebDriver flag (Selenium, Puppeteer, Playwright and similar set this)
if (data.checkWebdriver && (src.webdriver === true || lower(src.webdriver) === 'true')) {
  addSignal('webdriver', 100);
}

// 3. Headless-browser heuristics (need the object form of the input)
if (data.checkHeadless && inputType === 'object') {
  const brands = src.brands;
  if (getType(brands) === 'array') {
    for (let i = 0; i < brands.length; i++) {
      const b = getType(brands[i]) === 'object' ? brands[i].brand : brands[i];
      if (lower(b).indexOf('headless') > -1) {
        addSignal('headless:ua-data', 100);
        break;
      }
    }
  }
  const langs = src.languages;
  const langCount = getType(langs) === 'array' ? langs.length : makeNumber(langs);
  if (langs !== undefined && langs !== null && langCount === 0) {
    addSignal('headless:no-languages', 40);
  }
  if (src.outerWidth === 0 && src.outerHeight === 0) {
    addSignal('headless:zero-window', 40);
  }
  if (src.screenWidth === 0 || src.screenHeight === 0) {
    addSignal('headless:zero-screen', 40);
  }
}

// 4. Optional custom signal (e.g. a QA cookie or a server-side flag)
if (data.customSignal === true || lower(data.customSignal) === 'true' || lower(data.customSignal) === '1') {
  addSignal('custom', 100);
}

const parsedThreshold = makeNumber(data.threshold);
const threshold = (getType(parsedThreshold) === 'number' && parsedThreshold === parsedThreshold) ? parsedThreshold : 50;
const finalScore = score > 100 ? 100 : score;
const isBot = signals.length > 0 && finalScore >= threshold;

if (data.debug) {
  if (!userAgent) logToConsole('[GA4 Bot Detector] No user agent received - check the Browser signals field.');
  logToConsole('[GA4 Bot Detector]', {isBot: isBot, score: finalScore, signals: signals});
}

if (data.outputType === 'boolean') return isBot;
if (data.outputType === 'score') return finalScore;
if (data.outputType === 'reason') return signals.length ? signals.join('|') : 'none';
return isBot ? makeString(data.botLabel || 'bot') : makeString(data.humanLabel || 'human');


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Regular desktop browser is human
  code: |-
    mockData.browserSignals = browser({});
    assertThat(runCode(mockData)).isEqualTo('human');
- name: Googlebot user agent is bot
  code: |-
    mockData.browserSignals = browser({userAgent: 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)'});
    assertThat(runCode(mockData)).isEqualTo('bot');
- name: Plain user agent string input works
  code: |-
    mockData.browserSignals = 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)';
    mockData.outputType = 'reason';
    assertThat(runCode(mockData)).isEqualTo('ua:bot');
- name: Reason output names the matched pattern
  code: |-
    mockData.browserSignals = browser({userAgent: 'Mozilla/5.0 (X11; Linux x86_64) HeadlessChrome/120.0.0.0 Safari/537.36'});
    mockData.outputType = 'reason';
    assertThat(runCode(mockData)).isEqualTo('ua:headless');
- name: Cubot phone is not flagged
  code: |-
    mockData.browserSignals = browser({userAgent: 'Mozilla/5.0 (Linux; Android 11; CUBOT KINGKONG 5 Pro) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0 Mobile Safari/537.36'});
    assertThat(runCode(mockData)).isEqualTo('human');
- name: WebDriver flag true is bot
  code: |-
    mockData.browserSignals = browser({webdriver: true});
    mockData.outputType = 'boolean';
    assertThat(runCode(mockData)).isEqualTo(true);
- name: Headless brand in client hints is bot
  code: |-
    mockData.browserSignals = browser({brands: ['HeadlessChrome', 'Chromium']});
    assertThat(runCode(mockData)).isEqualTo('bot');
- name: Single weak headless signal stays below threshold
  code: |-
    mockData.browserSignals = browser({languages: 0});
    mockData.outputType = 'score';
    assertThat(runCode(mockData)).isEqualTo(40);
    mockData.outputType = 'label';
    assertThat(runCode(mockData)).isEqualTo('human');
- name: Two weak headless signals cross threshold
  code: |-
    mockData.browserSignals = browser({languages: 0, outerWidth: 0, outerHeight: 0});
    assertThat(runCode(mockData)).isEqualTo('bot');
- name: Custom pattern and custom labels
  code: |-
    mockData.browserSignals = browser({userAgent: 'MyInternalMonitor/1.0'});
    mockData.customPatterns = [{pattern: 'MyInternalMonitor'}];
    mockData.botLabel = 'suspected_bot';
    assertThat(runCode(mockData)).isEqualTo('suspected_bot');
- name: Custom allow pattern overrides default pattern
  code: |-
    mockData.browserSignals = browser({userAgent: 'Mozilla/5.0 MyCompanyApp-Robot/2.0 Chrome/120.0'});
    mockData.allowPatterns = [{pattern: 'mycompanyapp-robot'}];
    assertThat(runCode(mockData)).isEqualTo('human');
- name: Custom signal flags bot
  code: |-
    mockData.browserSignals = browser({});
    mockData.customSignal = 'true';
    assertThat(runCode(mockData)).isEqualTo('bot');
- name: Disabled checks are ignored
  code: |-
    mockData.browserSignals = browser({userAgent: 'Googlebot/2.1', webdriver: true});
    mockData.checkUserAgent = false;
    mockData.checkWebdriver = false;
    mockData.outputType = 'reason';
    assertThat(runCode(mockData)).isEqualTo('none');
- name: Missing input is not flagged
  code: |-
    mockData.browserSignals = undefined;
    assertThat(runCode(mockData)).isEqualTo('human');
setup: |-
  const pick = (o, k, d) => (o[k] !== undefined ? o[k] : d);
  const browser = (o) => ({
    userAgent: pick(o, 'userAgent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'),
    webdriver: pick(o, 'webdriver', false),
    brands: pick(o, 'brands', ['Google Chrome', 'Chromium']),
    languages: pick(o, 'languages', 2),
    outerWidth: pick(o, 'outerWidth', 1440),
    outerHeight: pick(o, 'outerHeight', 900),
    screenWidth: pick(o, 'screenWidth', 1440),
    screenHeight: pick(o, 'screenHeight', 900)
  });

  const mockData = {
    outputType: 'label',
    botLabel: 'bot',
    humanLabel: 'human',
    threshold: '50',
    checkUserAgent: true,
    useDefaultPatterns: true,
    checkWebdriver: true,
    checkHeadless: true,
    debug: false
  };


___NOTES___

Created on 16/10/2026. GA4 Bot Traffic Detector variable template.
