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
  The Laplacian of graph $G$ is $L = D - A$
]

#definition(title : "Graph Energy")[
  For $x in RR^n$, $x^T L x$ is called graph energy.
]

#example[
  Given a 2 path, $A = mat(0,1;1,0), D = mat(1,0;0,1) => L = mat(1, -1; -1, 1) => x^T L x = (x_1 - x_2)^2 >= 0$.

  Similarly, for a 3 path, $x^T L x = (x_1 - x_2)^2 + (x_2 - x_3)^2$
]

#thm[
  For a weighted graph,
  $
  x^T L x = sum_((i,j) in E) w_(i,j) (x_i - x_j)^2
  $
]

#proof[
  $
  x^T L x &= x^T (D - W) x\
  &= x^T D x - x^T W x\
  &= sum d_i x_i^2 - (sum w_(i,j) x_i x_j)\
  &= sum d_i x_i^2 - 2 sum_((i,j) in E) w_(i,j) x_i x_j\
  &= sum_((i,j) in E) (w_(i,j) x_i^2 - 2 w_i x_i x_j + w_(i,j) x_j^2)\
  &= sum_((i,j) in E) w_(i,j) (x_i - x_j)^2
  $
]

#cor[
  $L$ is Symmetric and Positive Semi-Definite.
]

This implies that $L$ has non-negative real Eigenvalues.

#definition(title: "Spectrum of Laplacian")[
 We define $sigma(L) := {0 <= lambda_1 <= lambda_2 <= dots <= lambda_n}$ as the spectrum of $L$
]

Let $v1 = (1,1,dots,1)^T$. Notice, $
L v1 &= (D-W) vec(1,dots.v, 1) \
&= D vec(1, dots.v, 1) - W vec(1, dots.v, 1)\
&= vec(d_1, dots, d_n) - vec(sum w_(1,j), dots, sum w_(n,j))\
&= 0
$
which implies $lambda_1 (L) = 0$ with eigenvector $v1$.

#thm[
  $lambda_2 > 0 <==> G$ is connected
]
#proof[
  ($==>$) Assume $G =G_1 union.sq G_2$ which implies $L_G = mat(L_(G_1), 0; 0, L_(G_2))$.

  This implies we have atleast 2 independent vectors: $vec(v1_(G_1), 0)$ and $vec(0, v1_(G_2))$ which have eigenvalue $0$ which makes $lambda_2 = 0$.

  ($<==$) Suppose $G$ is connected. Let $y in ker(L_G)$.
  $
  ==> y^T L y &= sum_((i,j) in E) (x_i - x_j)^2\
  &= 0
  $
  This implies that $x_i = x_j <==> (i,j) in E$. Thus, if vertex $i$ and $j$ are connected, then by a series of equalities, we'll end up with $y = v1$.

  Thus, $lambda_2 > 0$.
]

#cor[
  The number of connected components of $G$ is equal to the multiplicity of $0$ as an eigenvalue of $L$.
]

We could define the multiplicity of $0$ as $k$ in $chi_(L) (t) = t^k q(t)$ where $t divides.not q$.

 #example(title: "Eigenvalues of complete graph")[
  $G = K_n$ (the complete graph)

  What are the eigenvalue?
 ]
 #soln(title: "Solution(Mine)")[
  $
  L x = lambda x\
  => (n-1) x_i - sum_(j != i) x_j = lambda x_i\
  => n x_i - sum_(j) x_j = lambda x_i\
  => "either" x_1 = x_2 = dots = x_n "or" lambda = n
  $

  As it is connected, the second eigenvalue can't be $0$. Thus, all other eigenvalues are $n$.
 ]

 #soln(title: "Prof. Priyavrat's Solution")[
  As we have $n$ eigenvectors, then they form a eigenbasis.

  Thus, for eigenvector $y$, $chevron.l y, v1 chevron.r = sum_(j) y_j = 0$.

  $
  => (L y)_i = n y_i - sum_(j) y_j\
  = n y_i\
  => L y = n y
  $

  Thus, $n$ is an eigenvalue with multiplicity $n-1$.
 ]

 #example(title: "Eigenvalues of Star Graph")[
  Given $G = S_n$ (the star graph), What are the eigenvalue?
 ]

