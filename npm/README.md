# World News API

World News is a global news API that reads about 275 outlet feeds in 29 editions and 6 languages and merges them into stories: one entry per story however many outlets carry it, ranked by that coverage. Filter by 13 topics, by the country a story is about, by the edition it ran in, or by language.

[![npm version](https://img.shields.io/npm/v/@apiverve/news.svg)](https://www.npmjs.com/package/@apiverve/news)

This is a JavaScript wrapper for the [World News API](https://apiverve.com/marketplace/news?utm_source=npm&utm_medium=referral&utm_content=readme)

---

## Installation

Using npm:
```shell
npm install @apiverve/news
```

Using yarn:
```shell
yarn add @apiverve/news
```

---

## Configuration

Before using the World News API client, you have to setup your account and obtain your API Key.
You can get it by signing up at [https://apiverve.com](https://apiverve.com?utm_source=npm&utm_medium=referral&utm_content=readme)

---

## Quick Start

[Get started with the Quick Start Guide](https://docs.apiverve.com/quickstart?utm_source=npm&utm_medium=referral&utm_content=readme)

The World News API documentation is found here: [https://docs.apiverve.com/ref/news](https://docs.apiverve.com/ref/news?utm_source=npm&utm_medium=referral&utm_content=readme).
You can find parameters, example responses, and status codes documented here.

### Setup

```javascript
const newsAPI = require('@apiverve/news');
const api = new newsAPI({
    api_key: '[YOUR_API_KEY]'
});
```

---

## Usage

---

### Perform Request

Using the API is simple. All you have to do is make a request. The API will return a response with the data you requested.

```javascript
var query = {
  category: "technology",
  country: "JP",
  edition: "GB",
  language: "es",
  sort: "top",
  q: "chips",
  since: "2026-10-01",
  limit: 10
};

api.execute(query, function (error, data) {
    if (error) {
        return console.error(error);
    } else {
        console.log(data);
    }
});
```

---

### Using Promises

You can also use promises to make requests. The API returns a promise that you can use to handle the response.

```javascript
var query = {
  category: "technology",
  country: "JP",
  edition: "GB",
  language: "es",
  sort: "top",
  q: "chips",
  since: "2026-10-01",
  limit: 10
};

api.execute(query)
    .then(data => {
        console.log(data);
    })
    .catch(error => {
        console.error(error);
    });
```

---

### Using Async/Await

You can also use async/await to make requests. The API returns a promise that you can use to handle the response.

```javascript
async function makeRequest() {
    var query = {
  category: "technology",
  country: "JP",
  edition: "GB",
  language: "es",
  sort: "top",
  q: "chips",
  since: "2026-10-01",
  limit: 10
};

    try {
        const data = await api.execute(query);
        console.log(data);
    } catch (error) {
        console.error(error);
    }
}
```

---

## Example Response

```json
{
  "status": "ok",
  "error": null,
  "data": {
    "date": "2026-10-06",
    "category": "technology",
    "edition": null,
    "languages": [
      "en"
    ],
    "country": null,
    "sort": "top",
    "lastUpdated": "2026-10-06T21:25:23.605Z",
    "articleCount": 3,
    "articles": [
      {
        "category": "technology",
        "website": "Ars Technica",
        "title": "Amazon kills Alexa’s ability to control Echo speakers' AUX input",
        "pubDate": "2026-10-06T17:03:16.000Z",
        "image": "https://cdn.arstechnica.net/wp-content/uploads/2018/11/71I6oj6ZFBL._SL1000_-1000x648.jpg",
        "description": "Amazon hasn't made an Echo with a 3.5mm port in six years.",
        "link": "https://arstechnica.com/gadgets/2026/10/amazon-bricks-alexas-ability-to-control-echo-speakers-aux-input/",
        "id": "1c4e377fb78ebbb0",
        "categories": [
          "technology"
        ],
        "countries": [],
        "edition": "US",
        "language": "en",
        "coverage": 2,
        "sources": [
          {
            "website": "The Verge",
            "title": "Alexa can’t control the aux input on Amazon Echo speakers anymore",
            "link": "https://www.theverge.com/tech/1006103/amazon-alexa-aux-voice-commands",
            "pubDate": "2026-10-06T19:03:56.000Z"
          }
        ],
        "sentiment": "neutral",
        "sentimentScore": -1
      },
      {
        "category": "technology",
        "website": "TechRadar",
        "title": "ASOS hacked? Customers receive threatening notification from hackers, here’s what we know",
        "pubDate": "2026-10-06T09:51:14.000Z",
        "image": "https://cdn.mos.cms.futurecdn.net/vcsoVeYWsa449Faq6GXYyf-1920-80.jpg",
        "description": "The ASOS app sent out a threatening notification to thousands of users.",
        "link": "https://www.techradar.com/pro/security/asos-hacked-customers-receive-threatening-notification-from-hackers-heres-what-we-know",
        "id": "2f99fc0e8c1c33ac",
        "categories": [
          "technology"
        ],
        "countries": [],
        "edition": "GB",
        "language": "en",
        "coverage": 2,
        "sources": [
          {
            "website": "BBC News",
            "title": "Asos confirms hackers sent 'unauthorised' notification to app users",
            "link": "https://www.bbc.co.uk/news/articles/cj62ylzpr6d3o",
            "pubDate": "2026-10-06T17:50:19.000Z"
          }
        ],
        "sentiment": "very negative",
        "sentimentScore": -5
      },
      {
        "category": "technology",
        "website": "CBC News",
        "title": "Belgian physicist awarded Nobel Prize for pioneering work tracking neutrino particles at South Pole",
        "pubDate": "2026-10-06T10:33:19.000Z",
        "image": "https://i.cbc.ca/ais/817f3f8b-5650-4364-afd6-852d370b00ba,1791288766832/full/max/0/default.jpg?im=Crop%2Crect%3D%280%2C25%2C2200%2C1237%29%3B",
        "description": "Belgian American particle physicist Francis Halzen was announced as the winner of the 2026 Nobel Prize in Physics on Tuesday in Stockholm.",
        "link": "https://www.cbc.ca/news/world/nobel-award-physics-9.7369209?cmp=rss",
        "id": "912e072816d90c8e",
        "categories": [
          "technology"
        ],
        "countries": [
          "BE",
          "US",
          "SE"
        ],
        "edition": "CA",
        "language": "en",
        "coverage": 2,
        "sources": [
          {
            "website": "Ars Technica",
            "title": "Neutrino physicist wins 2026 Nobel Physics Prize",
            "link": "https://arstechnica.com/science/2026/10/neutrino-physicist-wins-2026-nobel-physics-prize/",
            "pubDate": "2026-10-06T16:53:17.000Z"
          }
        ],
        "sentiment": "very positive",
        "sentimentScore": 7
      }
    ]
  }
}
```

---

## Customer Support

Need any assistance? [Get in touch with Customer Support](https://apiverve.com/contact?utm_source=npm&utm_medium=referral&utm_content=readme).

---

## Updates

Stay up to date by following [@apiverveHQ](https://twitter.com/apiverveHQ) on Twitter.

---

## Legal

All usage of the APIVerve website, API, and services is subject to the [APIVerve Terms of Service](https://apiverve.com/terms?utm_source=npm&utm_medium=referral&utm_content=readme) and [Privacy Policy](https://apiverve.com/privacy?utm_source=npm&utm_medium=referral&utm_content=readme).

---

## License
Licensed under the MIT License (MIT)

Copyright (&copy;) 2026 APIVerve, and EvlarSoft LLC

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
