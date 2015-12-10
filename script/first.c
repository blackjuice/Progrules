/*Programa que resolve um problema de emparelhamento maximo (com peso)
 para grafos quaisquer lidos de uma matriz */

/*Le um numero que diz o numero de vertices e uma matriz nxn com os pesos de cada aresta*/

#include <stdio.h>
#include <stdlib.h>
#include <glpk.h>

int main()
{
  int n, i, j, iter, num;
  int *ia, *ja;
  double *ar;
  double **M;
  double result;
  glp_prob *ip;
  scanf("%d", &n);

  M = malloc(n * sizeof(double *));
  for(i = 0; i < n; i++)
    M[i] = malloc(n * sizeof(double));
 
  ia = malloc((n * (n - 1) + 2) * sizeof(int)); //precisamos de 2 vezes o numero de arestas de atribuiçoes na matriz de restriçoes 
  ja = malloc((n * (n - 1) + 2) * sizeof(int)); // (cada aresta aparece na restricao do vertice de entrada e saida)
  ar = malloc((n * (n - 1) + 2) * sizeof(double)); // + 2 por segurança ja que o GLPK usa vetores a partir de 1

  for(i = 0; i < n; i++)
    for(j=0; j < n; j++)
      scanf("%lf", &M[i][j]);

  ip = glp_create_prob();
  glp_set_obj_dir(ip, GLP_MAX); //objetivo: maximizar
  glp_add_rows(ip, n); //cada linha representa um vertice
  for (i = 0; i < n; i++)
    glp_set_row_bnds(ip, i + 1, GLP_UP, 0.0, 1.0); //so pode ter uma aresta p vertice

  glp_add_cols(ip, n * (n - 1) / 2); //temos n² - n / 2 arestas
  for (i = 1; i < n; i++)
  {
    for (j = 0; j < i; j++)
    {
      num = ((i * (i - 1)) / 2) + j + 1; //numero que estamos
      glp_set_col_kind(ip, num, GLP_BV); //variavel binaria (0 ou 1)
      glp_set_obj_coef(ip, num, M[i][j]); //coef que recebemos
    }
  } 

  //coloca restricoes de uma ligacao
  num = 0;
  for (i = 1; i < n; i++)
  {
    for (j = 0; j < i; j++)
    {
      num++;
      iter = (i * (i - 1) / 2) + j + 1; //iter e o numero da aresta
      ia[num] = i + 1, ja[num] = iter, ar[num] = 1.0; //essa aresta afeta o vertice i 
      num++;
      ia[num] = j + 1, ja[num] = iter, ar[num] = 1.0; //essa aresta afeta o vertice j
    }
  }

  glp_load_matrix(ip, num, ia, ja, ar);
  glp_simplex(ip, NULL);

  result = glp_get_obj_val(ip); //funcao objetivo
  printf("Total = %lf\n", result);

  for (i = 1; i < n; i++) 
  {
    for (j = 0; j < i; j++)
    {
      iter = (i * (i - 1) / 2) + j + 1;
      num = glp_get_col_prim(ip, iter);
      if (num == 1)
	printf("Aresta %d-%d esta no emparelhamento\n", j, i);
    }
  }

  //Finaliza
  glp_delete_prob(ip);
  for (i = 0; i < n; i++)
    free(M[i]);
  free(M);
  free(ia);
  free(ja);
  free(ar);
  return 0;
}
