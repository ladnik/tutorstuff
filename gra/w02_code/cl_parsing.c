#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <tgmath.h>

#include <unistd.h> // needed for getopt
#include <getopt.h> // defines things like optarg

#include <errno.h> // needed for error checks

void print_usage(const char *progname)
{
    printf("This is a message explaining how to use %s\n", progname);
}

void print_help(const char *progname)
{
    printf("This is a message explaining help for %s\n", progname);
}

unsigned tests(void)
{
    int failed = 0;
    printf("All tests PASSED\n");
    return failed;
}

int main(int argc, char **argv)
{
    // the program name is always the first element in argv
    const char *progname = argv[0];

    // these are default values - they can be overwritten
    // by using the options -a, -b and -n
    double a = 0.0, b = 1.0;
    size_t n = 2;

    // define an optstring for the following arguments:
    // -a <param>: requires argument, interprete as double
    // -b <param>: requires argument, interprete as double
    // -n <param>: requires argument, interprete as double
    // -t: requires no argument, run tests and exit
    // -h: requires no argument, show help msg and exit
    char *optstring = "a:b:n:th";

    char c;       // currently parsed argument char
    char *endptr; // used for number parsing

    // getopt returns the current option char, if no arguments
    // remain, -1 is returned. '?' is unrecognized option chars
    // optarg points to the argument for this option, if available
    while ((c = getopt(argc, argv, optstring)) != -1)
    {
        errno = 0; // reset errno to check if new error is caused by parsing
        switch (c)
        {
        case 'a':
            endptr = NULL;
            a = strtod(optarg, &endptr); // parse the string at 'optarg' to double
            if (
                (*endptr != '\0') ||  // endptr does not point to NUL
                (optarg == endptr) || // conversion failed
                (errno == ERANGE))    // over- or underflow
            {
                fprintf(stderr, "Invalid number: %s\n", optarg); // print to fd stderr
                exit(EXIT_FAILURE);
            }
            break;
        case 'b':
            endptr = NULL;
            b = strtod(optarg, &endptr); // parse the string at 'optarg' to double
            if (
                (*endptr != '\0') ||  // endptr does not point to NUL
                (optarg == endptr) || // conversion failed
                (errno == ERANGE))    // over- or underflow
            {
                fprintf(stderr, "Invalid number: %s\n", optarg); // print to fd stderr
                exit(EXIT_FAILURE);
            }
            break;
        case 'n':
            endptr = NULL;
            n = strtol(optarg, &endptr, 10); // parse the string at 'optarg' to long, base 10
            if (
                (*endptr != '\0') ||  // endptr does not point to NUL
                (optarg == endptr) || // conversion failed
                (errno == ERANGE))    // over- or underflow
            {
                fprintf(stderr, "Invalid number: %s\n", optarg); // print to fd stderr
                exit(EXIT_FAILURE);
            }
            break;
        case 't':
            return tests() ? EXIT_FAILURE : EXIT_SUCCESS;
            break;
        case 'h':
            print_help(argv[0]);
            exit(EXIT_SUCCESS);
            break;
        case '?':
            // unrecognized option
            print_usage(argv[0]);
            exit(EXIT_FAILURE);
        default:
            exit(EXIT_FAILURE);
        }
    }

    // get first element that isn't an option
    char* blah = argv[optind];

    // do stuff...
    printf("Running with a=%f, b=%f, n=%lu.\n", a, b, n);

    return EXIT_SUCCESS;
}
