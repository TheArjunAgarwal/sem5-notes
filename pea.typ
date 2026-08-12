#import "modules/notes.typ": *

#show: thm-rules

#let pm = $plus.minus$

#show: noteworthy.with(
  paper-size: "a4",
  language: "EN",
  title: "Parametrized and Exact Algorithms",
  author: "Arjun Maneesh Agarwal",
  prof : "G. Philip",
  course-desc: [
    The main book will be Parametrized Algorithms by Cygan et. al (chapters 1 to 7, 13 and 15). Other than that < copy from moodle >. 
  ],
  contact-details: "thearjunagarwal.github.io",
  toc-title: "Table of Contents"
)

= Philip's Wisdom
 "Why do you want to solve an algorithms problem, probably to make more money. Or kill more people. Or maybe save more people."

= Brief Intro and Motivation
Parametrized Algorithms starts where the first algorithms course ends: NP Completeness.

Most algorithms we saw in the algorithms course have complexity $O(n^c)$ for some constant $c$. This raises the question if that is true of all problems, sadly, this is where NP Hardness and Completeness comes in. While we don't know if we can solve them polytime, these NP Complete problems span thousands of fields and experts in their field have tried finding fast algorithms. As these problems are complete, all reduce to each other which implies that if one of them succeed, all of them succeed. Unfortunately, they have all failed, which is the sort of silence that speaks quite loudly.

So how do we cope with this? One is Approx Algorithms. The other idea is Random Algorithms. Another is heuristics and meta-heuristics (taken from physics and biology and what not).

In theory, NP Completeness implies all the problems are equally hard modulo some polynomial time translations. However, some problems were easier to solve in practice.

#example[
  Type Inference for Hindley-Milner type system is unconditionally not solvable in polynomial time (in the size $n$ of the input programme) as it hard for the class EXP (that is problems that can be solved in $O(2^"poly")$ time) (from Maivson, POPL 1990) and $"P" subset.neq "EXP"$ (Time Hierarchy theorem)

  However, we don't think about the size of programme while writing code. And the compiler happily (or sadly) infers the type quite quickly.
]

#thm[
  Type inference for Hindley-Milner Type ststem can be solved in $O(2^k n)$ time where
    - $n$ is the size of input programme,
    - $k$ is the nesting depth of types in the programmes
  (Lichtenstein and Porveli, POPL 1985)
]

The idea is to pick something that tends to something that is usually small in practice and limit the exponential blow up to that parameter.

So our roadmap is: pick a parameter $k$ that could be natural or something more convoluted, try to find an algorithm of time complexity $O(f(k) n^c)$. If we succeed the problem is Fixed Parameter Tractable aka FPT.

#definition(title:"Vertex Cover")[
  Vertex cover of a graph $G$ is a subset $S subset.eq V(G)$ such that $G backslash S$ has no edges.
]
#definition(title:"Vertex Cover (Standard Parametrization)")[
  Input: Graph $G$, $k in NN$

  Parameter: $k$

  Question: Does $G$ have a vertex cover of size $<= k$?
]
#remark[
  This can be thought of as choosing a subset as guard posts such that all the roads are guarded.

  Also, please make sure to not confuse this with *Dominating Set* (which is choosing vertices to put 1 edge radius umbrellas to cover everyone).
]

While vertex cover is NP Complete, we can see a simple algorithm that runs in $cal(O)^*(2^k)$ time (we can also do it in $cal(O)^*(1.4656^k)$ time as we'll later see and in $cal(O)^*(1.2529^k)$ as we shall not see).

The idea is that given an edge, one of the two vertices neighboring it have to be in the vertex cover. This is a local property and can be abused to get the algorithm.

#psudo(title: [Vertex Cover In $O(2^k n)$ time])[
  + func existVertexCover($G, k$):
    + pick edge $u v in V(G)$
    + return existVertexCover( $G backslash {u}, k - 1$) OR existVertexCover( $G backslash {v}, k - 1$)
]

= Definitions
#definition(title : "Classical Language")[
Let $Sigma$ be a finite alphabet, for example $Sigma = {0,1}$ or $Sigma = "ASCII"$. A classical language over $Sigma$ is $L subset.eq Sigma^*$, for example $L = {"All valid Haskell programmes"}$.]
#definition(title:"Parametrized Language")[
A parametrized language over $Sigma$ is $L subset.eq Sigma^* times NN$, for example $L = {(x,k) | x "is a valid Haskell programme", k "is the nesting depth of the type declarations in" x}$.

For a fixed $k$, $L_k = {(x,k) | (x,k) in L}$ is the $k$-th slice of $L$
]