#soln[
  #todo[]
]

= Laplacian Eigenmaps
While we have 'barely scratched the surface' of spectral graph theory, we already have an application.

In python's Scikit Learn's manifold learning we have a class *spectral embedding*. This is done by Belkins-Niyogi process (found in 2000).

#prob[
  Given data (a finite set of vectors) $ subset.eq RR^"high"$. find $Phi : RR^"high" -> RR^"low"$ preserving some property.
]

For example PCA preserves variance while LLE preserves neighborhoods.

The high-level flowchart is:

Data $->$ Data Graph (weighted to allow discrimination) $->$ Some eigenvalues of $L$ (equal to $"low"$) $->$ extract coordinates from these eigenvectors.

Note, this doesn't preserve the original coordinates as we move from data to an abstract graph.

#todo[Example]

How do we find such coordinates?

$"high" w_(i,j) => "low" |x_i - x_j|equiv "low" (x_i - x_j)^2$\
$"low" w_(i,j) => "high" |x_i - x_j|equiv "high" (x_i - x_j)^2$

This intuition can be formalized/translated to given optimization problem:

$
min_(x in RR^n) sum_(i, j) w_(i,j) (x_i - x_j)^2
$

which is nothing but $x^T L x$. To prevent $x_i = 0$ type solutions and simply scaled solutions, we can but $||x|| = 1$.

Also, to prevent $v1$ (appropriately) scaled from returning as solution, we can just add $x in v1^T$. 

= Lecture 3?!

= Lecture 4

Given a graph $G$ with Laplacian $L$, we want to minimize $
sum_(i, j) w_(i j) (y_i - y_j)^2 = 2 y^T L y
$

subject to $y^T D v1 = 0$ where $D$ is the diagonal matrix of degrees (keeping weights in mind) and $y^T D y = 1$.

One can solve this using Lagrange Multipliers:
$
cal(L)(y , lambda, mu) = y^T L y - lambda (y^T D y - 1) - mu (y^T D v1)\

=> (partial cal(L))/(partial y) = 2 L y - 2 lambda  D y - mu D v1 = 0\

=> L y - lambda D y - mu/2 D v1 = 0\

therefore L y = lambda D y + mu/2 D v1 quad quad (*)
$

Recall $v1^T L = 0$. Thus,

$
v1^T (L y - lambda D y - mu/2 D v1) = 0\
=> - lambda v1^T D y - mu/2 v1^T D v1 = 0\
=> mu/2 v1^T D v1 = 0 quad quad ("using our constraint!")\
=> (mu/2) (sum d_i) = 0\
=> mu = 0 quad quad ("as degrees are all positive")
$

going back to $(*)$
$
=> L y = lambda D y
$

This gives a 1-D embedding of $G$: $i |-> y_i$ which sort of preserves neighborliness.

We call the first non-zero eigenvalue (the second one in connected graphs) is called the Fiedler vector and the value it assigns are called the Fiedler values.

This is called a smooth graph signal by applied math people.

However, why would we embed our graph in 1D? That seems naive and somewhat useless for large datasets.

Now let's embed in $RR^m, m >= 2$.

Let $y_1 = vec(y_1 (1), y_2(2), dots.v, y_1(n)), y_2 , dots y_m$.

We say a node $i$ is mapped to $(y_1 (i), y_2 (i), dots, y_m (i)) = y^((i))$ which will be the rows of $Y = [y_1 | y_2 | dots | y_m]$.

We would like to minimize
$
sum_(i, j in E) w_(i, j) ||y^((i)) - y^((j))||^2 
$

which is equal to
$
underbrace(tr(Y^T L Y), m times m "matrix")
$

subject to $Y^T D Y = I_m$ and $Y^T D v1 = 0$.

We can solve using the same methods as above (albeit with more book keeping).

#underline[The solution to the above problem is]
$
L Y = D Y Lambda, quad quad  Lambda = "diag"(lambda_2, lambda_3, dots, lambda_m)
$ 

where $lambda_2 <= lambda_3 <= dots <= lambda_m$.

== Manifold Learning
Spectral Embedding is an example on manifold learning. Some other examples are:
#todo[]

