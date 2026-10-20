using System;
using System.Collections.Generic;
using System.Text;
using Newtonsoft.Json;

namespace APIVerve.API.WorldNews
{
    /// <summary>
    /// Query options for the World News API
    /// </summary>
    public class WorldNewsQueryOptions
    {
        /// <summary>
        /// Only stories on this topic. A story is in every topic its headline and summary name, not only its feed's section.
        /// </summary>
        [JsonProperty("category")]
        public string Category { get; set; }

        /// <summary>
        /// Only stories about this country, from any outlet: an ISO 3166 code or English name, for example JP or Japan.
        /// </summary>
        [JsonProperty("country")]
        public string Country { get; set; }

        /// <summary>
        /// Only stories run by outlets based in this country: what its press is covering, in the languages it writes in. See list=editions.
        /// </summary>
        [JsonProperty("edition")]
        public string Edition { get; set; }

        /// <summary>
        /// Only stories in this language. Defaults to English, or with edition to the languages that edition's press writes in. Stories are never translated.
        /// </summary>
        [JsonProperty("language")]
        public string Language { get; set; }

        /// <summary>
        /// top ranks stories by how many outlets carry them, favouring the last 12 hours; latest is newest first.
        /// </summary>
        [JsonProperty("sort")]
        public string Sort { get; set; }

        /// <summary>
        /// Only stories whose headlines or summaries contain every word given, in any case.
        /// </summary>
        [JsonProperty("q")]
        public string Q { get; set; }

        /// <summary>
        /// Only stories published at or after this date or date-time (ISO 8601), for example 2026-10-01 or 2026-10-01T14:00:00Z.
        /// </summary>
        [JsonProperty("since")]
        public string Since { get; set; }

        /// <summary>
        /// Maximum number of stories to return: up to 10 on the free plan, 50 on paid plans.
        /// </summary>
        [JsonProperty("limit")]
        public int? Limit { get; set; }
    }
}
