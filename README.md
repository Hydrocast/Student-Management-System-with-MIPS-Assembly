# Student Management System - MIPS Assembly
**Author:** Giannis Loizou

## Description
A MIPS Assembly program that implements a simple student management system for tracking student index numbers and their corresponding marks. The program provides a console-based menu interface for managing up to 10 students with features for adding, searching, displaying, and calculating average marks.

## Features

### Core Functionality
- **Add Student**: Store student index numbers (1-10) and their marks
- **Display All Students**: View all registered students with their index numbers and marks
- **Search by Index**: Find specific students using their index number
- **Average Marks**: Calculate and display the average marks of all students
- **Exit**: Cleanly terminate the program

### Data Management
- **Fixed Capacity**: Supports up to 10 students
- **Index Validation**: Ensures index numbers are between 1-10
- **Override Protection**: Warns when overwriting existing student records
- **Array Storage**: Uses separate arrays for index numbers and marks

### User Interface
- **Text-based Menu**: Simple console interface with numbered options
- **Input Validation**: Handles invalid menu choices and index numbers
- **Clear Navigation**: Easy-to-follow menu system with prompts
- **Error Handling**: Informative error messages for invalid operations

## Technical Details

### Data Structures
- `arrayIndex`: 40-byte array storing student index numbers
- `arrayMark`: 40-byte array storing corresponding student marks

### Memory Layout
- Each array can store up to 10 integers (4 bytes each)
- Index numbers are validated to be within 1-10 range
- Data is stored in corresponding positions across both arrays

### Program Flow
1. **Initialization**: Sets up array pointers in registers `$s0` and `$s1`
2. **Main Menu**: Displays options and processes user input
3. **Function Routing**: Branches to appropriate subroutines based on user choice
4. **Loop Execution**: Returns to main menu after each operation (except exit)

## Usage

The program runs in a MIPS simulator (like SPIM or MARS) and provides these menu options:

1. **Add Student**: Enter index number (1-10) and marks
2. **Display All**: Shows all registered students in format: "Index No: X, Marks: Y"
3. **Search**: Find student by index number
4. **Average**: Calculate mean of all student marks
5. **Exit**: Terminate program

## Error Handling
- Invalid menu choices display error message
- Out-of-range index numbers show validation error
- Search for non-existent students shows "not found" message
- Empty student lists handled gracefully in average calculation

## Assembly Features
- Uses standard MIPS system calls for I/O
- Implements subroutine calls with proper stack management
- Efficient array indexing using shift operations
- Modular design with separate functions for each feature

## Code Structure
main:
    # Main program loop and menu handling

addStudent:
    # Handles adding new students with validation

displayStudents:
    # Displays all registered students

searchbyIndex:
    # Searches for students by index number

displayAvgMarks:
    # Calculates and displays average marks
