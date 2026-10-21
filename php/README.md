# World News API - PHP Package

World News is a global news API that reads about 275 outlet feeds in 29 editions and 6 languages and merges them into stories: one entry per story however many outlets carry it, ranked by that coverage. Filter by 13 topics, by the country a story is about, by the edition it ran in, or by language.

## Installation

Install via Composer:

```bash
composer require apiverve/news
```

## Getting Started

Get your API key at [APIVerve](https://apiverve.com)

### Basic Usage

```php
<?php

require_once 'vendor/autoload.php';

use APIVerve\News\Client;

// Initialize the client
$client = new Client('YOUR_API_KEY');

// Make a request
$response = $client->execute([
    'category' => 'technology',
    'country' => 'JP',
    'edition' => 'GB',
    'language' => 'es',
    'sort' => 'top',
    'q' => 'chips',
    'since' => '2026-10-01',
    'limit' => 10
]);

// Print the response
print_r($response);
```


### Error Handling

```php
use APIVerve\News\Client;
use APIVerve\News\Exceptions\APIException;
use APIVerve\News\Exceptions\ValidationException;

try {
    $response = $client->execute(['category' => 'technology', 'country' => 'JP', 'edition' => 'GB', 'language' => 'es', 'sort' => 'top', 'q' => 'chips', 'since' => '2026-10-01', 'limit' => 10]);
    print_r($response['data']);
} catch (ValidationException $e) {
    echo "Validation error: " . implode(', ', $e->getErrors());
} catch (APIException $e) {
    echo "API error: " . $e->getMessage();
    echo "Status code: " . $e->getStatusCode();
}
```

### Debug Mode

```php
// Enable debug logging
$client = new Client(
    apiKey: 'YOUR_API_KEY',
    debug: true
);
```

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

## Requirements

- PHP 7.4 or higher
- Guzzle HTTP client

## Documentation

For more information, visit the [API Documentation](https://docs.apiverve.com/ref/news?utm_source=packagist&utm_medium=referral&utm_content=readme).

## Support

- Website: [https://apiverve.com/marketplace/news?utm_source=php&utm_medium=referral&utm_content=readme](https://apiverve.com/marketplace/news?utm_source=php&utm_medium=referral&utm_content=readme)
- Email: hello@apiverve.com

## License

This package is available under the [MIT License](LICENSE).
