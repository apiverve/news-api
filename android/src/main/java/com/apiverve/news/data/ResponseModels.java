// Converter.java

// To use this code, add the following Maven dependency to your project:
//
//
//     com.fasterxml.jackson.core     : jackson-databind          : 2.9.0
//     com.fasterxml.jackson.datatype : jackson-datatype-jsr310   : 2.9.0
//
// Import this package:
//
//     import com.apiverve.data.Converter;
//
// Then you can deserialize a JSON string with
//
//     WorldNewsData data = Converter.fromJsonString(jsonString);

package com.apiverve.news.data;

import java.io.IOException;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import java.util.*;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.OffsetTime;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.temporal.ChronoField;

public class Converter {
    // Date-time helpers

    private static final DateTimeFormatter DATE_TIME_FORMATTER = new DateTimeFormatterBuilder()
            .appendOptional(DateTimeFormatter.ISO_DATE_TIME)
            .appendOptional(DateTimeFormatter.ISO_OFFSET_DATE_TIME)
            .appendOptional(DateTimeFormatter.ISO_INSTANT)
            .appendOptional(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SX"))
            .appendOptional(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ssX"))
            .appendOptional(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
            .toFormatter()
            .withZone(ZoneOffset.UTC);

    public static OffsetDateTime parseDateTimeString(String str) {
        return ZonedDateTime.from(Converter.DATE_TIME_FORMATTER.parse(str)).toOffsetDateTime();
    }

    private static final DateTimeFormatter TIME_FORMATTER = new DateTimeFormatterBuilder()
            .appendOptional(DateTimeFormatter.ISO_TIME)
            .appendOptional(DateTimeFormatter.ISO_OFFSET_TIME)
            .parseDefaulting(ChronoField.YEAR, 2020)
            .parseDefaulting(ChronoField.MONTH_OF_YEAR, 1)
            .parseDefaulting(ChronoField.DAY_OF_MONTH, 1)
            .toFormatter()
            .withZone(ZoneOffset.UTC);

    public static OffsetTime parseTimeString(String str) {
        return ZonedDateTime.from(Converter.TIME_FORMATTER.parse(str)).toOffsetDateTime().toOffsetTime();
    }
    // Serialize/deserialize helpers

    public static WorldNewsData fromJsonString(String json) throws IOException {
        return getObjectReader().readValue(json);
    }

    public static String toJsonString(WorldNewsData obj) throws JsonProcessingException {
        return getObjectWriter().writeValueAsString(obj);
    }

    private static ObjectReader reader;
    private static ObjectWriter writer;

    private static void instantiateMapper() {
        ObjectMapper mapper = new ObjectMapper();
        mapper.findAndRegisterModules();
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        mapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);
        SimpleModule module = new SimpleModule();
        module.addDeserializer(OffsetDateTime.class, new JsonDeserializer<OffsetDateTime>() {
            @Override
            public OffsetDateTime deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
                String value = jsonParser.getText();
                return Converter.parseDateTimeString(value);
            }
        });
        mapper.registerModule(module);
        reader = mapper.readerFor(WorldNewsData.class);
        writer = mapper.writerFor(WorldNewsData.class);
    }

    private static ObjectReader getObjectReader() {
        if (reader == null) instantiateMapper();
        return reader;
    }

    private static ObjectWriter getObjectWriter() {
        if (writer == null) instantiateMapper();
        return writer;
    }
}

// WorldNewsData.java

package com.apiverve.news.data;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;

public class WorldNewsData {
    private LocalDate date;
    private Category category;
    private long articleCount;
    private Article[] articles;

    @JsonProperty("date")
    public LocalDate getDate() { return date; }
    @JsonProperty("date")
    public void setDate(LocalDate value) { this.date = value; }

    @JsonProperty("category")
    public Category getCategory() { return category; }
    @JsonProperty("category")
    public void setCategory(Category value) { this.category = value; }

    @JsonProperty("articleCount")
    public long getArticleCount() { return articleCount; }
    @JsonProperty("articleCount")
    public void setArticleCount(long value) { this.articleCount = value; }

    @JsonProperty("articles")
    public Article[] getArticles() { return articles; }
    @JsonProperty("articles")
    public void setArticles(Article[] value) { this.articles = value; }
}

// Article.java

package com.apiverve.news.data;

import com.fasterxml.jackson.annotation.*;

public class Article {
    private Category category;
    private Website website;
    private String title;
    private String pubDate;
    private String description;
    private String link;

    @JsonProperty("category")
    public Category getCategory() { return category; }
    @JsonProperty("category")
    public void setCategory(Category value) { this.category = value; }

    @JsonProperty("website")
    public Website getWebsite() { return website; }
    @JsonProperty("website")
    public void setWebsite(Website value) { this.website = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("pubDate")
    public String getPubDate() { return pubDate; }
    @JsonProperty("pubDate")
    public void setPubDate(String value) { this.pubDate = value; }

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("link")
    public String getLink() { return link; }
    @JsonProperty("link")
    public void setLink(String value) { this.link = value; }
}

// Category.java

package com.apiverve.news.data;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Category {
    TECHNOLOGY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case TECHNOLOGY: return "technology";
        }
        return null;
    }

    @JsonCreator
    public static Category forValue(String value) throws IOException {
        if (value.equals("technology")) return TECHNOLOGY;
        throw new IOException("Cannot deserialize Category");
    }
}

// Website.java

package com.apiverve.news.data;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Website {
    LATEST_FROM_TECH_RADAR_US_IN_COMPUTING_NEWS, LATEST_NEWS, NYT_TECHNOLOGY, THE_HACKER_NEWS, THE_VERGE, WIRED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case LATEST_FROM_TECH_RADAR_US_IN_COMPUTING_NEWS: return " Latest from TechRadar US in Computing News ";
            case LATEST_NEWS: return "Latest news";
            case NYT_TECHNOLOGY: return "NYT > Technology";
            case THE_HACKER_NEWS: return "The Hacker News";
            case THE_VERGE: return "The Verge";
            case WIRED: return "WIRED";
        }
        return null;
    }

    @JsonCreator
    public static Website forValue(String value) throws IOException {
        if (value.equals(" Latest from TechRadar US in Computing News ")) return LATEST_FROM_TECH_RADAR_US_IN_COMPUTING_NEWS;
        if (value.equals("Latest news")) return LATEST_NEWS;
        if (value.equals("NYT > Technology")) return NYT_TECHNOLOGY;
        if (value.equals("The Hacker News")) return THE_HACKER_NEWS;
        if (value.equals("The Verge")) return THE_VERGE;
        if (value.equals("WIRED")) return WIRED;
        throw new IOException("Cannot deserialize Website");
    }
}