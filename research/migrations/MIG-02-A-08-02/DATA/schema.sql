PRAGMA foreign_keys = ON;

CREATE TABLE project_meta (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);

CREATE TABLE places (
  place_id TEXT PRIMARY KEY,
  historical_name TEXT NOT NULL,
  modern_name TEXT,
  place_type TEXT,
  historical_region TEXT,
  modern_location TEXT,
  longitude REAL,
  latitude REAL,
  name_validity TEXT NOT NULL CHECK(name_validity IN ('verified','provisional','disputed','unverified')),
  notes TEXT
);

CREATE TABLE actors_groups (
  actor_id TEXT PRIMARY KEY,
  display_name TEXT NOT NULL,
  actor_type TEXT NOT NULL CHECK(actor_type IN ('individual','lineage','elite_group','civilian_group','military_group','religious_group','craft_group','administrative_population','other','unknown')),
  origin_place_id TEXT,
  date_start TEXT,
  date_end TEXT,
  notes TEXT,
  FOREIGN KEY(origin_place_id) REFERENCES places(place_id)
);

CREATE TABLE sources (
  source_id TEXT PRIMARY KEY,
  source_type TEXT NOT NULL CHECK(source_type IN ('primary_text','inscription','epitaph','archaeology','numismatic','modern_scholarship','gazetteer','other')),
  author_editor TEXT,
  title TEXT NOT NULL,
  publication_details TEXT,
  date_or_period TEXT,
  edition_or_version TEXT,
  chapter_page_locator TEXT,
  url_or_identifier TEXT,
  evidence_grade TEXT NOT NULL CHECK(evidence_grade IN ('A','B','C','D')),
  access_status TEXT NOT NULL CHECK(access_status IN ('checked','partially_checked','not_checked','inaccessible')),
  notes TEXT
);

CREATE TABLE migration_events (
  event_id TEXT PRIMARY KEY,
  event_label TEXT NOT NULL,
  date_start TEXT,
  date_end TEXT,
  date_precision TEXT NOT NULL CHECK(date_precision IN ('exact_day','exact_year','year_range','century','approximate','uncertain')),
  origin_place_id TEXT,
  destination_place_id TEXT,
  destination_type TEXT CHECK(destination_type IN ('actual_residence','administrative_exile_site','temporary_refuge','military_station','reported_destination','unknown')),
  movement_type TEXT CHECK(movement_type IN ('self_migration','war_refugee','state_relocation','military_movement','captivity_or_forced_transfer','return_migration','mixed_or_unknown')),
  actor_id TEXT,
  record_status TEXT NOT NULL CHECK(record_status IN ('verified','provisional','disputed','unverified','rejected')),
  route_status TEXT NOT NULL CHECK(route_status IN ('documented','partially_inferred','modelled','unknown')),
  confidence_note TEXT,
  notes TEXT,
  FOREIGN KEY(origin_place_id) REFERENCES places(place_id),
  FOREIGN KEY(destination_place_id) REFERENCES places(place_id),
  FOREIGN KEY(actor_id) REFERENCES actors_groups(actor_id)
);

CREATE TABLE evidence_links (
  evidence_id TEXT PRIMARY KEY,
  event_id TEXT NOT NULL,
  source_id TEXT NOT NULL,
  exact_quote_or_summary TEXT NOT NULL,
  locator TEXT,
  evidence_role TEXT NOT NULL CHECK(evidence_role IN ('direct_support','indirect_support','contradiction','dating_evidence','location_evidence','context_only')),
  evidence_grade TEXT NOT NULL CHECK(evidence_grade IN ('A','B','C','D')),
  record_status TEXT NOT NULL CHECK(record_status IN ('verified','provisional','disputed','unverified','rejected')),
  interpretation_note TEXT,
  FOREIGN KEY(event_id) REFERENCES migration_events(event_id),
  FOREIGN KEY(source_id) REFERENCES sources(source_id)
);

CREATE TABLE claims (
  claim_id TEXT PRIMARY KEY,
  claim_text TEXT NOT NULL,
  claim_type TEXT NOT NULL CHECK(claim_type IN ('historical_fact_claim','interpretation','hypothesis','model')),
  record_status TEXT NOT NULL CHECK(record_status IN ('verified','provisional','disputed','unverified','rejected')),
  supporting_evidence_ids TEXT,
  counter_evidence_ids TEXT,
  scope_limits TEXT,
  notes TEXT
);

CREATE TABLE event_actor_links (
  event_id TEXT NOT NULL,
  actor_id TEXT NOT NULL,
  role TEXT,
  PRIMARY KEY(event_id, actor_id),
  FOREIGN KEY(event_id) REFERENCES migration_events(event_id),
  FOREIGN KEY(actor_id) REFERENCES actors_groups(actor_id)
);

CREATE TABLE event_place_links (
  event_id TEXT NOT NULL,
  place_id TEXT NOT NULL,
  place_role TEXT NOT NULL CHECK(place_role IN ('origin','transit','destination','administrative_site','temporary_refuge','uncertain_association')),
  PRIMARY KEY(event_id, place_id, place_role),
  FOREIGN KEY(event_id) REFERENCES migration_events(event_id),
  FOREIGN KEY(place_id) REFERENCES places(place_id)
);

CREATE TABLE audit_log (
  audit_id INTEGER PRIMARY KEY AUTOINCREMENT,
  table_name TEXT NOT NULL,
  record_id TEXT NOT NULL,
  action TEXT NOT NULL CHECK(action IN ('created','updated','status_changed','rejected')),
  changed_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  change_reason TEXT NOT NULL,
  changed_fields TEXT
);

CREATE INDEX idx_events_dates ON migration_events(date_start, date_end);
CREATE INDEX idx_events_status ON migration_events(record_status);
CREATE INDEX idx_evidence_event ON evidence_links(event_id);
CREATE INDEX idx_evidence_source ON evidence_links(source_id);
