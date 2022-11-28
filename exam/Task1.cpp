/*
In Visual Studio, develop a console application with an assembler insert that implements any crypto algorithm with its decryption.
(Crypto algorithm : Caesar Cipher)
*/

#include <iostream>

char* encrypt(char* msg)
{
	int len_msg = strlen(msg);
	__asm
	{
		mov ecx, len_msg
		mov esi, [msg]
		mov ebx, 0
		cycle:
		mov al, byte ptr[esi + ebx]

			; Test: is the element a letter
			cmp al, 65
			jl no_need_to_encrypt
			cmp al, 122
			jg no_need_to_encrypt
			cmp al, 90
			jle need_to_encrypt
			cmp al, 97
			jl no_need_to_encrypt

			need_to_encrypt :

		; If the letter is X, Y or Z, then it should be encoded as A, B or C respectively
			cmp al, 88
			jne next_check
			mov al, 65
			jmp no_need_to_encrypt
			next_check :
		cmp al, 89
			jne next_check1
			mov al, 66
			jmp no_need_to_encrypt
			next_check1 :
		cmp al, 90
			jne next_check2
			mov al, 67
			jmp no_need_to_encrypt
			next_check2 :

		; If the letter is x, y or z, then it should be encoded as a, b or c respectively
			cmp al, 120
			jne next_check3
			mov al, 97
			jmp no_need_to_encrypt
			next_check3 :
		cmp al, 121
			jne next_check4
			mov al, 98
			jmp no_need_to_encrypt
			next_check4 :
		cmp al, 122
			jne end_check
			mov al, 99
			jmp no_need_to_encrypt
			end_check :

		; If the letter does not fall within the range of the tail, then we simply encode it with an shift of 3 (this is the key we chose)
			add al, 3

			no_need_to_encrypt :
		mov byte ptr[esi + ebx], al
			inc ebx
			loop cycle
	}
	return msg;
}

char* decrypt(char* msg)
{
	int len_msg = strlen(msg);
	__asm
	{
		mov ecx, len_msg
		mov esi, [msg]
		mov ebx, 0
		cycle:
		mov al, byte ptr[esi + ebx]

			; Test: is the element a letter
			cmp al, 65
			jl no_need_to_decrypt
			cmp al, 122
			jg no_need_to_decrypt
			cmp al, 90
			jle need_to_decrypt
			cmp al, 97
			jl no_need_to_decrypt

			need_to_decrypt :

		; If the letter is A, B or C, then it should be decoded as X, Y or Z respectively
			cmp al, 65
			jne next_check
			mov al, 88
			jmp no_need_to_decrypt
			next_check :
		cmp al, 66
			jne next_check1
			mov al, 89
			jmp no_need_to_decrypt
			next_check1 :
		cmp al, 67
			jne next_check2
			mov al, 90
			jmp no_need_to_decrypt
			next_check2 :

		; If the letter is a, b or c, then it should be decoded as x, y or z respectively
			cmp al, 97
			jne next_check3
			mov al, 120
			jmp no_need_to_decrypt
			next_check3 :
		cmp al, 98
			jne next_check4
			mov al, 121
			jmp no_need_to_decrypt
			next_check4 :
		cmp al, 99
			jne end_check
			mov al, 122
			jmp no_need_to_decrypt
			end_check :

		; If the letter does not fall within the range of the head, then we simply decoded it with an shift of 3 (this is the key we chose)
			sub al, 3

			no_need_to_decrypt :
		mov byte ptr[esi + ebx], al
			inc ebx
			loop cycle
	}
	return msg;
}



int main()
{
	std::cout << "*****************************************************************************************\n";
	std::cout << "Crypto algorithm : Caesar Cipher:\n";
	std::cout << "\t-> Encoding and decoding is implemented through functions with assembler inserts;\n";
	std::cout << "\t-> The shift is 3;\n";
	std::cout << "\t-> Upper and lower case letters of the English alphabet are supported; \n";
	std::cout << "\t-> Symbols and numbers are not encoded.\n";
	std::cout << "*****************************************************************************************\n" << std::endl;

	int answer = 0;
	bool will_encrypt = true;
	std::cout << "Do you want to encrypt and decrypt something?(1/0)\n";
	std::cin >> answer;
	if (answer == 1)
	{
		will_encrypt = true;
	}
	else
	{
		will_encrypt = false;
	}

	while (will_encrypt)
	{
		std::cout << "\nEnter the text you want to encrypt and decryp (without spaces):\n";
		char messeg[256] = "\0";
		std::cin >> messeg;

		char* encrypt_messeg = encrypt(messeg);
		std::cout << "\tYour encrypted text:\n\t" << encrypt_messeg << std::endl;

		char* decrypt_messeg = decrypt(encrypt_messeg);
		std::cout << "\tYour decrypted text:\n\t" << decrypt_messeg << std::endl;

		std::cout << "\nDo you want to encrypt and decrypt something?(1/0)\n";
		std::cin >> answer;
		if (answer == 1)
		{
			will_encrypt = true;
		}
		else
		{
			will_encrypt = false;
		}
	}

	std::cout << "\nSee you later\n";
	system("pause");
	return 0;
}