#definition(title : "Slice-wise Polynomial Time (XP)")[
  A parametrized language $L$ is slice-wise polynomial time solvable (XP) if there exists an algorithm $cal(A)$ and a computable function $f$ such that:
  - For all $x, k$, $cal(A)$ runs in $<= |x|^f(k)$ time on input $(x,k)$
  - $(x,k) in L <==> cal(A)((x,k)) = #text[*YES*]$
]

#definition(title : "Fixed Parameter Tractable (FPT)")[
  A parametrized language $L$ is fixed parameter tractable (FPT) if there exists an algorithm $cal(A)$ and a computable function $f$ such that:
  - For all $x,k$, $cal(A)$ runs in $<= f(k) |x|^c$ time on input $(x,k)$ where $c$ is a constant independent of $|x|$ and $k$.
  - $(x,k) in L <==> cal(A)((n,k)) = #text[*YES*]$.
]
For notational convenience, $f(k) |x|^c$ is abbreviated $cal(O)^* (f(k))$.

One motivation could be this table:
#table(
  columns: 4,
  [$(n^(k+1))/(2^k n)$], [$n = 50$], [$n = 100$], [$n = 150$],
  [$k=2$],[$625$],[$2500$],[$5625$],
  [$k=3$],[$15625$],[$125000$],[$421875$],
  [$k=10$],[$10^12$],[$8 times 10^13$],[$3.7 times 10^16$],
  [$k=20$],[$1.8 times 10^26$],[$5 times 10^30$],[$2.1 times 10^35$]
)

= Exact Exponential Algorithms
An example could be Hamiltonian Path.
#definition(title: "Hamiltonian Path")[
  Input: Given a graph $G$ and vertex $v in V$

  Question: Does there exist a path $P$ starting at $v$ which covers all vertices of $G$ without repeating vertices or edges.
]

This problem is NP Hard, however using a DP on sets, we can do this in $cal(O)^* (2^n)$ instead of the brute force $cal(O)^*(n!)$.

Another example is Chromatic Number
#definition(title : "Chromatic Number")[
  Input: Given a graph $G$ and $k in NN$

  Question: Can we properly color the graph $G$ using $k$ colors
]

While there is a $O^*(2^k)$ algorithm, we can see an interesting and simple $O^*(3^k)$ algorithm.

Consider all the subset of vertices and store all the independent sets (that means can be 1 colored). Now consider subsets of vertices and store all the ones that can be partitioned into independent sets (which will take $3^n$ time as we are basically 3 partitioning the vertices into $S = X union.sq Y$ and $V backslash S$) giving us the 2-colorable subsets. Repeat with $3$ coloring and so on. This will give an $underbrace(cal(O)^*(2^n)+cal(O)^*(3^n)+cal(O)^*(3^n)+dots+cal(O)^*(3^n), k "terms") = cal(O)^*(3^n)$.

= Kernalization
#todo[
  Introduction with sorting and cycle detection idea
]

#example(title:"European Rail Network Problem")[
  Given an input of $1,40,000$ trains, $25,000$ stations and $16,00,000$ single train stops (valid trains and station pairs).

  Our question is if there is any subset $T$ of trains, they wanted to find a smallest set $S$ of stations such that each train $T$ stops at atleast one of the stations in $S$.

  This is roughly equivalent to the red-blue dominating set which is NP Hard. However, Karsten Werhe gave a set of reduction rules (similar to the cycle detection) that would split this into small cases which he could solve by hand.
  #todo[
    Section 4.6 of Fundamentals of Parametrized Complexity by Downey and Fellow
  ]
]

This is a weird place as if we had a polynomial algorithm that could reduce the size of an NP problem by even 1 bit, we could just use the same algorithm to keep reducing it to 1 single bit (which would be the answer).

So what do we do?

#todo[Parametrization of Kernel]

For vertex cover, we can use the following reduction rules:
- If there is a vertex $v$ of degree zero in $G$, then delete $v$ from $G$ to get $G'$. Output: $(G', k)$
- If there is a vertex $v$ if degree $>= k+1$ in $G$, then delete $v$ from $G$ to get $G'$. Output: $(G', k-1)$

Let $(hat(G), hat(k))$ be an instnce to which none of the reduction rules applies. We then brute force from there.

We now need to prove:
1. Yes $<==>$ Yes
2. $|hat(G)| + hat(k) <= f(k)$ for some computable function of $k$.

#proof[
  #todo[]
]

#definition(title: "Kernalization")[
  Let $L subset.eq Sigma^* times NN$ be a parametrized language. A *kernalization* algorithm (also called *reduction to problem kernel*) for $L$ is an algorithm that given an instance $(x,k)$ runs in time polynomial in $(|x| + k)$ and outputs an instance $(x', k')$ such that
  1. $|x'| + k' <= g(k)$ for some computable $g$
  2. $(x,k) in L <==> (x', k') in L$
  $(x',k')$ is called a kernel of $L$ of size $g(k)$.
]

