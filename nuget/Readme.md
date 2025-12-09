APIVerve.API.WorldNews API
============

News API is a simple tool for scraping news data. It returns the news title, description, and more.

![Build Status](https://img.shields.io/badge/build-passing-green)
![Code Climate](https://img.shields.io/badge/maintainability-B-purple)
![Prod Ready](https://img.shields.io/badge/production-ready-blue)

This is a .NET Wrapper for the [APIVerve.API.WorldNews API](https://apiverve.com/marketplace/news)

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

Before using the news API client, you have to setup your account and obtain your API Key.
You can get it by signing up at [https://apiverve.com](https://apiverve.com)

---

## Quick Start

Here's a simple example to get you started quickly:

```csharp
using System;
using APIVerve;

class Program
{
    static async Task Main(string[] args)
    {
        // Initialize the API client
        var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");

        var queryOptions = new WorldNewsQueryOptions {
  category = "technology"
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

The APIVerve.API.WorldNews API documentation is found here: [https://docs.apiverve.com/ref/news](https://docs.apiverve.com/ref/news).
You can find parameters, example responses, and status codes documented here.

### Setup

###### Authentication
APIVerve.API.WorldNews API uses API Key-based authentication. When you create an instance of the API client, you can pass your API Key as a parameter.

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
using APIVerve;

public class Example
{
    public static async Task Main(string[] args)
    {
        var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");

        var queryOptions = new WorldNewsQueryOptions {
  category = "technology"
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
using APIVerve;

public class Example
{
    public static void Main(string[] args)
    {
        var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");

        var queryOptions = new WorldNewsQueryOptions {
  category = "technology"
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
using APIVerve;

public class Example
{
    public static async Task Main(string[] args)
    {
        var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");

        var queryOptions = new WorldNewsQueryOptions {
  category = "technology"
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
using APIVerve;

public class Example
{
    public static async Task Main(string[] args)
    {
        var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]");

        // Configure retry behavior (max 3 retries)
        apiClient.SetMaxRetries(3);        // Retry up to 3 times (default: 0, max: 3)
        apiClient.SetRetryDelay(2000);     // Wait 2 seconds between retries

        var queryOptions = new WorldNewsQueryOptions {
  category = "technology"
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
  category = "technology"
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
  category = "technology"
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
  category = "technology"
};

var response = await apiClient.ExecuteAsync(queryOptions);
```

### Dispose Pattern

The API client implements `IDisposable` for proper resource cleanup:

```csharp
using (var apiClient = new WorldNewsAPIClient("[YOUR_API_KEY]"))
{
    var queryOptions = new WorldNewsQueryOptions {
  category = "technology"
};
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
    "date": "2025-02-20",
    "category": "technology",
    "articleCount": 60,
    "articles": [
      {
        "category": "technology",
        "website": "Latest news",
        "title": "An Android Auto glitch is causing phones to reboot - here's how to fix it",
        "pubDate": "Thu, 20 Feb 2025 21:03:15 GMT",
        "description": "If you're having trouble with Android Auto, a specific version of the app may be to blame.",
        "link": "https://www.zdnet.com/article/an-android-auto-glitch-is-causing-phones-to-reboot-heres-how-to-fix-it/"
      },
      {
        "category": "technology",
        "website": "Latest news",
        "title": "iPhone 15 Pro is getting Apple's AI-powered Visual Intelligence",
        "pubDate": "Thu, 20 Feb 2025 21:01:50 GMT",
        "description": "iPhone 15 Pro owners will be able to use the Action button to get details on items they capture through the camera - once iOS 18.4 expands the skill beyond the iPhone 16.",
        "link": "https://www.zdnet.com/article/iphone-15-pro-is-getting-apples-ai-powered-visual-intelligence/"
      },
      {
        "category": "technology",
        "website": "Latest news",
        "title": "The best VPN services of 2025: Expert tested and reviewed",
        "pubDate": "Thu, 20 Feb 2025 20:55:28 GMT",
        "description": "We've extensively tested the best VPN solutions, ranking their security, speed, streaming capabilities, and features. Here are our recommendations.",
        "link": "https://www.zdnet.com/article/best-vpn/"
      },
      {
        "category": "technology",
        "website": "The Verge",
        "title": "Adidas plugs its website and app into Amazon&#8217;s &#8216;Buy with Prime&#8217; program",
        "pubDate": "2025-02-20T20:54:47Z",
        "description": "Adidas’s site and app will soon get “Buy with Prime” Amazon fulfillment, allowing Prime members to receive free shipping and streamlined returns when ordering directly from the three-stripe brand.  Beginning in the spring, paying US-based Amazon Prime subscribers will see Prime-eligible items for sale on adidas.com and through the Adidas app. By logging into their Amazon account during checkout, those items will be fulfilled by Amazon. In addition to faster free shipping, Prime members who make purchases this way will be able to view and track the purchase through their Amazon account. If you do the bulk of your shopping on Amazon then Buy with Prime may be a handy way to centralize your purchase history into one easy-to-find location, or at least make your subscription fee go a little further on the websites of other brands. While Adidas is joining thousands of other companies registered in the direct-to-consumer Buy with Prime program, it seems to be a notable score for Amazon when it comes to brand clout. Other notable brands linked up with the program include Belkin, Steve Madden, Laura Mercier, Izod, MrBeast, and more.",
        "link": "https://www.theverge.com/news/616891/amazon-adidas-buy-with-prime-direct-to-consumer"
      },
      {
        "category": "technology",
        "website": "The Verge",
        "title": "The busiest US airline now supports Apple’s AirTag location sharing",
        "pubDate": "2025-02-20T20:45:35Z",
        "description": "An American Airlines plane on the tarmac at the Miami International Airport on February 19, 2025 in Miami, Florida. | Photo: Joe Raedle / Getty Images  American Airlines has announced support for Apple’s Share Item Location feature, potentially making it easier for passengers to be reunited with lost luggage tracked with an AirTag. The airline transported 226,405,000 passengers around the world last year, making it the busiest and one of the largest carriers in the US. Share Item Location was first introduced as part of the iOS 18.2 update released last December. AirTag users are able to generate a shareable link within Apple’s Find My app on iPhones, iPads, or Macs allowing others to access an interactive map showing the location, or last known location, of a missing item. The link will be deactivated when a lost item is recovered and the location sharing can be turned off at any time. The links also automatically expire after seven days. “We’ve introduced the ability for customers to easily and securely share the location of their AirTag or Find My network accessory directly with the airline,” an American Airlines spokesperson told View from the Wing’s Gary Leff. “Customers can generate a link through Apple’s Share Item feature available on iOS 18.2 or later and share it with American in the rare case when a bag is delayed for any trips with a segment from or to a U.S. airport. Customers just need to scan the QR code at the baggage office to start their claim and provide their information.” Airlines like United, Delta, and Air Canada integrated the Share Item Location feature into their lost luggage procedures soon after it was released. Additional carriers, including Lufthansa Group and Virgin Atlantic, announced support earlier this month.",
        "link": "https://www.theverge.com/news/616912/american-airlines-apple-airtag-share-item-location-lost-luggage"
      },
      {
        "category": "technology",
        "website": "Latest news",
        "title": "I tried Google Photos' AI search and it was surprisingly bad - 3 ways to fix it",
        "pubDate": "Thu, 20 Feb 2025 20:40:00 GMT",
        "description": "'Ask Photos' actually made Google Photos worse. Here are 3 ways to make it genuinely helpful.",
        "link": "https://www.zdnet.com/article/i-tried-google-photos-ai-search-and-it-was-surprisingly-bad-3-ways-to-fix-it/"
      },
      {
        "category": "technology",
        "website": "The Verge",
        "title": "The Verge’s favorite kitchen gadgets",
        "pubDate": "2025-02-20T20:30:00Z",
        "description": "Many members of The Verge’s staff enjoy cooking — and all enjoy eating. Inspired by that admittedly obvious thought, we asked them to say which kitchen tools they most enjoy using these days. We got a wide and fascinating array of answers. They include gadgets that need to be charged, such as electric kettles, blenders, and smart thermometers, as well as simpler, non-powered tools like egg holders, spreader knives, and wooden spoons. (Sometimes simpler can be better.) So check out how our writers and editors hone their foodie skills, and let us know in the comments what your favorite kitchen tool is. (And feel free to check out our previous listing of favorite kitchen gadgets.) Charged gadgets As new parents, my wife and I heat up water a lot, whether it’s for baby formula or for our third cup of a caffeinated beverage to get us through the afternoon. We used to heat our water in a teapot on the stove — the horror — but after getting an electric kettle over the holidays, our lives have been forever changed. With this, the water heats up way faster, and the kettle turns itself off once the water is too hot, meaning it won’t whistle through the house (and possibly wake the baby). It’s the only kitchen gadget that has a permanent spot on our counters. Maybe I’ll heat up some tea for myself right now. — Jay Peters, news editor After realizing we’re not a family who likes to get their hands dirty while cooking (we leave that part to mixers and blenders), an automatic soap dispenser has become one of the most used devices in our kitchen. We opted for a cheap $25 option from Amazon that lets you adjust how much foaming soap is dispensed and lasts for a couple months between charges, but companies like Simplehuman sell pricier $80 versions wrapped in brushed metal or other fancy finishes that could better match your decor. We find we use less soap now that it’s always perfectly portioned out, and buying refills in bulk is much cheaper. There’s now one in every bathroom in our home. — Andrew Liszewski, senior reporter I may take some heat for this, but anyone who tells you that frozen Junior Mints, M&M’s, or — gasp — Sno-Caps are the perfect companion for an at-home movie night is unequivocally wrong. Popcorn is the true film snack, and Presto’s basic air popper has been my go-to in recent years for quickly whipping up large batches of the timeless treat.  The PopLite doesn’t require oil, nor do you need to shake or stir it like you do traditional stovetop methods. You just toss in the kernels, plug it in, and let the hot air do the work for you. Admittedly, it’s a little loud and bigger than I’d like for a single-use appliance that sits in my pantry, but you’d be hard-pressed to find a more foolproof method of making popcorn. Well, unless you’re into prefab bags of Orville Redenbacher. Even I can’t fault you for that. — Brandon Widder, senior commerce editor For the past few years, the Instant Pot has been a staple in my kitchen. From making rice to slow-cooking stews and even frying up chicken, it can do just about anything. The best part is that the Instant Pot can cook most recipes in a fraction of the time it would take in the oven or on the stove. Rice, for example, takes just six minutes to cook (not counting the amount of time it takes to build pressure), and there’s no fussing with covering the pot or adjusting the heat. Sometimes, it’s just easier — and much less stressful — to let the Instant Pot take the wheel. — Emma Roth, news writer How often do you blend things? Is it never? Maybe the reason is that taking out, assembling, and cleaning up after a normal blender is just way too much work. Do you know how many sauces I’ve thickened since getting an immersion blender? This thing is small, quick to set up, and you can mostly clean it with just a blast under the faucet. You’re going to blend so many things. — Jacob Kastrenakes, executive editor My wife and I bought this small blender to make ourselves smoothies and protein shakes. It’s now used to make purees for our baby. C’est la vie. — Antonio G. Di Benedetto, reviewer A meat thermometer is essential in my kitchen, and I haven’t found one as easy to use as the Typhur InstaProbe. I just flip and probe, and then I have a temperature reading in seconds — there’s no need to press any buttons or fiddle with any settings. I’ve used it for well over a year and haven’t had to change its batteries once; it always just works when I pull it out of the drawer (not the case with other digital alternatives I’ve tried). It’s also waterproof, so it’s easy to clean. — Jennifer Pattison Tuohy, reviewer Simple tools One of the first things I did when I got my own place was purchase a food chopper. Perhaps puritan chefs will disagree with my methods, but this saves me so much time. I like to make tikka masala, which requires dicing ginger. If you’ve ever tried to dice ginger, you know that a food chopper would come in handy. This one did break recently, so I’ll probably replace it with a fancier one. — Kylie Robison, senior AI reporter Spreading knives are fantastic, especially if you make as many sandwiches as I do. The broad, flat blade is perfect for spreading peanut butter, cream cheese, or whatever, and the serrated edge is sharp enough for removing crusts and slicing bagels.  The one I used growing up was a Cutco, a relic of my dad’s brief, unsuccessful stint as a knife salesman. This is not that knife. That knife costs $94 today, which feels like a bit much — even if the one my parents have is still in great shape after 45 years — so I got this Wüsthof instead. The handle isn’t quite as comfortable, but it’s a quarter of the price, so I’ll live.  — Nathan Edwards, senior reviews editor My partner and I have the unfortunate habit of buying interesting foodstuffs with the intention of eventually using them — and then finding them in the back of the fridge two months later, growing something, well, interesting. To try and track what we’ve refrigerated, we tried all sorts of phone and tablet apps, but in the end, what finally worked was a simple, inexpensive, and thin magnetic whiteboard. It sticks to the door of the refrigerator, along with some dry markers, and now we record what entrees and side dishes are in the fridge. As each is consumed, the entry gets erased. It’s a simple solution, and it’s not perfect. We still occasionally find a scientific experiment blooming in the back of the fridge, but it’s made us a lot less likely to waste food. — Barbara Krasnoff, reviews editor I never realized how much joy I could get from a grater until my partner and I picked up a Microplane last year. Whether I’m zesting lemons or creating big, pillowy clouds of grated parmesan for my pasta, the Microplane is an absolute pleasure to use. We still keep a big, blunt box grater around for the occasional vegetable, but the Microplane’s sharper blades are better for absolutely everything else. It’s not just us, either — we’ve since gifted this twice, to rave reviews. And if you know me in real life, then I’m afraid it’s only a matter of time before a Microplane comes your way, too. — Dominic Preston, news editor It’s kind of weird how much I like our Gripstics. Bag of chips open? Quick, grab a Gripstic. Kids vibing between two different cereals this week? A well-placed Gripstic will ensure they don’t get all squishy. Tiny package of chocolate chips you used for a recipe that is now kind of open in your cupboard for who knows how long? Just fold the top over, slide a Gripstic on it — the small blue one, thank you — and stop worrying so much.  I don’t know about you or your family’s shopping and eating habits, but try as we might to shop on the outside walls of the grocery store, we inevitably come home with many products packaged in single-use plastic bags. That in and of itself is a frustration, only compounded by those same products going bad if they’re not stored properly. The Gripstics are a simple solution to this universal problem, and one that I’m certain has paid for itself many times over.  — Christopher Grant, group publisher, The Verge and Polygon Pretty much every meal I cook includes garlic, so I genuinely don’t know why it took me so long to get a simple garlic press. But ever since I threw one in the cart absentmindedly on a recent IKEA run, it’s become one of my most-used kitchen tools. I still have to peel the garlic, which I find interminably annoying, but I haven’t had to slice or mince garlic since adding it to my utensil drawer. The press turns the garlic into a kind of mush, and it’s not consistent in the pieces it makes (sometimes larger slivers of garlic get caught around the edges of the press), but for my needs, which is mostly just tossing garlic into a sauté pan or a soup, it’s a dream. — Kristen Radtke, creative director I love a humble piece of bread and butter, but I hate spreading cold, hard butter on bread. Luckily, I haven’t had to since June 2023, when I finally got an airtight ceramic butter dish to store room temperature butter indefinitely. Am I recommending you do the same? No — I’m not prepared to debate anyone on the science behind keeping butter from spoiling. (The FDA says it can be left at room temperature for only one to two days.) All I will say is that the combination of salted butter, an airtight container, and a pair of kids who help me go through it one well-buttered grilled cheese sandwich at a time, has been more than enough to address my own fears.  There are many options like the small Sweese that I use. It just happened to be the first Amazon pick I didn’t return, because it was the first that fit a single block of Kerrygold almost perfectly. — Sean Hollister, senior editor My mom bought me this strange-looking juicer. I was skeptical at first, but I love how it folds flat so that it doesn’t catch on the shallow drawer that I store my kitchen spatulas in. And, of course, it works well as a juicer and is pretty easy to clean. — Helen Havlak, publisher, The Verge Once you get a set of narrow measuring spoons, you’ll never go back. Rather than having to carefully pour a teaspoon or tablespoon of spice into a round measuring spoon that doesn’t fit through the neck of your spice jar, you can just scoop directly from the jar. I absolutely love mine for recipes that require a lot of different spices. This stainless steel set from King Arthur Baking feels solid and has held up well for me despite frequent trips through the dishwasher over the last five years. — Helen Havlak, publisher, The Verge If you’re a backyard chicken owner (or live in Europe or Asia), this elegant countertop egg holder is an excellent way to display your ladies’ efforts and have easy access to eggs. The Hovico Egg Skelter’s metallic spiral design pushes the oldest eggs to the end so you can use them first. It’s then easy to add the newly laid (or purchased) ones to the top. As a bonus, it doubles as a nice decorative piece for your kitchen counter. (Note: fresh, unwashed eggs do not need to be refrigerated as they have a natural coating.) — Jennifer Pattison Tuohy, reviewer We have a drawer full of silicon spatulas in our kitchen that I use exclusively for flipping eggs and nothing else. For any other cooking task, I use my beloved wooden spoon. I love that it’s firm but doesn’t scratch ceramic pots and pans, and there is nothing better for deglazing a pan than a wooden spoon, which perfectly scrapes up all the delicious brown bits of a sear after you add a little vinegar or alcohol. While my other spatulas and spoons have broken or the silicone has begun to tear, my wooden spoon is almost indestructible. Bury me with it. — Kristen Radtke, creative director",
        "link": "https://www.theverge.com/favorites/612453/favorite-cooking-food-instant-pot"
      },
      {
        "category": "technology",
        "website": "Latest news",
        "title": "Switching to LED lightbulbs saved me hundreds of dollars - but there are 5 other reasons to do it",
        "pubDate": "Thu, 20 Feb 2025 20:21:00 GMT",
        "description": "I was curious about the benefits of LED over conventional lighting. Turns out it's more than just a money-saver.",
        "link": "https://www.zdnet.com/article/switching-to-led-lightbulbs-saved-me-hundreds-of-dollars-but-there-are-5-other-reasons-to-do-it/"
      },
      {
        "category": "technology",
        "website": "WIRED",
        "title": "The National Institute of Standards and Technology Braces for Mass Firings",
        "pubDate": "Thu, 20 Feb 2025 20:19:27 +0000",
        "description": "Approximately 500 NIST staffers, including at least three lab directors, are expected to lose their jobs at the standards agency as part of the ongoing DOGE purge, sources tell WIRED.",
        "link": "https://www.wired.com/story/the-national-institute-of-standards-and-technology-braces-for-mass-firings/"
      },
      {
        "category": "technology",
        "website": "WIRED",
        "title": "Netflix Plans to Spend $1 Billion Making Content in Mexico Over the Next 4 Years",
        "pubDate": "Thu, 20 Feb 2025 20:18:21 +0000",
        "description": "Netflix CEO Ted Sarandos says the money will go toward projects like Alfonso Cuarón’s film Roma, which was made in Mexico and went on to international acclaim.",
        "link": "https://www.wired.com/story/netflix-1-billion-dollars-mexico-production/"
      },
      {
        "category": "technology",
        "website": "Latest news",
        "title": "I tested Lenovo's new Windows handheld PC - now I'm wondering if I need any other device for travel",
        "pubDate": "Thu, 20 Feb 2025 20:11:00 GMT",
        "description": "The Lenovo Legion Go S offers an immersive gaming experience with powerful hardware and a rich, booming sound system.",
        "link": "https://www.zdnet.com/article/i-tested-lenovos-new-windows-handheld-pc-now-im-wondering-if-i-need-any-other-device-for-travel/"
      },
      {
        "category": "technology",
        "website": "Latest news",
        "title": "The best floodlights for outdoor security of 2025",
        "pubDate": "Thu, 20 Feb 2025 20:02:43 GMT",
        "description": "Our top picks for the best outdoor security flood lights include motion detection, cameras, and adjustable brightness to fit your needs-- and provide peace of mind.",
        "link": "https://www.zdnet.com/article/best-floodlight/"
      },
      {
        "category": "technology",
        "website": "Latest news",
        "title": "5 products Apple quietly killed while it rolled out iPhone 16e this week",
        "pubDate": "Thu, 20 Feb 2025 20:01:00 GMT",
        "description": "The newest iPhone looks like a promising entry-level device for consumers, but its unveiling also meant the end for these products and services.",
        "link": "https://www.zdnet.com/article/5-products-apple-quietly-killed-while-it-rolled-out-iphone-16e-this-week/"
      },
      {
        "category": "technology",
        "website": "WIRED",
        "title": "The 31 Best Movies on Max (aka HBO Max) Right Now (February 2025)",
        "pubDate": "Thu, 20 Feb 2025 20:00:00 +0000",
        "description": "We Live in Time, Blue Velvet, and Beetlejuice Beetlejuice are just a few of the movies you should be watching on Max this month.",
        "link": "https://www.wired.com/story/best-movies-hbo-max-right-now/"
      },
      {
        "category": "technology",
        "website": "The Verge",
        "title": "Nickelodeon’s next Avatar animated series is finally coming together",
        "pubDate": "2025-02-20T19:39:15Z",
        "description": "Rumours about the next mainline Avatar series have been circulating ever since Nickelodeon announced that Michael DiMartino and Bryan Konietzko were returning to lead Avatar Studios. But now, we finally know a bit more about where the franchise is heading after The Legend of Korra. Today, Nickelodeon announced that the Avatar saga (which began with The Last Airbender) will continue with Avatar: Seven Havens, a new 2D animated series co-created by Konietzko and DiMartino and executive produced by Ethan Spaulding (Mike Tyson Mysteries) and Sehaj Sethi (The Winchesters). No casting or potential release windows have been teased, but the network shared that Seven Havens’ story will be told over the course of 2 seasons consisting of 13-half-hour-long episodes each. Seven Havens will introduce a new earthbending Avatar who is seen as a threat to the world because of her powers. “Hunted by both human and spirit enemies, she and her long-lost twin must uncover their mysterious origins and save the Seven Havens before civilization’s last strongholds collapse,” according to Nickelodeon. The show’s announcement comes just a little under a year after the premieres of Netflix’s live-action The Last Airbender adaptation that Konietzko and DiMartino bowed out of in 2020 after two years of production due to creative differences. The Last Airbender showrunner Albert Kim similarly parted ways with the series after its first season, and Netflix brought on Jabbar Raisani and Christine Boylan to oversee the show’s next chapter. Though Netflix’s Avatar project is its own thing separate from what Avatar Studios is working on, there might be some narrative tissue connecting Seven Havens’ story with Nickelodeon’s upcoming movie focused on Aang and his friends in the time between The Last Airbender and The Legend of Korra. But that won’t become clear until Nickelodeon decides to share more.",
        "link": "https://www.theverge.com/news/616866/avatar-seven-havens-nickelodeon-konietzko-dimartino"
      },
      {
        "category": "technology",
        "website": "Latest news",
        "title": "The best kids' tablets of 2025: Parent recommended",
        "pubDate": "Thu, 20 Feb 2025 19:31:00 GMT",
        "description": "These are the best parent-approved kids' tablets we've tested, perfect for homework, entertainment, and durability.",
        "link": "https://www.zdnet.com/article/best-kids-tablet/"
      },
      {
        "category": "technology",
        "website": "The Verge",
        "title": "Kia unveils PV5 electric van as a futuristic ‘people mover’",
        "pubDate": "2025-02-20T19:23:25Z",
        "description": "Kia revealed the exterior design of the upcoming PV5 electric van, the automaker’s first EV to come out under its “Platform Before Vehicle” (PBV) brand.  With the PV5, Kia has declared its intention to compete with heavy hitters like the Volkswagen ID Buzz, Ford E-Transit, Mercedes eSprinter, and Ram ProMaster EV. There are very few electric vans on the market today, but that looks to be changing with these new entrants. The PV5 will come in a number of configurations, depending on whether you want something for cargo delivery, rideshare, or just to fulfill your #vanlife fantasies. There will also be models built for specialized conversions, which is sure to thrill the van conversion aftermarket. While the passenger version features a large window area, the cargo variant emphasizes space efficiency with a clean, modern look. Kia didn’t offer any details about its powertrain, range, price, or availability. The PV5 will be the first of many PBV-branded vehicles to come from Kia. PBV was introduced during CES 2024 in Las Vegas as a family of EVs built on a flexible vehicle architecture, with different swappable body types. The vehicle can be transformed from a minivan to a full-size van to a small truck, depending on the specific need. The driver cab remains fixed, while the rest of the vehicle is interchangeable, like a real-life Duplo set. At the time, Kia said that the PV5 would be ideal for ridehailing, delivery, and utilities. Uber swooped in soon after to sign a memorandum of understanding to add the PV5 as an option for its drivers in the hopes of fulfilling its pledge to go all-electric in all markets by 2040. Kia said it will reveal more details about the PV5, as well as a new model, at its Kia EV Day in Spain later this month. A heavily camouflaged PV5 was spotted by Electrek earlier this month in the US.",
        "link": "https://www.theverge.com/news/616711/kia-pv5-electric-van-exterior-pics"
      },
      {
        "category": "technology",
        "website": "Latest news",
        "title": "The best tablets of 2025: Top picks from our experts",
        "pubDate": "Thu, 20 Feb 2025 19:19:22 GMT",
        "description": "We've rounded up the best expert-loved tablets from Apple, Samsung, and Amazon.",
        "link": "https://www.zdnet.com/article/best-tablet/"
      },
      {
        "category": "technology",
        "website": "NYT > Technology",
        "title": "Elon Musk Is Focused on DOGE. What About Tesla?",
        "pubDate": "Thu, 20 Feb 2025 19:12:21 +0000",
        "description": "Mr. Musk, one of President Trump’s main advisers, has not outlined a plan to reverse falling sales at the electric car company of which he is chief executive.",
        "link": "https://www.nytimes.com/2025/02/20/business/elon-musk-tesla-trump.html"
      },
      {
        "category": "technology",
        "website": "The Verge",
        "title": "DJI’s RS 4 Mini camera stabilizer can now track moving people",
        "pubDate": "2025-02-20T19:07:25Z",
        "description": "The DJI RS 4 Mini works with smaller mirrorless cameras and smartphones using an optional mount. | Image: DJI  DJI has announced a new version of the smallest camera stabilizer in its Ronin series. Like last year’s RS 3 Mini, the upgraded RS 4 Mini is a more compact, lighter, and cheaper alternative to DJI’s RS 4 and RS 4 Pro stabilizers, but designed for smaller mirrorless cameras and smartphones. Although it’s slightly heavier than its predecessor, the RS 4 Mini introduces subject tracking through an optional module, similar to what DJI recently launched with its Osmo Mobile 7 Pro. The DJI RS 4 Mini is now available through the company’s online store in three versions. On its own, the gimbal sells for $369, but the $459 DJI RS 4 Mini Combo adds the new tracking module and a Mini Briefcase Handle accessory. There’s also the $478 DJI RS 4 Mini Creator Combo that includes the same accessories plus a smartphone holder for mobile creators looking to get more creative. It’s a little heavier than its predecessor — 890 grams (a little under two pounds) up from 795 grams — but the RS 4 Mini offers the same capacity with support for cameras weighing up to 4.4 pounds. Battery life gets a boost from 10 hours to 13 now, while a 30-minute fast charge provides five hours of use. Even with the extra weight the RS 4 Mini could be worth the upgrade thanks to DJI’s new RS Intelligent Tracking Module. It features its own camera and DJI’s tracking technology allowing the gimbal to autonomously follow and keep a moving human subject in frame from over 32 feet away without the need for DJI’s Ronin mobile app. Tracking can also be stopped and started remotely using an open palm hand gesture for creators working alone, while a new Responsive mode improves performance when capturing fast moving subjects. Other upgrades include faster switching to vertical shooting mode, a new Teflon coating to further smooth out movements and balancing, and a smaller and lighter horizontal briefcase handle allowing shots to be more easily captured from lower angles.",
        "link": "https://www.theverge.com/news/616642/dji-rs-4-mini-ronin-series-gimbal-stabilizer-camera-smartphone"
      },
      {
        "category": "technology",
        "website": "The Verge",
        "title": "Trump’s first 100 days: all the news affecting the tech industry",
        "pubDate": "2025-02-20T19:05:39Z",
        "description": "President Donald Trump kicked off the first day of his presidency by signing a flurry of executive actions, including halting enforcement of the TikTok ban and rolling back the Biden administration’s artificial intelligence order. Having already run the country once before, Trump entered the presidency with the goal of hitting the ground running, having already selected nominees and chairs for key agencies that oversee tech. This time, Trump has the backing of many tech billionaires who attended his inauguration and showed up at his home in Mar-a-Lago. Read on below as we keep track of all the ways Trump is leaving his mark on tech in his first 100 days in office. Not advertising on X could be bad for business. \t\t\t Apple CEO Tim Cook met with President Trump today. \t\t\t Some people who accepted the ‘fork in the road’ federal resignation offer got fired anyway. \t\t\t Nuclear whiplash. \t\t\t Trump administration hits disaster relief team with layoffs. \t\t\t A departing USDS leader’s thoughts on DOGE. \t\t\t Trump and Musk discuss DOGE and their relationship in a Fox News interview. \t\t\t Trump administration cancels approval for NYC congestion pricing. \t\t\t Trump issues an executive order claiming more oversight of independent agencies like the FTC and FCC. \t\t\t DOGE’s alleged cost-cutting achievements included a few extra zeroes. \t\t\t You’re (not) fired! \t\t\t DOGE can keep accessing government data for now, judge rules \t\t\t Elon Musk doesn’t work for DOGE \t\t\t DOGE is trying to access the IRS’s data on millions of taxpayers \t\t\t A team from SpaceX is being brought in to overhaul the FAA’s air traffic control system \t\t\t A US agency has been told to stop its election security work. \t\t\t Trump admin pulls hundreds of videos from CFPB’s YouTube channel \t\t\t Judge temporarily blocks mass firings at CFPB. \t\t\t Three different court hearings over DOGE just today. \t\t\t Trump administration adds anti-trans notices to restored websites \t\t\t Climate group that called for ‘free Palestine’ stripped of federal funding \t\t\t Treasury inspector general will investigate DOGE payments access \t\t\t Small businesses are already feeling Trump’s tariffs \t\t\t The technology team at financial regulator CFPB has been gutted \t\t\t Elon Musk’s DOGE website has been defaced because anyone can edit it \t\t\t Trump administration ordered to temporarily unfreeze foreign aid funds. \t\t\t “Trump’s share of a $10 million settlement Elon Musk’s X agreed to this week is expected to go to him directly.” \t\t\t What’s with the EPA seizing ‘gold bars’? \t\t\t State Dept.’s plan to buy $400 million worth of armored Teslas hastily changed to ‘armored EVs’ \t\t\t Federal workers say they increasingly distrust platforms like Facebook \t\t\t Trump’s January 6th Twitter lawsuit settled for ‘about $10 million’ \t\t\t Waste.gov locks down after people discover it’s just a WordPress template \t\t\t NHTSA censors car crash data to only reflect two genders. \t\t\t The Trump administration restores federal webpages after court order \t\t\t FCC to investigate Comcast for having DEI programs \t\t\t Trump administration illegally allowed DOGE to access workers’ data, lawsuit alleges \t\t\t Donald Trump reignites the lightbulb wars \t\t\t Constitutional crisis intensifies. \t\t\t Elon Musk’s DOGE activities trigger protests, vandalism for Tesla \t\t\t Elon Musk’s rapid unscheduled disassembly of the US government \t\t\t Trump’s next target: pennies. \t\t\t The CFPB’s headquarters are closing. \t\t\t Federal judge blocks DOGE from accessing sensitive Treasury records \t\t\t RIP CFPB? \t\t\t Musk promises to reinstate DOGE staffer linked to racist account \t\t\t FEMA’s website started deleting ‘climate change’ \t\t\t DOGE wreaked havoc on the government in just one week \t\t\t Federal employees who work to protect the environment are getting the ax. \t\t\t Mentions of trans kids scrubbed from national child safety clearinghouse website \t\t\t The ‘custom chatbot’ DOGE is reportedly building for the GSA. \t\t\t Trump’s energy secretary bypassed legal, IT warnings against giving a DOGE rep access. \t\t\t Mark Zuckerberg visits the White House. \t\t\t Deadline for government’s ‘Fork in the road’ mass resignation program delayed by court \t\t\t Trump has California’s high-speed rail in his crosshairs again \t\t\t Head of DOGE-controlled government tech task force resigns \t\t\t Elon Musk’s DOGE storms federal weather forecasters’ headquarters \t\t\t Donald Trump’s data purge has begun  \t\t\t The FDIC is “reevaluting” its approach crypto oversight. \t\t\t “I think they’re playing a quantity game and assuming the system can’t react to all this illegality at once.” \t\t\t DOGE (reportedly) has full access to a major US payment system. \t\t\t ‘Scared and betrayed’ — workers are reeling from chaos at federal agencies \t\t\t Treasury Department sued over DOGE takeover \t\t\t An “AI-first” GSA. \t\t\t “There is not one single entity holding Musk accountable.” \t\t\t CBS is preparing to give Harris interview materials to the FCC. \t\t\t Trump agrees to a one-month pause on Mexico, Canada tariffs \t\t\t Trump orders a ‘sovereign wealth fund’ for the US. \t\t\t Data brokers can keep selling your social security number, says new CFPB chief \t\t\t Canada will retaliate against Trump with tariffs on US goods \t\t\t Trump imposes sweeping tariffs on Canada, Mexico, and China \t\t\t Canadian officials have reportedly been notified of tariffs. \t\t\t Trump fires CFPB head Rohit Chopra \t\t\t Mr. Nvidia goes to the White House. \t\t\t Trump’s first round of tariffs is almost here \t\t\t Meta agrees to pay $25 million to settle Trump account suspension suit \t\t\t Lee Zeldin, who wants to “make America the AI capital of the world” will lead the Environmental Protection Agency. \t\t\t The new transportation secretary’s first act is to start letting cars pollute more. \t\t\t Trump’s media company is getting into fintech, too. \t\t\t Elon Musk saying he’ll ‘bring home’ two astronauts for Trump is as dumb as it sounds. \t\t\t Another change from Google’s maps team. \t\t\t Did Elon Musk write the federal worker buyout email? \t\t\t Donald Trump wants to claw back clean energy funding \t\t\t DeepSeek wakes up Trump. \t\t\t Trump says Microsoft wants TikTok (again). \t\t\t Google Maps in the US will change to Gulf of America and Mount McKinley \t\t\t Trump says he’ll put tariffs on imported chips ‘in the near future’ \t\t\t Elon Musk email to X staff: ‘we’re barely breaking even’ \t\t\t Trump bends to the tech oligarchy. \t\t\t How Meta’s MAGA heel turn is a play for global power \t\t\t Less Trump, unless you want it. \t\t\t Brendan Carr amps up his censorship campaign. \t\t\t NASA’s climate website is ‘moving.’ \t\t\t Satya Nadella on Elon’s Stargate accusations: “All I know is I’m good for my $80 billion.” \t\t\t Dozens of subreddits are banning links to X \t\t\t Trump’s war on electric cars has only just begun \t\t\t Elon Musk, White House adviser, says OpenAI deal announced at White House is a sham \t\t\t A PSA for all those wondering why you’re suddenly following Trump and Vance on social. \t\t\t Trump is absolutely going to make ByteDance sell TikTok or shut down again. \t\t\t Trump is discussing a 10 percent tariff on imports from China. \t\t\t Trump pardons Silk Road operator Ross Ulbricht \t\t\t Donald Trump acknowledged his meme coin today. \t\t\t Trump says he’s open to Musk or Ellison buying TikTok \t\t\t OpenAI and SoftBank are starting a $500 billion AI data center company \t\t\t ACLU and 18 states sue Trump over his attempt to repeal birthright citizenship \t\t\t CBS News reports OpenAI, Oracle, and Softbank will announce a ‘Stargate’ AI data center project. \t\t\t A federal website on reproductive rights has vanished \t\t\t The United States Digital Service is now DOGE — here’s what it was responsible for. \t\t\t Donald Trump rescinds Biden-era executive order on AI safety \t\t\t ‘There is no “EV mandate.”’ \t\t\t Trump signs executive order to reverse Biden’s electric vehicle policies \t\t\t Trump signs order refusing to enforce TikTok ban for 75 days \t\t\t Brendan Carr is officially in charge of the FCC \t\t\t Vivek Ramaswamy steps down from DOGE \t\t\t Trump declares a ‘national energy emergency’",
        "link": "https://www.theverge.com/24348851/donald-trump-presidency-tech-science-news"
      },
      {
        "category": "technology",
        "website": "The Verge",
        "title": "The entire story of Twitter / X under Elon Musk",
        "pubDate": "2025-02-20T19:05:39Z",
        "description": "Elon Musk bought Twitter, and now he’s rebranding it as X. Signs have gone up (and back down), icons are changing, and an old plan is new. How’d we get here? On April 4th, 2022, we learned that Musk had purchased enough shares of Twitter to become its largest individual shareholder. Eventually, he followed up with an unsolicited offer to buy 100 percent of Twitter’s shares for $54.20 each, or about $44 billion.  Twitter accepted Musk’s offer, but then things got weird because he tried to cancel the deal. There was a lot of back-and-forth about bots and text messages, but in the end, Musk settled on buying the company rather than facing a deposition or Chancery Court trial and eventually strode into Twitter HQ carrying a sink. Since then, there have been layoffs, more layoffs, and even more layoffs — plus drama over Substack, unpaid bills, and blue checkmarks. With ad revenue still down from previous years, Elon finally abdicated the role of CEO in May 2023, installing longtime NBCUniversal ad executive Linda Yaccarino. Read on for the latest updates about what’s going on inside Twitter right now.  \t\t\t\t\t Not advertising on X could be bad for business. \t\t\t “Trump’s share of a $10 million settlement Elon Musk’s X agreed to this week is expected to go to him directly.” \t\t\t Trump’s January 6th Twitter lawsuit settled for ‘about $10 million’ \t\t\t Trump drops his Twitter lawsuit appeal. \t\t\t X says its payments service will finally launch this year \t\t\t Elon Musk email to X staff: ‘we’re barely breaking even’ \t\t\t Dozens of subreddits are banning links to X \t\t\t Elon Musk is being sued by the feds over the way he bought Twitter \t\t\t How Elon Musk’s xAI is quietly taking over X \t\t\t Elon Musk says X’s algorithm pushes “too much negativity.” \t\t\t X’s new ‘Aurora’ image generator is gone. \t\t\t X gives Grok a new photorealistic AI image generator \t\t\t Who actually owns your social media accounts? (Not you.) \t\t\t Musk dodged a sanction over skipping an SEC meeting in September. \t\t\t A study found that X’s algorithm now loves two things: Republicans and Elon Musk \t\t\t Don Lemon says he’s leaving X. \t\t\t The Guardian is quitting X. \t\t\t X is allowing people you’ve blocked to see your posts \t\t\t X was supposed to be a bank by now \t\t\t X’s biggest anti-immigrant poster is… Elon Musk. \t\t\t The EU may fine Elon Musk’s other companies for X violations \t\t\t X blocked hacked JD Vance dossier links after the Trump campaign flagged it \t\t\t X drops Unilever from its ‘advertiser boycott’ lawsuit \t\t\t X will pay its Premium users to engage with each other \t\t\t Brazil clears X for return after a monthlong ban \t\t\t X argued it shouldn’t owe a fine in Australia because it’s not Twitter. \t\t\t Musk’s $44 billion Twitter now valued at just $9.4b as X. \t\t\t Brazil orders X to pay one more fine before it can go live. \t\t\t X will let people you’ve blocked see your posts \t\t\t Alexis Ohanian is premiering his women’s soccer show on X \t\t\t NBA Twitter newsbreaker Adrian Wojnarowski is retiring \t\t\t X’s top policy leader quits. \t\t\t Elon Musk is absolutely not a ‘free speech absolutist’ \t\t\t X’s TV app is out in beta. \t\t\t Brazilian Supreme Court panel upholds X ban, while Starlink refuses to comply \t\t\t Bluesky has gained a million new users in the last three days. \t\t\t Judge orders X ban in Brazil \t\t\t a16z, Jack Dorsey, Sean Combs, and Binance are among the investors in Elon Musk’s X. \t\t\t X says it has closed its Brazilian operation. \t\t\t The Elon Musk / Donald Trump interview on X started with an immediate tech disaster \t\t\t Two X lawsuits are being judged by a conservative Tesla investor. \t\t\t The EU warns Elon Musk about tonight’s Donald Trump livestream on X. \t\t\t Donald Trump’s account is currently unsearchable on X. \t\t\t Ad group sued by Elon Musk reportedly disbands \t\t\t X files antitrust lawsuit against advertisers over ‘illegal boycott’ \t\t\t X is closing its HQ in San Francisco. \t\t\t Don Lemon sues Elon Musk and X for canceling his talk show \t\t\t Here’s how to stop X from using your posts to train its AI \t\t\t X replaced the water pistol emoji with a regular gun, for some reason \t\t\t X may make it possible to disable links in replies to your posts. \t\t\t Oops, Trump and X did a copyright infringement \t\t\t Elon Musk is moving X and SpaceX to Texas \t\t\t You can search for bookmarks on X now. \t\t\t Livestreaming video is X’s newest paid feature. \t\t\t X all-hands leaves staff with few answers on delayed promotions \t\t\t X is about to start hiding all likes \t\t\t X has new rules that officially allow porn now \t\t\t Elon Musk finally agrees to testify in the SEC’s Twitter investigation \t\t\t How a 2019 Twitter thread full of anime trolls and lawyers created a legal super team. \t\t\t X is hiding likes to encourage ‘edgy’ engagement \t\t\t Twitter is officially X.com now \t\t\t This scraper can keep on scraping. \t\t\t X now wants to compete with Google Meet. \t\t\t X reverses course on Brazil. \t\t\t X’s ‘complimentary’ Premium push gives people blue checks they didn’t ask for \t\t\t Elon Musk’s reputation is falling — and it’s taking Tesla with it \t\t\t xAI claims Grok’s first update will make it much better at doing math. \t\t\t Elon Musk has a new pay-to-play X Premium gambit. \t\t\t Judge tosses Elon Musk’s X lawsuit against anti-hate group \t\t\t Is this what X will look like on a smart TV? \t\t\t Here’s the Elon Musk interview that got Don Lemon’s show canceled \t\t\t xAI open sources Grok \t\t\t Elon Musk cancels Don Lemon’s show on X after a ‘tense’ interview \t\t\t X adds “Articles.” They’re blog posts, but only for the most Premium posters. \t\t\t Twitter’s music label legal trouble might have legs \t\t\t Fired Twitter execs are suing Elon Musk for over $128 million \t\t\t The latest ‘Woj bomb’ was just a scam NFT tweet from a hacked account \t\t\t X restores Yulia Navalnaya’s account after briefly suspending it. \t\t\t One of the last ways to access Twitter without an account is dead. \t\t\t X will allow advertisers to only run ads on selected profiles. \t\t\t As the Super Bowl rolls into Las Vegas, X cuts a deal to advertise gambling odds. \t\t\t X plans to create a content moderation ‘headquarters’ in Austin \t\t\t The X iPhone app added passwordless logins with passkeys \t\t\t Why Elon Musk needs MrBeast \t\t\t Elon Musk is uncomfortable with the amount of control Elon Musk has over Tesla. \t\t\t X says charges were dropped against a student who posted about free food. \t\t\t Even X is giving up on NFTs. \t\t\t X is still promising peer to peer payments in 2024. \t\t\t X once again removes headlines from article links. \t\t\t Maybe $1,000 per month was too expensive. \t\t\t X once again adds headlines to article links — but with tiny text \t\t\t X said to be worth less than 29 percent of what Musk paid. \t\t\t Elon Musk’s X can’t shake off a lawsuit over millions of dollars in unpaid Twitter bonuses. \t\t\t X was down \t\t\t An X outage broke all outgoing links, again \t\t\t Ad sales on X are reportedly about about a half billion lower than anticipated for 2023. \t\t\t Is Threads signing a major free agent away from Elon Musk? \t\t\t Ex-Twitter security head claims the company fired him to flout regulations \t\t\t X CEO responds after X CTO tells departing advertisers to “go fuck yourself.” \t\t\t Elon Musk tells advertisers: ‘Go fuck yourself’ \t\t\t Paris Hilton pulls Twitter ads, but the NFL is staying. \t\t\t Flipboard is abandoning X for Mastodon \t\t\t X sues Media Matters to silence moderation criticism \t\t\t Advertisers flee X, but Linda Yaccarino stays the course \t\t\t Apple pulls its ads from X after Musk’s antisemitic posts \t\t\t IBM pulls X ads as Elon Musk endorses white pride \t\t\t X is backing one of the smallest-stakes legal fights imaginable. \t\t\t X added chat to live streams on the web. \t\t\t Stay classy, Elon. \t\t\t PlayStation is cutting off X sharing options \t\t\t X has reportedly started trying to sell user handles. \t\t\t The risks facing X \t\t\t Elon Musk’s ‘everything app’ plan for X, in his own words \t\t\t X is officially worth less than half of what Elon Musk paid for it \t\t\t One of Elon Musk’s investors thinks X is worth 65 percent less than when he bought it. \t\t\t X will demonetize posts corrected by Community Notes. \t\t\t X launches two new subscriptions to boost your replies \t\t\t Elon Musk wants more bad news. \t\t\t Elon Musk’s Twitter, one year later \t\t\t Elon Musk gives X employees one year to replace your bank \t\t\t Inside X’s first all-hands meeting \t\t\t Twitter’s decline in charts. \t\t\t X is officially rolling out audio and video calls \t\t\t Slack gets rid of its X integration \t\t\t Blue checkmarks on X are ‘superspreaders of misinformation’ about Israel-Hamas war \t\t\t The Twitter Fantasy. \t\t\t X will start charging new users in two countries $1 per year \t\t\t X gets a fine for not showing its work. \t\t\t X accused of illegally firing employee who criticized Elon’s return-to-work plan \t\t\t Is your X ad revenue sharing payment smaller than you expected? \t\t\t Now X posts can lock replies to only allow comment from verified accounts \t\t\t X users report unlabeled clickbait ads that you can’t block or report \t\t\t India’s government tells social media sites to remove CSAM from their platforms, or else. \t\t\t Elon Musk is stonewalling the SEC, and now he’s getting sued \t\t\t X stops showing headlines because Elon Musk thinks it will make posts look better \t\t\t X has to pay $1.1 million in legal fees for ex-Twitter execs \t\t\t X Social Media is suing X, a social media company \t\t\t Paris Hilton is getting a special deal to post on X \t\t\t Linda Yaccarino was set up to fail \t\t\t ‘Please fix this.’ \t\t\t Why isn’t X on Linda Yaccarino’s home screen? \t\t\t Linda Yaccarino says she hasn’t seen Elon Musk’s “demon mode” described in Walter Isaacson’s book. \t\t\t X is shutting down Circles \t\t\t X will now tell you if someone deletes a post you annotated with a Community Note \t\t\t Not a great look for Musk. \t\t\t X’s new terms of service insist that tweets are now posts \t\t\t X’s Community Notes feature will now include videos \t\t\t Elon Musk paid for our attention, but the price to keep it is getting higher \t\t\t Police won’t fine Elon Musk for illegally livestreaming while driving \t\t\t Just how many times did Musk tell on himself in one video? \t\t\t Elon Musk booed again. \t\t\t X hopes you’ll find your next job on the platform. \t\t\t Donald Trump returns to X / Twitter to post his mug shot \t\t\t Elon Musk says news organizations can get a share of X’s advertising revenue, too. \t\t\t X tests removing headlines from links to news articles \t\t\t X says it’s fixed the bug that broke links and images in pre-December 2014 tweets \t\t\t Here’s what data analysis says about Elon Musk’s followers on X. \t\t\t X glitch wipes out most pictures and links tweeted before December 2014 \t\t\t X appears to be working on an ID verification system. \t\t\t They’re really not called tweets anymore. \t\t\t TweetDeck is officially becoming a paid service \t\t\t X seemed to throttle some competitors and news sites for more than a week \t\t\t Twitter appears to finally be switching over to X.com. \t\t\t Elon Musk’s new round of X Ads Revenue Sharing payments arrived — eventually \t\t\t Some highlights from CNBC’s interview with X CEO Linda Yaccarino: \t\t\t Australia’s national broadcaster scales back its Twitter presence. \t\t\t X’s new “sensitivity settings” will let advertisers pick what types of content they don’t want their ads to appear next to. \t\t\t Mark Zuckerberg is ‘not holding my breath’ for August 26th fight date with Elon Musk \t\t\t The cage match is back on: Musk says Zuck fight will ‘be live-streamed on X’ \t\t\t Elon Musk’s ‘fund your legal bill’ tweet is a brand new level of bullshit \t\t\t Twitter Blue is now X Premium. \t\t\t Elon Musk’s X can’t send Blue subscribers their ad revenue-sharing payouts on time \t\t\t X takes over another account. \t\t\t Do you want to buy stocks on X? \t\t\t Elon Musk says he’s going to talk to Tim Cook about adjusting the Apple tax \t\t\t Verified Twitter / X Blue subscribers can hide their blue checks. \t\t\t TweetDeck’s new ‘XPro’ branding is starting to show up \t\t\t It looks like Twitter is still working on ID-based verification. \t\t\t Elon Musk’s X sues anti-hate researchers for allegedly scraping data from Twitter \t\t\t Elon Musk wants a second chance to fail at X \t\t\t The Twitter sign has left the building — and no, I’m not talking about the X. \t\t\t Elon Musk’s extravagant ‘X’ sign atop the former Twitter HQ has been dismantled \t\t\t Twitter gets special permission to be ‘X’ in the iOS App Store \t\t\t Twitter’s slipshod rebranding project runs into Apple’s App Store rules. \t\t\t What it’s like to work at Elon Musk’s X \t\t\t Twitter is now labeled X on iOS too. \t\t\t X officially rolls out its ads revenue sharing program for creators \t\t\t Twitter’s Android app rebranded X. \t\t\t Twitter Blue’s former lead talks about Elon Musk, X, and sleeping on the floor \t\t\t For Elon Musk, X equals everything \t\t\t The owner of @X didn’t get the big payout from Elon Musk people expected. \t\t\t Official Twitter account deactivated, redirects to X. \t\t\t Elon Musk just changed Twitter’s logo again — sort of \t\t\t Twitter Blue subscribers can now download videos posted to X \t\t\t Twitter’s half-sign is still hanging in there. \t\t\t The cofounder of Facebook has a theory about Elon’s favorite stat. \t\t\t Twitter removed half its HQ sign — then the police arrived \t\t\t Er. \t\t\t The Twitter sign is coming down, one letter at a time. \t\t\t RIP Twitter’s iconic bird logo \t\t\t Twitter is being rebranded as X \t\t\t Elon Musk’s best idea for stopping spambots is making you pay for extra Twitter DMs \t\t\t Twitter might try to step on LinkedIn’s turf. \t\t\t Elon Musk says Twitter is working on a feature that will let you publish articles \t\t\t Twitter is working on some kind of article-writing product that was apparently once called “Notes.” \t\t\t An update for how things are going with Twitter. \t\t\t Elon Musk sues four unknown individuals for scraping Twitter’s data \t\t\t Elon Musk’s new xAI company launches to ‘understand the true nature of the universe’ \t\t\t The success of Threads, explained. \t\t\t Twitter is doing really well. Promise. Better than ever. \t\t\t Well, the Taliban wants you to know it endorses Twitter over Instagram’s Threads. \t\t\t Twitter’s traffic is taking a dive, according to Cloudflare’s CEO. \t\t\t At least one third-party Twitter app may be working again, too. \t\t\t The good version of TweetDeck is back, but for how long? \t\t\t Twitter is suing the law firm that used to represent Twitter. \t\t\t Twitter’s running busted ads for Amazon and Sky TV \t\t\t Here’s how Twitter’s leadership is responding to Instagram Threads. \t\t\t Why Instagram is taking on Twitter with Threads \t\t\t Twitter claims it couldn’t warn anyone about the “temporary” rate limits. \t\t\t Tweeten developer moves on as Twitter forces everyone onto the new Tweetdeck. \t\t\t Instagram’s Twitter competitor launches July 6th \t\t\t Tweets aren’t showing up in Google results as often because of changes at Twitter \t\t\t Twitter’s ‘new’ TweetDeck lives behind a verified paywall \t\t\t The latest hit on Twitter? A full-length upload of Spider-Man: No Way Home. \t\t\t Twitter CEO Linda Yaccarino may lay out her vision for the company in August. \t\t\t So where are we all supposed to go now? \t\t\t TweetDeck is falling apart after Twitter’s rate-limiting fiasco \t\t\t Bluesky temporarily halts sign-ups because so many people are joining from Twitter \t\t\t The logic behind putting reading limits on a service that relies on advertising revenue. \t\t\t Elon Musk blames data scraping by AI startups for his new paywalls on reading tweets \t\t\t Meta’s Twitter competitor, Threads, briefly showed up on the Google Play app store today. \t\t\t Elon Musk confirms Twitter’s new login wall is intentional. \t\t\t Twitter has started blocking unregistered users \t\t\t Twitter’s API isn’t just expensive now, it’s also increasingly unreliable. \t\t\t Drugs have never seemed less cool. \t\t\t Mark Zuckerberg wants more fans? \t\t\t Yes, Twitter previews are broken in Slack and iMessage. \t\t\t Spotify does nothing as Joe Rogan peddles vaccine misinformation \t\t\t Twitter bans PlainSite and its founder Aaron Greenspan, an Elon Musk critic. \t\t\t Twitter sued for $250 million by music publishers over ‘massive’ copyright infringement \t\t\t Twitter may soon limit how much you DM — unless you pay for Blue. \t\t\t Read the new Twitter CEO’s first email to employees \t\t\t Elon Musk still hasn’t paid Twitter’s Google Cloud bill. \t\t\t Elon Musk is talking about splitting ad revenue with creators on Twitter again. \t\t\t This is what Instagram’s upcoming Twitter competitor looks like \t\t\t Twitter’s window to edit tweets is now one hour, but you still have to pay for it \t\t\t Twitter left up dozens of known images of child sexual abuse material, a new study says. \t\t\t Twitter’s ad sales stink of Musk. \t\t\t Linda Yaccarino is officially Twitter’s CEO, starting tomorrow. \t\t\t Twitter head of trust and safety Ella Irwin has resigned \t\t\t Twitter investor Fidelity says the company’s worth about a third of what Musk originally paid for it. \t\t\t ”I love Elon… I just don’t want him to dump his poop in the river.” \t\t\t EU commissioner says Twitter has left its Code of Practice on Disinformation. \t\t\t Twitter’s Spaces team now has “roughly three” people. \t\t\t Elon Musk is trying Twitter Spaces again, and this time it’s with Ford CEO Jim Farley. \t\t\t Elon’s jet-tracking mess could’ve been avoided if SpaceX filed the right paperwork? \t\t\t Elon Musk and Ron DeSantis’ fiasco shows they didn’t realize Twitter needs TV \t\t\t Twitter now lets you search for new lists to follow \t\t\t San Francisco is investigating Twitter following a lawsuit from ex-employees. \t\t\t This is Instagram’s new Twitter competitor \t\t\t Twitter’s biggest ad buyer no longer considers it ‘high risk,’ says report \t\t\t Elon Musk’s lawyer accuses Microsoft of abusing its access to Twitter data \t\t\t Elon Musk says ‘get off your work-from-home bullshit’ \t\t\t Welcome to hell. \t\t\t Twitter’s new CEO is Linda Yaccarino, a longtime ad exec for NBCU \t\t\t Twitter’s new CEO is probably this NBC exec \t\t\t Linda Yaccarino has resigned from NBCUniversal, clearing the way to take over Twitter soon. \t\t\t Elon Musk has found his replacement as CEO of Twitter \t\t\t “Try it but don’t trust it,” is good advice for all of Twitter. \t\t\t Twitter upgrades DM replies, Musk claims encrypted DMs launch on Wednesday \t\t\t “Starting today.” \t\t\t Tucker Carlson is taking his show to Twitter \t\t\t Not all of the Twitter Blue subscribers are sticking around. \t\t\t If nothing else works, try threats. \t\t\t Twitter backtracks, lets emergency and traffic alert accounts keep free API access \t\t\t The best takedown of Elon’s plan to let publishers charge per-story you’ll read. \t\t\t Twitter’s latest outage is logging out desktop users \t\t\t The entire Super Mario Bros. movie keeps getting posted to Twitter \t\t\t Here’s Casey Newton interviewing Yoel Roth, Twitter’s former head of trust and safety. \t\t\t “Either way, when the Auschwitz Museum is having to issue a public statement saying that they didn’t pay for Twitter Blue, it’s probably time for some deep self-reflection about what you’re doing.” \t\t\t #BlockTheBlue. \t\t\t Twitter is letting even more creators sell subscriptions. \t\t\t Twitter dropped its guardrails for propaganda from Russian, Chinese, and Iranian government accounts. \t\t\t One billionaire to another: here’s $8. \t\t\t Elon Musk’s wealth plummets by $12.6 billion after chaotic 24 hours at Twitter, Tesla, and SpaceX \t\t\t Elon Musk removes Twitter’s ‘government-funded media’ labels after outlets flee the platform \t\t\t LeBron James didn’t pay for his Twitter checkmark, but Elon Musk gave it to him anyway \t\t\t Twitter begins removing blue checkmarks from all legacy users \t\t\t Twitter promises it’s really, actually removing legacy blue checks very soon \t\t\t Elon Musk threatens to sue Microsoft \t\t\t Elon wants Twitter to be a free speech platform, advertisers be damned. \t\t\t #hashtag inventor Chris Messina has signed off of Twitter. \t\t\t Happy first year of hell, Elon. \t\t\t Maybe Twitter shouldn’t have shut down Revue? \t\t\t (Welcome to hell.) \t\t\t Twitter is rebranding Super Follows to Subscriptions \t\t\t PBS also stops tweeting after being hit with ‘government-funded media’ label \t\t\t It’s over, they got me. \t\t\t NPR becomes first major news organization to leave Twitter \t\t\t Five things I learned from Elon Musk’s BBC interview. \t\t\t Promises, promises. \t\t\t Two more Twitter alternatives have raised their hands: Post and Substack Notes. \t\t\t Elon Musk tweets then deletes DMs from Matt Taibbi over his Substack snit \t\t\t If you want to write in private, the technology you are looking for is a paper notebook. \t\t\t One of Elon’s handpicked ‘Twitter Files’ writers quits Twitter over its Substack restrictions \t\t\t The light of consciousness shall not extend to Substack. \t\t\t Substack writers say Twitter’s newsletter ban is bad for business — and worse for Twitter \t\t\t The problem with The Twitter Files, besides the doxxing, is all the errors. \t\t\t Substack founders fire back at Twitter over restrictions and rules that ‘change on a whim’ \t\t\t Twitter now disables likes, replies, and retweets if a tweet has Substack links \t\t\t Canary in the emerald mine \t\t\t Some ad execs aren’t thrilled to hear from Elon Musk. \t\t\t The Doge is gone. \t\t\t Does anyone know what NPR did to annoy Elon? \t\t\t Twitter tried to hide who pays for their checkmark, but life finds a way. \t\t\t Elon Musk’s obsession with blue checks is a verified problem \t\t\t Today in Twitter: where are the retweet labels, and why did Doge replace the bird? \t\t\t If you’re tired of Twitter trouble, Post.news has opened its doors to everyone. \t\t\t Did you run this by a lawyer? \t\t\t April Fools’ 2023: Twitter HQ moving to Miami. \t\t\t Twitter’s $1,000 checkmark will be free for the 10,000 most-followed companies \t\t\t Twitter takes its algorithm ‘open-source,’ as Elon Musk promised \t\t\t Lords, peasants, and kings. \t\t\t News outlets respond to Twitter Blue coercion with a resounding ‘meh.’ \t\t\t Twitter’s For You tab won’t be all bad. \t\t\t Tweet replies no longer show who users are replying to \t\t\t Elon Musk says Twitter’s For You page will only recommend verified accounts \t\t\t Elon Musk now says Twitter is worth $20 billion, or less than half of what he paid \t\t\t Twitter Blue subscribers may be able to hide their blue checks \t\t\t Twitter claims ‘legacy’ blue checkmarks will start to disappear on April Fools’ Day \t\t\t Twitter Blue subscriptions roll out globally, despite missing many promised features \t\t\t Twitter’s new bookmarks counter seems to be rolling out on the web. \t\t\t Great, tweets are showing another metric now \t\t\t Twitter’s API access continues to be a mess. \t\t\t The FTC’s Twitter privacy investigations have ramped up since Elon Musk’s takeover \t\t\t Elon Musk thinks Twitter has “a shot at being cash flow positive next quarter.” \t\t\t Oscar-winning documentarian Alex Gibney’s next subject is Elon Musk \t\t\t Twitter’s links and pictures were broken, but now they’re not \t\t\t Hey, where’s the Twitter Blue revenue sharing Elon Musk promised a month ago? \t\t\t Twitter’s timelines stopped working this morning \t\t\t Twitter rewrites its rules on violent content under Elon Musk \t\t\t Elon Musk’s ‘lab leak’ tweets could be an issue for Tesla’s plans in China \t\t\t Is this Twitter’s future CEO? \t\t\t Elon Musk inserts himself into the Dilbert fiasco to proclaim that “The media is racist.” \t\t\t Twitter’s Slack is coming back, though with a catch. \t\t\t Elon Musk says remaining Twitter employees will soon receive ‘very significant’ stock awards \t\t\t Twitter Blue head Esther Crawford is out at Twitter \t\t\t Elon Musk is laying off more Twitter employees, again. \t\t\t Twitter has removed captions from Spaces on iOS, and they don’t work on the web or Android \t\t\t Elon Musk keeps laying off Twitter employees after saying cuts were done \t\t\t Official: Twitter will now charge for SMS two-factor authentication \t\t\t Twitter is relaxing its policies to allow cannabis ads \t\t\t I guess Elon Musk really doesn’t like “Lola.” \t\t\t Twitter is back after struggling on a random Wednesday \t\t\t Yes, Elon Musk created a special system for showing you all his tweets first \t\t\t The scheduled tweets are back to haunt us. \t\t\t Twitter is just showing everyone all of Elon Musk’s tweets now \t\t\t Twitter’s new API is still on its way. \t\t\t Fox shares Elon Musk’s real-time coordinates — the kind of thing that gets journalists banned on Twitter. \t\t\t What was with all the Twitter errors yesterday? \t\t\t Most people can tweet again, but Twitter still has issues \t\t\t Now Twitter Blue subscribers can write 4,000-character tweets \t\t\t Twitter can now default to the ‘Following’ timeline on iOS and Android \t\t\t Elon Musk says bots with ‘good content’ can use Twitter’s API for free \t\t\t Twitter’s facing another lawsuit over unpaid bills. \t\t\t Twitter will let businesses keep their gold checkmarks — for $1,000 per month \t\t\t Elon Musk will share Twitter ad revenue — but only with creators who pay for Twitter Blue \t\t\t Twitter replaces its free API with a paid tier in quest to make more money \t\t\t Now anyone can appeal their Twitter account suspension. \t\t\t Twitter ends CoTweets, its collaborative posting feature \t\t\t Twitter’s payments ambitions update: applying for regulatory clearance, designing software. \t\t\t Twitter vows to take ‘less severe actions’ against rule-breaking accounts \t\t\t Bloomberg profiled Ella Irwin, Twitter’s head of trust and safety under Elon Musk. \t\t\t Yes, Twitter changed its font \t\t\t Elon Musk testified it’s ‘easy’ to raise money, so where are his Twitter investors? \t\t\t Twitter for web will now stay on your preferred timeline \t\t\t The third-party apps Twitter just killed made the site what it is today \t\t\t Elon Musk teases ‘higher priced’ Twitter Blue subscription with no ads \t\t\t Today on The Vergecast: Elon Musk status update, M2 MacBook Pros, and tech layoffs. \t\t\t Twitter tests adding more clutter to its cluttered interface. \t\t\t Twitter’s legal woes are mounting. \t\t\t Coffee makers and statues: Twitter starts auctioning off assets from its San Francisco headquarters \t\t\t Now Twitter is selling one year of blue check privileges at a discounted rate of $84 \t\t\t SpaceX is humming away in Elon Musk’s absence. \t\t\t Twitter says it’s intentionally blocking apps like Tweetbot \t\t\t Twitter rights its view count wrongs. \t\t\t Laid-off Twitter workers must drop class-action severance lawsuit, judge says \t\t\t Who should be the next CEO of Twitter? \t\t\t Twitter’s latest incentive for skeptical advertisers? \t\t\t Twitter’s “open source” algorithm could be revealed next month. \t\t\t Twitter’s For You timeline appears on desktop browsers now, too \t\t\t Judge rejects Elon Musk’s request to move his upcoming securities fraud trial to Texas \t\t\t Twitter clients like Tweetbot just stopped working. \t\t\t Twitter defaults to a For You page now, just like TikTok \t\t\t Elon Musk still annoyed about dad’s old emerald mine. \t\t\t The trouble with Twitter’s layoffs continues. \t\t\t TweetDeck.com is down, but TweetDeck still works \t\t\t Twitter laid off more employees despite Elon Musk saying the company was done with layoffs. \t\t\t Twitter Blue’s verification blues. \t\t\t Twitter users in Australia are having a bad day. \t\t\t Twitter says it will allow more political ads as it tries to claw back revenue \t\t\t Twitter’s landlord in San Francisco is suing the company for not paying rent. \t\t\t Twitter will soon let you swipe between tweets, topics, and trends \t\t\t The vibes are off at Tesla \t\t\t Twitter’s recovering from a few hours of glitchiness \t\t\t ElonJet is back on Twitter, but with a 24-hour delay \t\t\t Twitter is now showing everyone how many views your tweets get \t\t\t More layoffs hit Twitter. \t\t\t The verified @recklesspatel Twitter account is gone. \t\t\t Twitter’s “cashtags” show charts now. \t\t\t Where to find Verge staff on Mastodon \t\t\t Twitter won’t let you write your own Community Notes right away \t\t\t Elon Musk isn’t serious about giving power to a new CEO \t\t\t Geohot resigns from Twitter \t\t\t The FTC is still asking questions about Twitter under Elon Musk. \t\t\t Elon Musk started looking for a new Twitter CEO before polling the site’s users \t\t\t More than two million users have flocked to Mastodon since Elon Musk took over Twitter \t\t\t Twitter announces ‘Blue for Business’ to help identify brands and their employees \t\t\t Twitter’s latest unexpected change is square profile pictures for brands \t\t\t Elon Musk should step down as head of Twitter, says poll \t\t\t Tesla shares rise after poll says Elon Musk should step down as head of Twitter. \t\t\t It begins. \t\t\t Paul Graham is OUT on Twitter dot com. \t\t\t Twitter abruptly bans all links to Instagram, Mastodon, and other competitors \t\t\t Taylor Lorenz just got suspended from Twitter. \t\t\t Elon Musk re-enabled Twitter accounts for several journalists banned over @ElonJet \t\t\t Some journalists are still banned on Twitter. \t\t\t Elon Musk is offering the generous opportunity to invest in Twitter at $54.20 \t\t\t Twitter Spaces has returned. \t\t\t Apple could open up iOS, and the feds finally make a case against SBF. \t\t\t The Tweetbot company is putting Mastodon first. \t\t\t Twitter Spaces return after Elon Musk temporarily suspended them \t\t\t Even Elon Musk’s closest allies are over it. \t\t\t After a break to deal with some serious security issues, Hive Social is back. \t\t\t How to get your news fix now that Twitter sucks \t\t\t Musk takes a mulligan. \t\t\t Elon Musk starts banning critical journalists from Twitter \t\t\t Twitter is blocking links to Mastodon \t\t\t The Streisand effect is a phenomenon that occurs when an attempt to hide, remove, or censor information has the unintended consequence of increasing awareness of that information, often via the Internet. \t\t\t Twitter suspends Mastodon after it tweeted about Elon’s jet \t\t\t Everything ok in there, Mr. Musk? Sincerely, the FTC. \t\t\t Elon Musk sells yet another $3.58 billion of Tesla shares \t\t\t Twitter banned the @ElonJet account tracking Musk’s flights, reinstated it, then banned it again \t\t\t Elon Musk loses title of world’s richest man. \t\t\t Jack Dorsey on Musk’s Twitter files: ‘There’s nothing to hide’ \t\t\t The New York Times reports Elon Musk’s personal lawyer no longer works for Twitter. \t\t\t Whatever, I’m not a geologist. \t\t\t Twitter Blue is back, letting you buy a blue checkmark again \t\t\t “Twitter isn’t real life” remains Biden’s position on social media. \t\t\t Elon Musk booed at Dave Chappelle show, claims it was only like ‘10 percent boos’ \t\t\t The boos that cost $44 billion. \t\t\t Elon Musk’s $8 Twitter Blue subscription is coming back with phone number verification and a higher price on iOS \t\t\t Elon Musk reportedly threatens to sue Twitter employees who leak information to the press. \t\t\t Want to buy Twitter’s espresso machine? Bidding starts at $25. \t\t\t Get ready to grab that idle Twitter handle you’ve been eyeing. \t\t\t The Twitter checkmarks cometh. \t\t\t Take a look inside Elon Musk’s Twitter “hotel.” \t\t\t The last Moment for Twitter. \t\t\t Climate misinformation explodes on Twitter \t\t\t Twitter’s getting two of its biggest advertisers back. \t\t\t Twitter’s relying more heavily on automation to keep the platform safe. \t\t\t Elon Musk’s promised Twitter exposé on the Hunter Biden story is a flop that doxxed multiple people \t\t\t Now Elon Musk says he’ll publish details on “Hunter Biden story suppression.” \t\t\t Elon Musk is Elon Musk-pilled \t\t\t Tweets may be getting a view counter. \t\t\t Elon Musk says Tim Cook told him Apple ‘never considered’ removing Twitter \t\t\t Elon Musk is dragging Apple into the culture wars \t\t\t Elon Musk is delaying Twitter’s paid verification to avoid Apple’s 30 percent cut \t\t\t Twitter’s “Big Bang” to reinstate 62,000 suspended accounts. \t\t\t In losing Apple, Elon Musk’s Twitter loses one of the platform’s biggest advertisers. \t\t\t Elon’s pretend naiveté about Apple  and the App Store is very funny. \t\t\t Elon Musk says Apple has ‘threatened to withhold Twitter’ from the App Store \t\t\t Apple and Elon Musk clearly do not see eye-to-eye on moderation. \t\t\t In America, no one has to buy what you’re selling. \t\t\t Saddle up, Twitter engineering managers. \t\t\t Twitter hit with wave of porn and spam obscuring tweets about China protests \t\t\t Elon Musk never responded to Senator Ed Markey’s questions on Twitter verification. \t\t\t A Twitter executive got a court injunction to prevent Elon Musk from firing her \t\t\t Elon Musk says Twitter will begin manually authenticating Blue, Grey, and Gold accounts as soon as next week \t\t\t Elon Musk just decided to bring the worst people on the internet back to Twitter \t\t\t Elon Musk says SBF doesn’t have a stake in Twitter after all. \t\t\t Elon Musk proposes letting nearly everyone Twitter banned back on the site \t\t\t I finally get the jokes about Elon Musk’s coding whiteboard and Galactus. \t\t\t To those about to rock, we salute you. \t\t\t Dril predicts the end of Twitter will be a “cleansing fire.” \t\t\t Twitter wanted encrypted DMs so bad, it licensed Signal’s tech. \t\t\t Elon Musk tries to blame ‘activists’ for his Twitter moderation council lie \t\t\t Twitter’s rebranding Super Follows. \t\t\t Twitter will let you send crypto to accounts alongside “normal” money, Elon Musk says. \t\t\t Musk antagonist George Hotz hired to fix Twitter search — he’s got 12 weeks \t\t\t Elon Musk cuts more of Twitter’s employee perks. \t\t\t Twitter is making DMs encrypted and adding video, voice chat, per Elon Musk \t\t\t Elon Musk wants every Twitter employee sending weekly updates about their work via email now. \t\t\t Twitter won’t restart paid verification until ‘significant impersonations’ stop, Elon Musk says \t\t\t Elon Musk says Twitter is done with layoffs and ready to hire again \t\t\t Elon Musk is laying off even more Twitter workers \t\t\t Twitter loses another executive as Donald Trump’s account gets restored. \t\t\t Elon Musk says he’s letting Donald Trump back on Twitter \t\t\t The US government still isn’t sure about Elon Musk’s Twitter \t\t\t Twitter’s copyright strike system appears to be broken. \t\t\t Reddit’s software community is laughing at Elon. \t\t\t Musk has already axed the Twitter ad exec he reportedly convinced to stay \t\t\t Twitter’s now-former head of Trust and Safety predicts what’s next for its “custodians of the internet.” \t\t\t Elon Musk begins reinstating banned Twitter accounts, starting with Jordan Peterson and the Babylon Bee \t\t\t If you (still) work at Twitter and you can code, head to the HQ now. \t\t\t Can Elon Musk turn Twitter into an ‘everything app’? \t\t\t Everyone slows down to look at an accident. \t\t\t Twitter’s living wake kicked off with Elon’s 5PM deadline \t\t\t Twitter reportedly has a new head of trust and safety. \t\t\t Hundreds of employees opt out of Elon Musk’s ‘extremely hardcore’ Twitter \t\t\t Twitter’s getting sued over its remote work rules. \t\t\t Twitter might add even more badges. \t\t\t Elon Musk’s new email pushes Twitter managers to do his dirty work \t\t\t Elon Musk lays out options for remaining Twitter employees: click ‘yes’ or you’re done \t\t\t Elon Musk demands Twitter employees commit to ‘extremely hardcore’ culture or leave \t\t\t Twitter may resurrect end-to-end message encryption. \t\t\t Elon Musk says the new Twitter Blue will relaunch on November 29th \t\t\t Elon Musk is firing Twitter employees even when they criticize him in private \t\t\t Twitter might tragically stop telling you what phone (or fridge) tweets are coming from \t\t\t Buying ads on Twitter is ‘high-risk’ according to the world’s biggest ad agency \t\t\t “They’re all a bunch of cowards.” \t\t\t Ask A Manager has weighed in. \t\t\t Are you locked out of Twitter? Let us know. \t\t\t How to download an archive of your Twitter data \t\t\t Twitter didn’t respond to Eli Lilly about the fake insulin tweet for hours. \t\t\t The CEO of Tesla says he’ll be working remotely for a while. \t\t\t Green light. \t\t\t Elon robs from Elon to pay Elon. \t\t\t Twitter reportedly cut thousands of contractors without warning \t\t\t ‘Fix your companies. Or Congress will,’ Senator Ed Markey warns Elon Musk \t\t\t John Legere asks to run Twitter. \t\t\t Verified parody Jesus can probably keep on jeezing. \t\t\t Elon Musk’s lawyer: Twitter employees aren’t personally at risk over its liabilities to the FTC \t\t\t Another major ad agency recommends pausing Twitter ad campaigns \t\t\t Here’s one speedrun you won’t see at the next Games Done Quick. \t\t\t So long, and thanks for all the fail whales \t\t\t In retrospect, the $7.99 verification plan wasn’t perfect. \t\t\t Elon Musk learns the hard way that being a Twitter troll is way more fun than being a mod \t\t\t Twitter Blue signups disappear a day after fakes and mayhem \t\t\t Twitter reactivated the ‘official’ gray check for accounts that are actually verified \t\t\t Twitter lost Captain Sully, aka, that man knows when to ditch. \t\t\t Inside Elon Musk’s first meeting with Twitter employees \t\t\t Resignation accepted. \t\t\t Twitter loses exec leading trust and safety, but not its head of ad sales \t\t\t Sports Twitter is getting rocked by fake verified accounts. \t\t\t Elon is not helping win back Twitter’s advertisers. \t\t\t Read Elon Musk’s first email to Twitter employees \t\t\t Legitimately verified. \t\t\t Elon Musk is putting Twitter at risk of massive fines, warns employees \t\t\t Elon Musk tells Twitter staff to prepare for ‘difficult times ahead’ and ends remote work \t\t\t Mario flipped off Twitter for nearly two hours with the blessing of Musk’s ‘verification’ \t\t\t Elon Musk’s Twitter Blue with verification is now live \t\t\t Twitter’s new double-check verification disappears, Elon Musk says he ‘killed it’ \t\t\t Twitter rolls back gray ‘official’ checks that popped up on high-profile accounts \t\t\t Twitter’s solution for ruining verification is another check mark \t\t\t Tesla critic claims his anti-Tesla ad was banned from Twitter for ‘political’ reasons \t\t\t Twitter usage going up and up. \t\t\t Someone who is good at the economy please help me budget this. \t\t\t Twitter tells advertisers that user growth is at ‘all-time highs’ under Elon Musk \t\t\t Elon Musk’s response to fake verified Elon Twitter accounts: a new permanent ban policy for impersonation \t\t\t Twitter’s delaying the launch of Blue with verification until after the elections \t\t\t Elon Musk isn’t giving advertisers the answers they want to hear. \t\t\t Hey, who has the keys for this? \t\t\t Elon Musk continues spitballing new Twitter ideas. \t\t\t Jack Dorsey takes responsibility for Elon Musk’s mass layoffs at Twitter \t\t\t Elon Musk’s $7.99 Twitter Blue with verification is ‘coming soon’ on iOS \t\t\t Twitter cut 15 percent of its trust and safety staff but says it won’t impact moderation \t\t\t This might be all it takes to get Verified on Twitter. \t\t\t Elon Musk’s Twitter layoffs leave whole teams gutted \t\t\t You can easily check whether tech companies like Twitter are illegally surprising employees with mass layoffs. \t\t\t “Please use Twitter.” \t\t\t Elon Musk tries to distract from Twitter layoffs by claiming advertisers are fleeing the platform \t\t\t Twitter is being sued by former employees for Elon Musk’s mass firing \t\t\t Audi and General Mills pause their Twitter ads. \t\t\t Elon Musk’s Twitter layoffs are starting \t\t\t Elon Musk could cut half of Twitter’s workforce \t\t\t Elon Musk could enable Twitter’s edit button for everyone \t\t\t Twitter might let users paywall video content: report \t\t\t Elon Musk will let you pay $8 to be a verified ‘lord’ on Twitter \t\t\t Twitter is now an Elon Musk company \t\t\t Twitter braces for layoffs \t\t\t Elon Musk is the CEO of Twitter \t\t\t Twitter verification is the line between order and chaos \t\t\t Twitter is planning to start charging soon for verification \t\t\t Elon Musk wastes no time changing Twitter \t\t\t Will Elon Musk keep funding Twitter’s most interesting side project? \t\t\t Elon Musk says Twitter will have a ‘content moderation council’ \t\t\t Welcome to hell, Elon \t\t\t Elon Musk vs. Twitter: all the news about one of the biggest, messiest tech deals ever \t\t\t Twitter’s employees await their fate under Elon Musk \t\t\t The Twitter deal is all downside risk for Elon Musk \t\t\t Elon Musk tells advertisers he will not make Twitter a ‘free-for-all hellscape’ \t\t\t Elon Musk seems to feel at home inside Twitter’s HQ as ‘Chief Twit’ \t\t\t Elon Musk’s Twitter deal could tank the leveraged buyout market \t\t\t Elon Musk reportedly wants to fire most of Twitter’s employees \t\t\t Elon Musk is buying Twitter, probably? \t\t\t The Elon Musk vs. Twitter trial is on hold until October 28th \t\t\t Elon Musk is buying Twitter again — what does that mean for Tesla? \t\t\t Twitter trial is still on, and Elon Musk probably deleted some Signal messages, judge says \t\t\t Everything we know about Elon Musk’s messy new Twitter offer \t\t\t Elon Musk says he’ll buy Twitter, again, for $54.20 a share, again \t\t\t How Elon Musk, Jack Dorsey, and Parag Agrawal cratered the Twitter deal, in texts \t\t\t Elon Musk’s SpaceX and Tesla emails are for his eyes only \t\t\t Elon Musk sends yet another notice trying to terminate the Twitter deal \t\t\t Judge denies Elon Musk’s attempt to delay Twitter trial \t\t\t Judge agrees Musk’s buddy David Sacks is fighting a subpoena for podcast clout \t\t\t Is Elon Musk’s pal messing with Twitter to score bro points? \t\t\t Elon Musk pushes to delay the Twitter trial while citing whistleblower’s testimony \t\t\t Elon Musk says whistleblower’s testimony gives him more reasons to dump Twitter deal \t\t\t The Twitter whistleblower just got a subpoena from Elon Musk \t\t\t Judge rejects Elon Musk’s ‘absurdly broad’ data requests \t\t\t There’s a wonky number at the core of Elon Musk’s case against Twitter \t\t\t The SEC asked Twitter to explain its user metrics after Elon Musk complained \t\t\t Damning claims about Twitter’s bots and security lapses are ‘a false narrative,’ says CEO \t\t\t Twitter’s former security chief says company lied about bots and safety \t\t\t Elon Musk subpoenas former Twitter CEO Jack Dorsey \t\t\t Elon Musk says a lot of wild things — and somehow we have to believe him \t\t\t Elon Musk wins access to files from Twitter’s former head of product \t\t\t How Elon Musk’s attempt to drag out the Twitter trial could backfire \t\t\t Elon Musk changes plans, sells $6.9 billion in Tesla shares with Twitter trial looming \t\t\t Elon Musk challenges Twitter CEO to a ‘public debate’ about bots \t\t\t This is Elon Musk’s case alleging Twitter committed fraud \t\t\t The best burns Twitter’s lawyers deployed to deny Elon Musk’s claims \t\t\t Tesla is the latest company to be drawn into the Elon Musk-Twitter legal mess \t\t\t Twitter v. Elon Musk trial date set to start October 17th \t\t\t Elon Musk’s lawyers say Twitter is making the pretrial process impossible \t\t\t Elon Musk denies report of an affair with Google co-founder Sergey Brin’s wife \t\t\t Elon Musk’s Twitter takeover trial set to start in October \t\t\t Elon Musk wants Twitter trial to wait until February 2023 \t\t\t Twitter sues Elon Musk for attempting to abandon $44 billion acquisition \t\t\t Elon Musk’s Twitter battle ignites the right’s online agitators \t\t\t Twitter’s new lawyers tell Elon Musk the $44 billion deal is still on \t\t\t Twitter reportedly hires the firm that invented the ‘poison pill’ to sue Elon Musk \t\t\t Twitter tells employees not to tweet about Elon Musk deal \t\t\t Twitter says it’s going to sue Elon Musk for trying to back out of the deal \t\t\t Elon Musk officially tries to bail on buying Twitter \t\t\t It’s looking more like Elon Musk could bail on buying Twitter \t\t\t Twitter insists it has bots handled, claims it blocks 1 million spammers every day \t\t\t Elon Musk’s plan is to run Twitter off the top of his head \t\t\t Elon Musk tells employees he wants Twitter to be more like WeChat and TikTok \t\t\t Elon Musk will allow ‘outrageous’ comments on Twitter but says they shouldn’t be amplified \t\t\t Elon Musk hints that layoffs are in Twitter’s future \t\t\t Elon Musk says Twitter employees doing ‘excellent’ work can continue working from home \t\t\t Elon Musk to answer Twitter employee questions at company meeting on Thursday \t\t\t Twitter will give Elon Musk ‘firehose’ data access to settle bot complaints \t\t\t Elon Musk threatens to scrap Twitter deal over ‘breach’ of agreement \t\t\t Elon Musk reportedly orders hiring freeze, 10 percent staff reduction at Tesla \t\t\t Twitter’s reportedly shifting teams away from Spaces, newsletters, and communities \t\t\t SEC questions Elon Musk over late Twitter disclosure \t\t\t Musk-linked investor resigns from Twitter board, then returns \t\t\t Twitter shareholder sues Elon Musk for tanking the company’s stock \t\t\t Elon Musk will put up $6 billion to drop Tesla loans from his Twitter deal \t\t\t Elon Musk’s latest stunt: calling on the SEC to investigate Twitter’s user numbers \t\t\t Elon Musk says Twitter deal ‘cannot move forward’ until it proves bot numbers \t\t\t Twitter’s CEO and Elon Musk are beefing over bot counts \t\t\t Twitter CEO: ‘We need to be prepared for all scenarios’ \t\t\t Twitter shares plummet as Musk raises new doubts about acquisition \t\t\t Elon Musk says Twitter deal ‘on hold’ after spam / fake account report \t\t\t Twitter CEO pushes out top execs, freezes hiring \t\t\t Elon Musk: ‘I guess I would’ reverse Donald Trump’s Twitter ban \t\t\t Elon Musk got $1 billion from Larry Ellison for his Twitter takeover \t\t\t Twitter’s decentralized, open-source offshoot just released its first code \t\t\t Elon Musk suggests charging governments and corporations a ‘slight cost’ to use Twitter \t\t\t Twitter re-suspends two right-wing accounts trying to evade their bans \t\t\t Every ridiculous thing we learned today about Elon Musk’s plan to take over Twitter \t\t\t Elon Musk unloads $8.4 billion of Tesla stock to finance Twitter takeover \t\t\t Elon Musk’s plans for making money with Twitter reportedly include job cuts \t\t\t Twitter reassures advertisers Musk won’t make the platform more of a toxic hell-hole than it already is \t\t\t Conservative Twitter accounts got boost in followers after Musk acquisition, data shows \t\t\t Twitter policy chief faces wave of harassment amid Musk criticism \t\t\t Jeff Bezos is already testing Elon Musk’s commitment to free speech by trolling \t\t\t What Twitter employees are saying about Elon Musk \t\t\t Twitter CEO tells employees no layoffs planned ‘at this time’ following Elon Musk buyout \t\t\t How Elon Musk and Twitter can really fix free speech: act like a messaging app \t\t\t Twitter accepts buyout, giving Elon Musk total control of the company \t\t\t Elon Musk lays out funding for ambitious Twitter takeover \t\t\t Twitter board announces poison pill measure to block Musk buyout \t\t\t What Elon Musk’s Twitter ‘free speech’ promises miss \t\t\t Twitter CEO tells employees the board is still evaluating an Elon Musk takeover \t\t\t The Twitter board is reportedly not interested in Elon’s takeover offer \t\t\t Elon Musk’s new troll is buying Twitter — will it work? \t\t\t Buying Twitter ‘is not a way to make money,’ says Musk in TED interview \t\t\t Elon Musk offers to buy Twitter in takeover attempt \t\t\t How Elon Musk got everything he wanted out of Twitter \t\t\t Elon Musk’s SEC filings reserve the right to buy a larger stake in Twitter \t\t\t What is going on with Elon Musk and Twitter? \t\t\t Elon Musk won’t join Twitter’s board after all \t\t\t What Elon Musk could mean for Twitter \t\t\t Elon Musk updates the paperwork on his shocking Twitter purchase to avoid extra SEC drama \t\t\t Elon Musk tweeted his way onto Twitter’s board — now what? \t\t\t Twitter says Elon Musk won’t get special treatment from its rules, even as a board member \t\t\t Twitter will appoint Elon Musk to its board of directors",
        "link": "https://www.theverge.com/2022/4/11/23019836/elon-musk-twitter-board-of-directors-news-updates"
      },
      {
        "category": "technology",
        "website": "NYT > Technology",
        "title": "A.I. Is Changing How Silicon Valley Builds Start-Ups",
        "pubDate": "Thu, 20 Feb 2025 18:53:52 +0000",
        "description": "Tech start-ups typically raised huge sums to hire armies of workers and grow fast. Now artificial intelligence tools are making workers more productive and spurring tales of “tiny team” success.",
        "link": "https://www.nytimes.com/2025/02/20/technology/ai-silicon-valley-start-ups.html"
      },
      {
        "category": "technology",
        "website": "WIRED",
        "title": "USDA Layoffs Derail Projects Benefiting American Farmers",
        "pubDate": "Thu, 20 Feb 2025 18:30:44 +0000",
        "description": "The blanket firing of Department of Agriculture scientists has thrown a host of climate science and crop projects into chaos.",
        "link": "https://www.wired.com/story/usda-layoffs-throw-climate-and-crop-projects-into-chaos/"
      },
      {
        "category": "technology",
        "website": "The Verge",
        "title": "iPhone 16E: all the news on Apple’s new $599 phone",
        "pubDate": "2025-02-20T18:22:29Z",
        "description": "iPhone 16E back view  Apple has announced an update to the iPhone SE, but this time around, it’s called the iPhone 16E. As the rumors predicted, Apple’s new budget iPhone model has an updated design with a Face ID-enabled notch, replacing the old model that had a home button and Touch ID interface. Another new element is that this is the first iPhone with an Apple-designed 5G modem inside, the new C1, which Apple says is “the most power-efficient modem ever on an iPhone.”       The iPhone 16E has a 6.06-inch OLED display, customizable Action Button, and Apple Intelligence-ready A18 chipset to match the standard iPhone 16, but not a Dynamic Island display, no MagSafe support, and only a single 48MP rear camera lens. It also has a USB-C port instead of Lightning, and unlike the SE, it’s not much smaller than Apple’s flagship iPhones. The iPhone 16E launch is scheduled for February 28th, with preorders starting on February 21st, with two colors (white or black) and three storage capacity options (128GB, 256GB, and 512GB) and a starting price of $599. Read on for all of the updates about the new iPhone 16E.   \t\t\t\t\t Apple is bringing Visual Intelligence to the iPhone 15 Pro \t\t\t The standard iPhone needs ProMotion more than ever \t\t\t The iPhone is done with home buttons — here’s why I’ll miss it \t\t\t Verge staffers react to the iPhone 16E: what we love and don’t love \t\t\t Here’s when and where you can preorder the new iPhone 16E \t\t\t Apple Intelligence will be available in more languages in April. \t\t\t Apple no longer sells new iPhones with Lightning ports \t\t\t How the new iPhone 16E compares to the rest of Apple’s iPhone 16 lineup \t\t\t 8 important things to know about the iPhone 16E \t\t\t Apple launches the iPhone 16E \t\t\t The iPhone 16E doesn’t support MagSafe charging. \t\t\t Apple’s first in-house iPhone modem is the C1 \t\t\t Apple discontinues the iPhone 14 \t\t\t Watch Apple show off the new iPhone 16E in its reveal video \t\t\t Everything we think we know about the next iPhone SE",
        "link": "https://www.theverge.com/news/615399/apple-iphone-16e-event-specs-price-release-date-se"
      },
      {
        "category": "technology",
        "website": "The Verge",
        "title": "Apple is bringing Visual Intelligence to the iPhone 15 Pro",
        "pubDate": "2025-02-20T18:22:29Z",
        "description": "The iPhone 15 Pro will get Visual Intelligence, Apple’s Google Lens-like tool that lets you point your phone’s camera at things in the world to learn more about them, in a future software update, Apple representatives told John Gruber of Daring Fireball. Visual Intelligence was originally introduced with the initial iPhone 16 lineup in September, and Apple showed it off as a feature that you launched from the Camera Control button. But yesterday, Apple announced that Visual Intelligence would be available on the iPhone 16E, which does not have the Camera Control button, through its Action Button. That suggested that the feature could technically work with the iPhone 15 Pro, which also has an Action Button, and now Apple is confirming that Visual Intelligence will indeed come to that phone and be available via the Action Button. You’ll also be able to launch Visual Intelligence from the Control Center on the iPhone 15 Pro, Apple told Gruber. Apple didn’t tell Gruber which update will bring Visual Intelligence to the iPhone 15 Pro, however. He speculates that it could arrive with iOS 18.4, which could launch in developer beta very soon and is expected to be available publicly in early April.",
        "link": "https://www.theverge.com/news/616665/apple-iphone-15-pro-visual-intelligence"
      },
      {
        "category": "technology",
        "website": "WIRED",
        "title": "The Showdown Between Elon Musk and Sam Altman",
        "pubDate": "Thu, 20 Feb 2025 17:10:50 +0000",
        "description": "This week, the Uncanny Valley hosts discuss the lawsuits, bidding wars, and power plays over OpenAI.",
        "link": "https://www.wired.com/story/uncanny-valley-podcast-15-sam-altman-elon-musk/"
      },
      {
        "category": "technology",
        "website": " Latest from TechRadar US in Computing News ",
        "title": " Rumor suggests Nvidia’s had difficulties to iron out with chips for RTX 5070 and 5060 GPUs, seemingly leading to delays and possibly low stock levels ",
        "pubDate": "Thu, 20 Feb 2025 17:04:44 +0000",
        "description": "More chatter from the grapevine indicates that Nvidia RTX 5070 stock will be low initially, and the RTX 5060 won’t be out until April.",
        "link": "https://www.techradar.com/computing/gpu/rumor-suggests-nvidias-had-difficulties-to-iron-out-with-chips-for-rtx-5070-and-5060-gpus-seemingly-leading-to-delays-and-possibly-low-stock-levels"
      },
      {
        "category": "technology",
        "website": "WIRED",
        "title": "The Watergate-Inspired Law That’s Being Used to Fight DOGE",
        "pubDate": "Thu, 20 Feb 2025 17:01:54 +0000",
        "description": "Here's how the 1974 Privacy Act is being used in legal battles against DOGE—and how you can protect yourself from government surveillance.",
        "link": "https://www.wired.com/story/uncanny-valley-podcast-doge-privacy-act/"
      },
      {
        "category": "technology",
        "website": "WIRED",
        "title": "DOGE Puts $1 Spending Limit on Government Employee Credit Cards",
        "pubDate": "Thu, 20 Feb 2025 16:57:48 +0000",
        "description": "The restrictions are already in place at the General Services Administration along with several other agencies. Soon they’ll roll out to most of the federal government, sources say.",
        "link": "https://www.wired.com/story/doge-government-credit-cards/"
      },
      {
        "category": "technology",
        "website": "WIRED",
        "title": "The 3 Best Essential Oil Diffusers (and One to Avoid)",
        "pubDate": "Thu, 20 Feb 2025 16:09:00 +0000",
        "description": "Keep things smelling fresh with these handy home gadgets.",
        "link": "https://www.wired.com/gallery/best-essential-oil-diffusers/"
      },
      {
        "category": "technology",
        "website": " Latest from TechRadar US in Computing News ",
        "title": " Quordle hints and answers for Friday, February 21 (game #1124) ",
        "pubDate": "Thu, 20 Feb 2025 15:00:00 +0000",
        "description": "Looking for Quordle clues? We can help. Plus get the answers to Quordle today and past solutions.",
        "link": "https://www.techradar.com/computing/websites-apps/quordle-today-answers-clues-21-february-2025"
      },
      {
        "category": "technology",
        "website": " Latest from TechRadar US in Computing News ",
        "title": " NYT Strands hints and answers for Friday, February 21 (game #355) ",
        "pubDate": "Thu, 20 Feb 2025 15:00:00 +0000",
        "description": "Looking for NYT Strands answers and hints? Here's all you need to know to solve today's game, including the spangram.",
        "link": "https://www.techradar.com/computing/websites-apps/nyt-strands-today-answers-hints-21-february-2025"
      },
      {
        "category": "technology",
        "website": "WIRED",
        "title": "The Odds of a City-Killing Asteroid Hitting Earth Keep Rising",
        "pubDate": "Thu, 20 Feb 2025 15:00:00 +0000",
        "description": "The likelihood of 2024 YR4 colliding with the our planet in 2032 have ticked up to over 3 percent. Is it time to start worrying?",
        "link": "https://www.wired.com/story/the-odds-of-a-city-killer-asteroid-impact-in-2032-keep-rising-should-we-be-worried/"
      },
      {
        "category": "technology",
        "website": " Latest from TechRadar US in Computing News ",
        "title": " Did Siri break the law? Apple's latest privacy complaint in France doesn't bode well  ",
        "pubDate": "Thu, 20 Feb 2025 14:47:12 +0000",
        "description": "A French NGO is accusing Apple of violation of privacy, unlawful processing of personal data, and deceptive commercial practices. Here's all you need to know.",
        "link": "https://www.techradar.com/computing/cyber-security/did-your-siri-assistant-break-the-law-apples-latest-privacy-complaint-in-france-doesnt-bode-well"
      },
      {
        "category": "technology",
        "website": "WIRED",
        "title": "Work Has Given Me Tech Neck. This Device Is Helping Undo the Damage",
        "pubDate": "Thu, 20 Feb 2025 14:45:00 +0000",
        "description": "Hours of screen time lead to stiffness, pain, and brain fog. I tested the Chirp Wheel to see if it could help—and the results were surprising.",
        "link": "https://www.wired.com/story/work-has-given-me-tech-neck-this-godsend-device-is-undoing-the-damage/"
      },
      {
        "category": "technology",
        "website": "NYT > Technology",
        "title": "With Truth Social, Trump Has Official Mouthpiece and a Channel for Revenue",
        "pubDate": "Thu, 20 Feb 2025 13:40:12 +0000",
        "description": "The president’s company, Trump Media & Technology Group, represents a clear mingling of his official duties and his business interests.",
        "link": "https://www.nytimes.com/2025/02/19/us/politics/truth-social-trump-media.html"
      },
      {
        "category": "technology",
        "website": "The Hacker News",
        "title": "North Korean Hackers Target Freelance Developers in Job Scam to Deploy Malware",
        "pubDate": "Thu, 20 Feb 2025 19:07:00 +0530",
        "description": "Freelance software developers are the target of an ongoing campaign that leverages job interview-themed lures to deliver cross-platform malware families known as BeaverTail and InvisibleFerret. The activity, linked to North Korea, has been codenamed DeceptiveDevelopment, which overlaps with clusters tracked under the names Contagious Interview (aka CL-STA-0240), DEV#POPPER, Famous Chollima,",
        "link": "https://thehackernews.com/2025/02/north-korean-hackers-target-freelance.html"
      },
      {
        "category": "technology",
        "website": " Latest from TechRadar US in Computing News ",
        "title": " RTX 5050 spotted in HP Victus 15, another hint that Nvidia has a mobile GPU to pep up affordable gaming laptops ",
        "pubDate": "Thu, 20 Feb 2025 13:26:10 +0000",
        "description": "New HP Victus 15 gaming laptops purportedly pack options on RTX 5050 and 5060 graphics cards.",
        "link": "https://www.techradar.com/computing/gpu/rtx-5050-spotted-in-hp-victus-15-another-hint-that-nvidia-has-a-mobile-gpu-to-pep-up-affordable-gaming-laptops"
      },
      {
        "category": "technology",
        "website": " Latest from TechRadar US in Computing News ",
        "title": " AMD’s powerful Ryzen 9 9950X3D and 9900X3D CPUs rumored to arrive on March 12 – but gamers will still be better off with the 9800X3D ",
        "pubDate": "Thu, 20 Feb 2025 12:10:12 +0000",
        "description": "If you were wondering when the next 3D V-Cache chips might arrive, apparently it’s March 12, with reviews emerging the day before.",
        "link": "https://www.techradar.com/computing/cpu/amds-powerful-ryzen-9-9950x3d-and-9900x3d-cpus-rumored-to-arrive-on-march-12-but-gamers-will-still-be-better-off-with-the-9800x3d"
      },
      {
        "category": "technology",
        "website": "The Hacker News",
        "title": "China-Linked Attackers Exploit Check Point Flaw to Deploy ShadowPad and Ransomware",
        "pubDate": "Thu, 20 Feb 2025 16:51:00 +0530",
        "description": "A previously unknown threat activity cluster targeted European organizations, particularly those in the healthcare sector, to deploy PlugX and its successor, ShadowPad, with the intrusions ultimately leading to deployment of a ransomware called NailaoLocker in some cases. The campaign, codenamed Green Nailao by Orange Cyberdefense CERT, involved the exploitation of a new-patched security flaw",
        "link": "https://thehackernews.com/2025/02/chinese-linked-attackers-exploit-check.html"
      },
      {
        "category": "technology",
        "website": "The Hacker News",
        "title": "PCI DSS 4.0 Mandates DMARC By 31st March 2025",
        "pubDate": "Thu, 20 Feb 2025 16:51:00 +0530",
        "description": "The payment card industry has set a critical deadline for businesses handling cardholder data or processing payments- by March 31, 2025, DMARC implementation will be mandatory! This requirement highlights the importance of preventative measures against email fraud, domain spoofing, and phishing in the financial space. This is not an optional requirement as non-compliance may result in monetary",
        "link": "https://thehackernews.com/2025/02/pci-dss-40-mandates-dmarc-by-31st-march.html"
      },
      {
        "category": "technology",
        "website": "The Hacker News",
        "title": "Cybercriminals Use Eclipse Jarsigner to Deploy XLoader Malware via ZIP Archives",
        "pubDate": "Thu, 20 Feb 2025 16:42:00 +0530",
        "description": "A malware campaign distributing the XLoader malware has been observed using the DLL side-loading technique by making use of a legitimate application associated with the Eclipse Foundation. \"The legitimate application used in the attack, jarsigner, is a file created during the installation of the IDE package distributed by the Eclipse Foundation,\" the AhnLab SEcurity Intelligence Center (ASEC)",
        "link": "https://thehackernews.com/2025/02/cybercriminals-use-eclipse-jarsigner-to.html"
      },
      {
        "category": "technology",
        "website": " Latest from TechRadar US in Computing News ",
        "title": " RTX 5090 and 5080 GPU stock woes could be eased as Nvidia launches 'priority access' scheme to help genuine buyers and leave scalpers in the cold ",
        "pubDate": "Thu, 20 Feb 2025 10:53:35 +0000",
        "description": "RTX 5090 and RTX 5080 stock woes are ongoing, but Nvidia has a plan to help genuine buyers with the return of its priority access scheme.",
        "link": "https://www.techradar.com/computing/gpu/rtx-5090-and-5080-gpu-stock-woes-could-be-eased-as-nvidia-launches-priority-access-scheme-to-help-genuine-buyers-and-leave-scalpers-in-the-cold"
      },
      {
        "category": "technology",
        "website": " Latest from TechRadar US in Computing News ",
        "title": " Where to buy Nvidia RTX 5070 Ti: I'm expecting stock here first - but you'll need to be fast ",
        "pubDate": "Thu, 20 Feb 2025 10:18:19 +0000",
        "description": "Live updates on stock from our Computing team so you can know your best bet on where to buy an RTX 5070 Ti.",
        "link": "https://www.techradar.com/live/news/where-to-buy-nvidia-rtx-5070ti"
      },
      {
        "category": "technology",
        "website": " Latest from TechRadar US in Computing News ",
        "title": " These are the top 5 things people are using AI for –and free therapy doesn’t make the list ",
        "pubDate": "Thu, 20 Feb 2025 10:00:00 +0000",
        "description": "New research has revealed the most popular uses for AI tools in the UK and the US right now. And there are a few surprises...",
        "link": "https://www.techradar.com/computing/artificial-intelligence/these-are-the-top-5-things-people-are-using-ai-for-and-free-therapy-doesnt-make-the-list"
      },
      {
        "category": "technology",
        "website": " Latest from TechRadar US in Computing News ",
        "title": " Are you polite to ChatGPT? Here’s where you rank among AI chatbot users ",
        "pubDate": "Thu, 20 Feb 2025 10:00:00 +0000",
        "description": "We're getting kinder to AI, but some of us are still barking orders, and some are just too scared to be rude.",
        "link": "https://www.techradar.com/computing/artificial-intelligence/are-you-polite-to-chatgpt-heres-where-you-rank-among-ai-chatbot-users"
      },
      {
        "category": "technology",
        "website": "The Hacker News",
        "title": "Microsoft's End of Support for Exchange 2016 and 2019: What IT Teams Must Do Now",
        "pubDate": "Thu, 20 Feb 2025 15:30:00 +0530",
        "description": "For decades, Microsoft Exchange has been the backbone of business communications, powering emailing, scheduling and collaboration for organizations worldwide. Whether deployed on-premises or in hybrid environments, companies of all sizes rely on Exchange for seamless internal and external communication, often integrating it deeply with their workflows, compliance policies and security frameworks",
        "link": "https://thehackernews.com/2025/02/microsoft-end-of-support-for-exchange-2016-and-exchange-2019.html"
      },
      {
        "category": "technology",
        "website": "The Hacker News",
        "title": "Citrix Releases Security Fix for NetScaler Console Privilege Escalation Vulnerability",
        "pubDate": "Thu, 20 Feb 2025 10:06:00 +0530",
        "description": "Citrix has released security updates for a high-severity security flaw impacting NetScaler Console (formerly NetScaler ADM) and NetScaler Agent that could lead to privilege escalation under certain conditions. The vulnerability, tracked as CVE-2024-12284, has been given a CVSS v4 score of 8.8 out of a maximum of 10.0. It has been described as a case of improper privilege management that could",
        "link": "https://thehackernews.com/2025/02/citrix-releases-security-fix-for.html"
      },
      {
        "category": "technology",
        "website": "The Hacker News",
        "title": "Microsoft Patches Actively Exploited Power Pages Privilege Escalation Vulnerability",
        "pubDate": "Thu, 20 Feb 2025 09:59:00 +0530",
        "description": "Microsoft has released security updates to address two Critical-rated flaws impacting Bing and Power Pages, including one that has come under active exploitation in the wild. The vulnerabilities are listed below -  CVE-2025-21355 (CVSS score: 8.6) - Microsoft Bing Remote Code Execution Vulnerability CVE-2025-24989 (CVSS score: 8.2) - Microsoft Power Pages Elevation of Privilege Vulnerability  \"",
        "link": "https://thehackernews.com/2025/02/microsoft-patches-actively-exploited.html"
      },
      {
        "category": "technology",
        "website": "NYT > Technology",
        "title": "Nikola, Electric Truck Maker, Files for Bankruptcy",
        "pubDate": "Wed, 19 Feb 2025 19:03:32 +0000",
        "description": "The company, which once enjoyed a surging stock price, struggled to turn its plans for electric and hydrogen trucks into a viable business.",
        "link": "https://www.nytimes.com/2025/02/19/business/nikola-electric-truck-bankruptcy.html"
      },
      {
        "category": "technology",
        "website": "NYT > Technology",
        "title": "Apple Unveils Lower-Priced iPhone 16e With A.I. Features",
        "pubDate": "Wed, 19 Feb 2025 18:56:31 +0000",
        "description": "The iPhone 16e is the first update to the company’s most affordable model since 2022, but carries a higher price tag of $599.",
        "link": "https://www.nytimes.com/2025/02/19/business/apple-iphone-16e-ai.html"
      },
      {
        "category": "technology",
        "website": "The Hacker News",
        "title": "Hackers Exploit Signal's Linked Devices Feature to Hijack Accounts via Malicious QR Codes",
        "pubDate": "Wed, 19 Feb 2025 22:29:00 +0530",
        "description": "Multiple Russia-aligned threat actors have been observed targeting individuals of interest via the privacy-focused messaging app Signal to gain unauthorized access to their accounts. \"The most novel and widely used technique underpinning Russian-aligned attempts to compromise Signal accounts is the abuse of the app's legitimate 'linked devices' feature that enables Signal to be used on multiple",
        "link": "https://thehackernews.com/2025/02/hackers-exploit-signals-linked-devices.html"
      },
      {
        "category": "technology",
        "website": "NYT > Technology",
        "title": "Microsoft Says It Has Created a New State of Matter to Power Quantum Computers",
        "pubDate": "Wed, 19 Feb 2025 16:00:10 +0000",
        "description": "Microsoft’s new “topological qubit” is not based on a solid, liquid or gas. It is another phase of matter that many experts did not think was possible.",
        "link": "https://www.nytimes.com/2025/02/19/technology/microsoft-quantum-computing-topological-qubit.html"
      },
      {
        "category": "technology",
        "website": "The Hacker News",
        "title": "New Snake Keylogger Variant Leverages AutoIt Scripting to Evade Detection",
        "pubDate": "Wed, 19 Feb 2025 18:15:00 +0530",
        "description": "A new variant of the Snake Keylogger malware is being used to actively target Windows users located in China, Turkey, Indonesia, Taiwan, and Spain. Fortinet FortiGuard Labs said the new version of the malware has been behind over 280 million blocked infection attempts worldwide since the start of the year. \"Typically delivered through phishing emails containing malicious attachments or links,",
        "link": "https://thehackernews.com/2025/02/new-snake-keylogger-variant-leverages.html"
      },
      {
        "category": "technology",
        "website": "NYT > Technology",
        "title": "Elon Musk’s DOGE Seeks Access to Americans’ Data, Alarming Government Employees",
        "pubDate": "Wed, 19 Feb 2025 11:40:38 +0000",
        "description": "Employees from Elon Musk’s so-called Department of Government Efficiency are gaining access to vast amounts of information held by federal agencies, even as lawsuits try to stop them.",
        "link": "https://www.nytimes.com/2025/02/19/us/politics/elon-musk-doge-personal-data.html"
      },
      {
        "category": "technology",
        "website": "The Hacker News",
        "title": "The Ultimate MSP Guide to Structuring and Selling vCISO Services",
        "pubDate": "Wed, 19 Feb 2025 16:30:00 +0530",
        "description": "The growing demand for cybersecurity and compliance services presents a great opportunity for Managed Service Providers (MSPs) and Managed Security Service Providers (MSSPs) to offer virtual Chief Information Security Officer (vCISO) services—delivering high-level cybersecurity leadership without the cost of a full-time hire. However, transitioning to vCISO services is not without its challenges",
        "link": "https://thehackernews.com/2025/02/the-ultimate-msp-guide-to-structuring.html"
      },
      {
        "category": "technology",
        "website": "NYT > Technology",
        "title": "The Cryptocurrency Scam That Turned a Small Town Against Itself",
        "pubDate": "Wed, 19 Feb 2025 10:00:54 +0000",
        "description": "How did a successful, financially sophisticated banker gamble his community’s money away?",
        "link": "https://www.nytimes.com/2025/02/19/magazine/cryptocurrency-scam-kansas-heartland-bank.html"
      },
      {
        "category": "technology",
        "website": "NYT > Technology",
        "title": "Mira Murati, OpenAI’s Former Chief Technology Officer, Starts Her Own Company",
        "pubDate": "Wed, 19 Feb 2025 05:03:00 +0000",
        "description": "Mira Murati, who left OpenAI last year, has helped establish Thinking Machines Lab, a new artificial intelligence start-up.",
        "link": "https://www.nytimes.com/2025/02/18/technology/openai-mira-murati-startup.html"
      },
      {
        "category": "technology",
        "website": "NYT > Technology",
        "title": "HP to Buy Humane, Maker of the Ai Pin, for $116 Million",
        "pubDate": "Wed, 19 Feb 2025 03:11:07 +0000",
        "description": "Humane, which marketed its Ai Pin as the next big thing after smartphones, had raised $240 million from investors, including OpenAI’s Sam Altman. The pin will be discontinued.",
        "link": "https://www.nytimes.com/2025/02/18/technology/hp-humane-ai-pin.html"
      }
    ]
  }
}
```

---

## Customer Support

Need any assistance? [Get in touch with Customer Support](https://apiverve.com/contact).

---

## Updates
Stay up to date by following [@apiverveHQ](https://twitter.com/apiverveHQ) on Twitter.

---

## Legal

All usage of the APIVerve website, API, and services is subject to the [APIVerve Terms of Service](https://apiverve.com/terms) and all legal documents and agreements.

---

## License
Licensed under the The MIT License (MIT)

Copyright (&copy;) 2025 APIVerve, and EvlarSoft LLC

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
