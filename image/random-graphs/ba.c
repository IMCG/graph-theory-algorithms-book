/**************************************************************************
 * Copyright (C) 2011 Minh Van Nguyen <nguyenminh2@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * http://www.gnu.org/licenses/
 **************************************************************************/

#include <igraph.h>
#include <stdio.h>

/* Based on igraph revision 2340, 2011-02-14. See https://launchpad.net/igraph
 * The classic Barabasi-Albert model. Here we only consider directed edges.
 * Fix d = 5 for the minimum out-degree of each vertex, alpha = 1 for the
 * power, and A = 1. The relevant expression is d^alpha + A. Generate
 * Barabasi-Albert random graphs, one graph for each of the following number
 * of vertices:
 *
 * * 10^5 = 100,000
 * * 10^6 = 1,000,000
 * * 10^7 = 10,000,000
 * * 2*10^7 = 20,000,000
 *
 * For each generated graph, find the in-degree of each vertex and write it to
 * a file named "n.dat", where "n" is the number of vertices in the graph. The
 * output is written on one line according to the format:
 *
 * vertex_id  in_degree
 */
int main() {
  char *filename;
  FILE *f;
  igraph_t g;
  igraph_integer_t nvert[4] = {100000, 1000000, 10000000, 20000000};
  igraph_integer_t d = 5;
  igraph_vector_t deg;
  long int i, k;

  for (i = 0; i < 4; i++) {
    asprintf(&filename, "%li.dat", (long int)nvert[i]);
    f = fopen(filename, "w");
    igraph_barabasi_game(/* graph      */ &g,
			 /* n          */ nvert[i],
			 /* power      */ 1,
			 /* m          */ d,
			 /* outseq     */ NULL,
			 /* outpref    */ 0,
			 /* A          */ 1,
			 /* directed   */ 1,
			 /* algo       */ IGRAPH_BARABASI_BAG,
			 /* start_from */ NULL);
    igraph_vector_init(&deg, 0);
    igraph_degree(&g, &deg, igraph_vss_all(), IGRAPH_IN,
		  /* ignore self-loops */ 0);
    for (k = 0; k < igraph_vector_size(&deg); k++) {
      fprintf(f, "%li %li\n", (long int)k, (long int)VECTOR(deg)[k]);
    }
    fclose(f);
    igraph_vector_destroy(&deg);
    igraph_destroy(&g);
  }

  return 0;
}
