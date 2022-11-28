# Low-level-programming-languages.Assembler-MASM32

## **Program 1**

### **Program 1-1**
```
(3a-6b+300)/(b-2a)   
```   

## **Program 2**

### **Program 2-1**
```
Working with the stack.   

(2*a*a*b+a*b)   
```   
### **Program 2-2**
```
(7a-3b-2)/(b-5)   
```   
### **Program 2-3**
```
(a+b)/(a-b)   
```   

## **Program 3**

### **Program 3-1**
```
Working with the procedure.   
Example 1. Shows how to perform simple addition using registers and assembler instructions.   
Example 2. Comparing two numbers stored in memory and branch to different labels depending on how large the number is.
(PROC, SVAL, CMP, JE, JG, JL, JMP... )   
```   
### **Program 3-2**
```
Solve through the procedure.   

(a+b)/(a-b)   
```   
### **Program 3-3**
```
Enter 3 signed integers from the keyboard and output the maximum.   
   
Solve through the procedure.   
Do not use CMP.   
(.IF, .ELSE, .ENDIF)   
```   

## **Program 4**

### **Program 4-1**
```
Enter 3 signed integers of type "db".   
Using the comparison procedure, output the maximum.   
(MOVSX)   
```   
### **Program 4-2**
```
Enter 3 unsigned integers of type "db".   
Using the comparison procedure, output the maximum.   
(MOVZX)   
```   
### **Program 4-3**
```
Enter 3 signed and unsigned integers of type "db".   
Using the comparison procedure, output the maximum value.   
```   

## **Program 5**

### **Program 5-1**
```
Input and output an array of type dd.   
(DUP, $, EQU, LOOP, OFFSET, LENGTHOF, TYPE, SIZEOF, PTR)   
```   
### **Program 5-2**
```
Print the sum of the negative elements of the array.   
```   
### **Program 5-3**
```
Apply a logical shift (shl, shr, sal, sar, rol, ror) by 3 bits to the number:   
a db 127   
(SHL, SHR, SAL, SAR, ROL, ROR)   
```   
[Information about these commands is in folder 5](./5)   

## **Program 6**

### **Program 6-1**
```
Input and output of a matrix of type dd.   
Output the max element. Output the index of the max element.   
```   
### **Program 6-2**
```
Input and output of a matrix of type dd.   
Output the min element. Output the index of the min element.    
```   

## **Program 7**

### **Program 7-1**
```
3a^2*b-3ab

a real8 1.5   
b real8 10.0   
The answer should be 22.5

(Coprocessor, real numbers)
```   
### **Program 7-2**
```
(3a+2b^2)/(2a+b)

a real8 2.0   
b real8 3.0   
The answer should be 3.428

(Coprocessor, real numbers)
```   

## **exam**  
Task 1   
In Visual Studio, develop a console application with an assembler insert that implements any crypto algorithm with its decryption.   
(Crypto algorithm: Caesar Cipher)   

Task 2   
Set a string containing english letters, digits, separators (there must be digits, letters, separators in one line).   
Delete all the digits and output the resulting string to the console.   

Task 3
Working with a coprocessor, real numbers.   
Calculate the four value of the function in increments of 0.5. The choice of the initial value of x is arbitrary. The number of signs in the fractional part of the result should not exceed five signs.   
Implement the function: $y(x)=\frac{sin(x)+1.5x}{0.3}$   

Task 4   
Set a one-dimensional array of natural numbers. Delete all odd numbers and output the remaining array of even numbers to the console and a text file.
