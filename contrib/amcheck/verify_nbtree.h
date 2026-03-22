/*-------------------------------------------------------------------------
 *
 * verify_nbtree.h
 *		Declarations for nbtree verification and inspection functions.
 *
 * Copyright (c) 2017-2026, PostgreSQL Global Development Group
 *
 * IDENTIFICATION
 *	  contrib/amcheck/verify_nbtree.h
 *
 *-------------------------------------------------------------------------
 */

#ifndef VERIFY_NBTREE_H
#define VERIFY_NBTREE_H

#include "fmgr.h"

extern Datum bt_index_bloat_stats(PG_FUNCTION_ARGS);

#endif							/* VERIFY_NBTREE_H */