#thm(title: "First Theorem of Parametrized Complexity")[
  A computable parametrized language $L$ has an FPT algorithm if and only if it has a kernalization algorithm.
]
#proof[
  Let there be a $O(f(x))$ (not necessarily polynomial) algorithm for the decision problem where $x$ is the size of problem.
  $(<==)$ From the definition of kernalization, we can find the kernel in $O("poly"(|x| + k))$ time and then the solution in time bounded by $O(f(|x| + k)) <= O(f(g(k)))$ which has no factor of $n$ and hence, is an FPT.

  $(==>)$ Suppose $cal(A)$ solves instance $(x,k)$ of $L$ in time $O(f(k) dot |x|^c)$.


  #algo[Run $cal(A)$ on $(x, k)$ for $|x|^(c+1)$ steps
    - If $cal(A)$ stops and returns an answer, return a trivial Yes or No instance
    - Else: return $(x,k)$
  ]

It is clear that Yes $<==>$ Yes. What about the "$|x'| + k' <= g(k)$ for some computable $g$"?

Well, as $cal(A)$ is an FPT with runtime $O(f(x) dot |x|^c)$, the fact the algorithm has not terminated tells us:
$
|x|^(c+1) = O(f(k) |x|^c)\
=> |x|^(c+1) <= c_2 f(k) |x|^c\
=> |x| <= c_2 f(k)\
=> |x| = O(f(k))
$

Thus, $|x| + k = O(f(k) + k)$.

Thus, we have a kernel of size $O(f(k) + k)$.
]

Notice, the FPT doesn't give a particularly useful kernalization. It is just a nice statement to say.

== Planar Independent Set
#definition(title : "Independent Set")[
  Input: Given a graph $G$ and $k in NN$
  
  Question: Does there exist $S subset.eq V$ such that $|S| >= k$ such that $u,v in S <==> u v in.not E$?
]

While in the classical setting, this and vertex cover are twins; The same doesn't track here. If we reduce to vertex cover, we have a $O^* (2^(n-k))$ algorithm which is not FPT.

Sadly, there is no FPT using the standard parametrization as the problem is $W[1]$ hard with respect to $k$.

However, if we restrict to the planar case, we can however have a kernel.

#definition(title : "Planar Independent Set")[
  Input: Given a planar graph $G$ and $k in NN$
  
  Question: Does there exist $S subset.eq V$ such that $|S| >= k$ such that $u,v in S <==> u v in.not E$?
]

While this NP Hard (even on bounded degree), we now have a linear kernel (and hence, FPT) on the standard parametrization: if $|V| >= 4 k$ then by 4 color theorem, return *Yes*. Otherwise, return $(G, k)$.

This is sometimes called a _cheat_ kernel as we don't really find out much about the problem.

= Feedback Vertex Set
#definition(title : "Feedback Vertex Set")[
  Input: Given an undirected graph $G$ on $n$ vertices, $k in NN$.

  Parameter: $k$

  Question: Does $G$ contain a set $S$ of size $<= k$ such that $G-S$ has no cycles.
]

We call $S subset.eq V(G)$ is a feedback vertex set of $G$ if and only if $G - S$ is acyclic.

The idea is similar to vertex cover. We first delete all degree 0 and 1 vertices.

Now that we have a graph with degree atleast 2, there must either be a 
#todo[]

#thm[
  If $n < (2 log_2 n)^k$ then:
    $
    (2 log_2 n)^k < (4 k log_2 n)^k
    $
    #todo[hain]
]
#proof[#todo[hain]]

= Feedback Arc Set
#definition(title: "Feedback Arc Set in Tournament")[
  Input: Given a tournament $T$ on $n$ vertices, $k in NN$

  Parameter: $k$

  Question: Does $T$ contain an arc set $F$ of size $<= k$, such that $T - F$ has no directed cycle?
]

Such a $F$ is called a feedback arc set of tournament $T$.

We can begin with getting rid of all the clear winners (out-degree 0) and clear losers (in-degree 0).

Now the tournament is guaranteed to have a cycle, we use the following claim:
#claim[
  An arc (and vertex) in a tournament is part of directed cycle if and only if it is part of a directed triangle.
]
#proof[
  FTSOC let the arc $u v$ be part of a the shortest cycle $c$ which is not a triangle.

  #todo[]
]

Similar to vertex cover, we would like to sort of have a rule to deal with arc's which are part of large number of triangle ($k$). But we can't delete it as otherwise the instance is no longer a tournament. So what do we do?

#claim[
  #todo[Reverse arc wala]
]