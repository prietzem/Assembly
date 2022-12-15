#include <inttypes.h>
#include <limits.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define BOUND 100

extern void sort(uint64_t len, int64_t a[len]);

static inline void printArray(int64_t *to_show, uint64_t len)
{
	for (uint64_t i = 0; i < len; i++) {
		if (i == 0) { // erstes Element
			printf("Array: %" PRId64 ", ", to_show[i]);
		} else if (i == (len - 1)) { // letztes Element
			printf("%" PRId64 "\n", to_show[i]);
		} else {
			printf("%" PRId64 ", ", to_show[i]);
		}
	}
}

int main(int argc, char *argv[])
{
	if (argc < 2) {
		fprintf(stderr, "Not enough arguments!\n");
		printf("Usage: ./bubblesort <len>\n");
		return 1;
	}

        /* Fail if
         *  1. string is empty or
         *  2. there were trailing characters or
         *  3. the converted value is out of range
         */
        char *endptr;
        const uint64_t len = strtoull(argv[1], &endptr, 10);
        if (argv[1][0] == '\0' || *endptr != '\0' ||
            (len == ULONG_MAX && errno == ERANGE)) {
                fprintf(stderr, "Invalid Argument: \"%s\"\n", argv[1]);
                return 2;
        }

	if (len < 2) {
		fprintf(stderr, "Length must be at least 2.\n");
		return 3;
	}

	srand(time(NULL));
	int64_t to_sort[len];
	for (uint64_t i = 0; i < len; i++) {
		to_sort[i] = rand() % BOUND;
		// int8_t neg = rand() % 2;
		// if(neg) {
		// 	to_sort[i] = to_sort[i] * -1;
		// }
	}

	printArray(to_sort, len);
	sort(len, to_sort);
	printArray(to_sort, len);
}
