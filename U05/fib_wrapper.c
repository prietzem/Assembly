#include <inttypes.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <sys/time.h>

#define MAX_WIDTH 1000000

typedef struct {
	clock_t cycles;
	uint64_t time;
	uint64_t res;
} Measurement;

extern uint64_t asm_fib_it(uint64_t);
extern uint64_t asm_fib_rek(uint64_t);

static uint64_t c_fib_it(uint64_t);
static uint64_t c_fib_rek(uint64_t);

/*
 * @description ruft eine Funktion auf und misst deren Zeit und CPU-Cyclen
 * @para uint64_t (*func)(uint64_t): Funktion die aufgerufen werden soll
 * @para uint64_t val: parameter mit dem 'func' aufgerufen werden soll
 * @para struct Measurements* m: Pointer auf struct für Messwerte
 */
void simple_benchmark(uint64_t (*func)(uint64_t), uint64_t val, Measurement *m)
{
	// CPU-cycles
	m->cycles = clock();
	m->res = func(val);
	m->cycles = clock() - m->cycles; // MUSS SO!

	// Zeit in Microsekunden
	struct timeval beg;
	struct timeval end;
	gettimeofday(&beg, NULL);
	m->res = func(val);
	gettimeofday(&end, NULL);
	m->time = (1000000 * end.tv_sec + end.tv_usec);
	m->time -= (1000000 * beg.tv_sec + beg.tv_usec);
}

/*
 * @description: zeichnet Tabelle mit Messergebnissen
 * @param char* name: name für Tabelle
 * @param struct Measurements* m_it: Messergebniss für iterative Funktion
 * @param struct Measurements* m_rek: Messergebniss für rekursive Funktion
 */
void drawTable(char *name, Measurement *ergs_it, Measurement *ergs_rek)
{
	bool res_size_it = (ergs_it->res >= MAX_WIDTH) ? true : false;
	bool res_size_rek = (ergs_rek->res >= MAX_WIDTH) ? true : false;

	bool cyc_size_it = (ergs_it->cycles >= MAX_WIDTH) ? true : false;
	bool cyc_size_rek = (ergs_rek->cycles >= MAX_WIDTH) ? true : false;

	bool time_size_it = (ergs_it->time >= MAX_WIDTH) ? true : false;
	bool time_size_rek = (ergs_rek->time >= MAX_WIDTH) ? true : false;

	fputs("+-------+---------------+---------------+---------------+\n",
	      stdout);
	printf("|"
	       "%s"
	       "\t|Erg:\t\t|CPU-Cycles:\t|Time (us):\t|\n",
	       name);
	fputs("+-------+---------------+---------------+---------------+\n",
	      stdout);

	printf("|It:\t|%" PRIu64 "\t%s|%ld\t%s|%" PRIu64 "\t%s|\n",
	       ergs_it->res, (!res_size_it) ? "\t" : "", ergs_it->cycles,
	       (!cyc_size_it) ? "\t" : "", ergs_it->time,
	       (!time_size_it) ? "\t" : "");

	printf("|Rek:\t|%" PRIu64 "\t%s|%ld\t%s|%" PRIu64 "\t%s|\n",
	       ergs_rek->res, (!res_size_rek) ? "\t" : "", ergs_rek->cycles,
	       (!cyc_size_rek) ? "\t" : "", ergs_rek->time,
	       (!time_size_rek) ? "\t" : "");

	fputs("+-------+---------------+---------------+---------------+\n\n",
	      stdout);
}

int main(int argc, char *argv[])
{
	if (argc < 2) {
		fputs("A number is required!\n", stderr);
		return EXIT_FAILURE;
	}

	char *endPtr = NULL;
	uint64_t val = strtoull(argv[1], &endPtr, 10);
	if (*endPtr || (argv[1][0] == '-')) {
		fprintf(stderr, "Invalid argument: \"%s\"\n", argv[1]);
		fputs("Please enter a positive number.\n", stdout);
		return EXIT_FAILURE;
	}

	printf("\nBenchmark für die %" PRIu64 ". Fibonacci Zahl:\n\n", val);

	Measurement m_ergs_it;
	Measurement m_ergs_rek;

	// C
	simple_benchmark(c_fib_it, val, &m_ergs_it);
	simple_benchmark(c_fib_rek, val, &m_ergs_rek);
	drawTable("C", &m_ergs_it, &m_ergs_rek);

	// ASM
	simple_benchmark(asm_fib_it, val, &m_ergs_it);
	simple_benchmark(asm_fib_rek, val, &m_ergs_rek);
	drawTable("ASM", &m_ergs_it, &m_ergs_rek);

	return EXIT_SUCCESS;
}

uint64_t c_fib_it(uint64_t n)
{
	uint64_t x_1 = 0;
	uint64_t x_2 = 1;
	uint64_t k = 0;

	while (n > 0) {
		x_1 = x_2;
		x_2 = k;
		k = x_1 + x_2;
		n--;
	}

	return k;
}

uint64_t c_fib_rek(uint64_t n)
{
	if (n < 3) {
		return 1;
	} else {
		return c_fib_rek(n - 1) + c_fib_rek(n - 2);
	}
}
