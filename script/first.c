/*Programa que resolve um problema de emparelhamento maximo (com peso)
 para grafos quaisquer lidos de uma matriz */

/*Le um numero que diz o numero de vertices e uma matriz nxn com os pesos de cada aresta*/

#include <stdio.h>
#include <stdlib.h>
#include <glpk.h> //GNU Linear Programming Kit

//Structs que vamos precisar
/*Blob guarda uma coleçao de vertices de tamanho size*/
typedef struct Blob{
  int size;
  int *cont;
} Blob;

/*Blobrray e um array dinamico de blobs*/
typedef struct Blobrray{
  int size;
  Blob **cont;
} Blobrray;

double getBlobAresta(Blob *a, Blob *b, double **original); //Calcula o peso da aresta entre duas blobs
//o peso da aresta e a media simples de todas as arestas saindo do blob a e entrando no blob b
double **produceMatrix(Blobrray *a, double **original); //Produz uma matriz-problema baseado num blobrray e na matriz-problema original
/*linha 0 corresponde ao Blob 0 do Blobrray etc*/

Blob *createBlob(int n); //Cria um blob de tamanho 1 com n como conteudo
Blobrray *createBlobrray(); //Inicializa um Blobrray com tamanho zero
void Blobpush(Blobrray *dad, Blob *child); //Adiciona um blob no array
Blob *mergeBlob(Blob *a, Blob *b); //devolve um blob resultado da soma de dois
Blob *copyBlob(Blob *a); //produz uma copia dessa blob

void freeBlob(Blob *a); //da free num Blob
void freeBlobrray(Blobrray *a); //da free num Blobrray e todos os Blobs

void dumpBlobrray(Blobrray *a); //descreve em texto o que um Blobrray contem

void solveEmparelhamento(int n, double **M, int *answer, int ALG);

int main()
{
  int n, i, j, merges, ALG;
  double **M, **subM;
  int *answer, *checked;
  Blob *temp;
  Blobrray *myarray, *newarray;
  FILE *saida;
  scanf("%d", &n);

  /*Aloca e le matriz-problema  original*/
  M = malloc(n * sizeof(double *));
  for(i = 0; i < n; i++)
    M[i] = malloc(n * sizeof(double));
 
  for(i = 0; i < n; i++)
    for(j=0; j < n; j++)
      scanf("%lf", &M[i][j]);

  /*Faz o primeiro Blobrray contendo Blobs de todos os numeros*/
  myarray = createBlobrray();
  for (i = 0; i < n; i++)
  {
    temp = createBlob(i);
    Blobpush(myarray, temp);
  }
  
  /*Loop principal*/
  ALG = 0; //começamos so com o resultado do relaxamento em proglin
  while (n > 3)
  {
    if (n < 50) //heuristica, vamos testar ate onde e possivel usar o custoso algoritmo de programacao inteira
      ALG = 1;
    /*Vetores auxiliares*/
    answer = malloc(n * sizeof(int));
    checked = malloc(n * sizeof(int));
    for (i = 0; i < n; i++)
      checked[i] = 0;

    /*Pede uma soluçao de emparelhamento*/
    subM = produceMatrix(myarray, M);
    solveEmparelhamento(n, subM, answer, ALG);
  
    /*Faz um novo Blobrray baseado na soluçao do emparelhamento*/
    newarray = createBlobrray();
    merges = 0;

    for (i = 0; i < n; i++)
    {
      if (checked[i] == 0)
      {
	if (answer[i] != -1)
	{
	  temp = mergeBlob(myarray->cont[i], myarray->cont[answer[i]]); 
	  Blobpush(newarray, temp);
	  checked[answer[i]] = 1;
	  checked[i] = 1;
	  merges++;
	  if (n - merges == 3)  //chegamos ao final, vamos impedir mais merges
	    for (j = 0; j < n; j++)
	      answer[i] = -1;
	}
	else
	{
	  temp = copyBlob(myarray->cont[i]);
	  Blobpush(newarray, temp);
	  checked[i] = 1;
	}
      }
    }
    /*Free nas coisas dessa iteraçao*/
    freeBlobrray(myarray);
    free(answer);
    free(checked);
    for (i = 0; i < n; i++)
      free(subM[i]);
    free(subM);
    
    /*prepara proxima iteraçao*/
    myarray = newarray;
    /*anti-loop infinito measure*/
    if (n == myarray->size) //nao teve merge nenhum
    {
      if (ALG == 0)
	ALG = 1;
      else
	break; //grafo estranho
    }
    n = myarray->size;
    dumpBlobrray(myarray);
  }
  //
  printf("FIM\n");
  printf("n de grupos %d\n", myarray->size);
  dumpBlobrray(myarray);
 
  //Escreve resultado num arquivo a ser lido pelo Ruby
  //Estrutura: alunos do grupo separados por virgula, grupos separados por newline
  saida = fopen("results.txt", "w+");
  for (i = 0; i < myarray->size; i++)
  {
    temp = myarray->cont[i];
    fprintf(saida, "%d", temp->cont[0]);
    for (j = 1; j < temp->size; j++)
      fprintf(saida, ",%d", temp->cont[j]);
    fprintf(saida, "\n");
  }
  fclose(saida);
  //Finaliza
  freeBlobrray(myarray);  
  for (i = 0; i < n; i++)
    free(M[i]);
  free(M);
  return 0;
}

