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
        /// The news category for which you want to get the news. Allowed values: business, entertainment, world, health, science, sports, technology
        /// Example: technology
        /// </summary>
        [JsonProperty("category")]
        public string Category { get; set; }
    }
}
