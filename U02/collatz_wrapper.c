#include <errno.h>
#include <inttypes.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

extern uint64_t collatz(uint64_t);
static uint64_t collatz_check(uint64_t n)
{
	uint64_t k = 0;
	while (n > 1) {
		if (n % 2 == 0) {
			n /= 2;
		} else {
			n *= 3;
			n++;
		}
		k++;
	}
	return k;
}

int main(int argc, char *argv[])
{
	if (argc < 2) {
		fprintf(stderr, "Not enough arguments!\n");
		return 1;
	}

	/* Fail if
	 *  1. string is empty or
	 *  2. there were trailing characters or
	 *  3. the converted value is out of range
	 */
	char *endptr;
	const uint64_t val = strtoull(argv[1], &endptr, 10);
	if (argv[1][0] == '\0' || *endptr != '\0' ||
	    (val == ULONG_MAX && errno == ERANGE)) {
		fprintf(stderr, "Invalid Argument: \"%s\"\n", argv[1]);
		return 2;
	}

	const uint64_t res = collatz(val);
	const uint64_t chk = collatz_check(val);
	printf("collatz(%" PRIu64 ") = %" PRIu64 "[%s]\n", val, res,
	       chk == res ? "CORRECT" : "WRONG");

	return chk == res ? 0 : 3;
}
