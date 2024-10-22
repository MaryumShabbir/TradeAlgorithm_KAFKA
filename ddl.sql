CREATE TABLE market_news
 (
  id BIGINT,
  author VARCHAR,
  headline VARCHAR,
  source VARCHAR,
  summary VARCHAR,
  data_provider VARCHAR,
  url VARCHAR,
  symbol VARCHAR,
  sentiment VARCHAR,
  timestamp BIGINT,
  event_time AS TIMESTAMP_LTZ(timestamp_ms, {}),
  WATERMARK FOR event_time AS event_time - INTERVAL '5' SECOND
) WITH (
  CONNECTOR = 'kafka',
  TOPIC = 'market-news',
  PROPERTIES.bootstrap.servers = 'redpanda-1:29092,redpanda-2:29093',
  PROPERTIES.group.id = 'market-news-group',
  PROPERTIES.auto.offset.reset = 'earliest',
  FORMAT = 'json'
);