#definition(title: "The Manifold Hypothesis")[
  The manifold hypothesis posits that many high-dimensional data sets that occur in the real world actually lie along low-dimensional latent manifolds inside that high-dimensional space.

  or as Prof. Priyavrat says: "Data is high-dimensional but the number of "interesting"  intrinsic features is pretty less"
]

#remark[
  A lot of versions of the above are sloppier and say stupid things like: "all high-dimensional data can be embedded in a low-dimensional manifold"

  This is false, sloppy and stupid.
]

#definition(title: "Manifold")[
  A manifold $M$ is a subset of $RR^n$ which is locally flat.

  Given any $p in M$, there exists an open ball $U$ containing $p$ and a map $phi : U -> RR^d$ such that $phi(p) = 0$ and $phi(U)$ is open ball containing $0$ in $RR^d$.

  $phi : U -> phi(U)$ is a homeomorphism.

  The pair $(U, phi)$ is called a chart around $p$.

  Furthermore, if $(U, phi)$ and $(V, psi)$ are 2 charts around $p$ then $phi compose psi^(-1)$ and $psi compose phi^(-1)$ are smooth maps from subsets of $RR^d$ to open subsets of $RR^d$.
]

#idea[
  The idea is the manifolds are locally Euclidean. Euclidean is really nice as we have a calculus over it.

  What does locally Euclidean mean? That we can sort of treat every point as an origin and induce a coordinate system around it. Like sort of Earth is round, but locally, it is flat and every point feels like the centre.

  But there could be more than one coordinate system. Thus, we want some way to translate between these coordinate systems.
]

#todo[Prof. Priyavrat's diagram]

Let's look at a manifold without a global coordinate system.

#example(title: [The Unit Circle in $RR^2$])[
  #figure(image("tagt-images/unit_circle.png"))
]

#definition(title: "Riemannian Manifold")[
  A manifold with a Riemannian metric (a way to measure length) is called a Riemannian Manifold.

  Basically, Riemannian metric assigns to each point a definition of inner product (which is a symmetric bilinear form). This makes Riemannian metric a tensor.
]

Basically, given data, we want to find the best fitting Riemannian Manifold to embed said data in.

$
cal(C)^(oo) (M)= {f : M -> RR, f "is smooth"} ~ F(G, RR)
$

where the former is $cal(C)^(oo)(M)$ is an infinite dimensional vector space while $F(G, RR)$'s vector space is $RR^n$.

Also,

$
gradient f|_p = ((partial f)/(partial x_1) |_p, (partial f)/(partial x_2) |_p, dots, (partial f)/(partial x_n) |_p)
$

the divergence $gradient f$ measures local spread of a $v f$

The Laplace-Beltrami operator $Delta_g : cal(C)^(oo) (M) ->^"lin" cal(C)^(oo)(M)$ with
$
Delta_g (f) := "div"(gradient f)
$

measures the difference between between $f(p)$ and avg $f$ value. 

Notice, $Delta_g (f) > 0 equiv f(p) < "avg value"$

Sort of corresponds to the Laplacian in the discrete case.

We can also use Laplace-Beltrami to get a Hammel Basis for the infinite dimensional vector space
$
Delta_g psi = lambda_i psi => i in NN, {psi_1, psi_2, dots, psi_n }
$

This implies $M arrow.r.hook cal(C)^(oo)(M)$ with $p |-> {psi_1, psi_2, dots, psi_n}$.

Belkin-Niyogi proved that (under some constraints) as vertices go to infinity, the laplacian converges to Laplace-Beltrami operator on some manifold.

= Graph Partitioning
#definition(title: "Graph Partitioning")[
  Given a graph $G$, we define the graph partitioning to be the solution:
  $
  S = arg min_(S subset.eq V_G) "cut"(S, S^c)
  $

  where $"cut"(U, V) = sum_(u in U, v in V) a_(u, v)$.
]

#definition(title: "Some other cuts")[
  $
  "RatioCut"(S, S^c) = (4/n) "cut"(S, S^c)
  $
  $
  "NormalizedCut"(S, S^c) ="cut"(S, S^c) (1/("vol"(S)) + 1/("vol"(S^c)))
  $
  where $"vol"(G) = sum_(v in G) "deg"(v)$
]

