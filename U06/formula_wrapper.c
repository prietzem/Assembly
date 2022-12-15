#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>

extern int32_t formula_int(int32_t, int32_t, int32_t, int32_t, int32_t, int32_t,
                           int32_t, int32_t);
extern double formula_flt(double, double, double, double, double, double,
                          double, double);

static double check_flt(double a, double b, double c, double d, double e,
                        double f, double g, double h)
{
	return (((a + b) * (c - d)) * ((e * 8) + (f * 4) - (g / 2) + (h / 4))) /
	       3;
}

static int32_t check_int(int32_t a, int32_t b, int32_t c, int32_t d, int32_t e,
                         int32_t f, int32_t g, int32_t h)
{
	return (((a + b) * (c - d)) * ((e * 8) + (f * 4) - (g / 2) + (h / 4))) /
	       3;
}

static int32_t check_int_shift(int32_t a, int32_t b, int32_t c, int32_t d,
                               int32_t e, int32_t f, int32_t g, int32_t h)
{
	return (((a + b) * (c - d)) *
	        ((e << 3) + (f << 2) - (g >> 1) + (h >> 2))) /
	       3;
}

int main(int argc, char *argv[])
{
	if (argc < 9) {
		fprintf(stderr, "Not enough arguments!\n");
		return EXIT_FAILURE;
	}

	char *test = NULL;
	double a = strtod(argv[1], &test);
	if (*test) {
		fprintf(stderr, "Invalid Argument: %s\n", argv[1]);
	}

	double b = strtod(argv[2], &test);
	if (*test) {
		fprintf(stderr, "Invalid Argument: %s\n", argv[2]);
	}

	double c = strtod(argv[3], &test);
	if (*test) {
		fprintf(stderr, "Invalid Argument: %s\n", argv[3]);
	}

	double d = strtod(argv[4], &test);
	if (*test) {
		fprintf(stderr, "Invalid Argument: %s\n", argv[4]);
	}

	double e = strtod(argv[5], &test);
	if (*test) {
		fprintf(stderr, "Invalid Argument: %s\n", argv[5]);
	}

	double f = strtod(argv[6], &test);
	if (*test) {
		fprintf(stderr, "Invalid Argument: %s\n", argv[6]);
	}

	double g = strtod(argv[7], &test);
	if (*test) {
		fprintf(stderr, "Invalid Argument: %s\n", argv[7]);
	}

	double h = strtod(argv[8], &test);
	if (*test) {
		fprintf(stderr, "Invalid Argument: %s\n", argv[8]);
	}

	if (*test) {
		return EXIT_FAILURE;
	}

	int32_t a_int = a, b_int = b, c_int = c, d_int = d, e_int = e,
	        f_int = f, g_int = g, h_int = h;
	double res_flt = formula_flt(a, b, c, d, e, f, g, h);
	double chk_flt = check_flt(a, b, c, d, e, f, g, h);
	int32_t res_int = formula_int(a_int, b_int, c_int, d_int, e_int, f_int,
	                              g_int, h_int);
	int32_t chk_int = check_int(a_int, b_int, c_int, d_int, e_int, f_int,
	                            g_int, h_int);
	int32_t chk_int_shift = check_int_shift(a_int, b_int, c_int, d_int,
	                                        e_int, f_int, g_int, h_int);

	printf("Erg:  formula_flt(%lf, %lf, %lf, %lf, %lf, %lf, %lf, %lf) = "
	       "%lf [%lf]\n", a, b, c, d, e, f, g, h, res_flt, chk_flt);
	printf("Erg:  formula_int(%" PRId32 ", %" PRId32 ", %" PRId32 ", "
	       "%" PRId32 ", %" PRId32 ", %" PRId32 ", %" PRId32 ", "
	       "%" PRId32 ") = %" PRId32 " [%" PRId32 ", shift: %" PRId32 "]\n",
	       a_int, b_int, c_int, d_int, e_int, f_int, g_int, h_int, res_int,
	       chk_int, chk_int_shift);

	return EXIT_SUCCESS;
}
