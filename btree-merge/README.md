# B-Tree Index Bloat Experiments

This directory contains reproducible experiments for analyzing B-tree index bloat in PostgreSQL.

## Implemented

* Set up a local PostgreSQL development environment
* Created a synthetic workload to generate index bloat using `DELETE` and `VACUUM` operations
* Used `amcheck` (`bt_index_bloat_stats`) to measure index-level bloat
* Used `pageinspect` (`bt_page_stats`) to analyze page-level characteristics
* Observed distribution of:

  * leaf pages
  * internal pages
  * deleted pages
* Measured free and used space across different page types
* Identified scenarios with:

  * significant deleted-page accumulation
  * underfilled leaf pages

## Purpose

The goal of these experiments is to reproduce and study B-tree index bloat behavior under controlled workloads.

