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
      category:     null | string;
      edition:      null;
      languages:    (null | string)[];
      country:      null;
      sort:         null | string;
      lastUpdated:  Date | null;
      articleCount: number | null;
      articles:     Article[];
  }
  
  interface Article {
      category:       null | string;
      website:        null | string;
      title:          null | string;
      pubDate:        Date | null;
      image:          null | string;
      description:    null | string;
      link:           null | string;
      id:             null | string;
      categories:     (null | string)[];
      countries:      (null | string)[];
      edition:        null | string;
      language:       null | string;
      coverage:       number | null;
      sources:        Source[];
      sentiment:      null | string;
      sentimentScore: number | null;
  }
  
  interface Source {
      website: null | string;
      title:   null | string;
      link:    null | string;
      pubDate: Date | null;
  }

  export default class newsWrapper {
    constructor(options: newsOptions);

    execute(callback: (error: any, data: newsResponse | null) => void): Promise<newsResponse>;
    execute(query: Record<string, any>, callback: (error: any, data: newsResponse | null) => void): Promise<newsResponse>;
    execute(query?: Record<string, any>): Promise<newsResponse>;
  }
}
