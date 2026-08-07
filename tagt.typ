#import "modules/notes.typ": *

#show: thm-rules

#let pm = $plus.minus$
#let v1 = $bb(1)$

#show: noteworthy.with(
  paper-size: "a4",
  language: "EN",
  title: "Topics in Applied Graph Theory",
  author: "Arjun Maneesh Agarwal",
  prof : "Priyavrat Deshepande",
  course-desc: [
    Evaluation: Assignments + Projects
  ],
  contact-details: "thearjunagarwal.github.io",
  toc-title: "Table of Contents"
)

= Introduction
#definition(title: "Graph")[
  A graph $G = (V,E)$ is a specified by two finite sets $V$ and $E$ where $V$ is the set of vertices and $E$ is the set of edges (a subset of 2 subsets of $V$).
]

#definition(title: "Directed Graph")[
  A directed graph $G = (V,E)$ is a specified by two finite sets $V$ and $E$ where $V$ is the set of vertices and $E$ is the set of edges (a subset of $V times V$ barring $(x,x)$ or loops).
]

#note[
  The graph is simple and undirected (notice 2 subsets) while a directed graph is, well, directed (notice the cartesian product).
]

#definition(title: "Multigraph")[
  A multigraph $G$ has $E$ be a multiset.
]

#definition(title: "Weighted")[
  We say a graph is (edge) weighted, if we have a function $w : E -> RR$
]

For notational convenience, we take $V = [n]$.

#definition(title: "Adjacency Matrix")[
Adjacency matrix of graph $G$, called $A_G$ is a $n times n$ matrix where $a_(i,j) = 1 <==> (i,j) in E$ and $0$ otherwise.

In weighted graph, $a_(i,j) = w((i,j))$
]

#definition(title: "Degree")[
The degree of vertex $i$ is number of edges containing said vertex, that is $d_G (i) = deg(i) = sum_(j = 1)^n a_(n, j)$.
]

#definition(title: "Degree Matrix")[
  The degree matrix of $D$ is a diagonal matrix $D(i,i) = d(i)$.
]

#definition(title : "Laplacian")[
  The Laplacian of graph $G$ is $cal(L) = D - A$
]

#definition(title : "Graph Energy")[
  For $x in RR^n$, $x^T cal(L) x$ is called graph energy.
]

#example[
  Given a 2 path, $A = mat(0,1;1,0), D = mat(1,0;0,1) => cal(L) = mat(1, -1; -1, 1) => x^T cal(L) x = (x_1 - x_2)^2 >= 0$.

  Similarly, for a 3 path, $x^T cal(L) x = (x_1 - x_2)^2 + (x_2 - x_3)^2$
]

#thm[
  For a weighted graph,
  $
  x^T cal(L) x = sum_((i,j) in E) w_(i,j) (x_i - x_j)^2
  $
]

#proof[
  $
  x^T cal(L) x &= x^T (D - W) x\
  &= x^T D x - x^T W x\
  &= sum d_i x_i^2 - (sum w_(i,j) x_i x_j)\
  &= sum d_i x_i^2 - 2 sum_((i,j) in E) w_(i,j) x_i x_j\
  &= sum_((i,j) in E) (w_(i,j) x_i^2 - 2 w_i x_i x_j + w_(i,j) x_j^2)\
  &= sum_((i,j) in E) w_(i,j) (x_i - x_j)^2
  $
]

#cor[
  $cal(L)$ is Symmetric and Positive Semi-Definite.
]

This implies that $cal(L)$ has non-negative real Eigenvalues.

#definition(title: "Spectrum of Laplacian")[
 We define $sigma(cal(L)) := {0 <= lambda_1 <= lambda_2 <= dots <= lambda_n}$ as the spectrum of $cal(L)$
]

Let $v1 = (1,1,dots,1)^T$. Notice, $
cal(L) v1 &= (D-W) vec(1,dots.v, 1) \
&= D vec(1, dots.v, 1) - W vec(1, dots.v, 1)\
&= vec(d_1, dots, d_n) - vec(sum w_(1,j), dots, sum w_(n,j))\
&= 0
$
which implies $lambda_1 (cal(L)) = 0$ with eigenvector $v1$.

#thm[
  $lambda_2 > 0 <==> G$ is connected
]
#proof[
  ($==>$) Assume $G =G_1 union.sq G_2$ which implies $cal(L)_G = mat(cal(L)_(G_1), 0; 0, cal(L)_(G_2))$.

  This implies we have atleast 2 independent vectors: $vec(v1_(G_1), 0)$ and $vec(0, v1_(G_2))$ which have eigenvalue $0$ which makes $lambda_2 = 0$.

  ($<==$) Suppose $G$ is connected. Let $y in ker(cal(L)_G)$.
  $
  ==> y^T cal(L) y &= sum_((i,j) in E) (x_i - x_j)^2\
  &= 0
  $
  This implies that $x_i = x_j <==> (i,j) in E$. Thus, if vertex $i$ and $j$ are connected, then by a series of equalities, we'll end up with $y = v1$.

  Thus, $lambda_2 > 0$.
]