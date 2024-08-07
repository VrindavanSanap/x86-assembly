#include <stdio.h>
#include <string.h> // Added for strlen

int main() {
    FILE *file;
    int numbers[10];

    // Fill the array with numbers from 1 to 10
    for (int i = 0; i < 10; i++) {
        numbers[i] = i + 1;
    }

    // Open file in binary write mode ("wb" stands for write binary)
    file = fopen("output.bin", "wb");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    printf("Size of int: %zu bytes\n", sizeof(int));
    printf("Size of char: %zu bytes\n", sizeof(char));

    // Write the array of integers to the file
    size_t result = fwrite(numbers, sizeof(int), 10, file);
    if (result != 10) {
        perror("Error writing to file");
        fclose(file);
        return 1;
    }

    char* string = "hello world"; // Fixed missing semicolon
    size_t length = strlen(string) + 1; // +1 for the null terminator
    result = fwrite(string, sizeof(char), length, file);
    if (result != length) {
        perror("Error writing to file");
        fclose(file);
        return 1;
    }

    // Close the file
    fclose(file);

    return 0;
}
