declare module '@apiverve/news' {
  export interface newsOptions {
    api_key: string;
    secure?: boolean;
  }

  /**
   * Describes fields the current plan does not unlock. Locked fields arrive as null
   * in `data`; `locked_fields` names them, using dot paths for nested fields.
   * Absent when the plan unlocks everything.
   */
  export interface PremiumInfo {
    message: string;
    upgrade_url: string;
    locked_fields: string[];
  }

  export interface newsResponse {
    status: string;
    error: string | null;
    data: WorldNewsData;
    code?: number;
    premium?: PremiumInfo;
  }


  interface WorldNewsData {
      date:         Date | null;
      category:     Category | null;
      articleCount: number | null;
      articles:     Article[];
  }
  
  interface Article {
      category:    Category | null;
      website:     Website | null;
      title:       null | string;
      pubDate:     null | string;
      description: null | string;
      link:        null | string;
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