/*n vertices, M matriz, answer e vetor onde fica a resposta*/
/*Se ALG entao vamos ate o fim em integer programming, se nao (tipicamente para n muito grande) nos contentamos com
a soluçao aproximada do relaxamento do problema para programacao linear*/
void solveEmparelhamento(int n, double **M, int *answer, int ALG)
{
  int i, j, iter, num;
  int *ia, *ja;
  double *ar, result;
  glp_prob *ip;

  ia = malloc((n * (n - 1) + 2) * sizeof(int)); //precisamos de 2 vezes o numero de arestas de atribuiçoes na matriz de restriçoes 
  ja = malloc((n * (n - 1) + 2) * sizeof(int)); // (cada aresta aparece na restricao do vertice de entrada e saida)
  ar = malloc((n * (n - 1) + 2) * sizeof(double)); // + 2 por segurança ja que o GLPK usa vetores a partir de 1
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
  if (ALG)
    glp_intopt(ip, NULL);

  for (i = 0; i < n; i++)
    answer[i] = -1;

  for (i = 1; i < n; i++) 
  {
    for (j = 0; j < i; j++)
    {
      iter = (i * (i - 1) / 2) + j + 1;
      if (ALG)
	num = glp_mip_col_val(ip, iter);
      else
	num = glp_get_col_prim(ip, iter);

      if (num == 1)
      {
	answer[i] = j;
	answer[j] = i;
      }

    }
  }
  if (ALG)
    result = glp_mip_obj_val(ip);
  else
    result = glp_get_obj_val(ip);
  printf("OBJECTIVE VALUE: %lf\n", result);
  //Finaliza
  glp_delete_prob(ip);
  free(ia);
  free(ja);
  free(ar);
}

double getBlobAresta(Blob *a, Blob *b, double **original)
{
  int i, j;
  double ans = 0.0;
  for (i = 0; i < a->size; i++)
    for (j = 0; j < b->size; j++)
      ans += original[a->cont[i]][b->cont[j]]; //original tem propriedade a[i][j] == a[j][i]
  return ans / (a->size) * (b->size);
}

double **produceMatrix(Blobrray *a, double **original)
{
  int i, j, size;
  double **ans;
  double temp;
  size = a->size;

  //Aloca a matriz
  ans = malloc(size * sizeof(double *));
  for (i = 0; i < size; i++)
    ans[i] = malloc(size * sizeof(double));
  
  //Preenche matriz
  for (i = 0; i < size; i++)
    ans[i][i] = 0.0;
  
  for (i = 0; i < size; i++)
    for (j = i + 1; j < size; j++)
      ans[i][j] = ans[j][i] = getBlobAresta(a->cont[i], a->cont[j], original);
  return ans;
}

Blob *createBlob(int n)
{
  Blob *result;
  result = malloc(sizeof(Blob));
  result->size = 1;
  result->cont = malloc(1 * sizeof(int));
  result->cont[0] = n;
  return result;
}

Blobrray *createBlobrray()
{
  Blobrray *result;
  result = malloc(sizeof(Blobrray));
  result->size = 0;
  result->cont = NULL;
}

void Blobpush(Blobrray *dad, Blob *child)
{
  Blob **substitute;
  int i;
  if (dad->size == 0)
  {
    dad->cont = malloc(1 * sizeof(Blob *));
    dad->cont[0] = child;
    dad->size++;
  }
  else
  {
    substitute = malloc((dad->size + 1) * sizeof(Blob *));
    for (i = 0; i < dad->size; i++)
      substitute[i] = dad->cont[i];
    substitute[dad->size] = child;
    free(dad->cont);
    dad->cont = substitute;
    dad->size++;
  } 
}

Blob *mergeBlob(Blob *a, Blob *b)
{
  Blob *c;
  int i, j;
  c = malloc(sizeof(Blob));
  c->size = a->size + b->size;
  c->cont = malloc(c->size * sizeof(int));
  for (i = 0; i < a->size; i++)
    c->cont[i] = a->cont[i];
  for (j = 0; j < b->size; j++)
    c->cont[i + j] = b->cont[j];
  return c;
}

Blob *copyBlob(Blob *a)
{
  int i;
  Blob *result;
  result = malloc(sizeof(Blob));
  result->size = a->size;
  result->cont = malloc(result->size * sizeof(int));
  for (i = 0; i < result->size; i++)
    result->cont[i] = a->cont[i];
  return result;
}

void freeBlob(Blob *a)
{
  free(a->cont);
  free(a);
}

void freeBlobrray(Blobrray *a)
{
  int i;
  for (i = 0; i < a->size; i++)
    freeBlob(a->cont[i]);
  free(a->cont);
  free(a);
}

void dumpBlobrray(Blobrray *a)
{
  int i, j;
  Blob *temp;
  printf("Informando sobre Blobrray de tamanho %d\nBlobs:\n", a->size);
  for (i = 0; i < a->size; i++)
  {
    temp = a->cont[i];
    printf("%d: Blob de tamanho %d contendo", i, temp->size);
    printf(" %d", temp->cont[0]);
    for (j = 1; j < temp->size; j++)
      printf(", %d", temp->cont[j]);
    printf("\n");
  }
}