Notice, all of these have Laplacian forms. For Graph Partitioning, we can represent the objective as $x^T L x$ where $x_i = 1$ if $i in S$ and $0$ otherwise or as $1/4 s^T L s$ where $s_i = 1$ if $i in S$ and $-1$ otherwise.

Sadly, these are all NP Hard to solve. So instead, we'll deal with the spectral relaxation.

For Ratio Cut, we can see the spectral relaxation is:
$
min_(f in RR^n) f^T L f "subject to" sum f_i = 0, quad ||f|| = sqrt(n)
$

The solution, as we have seen before, is the Fiedler Vector as our equation is the Rayleigh.

For Normalized Cut, we can see the spectral relaxation is:
$
min_(f in RR^n) f^T L f "subject to" sum D f_i = 0, quad f^T D f = "vol"(G)
$

Solving it amounts to $L f = lambda D f => "eigenvector of" L_("sym") = D^(-1/2) L D^(-1/2)$ with $v |-> sqrt(D) v$.

#proof[
  $
  L_("sym") w = lambda w\
  D^(-1/2) L D^(-1/2) w = lambda w\
  D^(-1/2) L D^(-1/2) sqrt(D) v = lambda sqrt(D) v\
  D^(-1/2) L v = lambda sqrt(D) v\
  L v = lambda D v\
  $
]

Fiedler in 1973 proved
#thm[
  Let $G$ be a connected graph wit laplacian $L$ and $v_2 = (v_(2,1), dots, v_(2, n))$ the eigenvector corresponds to the smallest $n >=$ eigenvalue.

  Set $S = {i in [n] | v_(2,i) >= 0}$. Then the induced subgraphs $G[S]$ and $G[S^c]$ are connected.
]

Although, in practice we like our components balanced. Hence, trying to order the components and splitting them somewhere (usually median). (Could probabilistic rounding work?! *TO CHECK LATER!*)

Priyavrat's Conjucture:
#conj[
  Order the Fiedler vector. Cut it anywhere. Both components are connected.
]

We will now try to prove Fiedler's theorem.

#proof[
  $
  L v = lambda v quad (lambda != 0 amp "is smallest")\
  (L v)_i &= ((D-A) v)_i = d_i v_i - sum_(i j in E) v_j\
  &= sum_(j in N(i)) v_i - v_j\
  &= lambda v_i quad ("Eigenvector")
  $
  This implies
  $
  => sum_(j in N(i)) v_i - v_j = lambda v_i\
  => (d_i - lambda) v_i = sum_(j in N(i)) v_j\
  => v_i = 1/(d_i - lambda) sum_(j in N(i)) v_j
  $
]

What if we want to partition into multiple parts? We now define:
$
"RatioCut"(S_1, S_2, dots, S_k) = 1/2 sum ("cut"(S_i, S_i^c))/(|s_i|)
$

$
"NormalizedCut"(S_1, S_2, dots, S_k) = 1/2 sum ("cut"(S_i, S_i^c))/("Vol"(s_i))
$

We define the characteristic vector as:
$
H_(i j) = cases(
  1/(sqrt(|S_j|)) ("or" (sqrt(d_i))/(sqrt("vol"(S_j)))) & s_i in S_j,
  0 & s_i not in S_j
)
$

We can relax these as well. For Ratio Cut,
$
arg min_(H) "Tr"(H^T L H) "s.t." H^T H = I_k
$
and for Normalized Cut,
$
arg min_(F) "Tr"(F^T L_"Sym" F) "s.t." F^T F = I_k
$
where $F = sqrt(D) H$

Let $U_(k m)$ be the matrix whose rows re the 1st $k$-eigenvectors of $L$.

We use $k$-means to solve these further. All this goes via "Chigger-Inequalities" or "Spectal Wrapping" (google later!).

#psudo(title: [The Spectral Clustering (for $k>=3$)])[
  + def Cluster(data, k)
   + Find the Laplacian of the data graph 
   + Find $U_(k, n)$ (the first $k$ eigenvector of the Laplacian)
   + Apply $k$-means to columns of $U_(k, n)$
   + return the above
]

In some algorithms, we don't need to chose a $k$ and choose $k$ by the spectral gap. We define $Delta_k := lambda_(k+1) - lambda_k$ and choose $hat(k) = arg max_(k) Delta_k$.