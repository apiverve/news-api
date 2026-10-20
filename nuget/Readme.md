World News API
============

World News is a global news API that reads about 275 outlet feeds in 29 editions and 6 languages and merges them into stories: one entry per story however many outlets carry it, ranked by that coverage. Filter by 13 topics, by the country a story is about, by the edition it ran in, or by language.


[![NuGet version](https://img.shields.io/nuget/v/APIVerve.API.WorldNews.svg)](https://www.nuget.org/packages/APIVerve.API.WorldNews)

This is a .NET wrapper for the [World News API](https://apiverve.com/marketplace/news?utm_source=nuget&utm_medium=referral&utm_content=readme)

---

## Installation

Using the .NET CLI:
```
dotnet add package APIVerve.API.WorldNews
```

Using the Package Manager:
```
nuget install APIVerve.API.WorldNews
```

Using the Package Manager Console:
```
Install-Package APIVerve.API.WorldNews
```

From within Visual Studio:

1. Open the Solution Explorer
2. Right-click on a project within your solution
3. Click on Manage NuGet Packages
4. Click on the Browse tab and search for "APIVerve.API.WorldNews"
5. Click on the APIVerve.API.WorldNews package, select the appropriate version in the right-tab and click Install

---

## Configuration

Before using the World News API client, you have to setup your account and obtain your API Key.
You can get it by signing up at [https://apiverve.com](https://apiverve.com?utm_source=nuget&utm_medium=referral&utm_content=readme)

---

## Quick Start

Here's a simple example to get you started quickly:

```csharp
using System;
using APIVerve.API.WorldNews;

class Program
{
    static async Task Main(string[] args)
    {
        // Initialize the API client
        var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");

        var queryOptions = new WorldNewsQueryOptions {
            Category = "technology",
            Country = "JP",
            Edition = "GB",
            Language = "es",
            Sort = "top",
            Q = "chips",
            Since = "2026-10-01",
            Limit = 10
        };

        // Make the API call
        try
        {
            var response = await apiClient.ExecuteAsync(queryOptions);

            if (response.Error != null)
            {
                Console.WriteLine($"API Error: {response.Error}");
            }
            else
            {
                Console.WriteLine("Success!");
                // Access response data using the strongly-typed ResponseObj properties
                Console.WriteLine(Newtonsoft.Json.JsonConvert.SerializeObject(response, Newtonsoft.Json.Formatting.Indented));
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Exception: {ex.Message}");
        }
    }
}
```

---

## Usage

The World News API documentation is found here: [https://docs.apiverve.com/ref/news](https://docs.apiverve.com/ref/news?utm_source=nuget&utm_medium=referral&utm_content=readme).
You can find parameters, example responses, and status codes documented here.

### Setup

###### Authentication
World News API uses API Key-based authentication. When you create an instance of the API client, you can pass your API Key as a parameter.

```csharp
// Create an instance of the API client
var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");
```

---

## Usage Examples

### Basic Usage (Async/Await Pattern - Recommended)

The modern async/await pattern provides the best performance and code readability:

```csharp
using System;
using System.Threading.Tasks;
using APIVerve.API.WorldNews;

public class Example
{
    public static async Task Main(string[] args)
    {
        var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");

        var queryOptions = new WorldNewsQueryOptions {
            Category = "technology",
            Country = "JP",
            Edition = "GB",
            Language = "es",
            Sort = "top",
            Q = "chips",
            Since = "2026-10-01",
            Limit = 10
        };

        var response = await apiClient.ExecuteAsync(queryOptions);

        if (response.Error != null)
        {
            Console.WriteLine($"Error: {response.Error}");
        }
        else
        {
            Console.WriteLine(Newtonsoft.Json.JsonConvert.SerializeObject(response, Newtonsoft.Json.Formatting.Indented));
        }
    }
}
```

### Synchronous Usage

If you need to use synchronous code, you can use the `Execute` method:

```csharp
using System;
using APIVerve.API.WorldNews;

public class Example
{
    public static void Main(string[] args)
    {
        var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");

        var queryOptions = new WorldNewsQueryOptions {
            Category = "technology",
            Country = "JP",
            Edition = "GB",
            Language = "es",
            Sort = "top",
            Q = "chips",
            Since = "2026-10-01",
            Limit = 10
        };

        var response = apiClient.Execute(queryOptions);

        if (response.Error != null)
        {
            Console.WriteLine($"Error: {response.Error}");
        }
        else
        {
            Console.WriteLine(Newtonsoft.Json.JsonConvert.SerializeObject(response, Newtonsoft.Json.Formatting.Indented));
        }
    }
}
```

---

## Error Handling

The API client provides comprehensive error handling. Here are some examples:

### Handling API Errors

```csharp
using System;
using System.Threading.Tasks;
using APIVerve.API.WorldNews;

public class Example
{
    public static async Task Main(string[] args)
    {
        var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");

        var queryOptions = new WorldNewsQueryOptions {
            Category = "technology",
            Country = "JP",
            Edition = "GB",
            Language = "es",
            Sort = "top",
            Q = "chips",
            Since = "2026-10-01",
            Limit = 10
        };

        try
        {
            var response = await apiClient.ExecuteAsync(queryOptions);

            // Check for API-level errors
            if (response.Error != null)
            {
                Console.WriteLine($"API Error: {response.Error}");
                Console.WriteLine($"Status: {response.Status}");
                return;
            }

            // Success - use the data
            Console.WriteLine("Request successful!");
            Console.WriteLine(Newtonsoft.Json.JsonConvert.SerializeObject(response, Newtonsoft.Json.Formatting.Indented));
        }
        catch (ArgumentException ex)
        {
            // Invalid API key or parameters
            Console.WriteLine($"Invalid argument: {ex.Message}");
        }
        catch (System.Net.Http.HttpRequestException ex)
        {
            // Network or HTTP errors
            Console.WriteLine($"Network error: {ex.Message}");
        }
        catch (Exception ex)
        {
            // Other errors
            Console.WriteLine($"Unexpected error: {ex.Message}");
        }
    }
}
```

### Comprehensive Error Handling with Retry Logic

```csharp
using System;
using System.Threading.Tasks;
using APIVerve.API.WorldNews;

public class Example
{
    public static async Task Main(string[] args)
    {
        var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");

        // Configure retry behavior (max 3 retries)
        apiClient.SetMaxRetries(3);        // Retry up to 3 times (default: 0, max: 3)
        apiClient.SetRetryDelay(2000);     // Wait 2 seconds between retries

        var queryOptions = new WorldNewsQueryOptions {
            Category = "technology",
            Country = "JP",
            Edition = "GB",
            Language = "es",
            Sort = "top",
            Q = "chips",
            Since = "2026-10-01",
            Limit = 10
        };

        try
        {
            var response = await apiClient.ExecuteAsync(queryOptions);

            if (response.Error != null)
            {
                Console.WriteLine($"API Error: {response.Error}");
            }
            else
            {
                Console.WriteLine("Success!");
                Console.WriteLine(Newtonsoft.Json.JsonConvert.SerializeObject(response, Newtonsoft.Json.Formatting.Indented));
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Failed after retries: {ex.Message}");
        }
    }
}
```

---

## Advanced Features

### Custom Headers

Add custom headers to your requests:

```csharp
var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");

// Add custom headers
apiClient.AddCustomHeader("X-Custom-Header", "custom-value");
apiClient.AddCustomHeader("X-Request-ID", Guid.NewGuid().ToString());

var queryOptions = new WorldNewsQueryOptions {
    Category = "technology",
    Country = "JP",
    Edition = "GB",
    Language = "es",
    Sort = "top",
    Q = "chips",
    Since = "2026-10-01",
    Limit = 10
};

var response = await apiClient.ExecuteAsync(queryOptions);

// Remove a header
apiClient.RemoveCustomHeader("X-Custom-Header");

// Clear all custom headers
apiClient.ClearCustomHeaders();
```

### Request Logging

Enable logging for debugging:

```csharp
var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]", isDebug: true);

// Or use a custom logger
apiClient.SetLogger(message =>
{
    Console.WriteLine($"[LOG] {DateTime.Now:yyyy-MM-dd HH:mm:ss} - {message}");
});

var queryOptions = new WorldNewsQueryOptions {
    Category = "technology",
    Country = "JP",
    Edition = "GB",
    Language = "es",
    Sort = "top",
    Q = "chips",
    Since = "2026-10-01",
    Limit = 10
};

var response = await apiClient.ExecuteAsync(queryOptions);
```

### Retry Configuration

Customize retry behavior for failed requests:

```csharp
var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");

// Set retry options
apiClient.SetMaxRetries(3);           // Retry up to 3 times (default: 0, max: 3)
apiClient.SetRetryDelay(1500);        // Wait 1.5 seconds between retries (default: 1000ms)

var queryOptions = new WorldNewsQueryOptions {
    Category = "technology",
    Country = "JP",
    Edition = "GB",
    Language = "es",
    Sort = "top",
    Q = "chips",
    Since = "2026-10-01",
    Limit = 10
};

var response = await apiClient.ExecuteAsync(queryOptions);
```

### Dispose Pattern

The API client implements `IDisposable` for proper resource cleanup:

```csharp
var queryOptions = new WorldNewsQueryOptions {
    Category = "technology",
    Country = "JP",
    Edition = "GB",
    Language = "es",
    Sort = "top",
    Q = "chips",
    Since = "2026-10-01",
    Limit = 10
};

using (var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]"))
{
    var response = await apiClient.ExecuteAsync(queryOptions);
    Console.WriteLine(Newtonsoft.Json.JsonConvert.SerializeObject(response, Newtonsoft.Json.Formatting.Indented));
}
// HttpClient is automatically disposed here
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

Need any assistance? [Get in touch with Customer Support](https://apiverve.com/contact?utm_source=nuget&utm_medium=referral&utm_content=readme).

---

## Updates
Stay up to date by following [@apiverveHQ](https://twitter.com/apiverveHQ) on Twitter.

---

## Legal

All usage of the APIVerve website, API, and services is subject to the [APIVerve Terms of Service](https://apiverve.com/terms?utm_source=nuget&utm_medium=referral&utm_content=readme) and all legal documents and agreements.

---

## License
Licensed under the MIT License (MIT)

Copyright (&copy;) 2026 APIVerve, and EvlarSoft LLC

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
