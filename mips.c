#include "mips.h"


FILE* openFile(char * path){


		FILE* res = fopen(path, "a" );

		if(res == NULL){

				printf("Mips File Error :(\n");

				exit(1);


		}

		return res;

}


void quadGenreate(struct quad* q, int debut){

	FILE* res = openFile("mips.s");
	struct quad* scan = q;

	if(debut ==0){

	while( scan != NULL){

			fprintf(res,"\n li $a0, %d\n",scan->arg1->value);
					
			fprintf(res," li $a1, %d\n",scan->arg2->value);
			switch (scan->op){
					case '+':
							fprintf(res,"add $a0, $a0, $a1\n");
					break;

					case '-':
							fprintf(res,"sub $a0, $a0 , $a1\n");
					break;

					case '*': fprintf(res, "mul $a0, $a0, $a1\n");
					break;

				
					

			}

			fprintf(res,"\nli $v0 1\n ");
			fprintf(res,"syscall\n");
			fprintf(res,"\nla $a0 , newline\n");
			fprintf(res,"li $v0 , 4\n");
			fprintf(res,"syscall\n");

			
			scan=scan->next;

	}

	}

	else{

		fprintf(res,"\nli $v0, 10\nsyscall\n");
	}

}

void closeFile(FILE* f){




	fclose(f);


}

