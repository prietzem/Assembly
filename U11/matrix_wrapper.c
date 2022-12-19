#include <inttypes.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <errno.h>
#include <limits.h>
#include <assert.h>

#include <sys/time.h>

#define DEFAULT_M 1024 // rows
#define DEFAULT_N 1024 // cols

#define BOUND 1000
#define MAX_WIDTH 1000000

struct measurement {
	clock_t cycles;
	uint64_t time;
	int64_t res;
};

struct parameter {
	int64_t *matrix;
	uint64_t m;
	uint64_t n;
};

// C
int64_t cRowAdd(int64_t matrix[], uint64_t m, uint64_t n);
int64_t cColAdd(int64_t matrix[], uint64_t m, uint64_t n);

// ASM
extern int64_t asmRowAdd(int64_t matrix[], uint64_t m, uint64_t n);
extern int64_t asmColAdd(int64_t matrix[], uint64_t m, uint64_t n);

/*
 * @description ruft eine Funktion auf und misst deren Zeit und CPU-Cyclen
 * @para uint64_t (*func)(uint64_t): Funktion die aufgerufen werden soll
 * @para uint64_t val: parameter mit dem 'func' aufgerufen werden soll
 * @para struct measurement* m: Pointer auf struct für Messwerte
 */
void benchmark(int64_t (*func)(int64_t[], uint64_t, uint64_t), struct parameter *p,
               struct measurement *m)
{
	// Für maximale Präzision, jeweils zwei Aufrufe von 'func'
	// CPU-cycles
	m->cycles = clock();
	m->res = func(p->matrix, p->m, p->n);
	m->cycles = clock() - m->cycles; // MUSS SO!

	// Zeit in Microsekunden
	struct timeval beg, end;
	gettimeofday(&beg, NULL);
	m->res = func(p->matrix, p->m, p->n);
	gettimeofday(&end, NULL);
	m->time = (1000000 * end.tv_sec + end.tv_usec);
	m->time -= (1000000 * beg.tv_sec + beg.tv_usec);
}

/*
 * @description: zeichnet Tabelle mit Messergebnissen
 * @param char* name: name für Tabelle
 * @param struct struct measurements* m_cols: Messergebniss für iterative Funktion
 * @param struct struct measurements* m_rows: Messergebniss für rekursive Funktion
 */
void drawTable(char *name, struct measurement *ergs_cols, struct measurement *ergs_rows)
{
	bool res_size_cols = (ergs_cols->res >= MAX_WIDTH) ? true : false;
	bool res_size_rows = (ergs_rows->res >= MAX_WIDTH) ? true : false;

	bool cyc_size_cols = (ergs_cols->cycles >= MAX_WIDTH) ? true : false;
	bool cyc_size_rows = (ergs_rows->cycles >= MAX_WIDTH) ? true : false;

	bool time_size_cols = (ergs_cols->time >= MAX_WIDTH) ? true : false;
	bool time_size_rows = (ergs_rows->time >= MAX_WIDTH) ? true : false;

	fputs("+-------+---------------+---------------+---------------+\n",
	      stdout);
	printf("|"
	       "%s"
	       "\t|Erg:\t\t|CPU-Cycles:\t|Time (us):\t|\n",
	       name);
	fputs("+-------+---------------+---------------+---------------+\n",
	      stdout);

	printf("|Cols:\t|%" PRIu64 "\t%s|%ld\t%s|%" PRIu64 "\t%s|\n",
	       ergs_cols->res, (!res_size_cols) ? "\t" : "", ergs_cols->cycles,
	       (!cyc_size_cols) ? "\t" : "", ergs_cols->time,
	       (!time_size_cols) ? "\t" : "");

	printf("|Rows:\t|%" PRIu64 "\t%s|%ld\t%s|%" PRIu64 "\t%s|\n",
	       ergs_rows->res, (!res_size_rows) ? "\t" : "", ergs_rows->cycles,
	       (!cyc_size_rows) ? "\t" : "", ergs_rows->time,
	       (!time_size_rows) ? "\t" : "");

	fputs("+-------+---------------+---------------+---------------+\n\n",
	      stdout);
}


long long strtoll_or_die(const char *const restrict nptr, const int base)
{
	char *endptr = NULL;
	errno = 0;

	long long n = strtoll(nptr, &endptr, base);
	if (errno) {
		perror("strtoll");
		exit(EXIT_FAILURE);

	}
	if (*endptr != '\0') {
		fprintf(stderr, "Invalid number in base %d: \"%s\"\n", base, nptr);
		exit(EXIT_FAILURE);
	}

	return n;
}


int main(int argc, char *argv[])
{
	size_t M = DEFAULT_M;
	size_t N = DEFAULT_N;
	if (argc != 1 && argc != 3) {
		fprintf(stderr, "Either pass no arguments or specify M and N\n");
		return EXIT_FAILURE;
	}
	if (argc == 3) {
		char *mstr = argv[1];
		char *nstr = argv[2];
		long long m = strtoll_or_die(mstr, 10);
		long long n = strtoll_or_die(nstr, 10);
		//static_assert(LLONG_MAX < SIZE_MAX);
		if (m < 0) {
			fprintf(stderr, "Invalid value for M (%lld)\n", m);
			return EXIT_FAILURE;
		}

		if (n < 0) {
			fprintf(stderr, "Invalid value for N (%lld)\n", n);
			return EXIT_FAILURE;
		}

		M = m;
		N = n;
	}
	int64_t *matrix = calloc(sizeof (*matrix), N*M);
	if (!matrix) { perror("malloc"); return EXIT_FAILURE; }

	struct measurement erg_cols, erg_rows;
	struct parameter p = {.matrix = matrix, .n = N, .m = M};

	srand(time(NULL));
	for (size_t i = 0; i < M * N; i++) {
		matrix[i] = rand() % BOUND;
	}

	printf("Benchmark: Zeilen = %zu & Spalten = %zu => Elemente = %zu\n\n", M,
	       N, N * M);

	// C
	benchmark(cColAdd, &p, &erg_cols);
	benchmark(cRowAdd, &p, &erg_rows);
	drawTable("C", &erg_cols, &erg_rows);

	// ASM
	benchmark(asmColAdd, &p, &erg_cols);
	benchmark(asmRowAdd, &p, &erg_rows);
	drawTable("ASM", &erg_cols, &erg_rows);

	free(matrix);

	return EXIT_SUCCESS;
}

int64_t cColAdd(int64_t matrix[], uint64_t m, uint64_t n)
{
	int64_t res = 0;
	for (size_t i = 0; i < n; i++) {
		for (size_t j = 0; j < m; j++) {
			res += matrix[j * n + i];
		}
	}
	return res;
}

int64_t cRowAdd(int64_t matrix[], uint64_t m, uint64_t n)
{
	int64_t res = 0;
	for (size_t i = 0; i < m; i++) {
		for (size_t j = 0; j < n; j++) {
			res += matrix[i * n + j];
		}
	}
	return res;
}
