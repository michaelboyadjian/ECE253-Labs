#include<stdio.h>
#include<stdlib.h>

int bubbleSort(int *array, int size) {
int temp = 0;
int i = 0;
int j = 0;

  	if (array == NULL) {
     		return -1;
  	 }

   	for (i=0; i<size; i=i+1) {
      		for (j=0; j<size-1; j=j+1) {
         			if (array[j] > array[j+1]) {
           				temp = array[j];
            				array[j] = array[j+1];
            				array[j+1] = temp; 
         			}
     		}
   	}

  	 return 0;

}
