#include "pascal.h"
#include "computation.h"
#include <stdio.h>

void pascal(unsigned int pascalIndex) {
    unsigned int number = 1;
    for (int i = 1; i<=pascalIndex; i++) {
        printf("%u", number);
        number = number * computation(pascalIndex, i) / i;
        printf(" ");
    }
}