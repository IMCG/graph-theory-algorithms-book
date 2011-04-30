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
#include <math.h>
#include <stdio.h>

/* Based on igraph revision 2345, 2011-02-17. See https://launchpad.net/igraph
 * Simple undirected G(n,p) model. Fix n = 20,000 and consider r = 50
 * probability points chosen as follows. Let pmin = 0.000001, pmax = 0.999999,
 * F = (pmax / pmin)^(1 / (r-1)). For i = 1, 2, ..., r=50 the i-th
 * probability point p_i is defined by p_i = pmin * (F^(i-1)). Each experiment
 * consists in generating maxrun = 500 random graphs from G(n, p_i). For each
 * such graph Gi, compute the following quantities:
 *
 * * the actual number A of edges
 * * the expected number alpha of edges
 * * the actual total degree B
 * * the expected total degree beta
 *
 * Write the above metrics to a file named "i.dat", following the format:
 *
 * A  B
 *
 * The first line of the file contains the metrics
 *
 * alpha  beta
 *
 * That is, on the first line of the file we write the expected number of edges
 * and the expected total degree. On subsequent lines we write the
 * experimental values of A and B. The file "i.dat" should contain 501 lines
 * of data. The first line is the expected metrics as above and the remaining
 * 500 lines are for the experimental metrics A and B.
 */
int main() {
  char *filename;
  FILE *f;
  igraph_t g;
  igraph_integer_t nverts = 20000;
  igraph_integer_t A, B;
  long int maxrun = 500;
  long int r = 50;
  long int i, k;
  double alpha, beta;
  double p_i;
  double pmin = 0.000001;
  double pmax = 0.999999;
  double b = pmax / pmin;
  double e = 1.0 / ((double)r - 1.0);
  double F = powl(b, e);
  double maxedges = 199990000;  /* n(n-1)/2 */
  double M = 399980000;         /* n(n-1) */

  /* run each of the r experiments */
  for (i = 0; i < r; i++) {
    /* We start from zero, so we take i. If we start from 1, we take i - 1. */
    p_i = pmin * powl(F, (double)i);
    alpha = p_i * maxedges;
    beta = p_i * M;
    asprintf(&filename, "%li.dat", i + 1);
    f = fopen(filename, "w");
    fprintf(f, "%.50f  %.50f\n", alpha, beta);
    /* perform maxrun of each experiment */
    for (k = 0; k < maxrun; k++) {
      igraph_erdos_renyi_game(&g, IGRAPH_ERDOS_RENYI_GNP, nverts, p_i,
    			      0 /* not directed */, 0 /* no self-loops */);
      A = igraph_ecount(&g);
      B = 2 * A;
      fprintf(f, "%li  %li\n", (long int)A, (long int)B);
      igraph_destroy(&g);
    }
    fclose(f);
  }

  return 0;
}
