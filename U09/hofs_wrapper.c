#define _POSIX_C_SOURCE 200809L

#include <assert.h>
#include <errno.h>
#include <inttypes.h>
#include <limits.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <string.h>


extern void sort(void *base, size_t nel,
                 int64_t (*compar)(const void *, const void *));

__attribute__((force_align_arg_pointer))
static int64_t int_compar(const void *_a, const void *_b)
{
        const int64_t *a = _a;
        const int64_t *b = _b;
        int64_t c = (*a - *b);
//	fprintf(stderr, "\"%"PRId64"\" %c \"%"PRId64"\"\n", *a, c < 0 ? '<' : '>', *b);
        return (c);
}

__attribute__((force_align_arg_pointer))
static int64_t str_compar(const void *_a, const void *_b)
{
	char *const *a = _a;
	char *const *b = _b;
	int64_t c = strcmp(*a, *b);
//	fprintf(stderr, "\"%s\" %c \"%s\"\n", *a, c < 0 ? '<' : '>', *b);
	return (c);
}

#define MIN_ELEMS 1
#define MAX_ELEMS 512
#define MAX_INT 1000L

int main(int argc, char *argv[])
{
	static int64_t int_array[MAX_ELEMS];

	enum {
		TYPE_INT,
		TYPE_STRING,
	} type = TYPE_INT;
	int errflg = 0;
	int help = 0;
	int c;
	while (c = getopt(argc, argv, ":sih"), c != -1) {
		switch (c) {
		case 's':
			type = TYPE_STRING;
			break;
		case 'i':
			type = TYPE_INT;
			break;
		case 'h':
			help = 1;
			break;
		case ':':
			assert(false);
			break;
		case '?':
			fprintf(stderr, "Unrecognized option: '-%c'\n", optopt);
			errflg = 1;
			break;
		}
	}
	if (errflg || help) {
		fprintf(errflg ? stderr : stdout,
			"Usage: hofs element1 ...\n"
			"Where `element' is an integer unless specified otherwise in the options.\n"
			"Use `--' to disambiguate input from options if necessary (see examples).\n"
			"\n"
			"Options:\n"
			"\t-s\tSort strings\n"
			"\t-i\tSort integers (default)\n"
			"\t-h\tThis help\n"
			"Examples:\n"
			"\thofs 7 -1 3 6\n"
			"\thofs -- -7 8 2 3\n"
			"\thofs -s abc def aa\n"
			"\thofs -s -- -abc def aa\n");
		exit(errflg ? 2 : 0);
	}

	const int num_elems = argc - optind;

	if (num_elems < MIN_ELEMS || num_elems > MAX_ELEMS) {
		fprintf(stderr, "Input must be have between %d and %d elements\n", MIN_ELEMS, MAX_ELEMS);
		exit(3);
	}

	if (type == TYPE_INT) {
//		fprintf(stderr, "Sorting %d elements\n", argc-optind);
		for (int i = 0; i < argc-optind; i++) {
			char *endptr;
			long el = strtoll(argv[optind+i], &endptr, 10);
			if (argv[optind+i][0] == '\0' || *endptr != '\0' ||
			    el > MAX_INT) {
				fprintf(stderr, "Integer elements must be %ld max\n", MAX_INT);
				exit(3);
			}
			int_array[i] = el;
		}
		sort(int_array, argc-optind, int_compar);
		int64_t last = INT64_MIN;
		bool correct = true;
		for (int i = 0; i < argc-optind; i++) {
			correct = correct && int_array[i] >= last;
			last = int_array[i];
			printf("%"PRId64" ", int_array[i]);
		}
		printf("\n");
		printf("%s\n", correct ? "Sorted correct" : "Sorting was wrong");
	} else if (type == TYPE_STRING) {
		fprintf(stderr, "Sorting %d elements\n", argc-optind);
		sort(&argv[optind], argc-optind, str_compar);
		const char *last = "";
		bool correct = true;
		for (int i = optind; i < argc; i++) {
			correct = correct && strcmp(argv[i], last) >= 0;
			last = argv[i];
			printf("%s\n", argv[i]);
		}
		printf("%s\n", correct ? "Sorted correct" : "Sorting was wrong");
	} else {
		assert(false);
	}

}
