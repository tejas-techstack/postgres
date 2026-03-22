/*-------------------------------------------------------------------------
 *
 * amcheck.c
 *		Shared extension exports.
 *
 * Copyright (c) 2017-2026, PostgreSQL Global Development Group
 *
 * IDENTIFICATION
 *	  contrib/amcheck/amcheck.c
 *
 *-------------------------------------------------------------------------
 */

#include "postgres.h"

#include "verify_nbtree.h"

PG_FUNCTION_INFO_V1(bt_index_bloat_stats);
