-- Reset test objects and create reproducible B-Tree bloat,
-- then call amcheck's bt_index_bloat_stats().

\x on

CREATE EXTENSION IF NOT EXISTS amcheck;
CREATE EXTENSION IF NOT EXISTS pageinspect;

DROP INDEX IF EXISTS idx_bloat_val;
DROP TABLE IF EXISTS bloat_test;

CREATE TABLE bloat_test (
	id	bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	val	bigint NOT NULL
);

CREATE INDEX idx_bloat_val ON bloat_test(val);

INSERT INTO bloat_test(val)
SELECT g
FROM generate_series(1, 5000000) AS g;

ANALYZE bloat_test;

-- First churn pass
DELETE FROM bloat_test
WHERE val % 2 = 0;

INSERT INTO bloat_test(val)
SELECT g + 5000000
FROM generate_series(1, 1000000) AS g;

ANALYZE bloat_test;
VACUUM (VERBOSE, INDEX_CLEANUP ON) bloat_test;

-- Contiguous-range delete to create fully-empty leaf-page runs
DELETE FROM bloat_test
WHERE val BETWEEN 1 AND 4500000;

VACUUM (VERBOSE, INDEX_CLEANUP ON) bloat_test;

-- Main function under test
SELECT *
FROM bt_index_bloat_stats('idx_bloat_val'::regclass);

-- Optional verification via pageinspect
SELECT count(*) FILTER (WHERE (s.btpo_flags & 4) = 4) AS deleted_pages,
	   count(*) FILTER (WHERE (s.btpo_flags & 2) = 2) AS halfdead_pages,
	   count(*) AS scanned_pages
FROM generate_series(
	   1,
	   (SELECT relpages - 1 FROM pg_class WHERE oid = 'idx_bloat_val'::regclass)
	 ) AS g(blkno)
CROSS JOIN LATERAL bt_page_stats('idx_bloat_val', g.blkno) AS s;
