#include <assert.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_STR_LEN 50

/*
 * Declare these as weak as we have fallback functions in C if one or both are
 * not implemented
 */
__attribute__((weak)) extern int64_t strToInt(const char *, uint8_t);
__attribute__((weak)) extern size_t intToStr(int64_t, uint8_t, char *, size_t);

static bool strToInt_unimplemented;
static bool intToStr_unimplemented;

int64_t strToInt(const char *str, uint8_t base)
{
	strToInt_unimplemented = true;

	/* invalid base */
	if (base <= 1 || base > 36) {
		return 0;
	}

	return strtol(str, NULL, base);
}

/* Supports up to base 36 */
static char toascii(uint8_t digit)
{
	if (digit < 10) {
		return (char)digit + '0';
	}
	return (char)digit - 10 + 'A';
}

static size_t uintToStr(uint64_t num, uint8_t base, char *outbuf, size_t len)
{
	/* no output buffer */
	if (!outbuf || len == 0) {
		return 0;
	}

	/* invalid base */
	if (base <= 1 || base > 36) {
		return 0;
	}

	/* Euklidean algorithm */
	uint64_t new = num / base;
	uint64_t rem = num % base;
	size_t written;
	if (new == 0) {
		/* tail case: first digit we will write */
		written = 0;
	} else {
		/* chain call, will write all digits til' our current and tell
		 * us how many were yet written */
		written = uintToStr(new, base, outbuf, len);
	}

	/* make sure we do not overflow */
	if (written == len) {
		/* truncate */
		outbuf[written - 1] = '\0';
		/* exit: climb up our call hiearchy */
		return written;
	}

	/* actually write the digit */
	assert(rem < UINT8_MAX);
	outbuf[written] = toascii((uint8_t)rem);
	written++;
	return written;
}

size_t intToStr(int64_t num, uint8_t base, char *outbuf, size_t len)
{
	intToStr_unimplemented = true;

	/* no output buffer */
	if (!outbuf || len == 0) {
		return 0;
	}

	/* invalid base */
	if (base <= 1 || base > 36) {
		return 0;
	}

	/* empty output buffer, we write a NUL just to be safe */
	if (len == 1) {
		*outbuf = '\0';
		return 1;
	}

	/* negative numbers: write leading sign and now use unsigned numbers */
	if (num < 0) {
		*outbuf = '-';
		size_t written = uintToStr((uint64_t)labs(num), base,
		                           outbuf + 1, len - 1);
		return written + 1;
	}

	/* otherwise just chain-call */
	return uintToStr((uint64_t)num, base, outbuf, len);
}

int main(int argc, char *argv[])
{
	if (argc < 3) {
		fprintf(stderr, "Not enough arguments!\n");
		fprintf(stderr, "Usage: convert string base\n"
				"Example: convert -abc 16\n");
		return 1;
	}

	char *end = NULL;
	unsigned long _base = strtoul(argv[2], &end, 10);
	if (*end || _base >= UINT8_MAX) {
		printf("No valid base: %s\n", argv[2]);
		return 2;
	}
	uint8_t base = (uint8_t)_base;

	int64_t val = strToInt(argv[1], base);
	printf("strToInt: %s_%hhu = %" PRId64 "_10%s\n",
			argv[1], base, val, strToInt_unimplemented ?
			" [UNIMPLEMENTED]" : "");

	char int_str[MAX_STR_LEN];
	size_t len = intToStr(val, base, int_str,
	                      sizeof(int_str) / sizeof(int_str[0]));
	printf("intToStr: %" PRId64 "_10 = %s_%hhu, length: %zu%s\n", val,
			int_str, base, len, intToStr_unimplemented ?
			" [UNIMPLEMENTED]" : "");

	return 0;
}
