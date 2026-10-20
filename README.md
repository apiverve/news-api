# [World News API](https://apiverve.com/marketplace/news?utm_source&#x3D;github&amp;utm_medium&#x3D;referral&amp;utm_content&#x3D;readme)

World News is a global news API that reads about 275 outlet feeds in 29 editions and 6 languages and merges them into stories: one entry per story however many outlets carry it, ranked by that coverage. Filter by 13 topics, by the country a story is about, by the edition it ran in, or by language.

The World News API provides a simple, reliable way to integrate world news functionality into your applications. Built for developers who need production-ready world news capabilities without the complexity of building from scratch.

**[View API Details →](https://apiverve.com/marketplace/news?utm_source&#x3D;github&amp;utm_medium&#x3D;referral&amp;utm_content&#x3D;readme)**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![API Status](https://img.shields.io/badge/Status-Active-green.svg)](https://apiverve.com/marketplace/news?utm_source&#x3D;github&amp;utm_medium&#x3D;referral&amp;utm_content&#x3D;readme)
[![Method](https://img.shields.io/badge/Method-GET-blue.svg)](#)
[![Platform](https://img.shields.io/badge/Platform-Multi--Platform-orange.svg)](#installation)

**Available on:**
[![npm](https://img.shields.io/badge/npm-CB3837?style=flat&logo=npm&logoColor=white)](https://www.npmjs.com/package/@apiverve/news)
[![NuGet](https://img.shields.io/badge/NuGet-004880?style=flat&logo=nuget&logoColor=white)](https://www.nuget.org/packages/APIVerve.API.WorldNews)
[![PyPI](https://img.shields.io/badge/PyPI-3776AB?style=flat&logo=python&logoColor=white)](https://pypi.org/project/apiverve-news/)
[![RubyGems](https://img.shields.io/badge/RubyGems-E9573F?style=flat&logo=rubygems&logoColor=white)](https://rubygems.org/gems/apiverve_news)
[![Packagist](https://img.shields.io/badge/Packagist-F28D1A?style=flat&logo=packagist&logoColor=white)](https://packagist.org/packages/apiverve/news)
[![Go](https://img.shields.io/badge/Go-00ADD8?style=flat&logo=go&logoColor=white)](#-go)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white)](https://pub.dev/packages/apiverve_news)
[![JitPack](https://img.shields.io/badge/JitPack-2E7D32?style=flat&logo=android&logoColor=white)](#-android-jitpack)

---

## Quick Start

### Using JavaScript

```javascript
async function callWorldNewsAPI() {
    try {
        const params = new URLSearchParams({
            category: 'technology',
            country: 'JP',
            edition: 'GB',
            language: 'es',
            sort: 'top',
            limit: 10
        });

        const response = await fetch(`https://api.apiverve.com/v1/news?${params}`, {
            method: 'GET',
            headers: {
                'x-api-key': 'YOUR_API_KEY_HERE'
            }
        });

        const data = await response.json();
        console.log(data);
    } catch (error) {
        console.error('Error:', error);
    }
}

callWorldNewsAPI();
```

### Using cURL

```bash
curl -X GET "https://api.apiverve.com/v1/news?category=technology&country=JP&edition=GB&language=es&sort=top&limit=10" \
  -H "x-api-key: YOUR_API_KEY_HERE"
```

**Get your API key:** [https://apiverve.com](https://apiverve.com)

**📁 For more examples, see the [examples folder](./examples/)**

---

## Installation

Choose your preferred programming language:

### 📦 NPM (JavaScript/Node.js)

```bash
npm install @apiverve/news
```

[**View NPM Package →**](https://www.npmjs.com/package/@apiverve/news) | [**Package Code →**](./npm/)

---

### 🔷 NuGet (.NET/C#)

```bash
dotnet add package APIVerve.API.WorldNews
```

[**View NuGet Package →**](https://www.nuget.org/packages/APIVerve.API.WorldNews) | [**Package Code →**](./nuget/)

---

### 🐍 Python (PyPI)

```bash
pip install apiverve-news
```

[**View PyPI Package →**](https://pypi.org/project/apiverve-news/) | [**Package Code →**](./python/)

---

### 💎 Ruby (RubyGems)

```bash
gem install apiverve_news
```

[**View RubyGems Package →**](https://rubygems.org/gems/apiverve_news) | [**Package Code →**](./ruby/)

---

### 🐘 PHP (Packagist)

```bash
composer require apiverve/news
```

[**View Packagist Package →**](https://packagist.org/packages/apiverve/news) | [**Package Code →**](./php/)

---

### 🎯 Dart (pub.dev)

```bash
dart pub add apiverve_news
```

[**View pub.dev Package →**](https://pub.dev/packages/apiverve_news) | [**Package Code →**](./dart/)

---

### 🤖 Android (JitPack)

```gradle
implementation 'com.github.apiverve:news-api:1.0.0'
```

[**Package Code →**](./android/)

---

### 🐹 Go

```bash
go get github.com/apiverve/news-api/go
```

[**Package Code →**](./go/)

---

## Why Use This API?

| Feature | Benefit |
|---------|---------|
| **Multi-language SDKs** | Native packages for JavaScript, Python, C#, Go, and Android |
| **Simple Integration** | Single API key authentication, consistent response format |
| **Production Ready** | 99.9% uptime SLA, served from 24 global regions |
| **Comprehensive Docs** | Full examples, OpenAPI spec, and dedicated support |

---

## Documentation

- 🏠 **API Home:** [World News API](https://apiverve.com/marketplace/news?utm_source&#x3D;github&amp;utm_medium&#x3D;referral&amp;utm_content&#x3D;readme)
- 📚 **API Reference:** [docs.apiverve.com/ref/news](https://docs.apiverve.com/ref/news)
- 📖 **OpenAPI Spec:** [openapi.yaml](./openapi.yaml)
- 💡 **Examples:** [examples/](./examples/)

---

## What Can You Build?

The World News API is commonly used for:

- **Web Applications** - Add world news features to your frontend or backend
- **Mobile Apps** - Native SDKs for Android development
- **Automation** - Integrate with n8n, Zapier, or custom workflows
- **SaaS Products** - Enhance your product with world news capabilities
- **Data Pipelines** - Process and analyze data at scale

---

## API Reference

### Authentication
All requests require an API key in the header:
```
x-api-key: YOUR_API_KEY_HERE
```

Get your API key: [https://apiverve.com](https://apiverve.com)

### Response Format

Every APIVerve endpoint returns the same envelope — check `status`, then read `data`:

```json
{
  "status": "ok",
  "error": null,
  "data": { ... }
}
```

### Example Response

A real response from the World News API:

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

## Support & Community

- 🏠 **API Home**: [World News API](https://apiverve.com/marketplace/news?utm_source&#x3D;github&amp;utm_medium&#x3D;referral&amp;utm_content&#x3D;readme)
- 💬 **Support**: [https://apiverve.com/contact](https://apiverve.com/contact)
- 🐛 **Issues**: [GitHub Issues](../../issues)
- 📖 **Documentation**: [https://docs.apiverve.com](https://docs.apiverve.com)
- 🌐 **Website**: [https://apiverve.com](https://apiverve.com)

---

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## Security

For security concerns, please review our [Security Policy](SECURITY.md).

---

## License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

Built with ❤️ by [APIVerve](https://apiverve.com)

Copyright © 2026 APIVerve. All rights reserved.
