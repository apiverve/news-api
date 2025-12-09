declare module '@apiverve/news' {
  export interface newsOptions {
    api_key: string;
    secure?: boolean;
  }

  export interface newsResponse {
    status: string;
    error: string | null;
    data: WorldNewsData;
    code?: number;
  }


  interface WorldNewsData {
      date:         Date;
      category:     Category;
      articleCount: number;
      articles:     Article[];
  }
  
  interface Article {
      category:    Category;
      website:     Website;
      title:       string;
      pubDate:     string;
      description: string;
      link:        string;
  }
  
  enum Category {
      Technology = "technology",
  }
  
  enum Website {
      LatestFromTechRadarUSInComputingNews = " Latest from TechRadar US in Computing News ",
      LatestNews = "Latest news",
      NYTTechnology = "NYT > Technology",
      TheHackerNews = "The Hacker News",
      TheVerge = "The Verge",
      Wired = "WIRED",
  }

  export default class newsWrapper {
    constructor(options: newsOptions);

    execute(callback: (error: any, data: newsResponse | null) => void): Promise<newsResponse>;
    execute(query: Record<string, any>, callback: (error: any, data: newsResponse | null) => void): Promise<newsResponse>;
    execute(query?: Record<string, any>): Promise<newsResponse>;
  }
}
