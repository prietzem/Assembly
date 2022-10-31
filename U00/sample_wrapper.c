#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

extern int64_t tri_area(int64_t base, int64_t height);

int main(int argc, char *argv[])
{
	if (argc != 3) {
		fprintf(stderr, "Provide exactly two arguments!\n");
		exit(1);
	}

	int64_t base = atoi(argv[1]);
	int64_t height = atoi(argv[2]);
	int64_t area = tri_area(base, height);
	printf("tri_area(%" PRId64 ", %" PRId64 ") = %" PRId64 "\n", base,
	       height, area);
}
