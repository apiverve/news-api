/**
 * Basic Example - World News API
 *
 * This example demonstrates how to use the World News API.
 * Make sure to set your API key in the .env file or replace '[YOUR_API_KEY]' below.
 */

require('dotenv').config();
const newsAPI = require('../index.js');

// Initialize the API client
const api = new newsAPI({
    api_key: process.env.API_KEY || '[YOUR_API_KEY]'
});

// Example query
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

// Make the API request using callback
console.log('Making request to World News API...\n');

api.execute(query, function (error, data) {
    if (error) {
        console.error('Error occurred:');
        if (error.error) {
            console.error('Message:', error.error);
            console.error('Status:', error.status);
        } else {
            console.error(JSON.stringify(error, null, 2));
        }
        return;
    }

    console.log('Response:');
    console.log(JSON.stringify(data, null, 2));
});
