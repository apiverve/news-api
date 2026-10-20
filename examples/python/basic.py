"""
World News API - Basic Usage Example

This example demonstrates the basic usage of the World News API.
API Documentation: https://docs.apiverve.com/ref/news
"""

import os
import requests
import json

API_KEY = os.getenv('APIVERVE_API_KEY', 'YOUR_API_KEY_HERE')
API_URL = 'https://api.apiverve.com/v1/news'

def call_news_api():
    """
    Make a GET request to the World News API
    """
    try:
        # Query parameters
        params &#x3D; {&#x27;category&#x27;: &#x27;technology&#x27;, &#x27;country&#x27;: &#x27;JP&#x27;, &#x27;edition&#x27;: &#x27;GB&#x27;, &#x27;language&#x27;: &#x27;es&#x27;, &#x27;sort&#x27;: &#x27;top&#x27;, &#x27;limit&#x27;: 10}

        headers = {
            'x-api-key': API_KEY
        }

        response = requests.get(API_URL, headers=headers, params=params)

        # Raise exception for HTTP errors
        response.raise_for_status()

        data = response.json()

        # Check API response status
        if data.get('status') == 'ok':
            print('✓ Success!')
            print('Response data:', json.dumps(data['data'], indent=2))
            return data['data']
        else:
            print('✗ API Error:', data.get('error', 'Unknown error'))
            return None

    except requests.exceptions.RequestException as e:
        print(f'✗ Request failed: {e}')
        return None

if __name__ == '__main__':
    print('📤 Calling World News API...\n')

    result = call_news_api()

    if result:
        print('\n📊 Final Result:')
        print(json.dumps(result, indent=2))
    else:
        print('\n✗ API call failed')
