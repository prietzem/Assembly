#include <inttypes.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

extern float calc_add(float, float);

int main(int argc, char *argv[])
{
	// Check if enough arguments are provided
	if (argc < 3) {
		fprintf(stderr, "Not enough arguments! Try ./calc 1.2 3.4\n");
		return EXIT_FAILURE;
	}

	// Read operands from command line
	float operand1 = (float)atof(argv[1]);
	float operand2 = (float)atof(argv[2]);

	// Perform addition
	printf("%f + %f = ", operand1, operand2);
	float result = calc_add(operand1, operand2);
	printf("%f\n", result);

	return EXIT_SUCCESS;
}
