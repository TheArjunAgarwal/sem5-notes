#import "modules/notes.typ": *

#show: thm-rules

#let pm = $plus.minus$
#let langle = $chevron.l$
#let rangle = $chevron.r$

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

 "They are a complexity theorist. They want nothing to do with algorithms."

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

While there is a $cal(O)^*(2^k)$ algorithm, we can see an interesting and simple $cal(O)^*(3^k)$ algorithm.

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

While in the classical setting, this and vertex cover are twins; The same doesn't track here. If we reduce to vertex cover, we have a $cal(O)^* (2^(n-k))$ algorithm which is not FPT.

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

We could begin with getting rid of all the clear winners (out-degree 0) and clear losers (in-degree 0).

Now the tournament is guaranteed to have a cycle, we use the following claim:
#claim[
  An arc (and vertex) in a tournament is part of directed cycle if and only if it is part of a directed triangle.
]
#proof[
  FTSOC let the arc $u v$ be part of a the shortest cycle $c$ which is not a triangle.

  #todo[]
]

Similar to vertex cover, we would like to sort of have a rule to deal with arc's which are part of large number of triangle ($k$). But we can't delete it as otherwise the instance is no longer a tournament. So what do we do?

#definition[
  For a subset $F$ of arcs of $T$, let $T plus.o F$ be the tournament obtained from $T$ by reversing the arcs in $F$
]
#claim[
  If $T plus.o F$ is acyclic then $F$ is a feedback set of $T$
]
#claim[
  If $F$ is an inclusion minimal feedback arc set of $T$ then $T plus.o F$ is acyclic. 
]

#todo[proof is hw]

#cor[
  If $(T,k)$ is an Yes instance of FAST $<==>$ there is a set $F$ of arcs of $T$, $|F| <= k$, such that $T plus.o F$ is acyclic. 
]

These gives us clear reduction rules (which are very similar to vertex cover):
- #underline[*Reduction Rule 1*]: If $T$ has vertex $v$ which is not part of any triangle in $T$, return $(T - v, k)$
- #underline[*Reduction Rule 2*]: If $T$ has an arc $e$ that is part of $>= k+1$ triangles, then return $(T plus.o {e}, k-1)$

#todo[
  Prove Validity of rule 2!
]

But why is this a valid kernel?
#proof[
If both the reduction rules fail and we are in a non-trivial instance, notice that every arc is part of atmost $k$ triangles and every vertex is part of a triangle.

Hence, each arc covers atmost $k$ triangles. Thus, reversing an edge can 'destroy' atmost $k$ triangles which cover $k + 2$ vertices.

Thus, if the instance has $ >k(k+1)$ vertices, we can return a No instance.
]

This gives us a $k^2 + 2k + k = O(k^2)$ kernel.

#idea[
  The usual idea in coming up with kernalization algorithms is to come up with reduction rules based on 'simple' cases. 

  The way we come up with these rules is to find useful structures we can discover in polynomial time.

  Some common structures are:
  - Something that is definitely part of the solution
  - Something that is definitely not part of optimal solution
  - Something which we can replace with a smaller/simpler thing
]

Note, this same idea gives us a $cal(O)^*(3^k)$ FPT algorithm by branching on the triangles.

$cal(O)^*(2^(O(sqrt(k) log(k))))$ is the best known bound for FAST by Alon, Lokshtanov and Saurabh in 2009.

For FVS, the easy bound is $cal(O)^*(3^k)$. The iterated compression method gives $cal(O)^*(2^k)$ and the current best is $cal(O)^*(1.618^k)$ by Kumar#footnote[Another CMI person!] and Lokshtanov in 2016.

= Feedback Vertex Set Revisited
Once we make the reductions and have a graph $G$ left with degree atleast $3$, consider that if $X$ is a FVS and $G - X$ is a huge forest, then *every leaf in $G - X$ has to have a atleast 2 edges entering $X$.*

So we would like atleast some high degree vertices in the $X$. We could formalize this as:

#lem[
  Let $V(G) = {v_1, v_2, dots, v_n}$ in non-increasing order of degree. 

  Let $V_(3k)$ be the first $3k$ vertices in this order (with ties broken arbitrarily). Then, any FVS of $G$ of size $<= k$, must contain atleast one of the vertex of $V_(3k)$
]
#proof[
#claim[
  Let $X$ be any FVS of $G$. Then,
  $
  sum_(v in X) (deg(v) - 1) >= m - n + 1
  $
]

#proof[
  $\# "edges in" G-X <= n - |X| - 1$

  $\# "other kind of edges" <= sum_(v in X) deg(v)$

  Adding these, $m <= sum_(v in X) (deg(v) - 1) + n - 1 => sum_(v in X) (deg(v) - 1) >= m - n + 1$.
]

FTSOC, let $V_(3k) subset.eq V(G - X)$. Then,

$
sum_(v in V_(3k)) (deg(v) - 1)\
>= 3 (sum_(v in X) (deg(v) - 1))\
>= 3 (m - n +1)
$

Consider
$
sum_(v in.not V_(3k)) (deg(v) - 1) >= sum_(v in X) (deg(v) - 1)\
>= m - n + 1
$

$
sum_(v in V(G)) (deg(v) - 1) >= 4m - 4n + 4\
2m - n >= 4m - 4n + 4
$

#todo[Clarify?!]

Which is a contradiction.
]

This gives us a $cal(O)^*((3k)^k)$ algorithm.

We can also have a randomized $cal(O)^*(4^k)$ algorithm.

#todo[Photo from Image]

= Crown Decomposition
Notice, vertex cover was a high degree rule. It worked on high degree vertices. We might also note:
- Degree 0 rule $~~>$ min degree $1$ graph: \# vertices in the resulting kernel $<= k+k^2$ 
- Degree 1 rule $~~>$ min degree $2$ graph: \# vertices in the resulting kernel $<= k+k^2/2$ 
- Degree 2 rule $~~>$ min degree $3$ graph: \# vertices in the resulting kernel $<= k+k^2/3$
- $dots.v$ 


#definition(title: "Matching")[
  A Matching $M$ in Graph $G$ is a set of edges in $G$ of which no two share a common end-point.

  A vertex subset $X subset.eq V(G)$ is *saturated* by matching $M$ is every vertex in $X$ has an edge in $M$ incident to it.
]

There is a (very, very non-trivial) polynomial time algorithm to find a maximal matching in a graph.

#definition(title: "Crown Decomposition")[
  A *Crown Decomposition* of a graph $G$ is a  of its vertex set $V(G)$ into three parts: $V(G) = C union.plus H union.plus B$ where:
  + The *crown* C is non-empty independent set in $G$
  + The set $E'$ of edges between $C$ and the *head* H contains a matching that *saturates* $H$.
  + There are no edges with one end-point in $C$ nd the other in the *body* $B$.
]

#figure(image("pea-images/crown-decomposition.png", height: 30%))
#claim[
For vertex cover, if $langle C, H, B rangle$ is a crown decomposition of a graph $G$ then there is a smallest vertex cover of $G$ that contains *all* of $H$ and *none* of $C$.
]

#proof[
  As there is a matching, *not taking all* of $H$ and taking *none* of $C$ will leave some edge where both it's neighbors are not in the vertex cover.

  If we don't take all of $H$ and take *some* of $C$, we can have an equal or better instance by moving the 'guard' from a choosen $C$ to the $H$ it neighbors (can't happen that this doesn't occur as otherwise we have an edge that is not covered).
]

But to do any of that, we need to find the crown-decomposition which can't be polytime (unless $P = N P$). So what do we do?

#thm(title: "Konnig's Theorem")[
  There is a smallest vertex cover of a bipartite graph $B$, is equal to the size of a maximum matching of $B$. 
  
  There is a polynomial time algorithm that finds a largest matching, and a smallest vertex cover, on the input bipartite graph $B$
]

We now have an(other) algorithm for vertex cover.
#psudo(title: [A $cal(O)^*(3k)$ kernel for Vertex Cover])[
  + Find maximal matching $M$ of $G$. 
    + If $|M| > k$ then: return *No*
  + Let $V_m$ be the set of all vertices involved in $M$. Then $I = (V(G) backslash V_m)$ is an independent set.
    + If $|I| <= k$ then return $(G, k)$
  + So: $|I| > k$. Let $B$ be the bipartite graph induced by $V_m union.plus I$. Find a largest matching $tilde(M)$ and a smallest vertex cover $tilde(S)$ of $B$.
    + If $|tilde(M)| > k$ then return *No*
  + Let $C$ be the set of vertices in $I$ that are *not* in $tilde(S)$, $H$ be the set of vertices of $V_m$ that *are* in $tilde(S)$ and let $B = V(G) backslash (C union H)$ be the body.
    +  return $((G backslash C union H), k - |H|)$
]

Our penultimate step indeed choose a crown decomposition as:
+ $C$ is non-empty and independent (as subset of $I$)
+ $H$ is saturated by a matching from $C$ (otherwise, violates vertex cover property)
+ There are no edges with one end-point in $C$ and the other in *body* $B$ (otherwise, violates vertex cover or induced bipartite).

#remark[
  There is a linear programme to find a crown decomposition $langle C, H, B rangle$ such that $G backslash C union H$ has no crown decomposition.

  Furthermore, if $langle C_1, H_1, B_1 rangle, langle C_2, H_2, B_2 rangle, dots, langle C_k, H_k, B_k rangle$ are the crown decompositions of $G, G backslash C_1 union H_1, dots, G backslash (C_1 union C_2 union dots union C_(k-1)) union (B_1 union B_2 union dots union B_(k-1))$ respectively, then $langle union.big C_i, union.big B_i, G backslash (union.big C_i) union (union.big B_i)$ is a crown decomposition.
]

= An $cal(O)^*(2k)$ Kernel for Vertex Cover
This will be 'optimal' in some sense as Unique Game Conjecture would be violated by, $2 - epsilon$ approximation and thus, a kernel better than $(2 - epsilon)k$ is not possible.

We will proceed via ILP.
#definition(title: "ILP of Vertex Cover")[
  A variable $x_v$ for each vertex $v in V(G)$.

  For each $u v in E(G) : x_u + x_v >= 1$.

  For each $v in V(G)$, $x_v in {0,1}$

  Minimize $sum_(v in V(G)) x_v$ subject to above.
]

We can relax the integral constraint to get a linear programme
$
0 <= x_v <= 1 "for all" v in V(G)
$

As we shall see in sometime (and blackbox for now), vertex cover's LP has the half-integrability property.

#definition(title: "Half-Integrability")[
  If an ILP admits an optimal solution where every variable takes one of the values ${0, 1/2, 1}$.
]

#figure(image("pea-images/half-lp-vc.png", width: 50%))

This sort of looks like a crown decomposition already...

#claim[
  There is a matching saturating $V_1$ from $V_0$
]
#proof[
  FTSOC, let there be no such matching. Then, by Hall's marriage lemma, there exists a $X subset.eq V_1$ such that $|N(X)| < |X|$ but then, reassign all variables in $N(X) union X$ as $1/2$ and that reduces the objective function.

  This doesn't violate constraints as
  - $X <--> N(X)$ as $1/2 + 1/2 = 1$
  - $X <--> V_1/2$ as $1/2 + 1/2 = 1$
  - $N(X) <--> V_1 backslash X$ as the vertex from $V_1 backslash X$ was already $1$ and $1/2 + 1 > 0 + 1 >= 1$.

Thus, we have a contradiction as the solution was optimal.
]

Notice, $V_(1/2)$ has less than $2k$ vertices as otherwise the relaxed instance has objective greater than the ILP which implies the ILP doesn't admit a solution. Thus, we already have a $cal(O)^*(2k)$ kernel.

= Sunflower Lemma
Notice, crown decomposition is sort of a generalization of the degree one rule.
#figure(image("pea-images/1d-crown.png", width: 50%))

Similarly, the sunflower lemma is a generalization of the large degree rule.

#definition(title: "Sunflower")[
  Let $cal(U)$ be a finite universe and let $S_1, S_2, dots, S_t$ be subsets of $cal(U)$ when:
  + There is a (possibly empty) set $C$ such that $(S_1 inter S_2) = C$ holds for all $1 <= i <= j <= t$ and
  + $P_i = (S_i inter C)$ is non-empty for each $1 <= i <= t$.
then $S_1, S_2, dots, S_t$ is. sunflower with core $C$ and petals $P_1, P_2, dots, P_t$.
]

Erdos had asked Rado (who was a kid then, literally eating cereal): Fix positive integers $k$ and $d$. Does just taking a large enough collection of distinct $d$-sized subsets of $cal(U)$, guarantee a sunflower with $k$ petals?

Rado answered shortly after leading to the *Sunflower Lemma*.

#thm(title: "Theorem (Sunflower Lemma, Erdos & Rado 1960)")[
  Let $cal(A)$ be a family of $d$-sized sets (without duplicates) over a finite universe $cal(U)$. If $|A| > d! (k-1)^d$ then $cal(A)$ contains a sunflower with $k$ petals. Such a sunflower can be computed from $cal(A)$ in time polynomial $|cal(A)| + |cal(U)| + k$.
]

= Iterated Compression
#todo[
  Didn't go to class as sick and sleepy...
]

A $cal(O)^*(g(k))$ algorithm for the disjoint version $=>$ an $cal(O)^* (sum_(i=0)^k binom(k+i, i) g(k-i))$ algorithm for the original problem when $g(k) = alpha^k$. This gives $cal(O)^* ((alpha+1)^k)$.

= Tournament Feedback Vertex Set
#definition(title: "Tournament Vertex Set")[
  Input: Given a tournament $cal(T)$ on $n$ vertices.

  Parameter: $k$

  Question: Is there a set $S subset.eq V(cal(T)), |S| <= k$, such that $T - S$ is acyclic?
]

#todo[What?!]

= Randomized Algorithms
A randomized algorithm can be thought of as a classical algorithm with access to a stream of random bits. If to solve a problem, the algorithm reads $r$ random bits, then we measure it's success over the $2^r$ possible bit strings.

In the FPT world, most of the random algorithms we'll see will be *One Sided error Monte Carlo algorithm with false negatives*.

#definition(title: "One Sided error Monte Carlo algorithm with false negatives")[
  A random algorithm which always terminates in some bounded time and reports *NO* on all *NO* instances and *YES* on an *Yes* instance with probability $p in [0,1]$.
]

The reason we want one sided error is, say $p = 1/(f(k))$ for computable function $f$. Then if we repeat the algorithm $f(k)$ times.

Then the probability that the algorithm gives a wrong (*NO*) every time is $(1-p)^(1/p) <= 1/e$. Thus, we have a constant error odds at the end.

== Color Coding
#definition(title: "Hamiltonian Path")[
  Input: Given a graph $G$ on $n$ vertices

  Question: Does $G$ have a (simple) path on $n$ vertices
]

#definition(title: "Simple Path")[
  A (simple) path has no repeated vertices or edges.
]

This problem is known to be NP hard.

A weaker(?) version of this problem is
#definition(title: "c-Path")[
  Input: Given a graph $G$ on $n$ vertices and a constant $c$, independent of the graph.

  Question: Does $G$ have a path on $c$ vertices?
]

This can clearly be solved in $cal(O)(binom(n, c) c!) approx cal(O)(n^c c!)$ which is polytime. So at some point in between of constant and everything, we slip into NP.

#definition(title: "k-Path")[
  Input: Given a graph $G$ on $n$ vertices and a constant $k$, which could be dependent of the graph.

  Question: Does $G$ have a path on $k$ vertices?
]

Monien in 1985 showed that k-path can be solved in $cal(O)^*(k!)$ time and hence, $k = (log(n))(log(log(n)))$ in $P$.

Papedmirou and Yennakekku in 1993 conjectured that k-path is in $P$ for $k = o(log(n))$. This was proven by Alon, Yuster and Zwick in 1994 using this new technique called *Color Coding*.

The problem with long path finding is that you sort of need to look at the path to find it. If I tell you that a graph has a small vertex cover, there is some structural property (sparseness) we have implied. Same with feedback vertex set. The issue is that I can take any random graph and affix a long path to it. This is what Alon, Yuster and Zwick had to deal with...

To simplify this problem:
#definition(title: "Rooted k-Path")[
  Input: Given a graph $G$ on $n$ vertices, a specified starting vertex $s$ and a constant $k$, which could be dependent of the graph.

  Parameter: $k$

  Question: Does $G$ have a path of length $k$ that starts at $s$?
]

A naive algorithm could be to recurse on the neighbors of $s$ as: $
"SOL"(G, s, k) = or.big_(v in N(s)) "SOL"(G - {s}, v, k-1)
$

We can get slightly better by DP. Consider a DP table $D$ where $D$ has one row for each vertex $v$ in $G$ and one column for each possible length $1 <= i <= k$.

$D[v, i]$ stores all paths of length $i$ from $s$ to $v$ with $s$ and $v$ included.
#todo[?]

This leads to a $cal(O)(binom(n,k) n k)$ size table.

We make the following simplification: each vertex of $G$ has one of the $k$ colors $c_1, c_2, dots, c_k$.

Given this, look for a path that:
- starts at $s$
- has length $k$, and
- has all the $k$ different colors

We can solve this using the above DP by storing the subset of colors that has already been seen.

This solves our problem in $cal(O)(2^k n k ) = cal(O)^* (2^k)$ time.

But how do we do this coloring? Well, *randomly*!

#idea[
  If we randomly color the graph with the probability of vertex $v$ being colored $c_i$ being $1/k$ (uniformly).

  Then, the odds of a $k$ path having different colors is $k^k/k! >= e^(-k)$ as $e^k = 1 + k + k^2/2! + dots + k^k/k! + dots => e^k >= k^k/k!$.

  Thus, if we repeat the above with a random coloring, we get a constant probability random algorithm with runtime $cal(O)^*((2e)^k)$.
]

But these people didn't stop. We are using too much randomness as any subgraph of size $k$ in graph can be detected in this manner. Why be this general?

#definition(title: "Perfect Hash Family")[
  A set $cal(F)$ of functions from ${1, 2, dots, n}$ to ${1, 2, dots, k}$ is said to be a *$(n,k)$ perfect hash family* if, for any subset $S <= [n]$ of size $k$, there is a atleast one function $f in F$ such that $f$ is injective on $S$.
]

#thm(title: "Theorem (Alan et al)")[
  For ay $n, k >= 1$ one can construct an $(n,k)$ perfect hash family of size $e^k k^(O(log k)) dot log(n)$ in time $e^k k^(cal(O)(log k)) dot n log n$.
]

We could just make the family and run the colorful path algorithm on the colorings induced by this family. This would still give an (un-randomized) algorithm in $cal(O)^*((2 e)^k)$.

In the 1993 paper by Papedmirou and Yennakekku, all open problems have been solved; other than one.
#todo[Arvind and others have work on it to show if]

== Random Separation
Cyan et al came up with the idea to perhaps use only 2 colors: one for the object we are trying to find and the other to separate it.

#idea[
  If we want to find an object $X$ inside an input instance and we color the entire instance with $2$ colors (say #text(red)[red] and #text(green)[green]) uniformly at random, then the probability that "our" object gets colored with green is $1/(2^(|X|)).$ This is "fpt" is $|X| <= f(k)$
]

#definition(title: "Subgraph Isomorphism")[
  Input: Given graphs $G, H$ where $|V(H)| = k, |V(G)| = n$

  Parameter: k

  Question: Is $H$ a subgraph of $G$?
]
#definition(title: "Clique")[
  Input: Given a graph $G$ and integer $h$ where $|V(G)| = n$

  Parameter: h

  Question: Is there a $h$-clique as a subgraph of $G$?
]

Both of these are not expected to be in FPT as they are W[1] hard (Hardness of Clique $=>$ Hardness of Subgraph Isomorphism)

However, if the degree of $G$ is bounded, we can solve it using *random separation*!

#definition(title: "Subgraph Isomorphism with degree bounded")[
  Input: Given graphs $G, H$ where $|V(H)| = k, |V(G)| = n$ and $max_(v in V(G)) deg(v) = d$

  Parameter: k, d

  Question: Is $H$ a subgraph of $G$?
]

+ Color every edge of $G$ green or red, with probability $1/2$ each.
+ let $chi : E(G) -> {"red", "green"}$ be the resulting coloring
+ Let $H'$ be an (unknown) copy of $H$ inside $G$. Let $Y$ be the set of edges that are: incident on a vertex of $V(H')$ and are not in $E(H')$.

Can $Y$ have edges, both of whose end-points are in $V(H')$? Yes! These are the edges not in $V(H')$ as $H$ is not necessarily a clique.

Say $chi$ is a good if every edge of $E(H)$ is green and every edge in $Y$ is red.

#claim[
  If $H$ is connected, then $H'$ will be equal to one of the connected components of the 'green' subgraph defined by a good coloring $chi$.
]

So we can delete the red edges and then look at the $k$ sized connected components.

$
PP("a random coloring is good") = 1/(2^(|E(H')|) dot 2^(|Y|))
$

as we want all edges of $H'$ to be green and all edges in $Y$ to be red. As the degree is bounded and $E(H')$ and $Y$ are incident on $V(H')$. Thus, $E(H') + |Y| = k d$. Thus,

$
PP("a random coloring is good") >= 1/(2^(k d))
$

Thus, we can solve the problem (for connected $H$) by doing a uniform random coloring of edges to red or green, deleting red edges, checking connected components of size $k$ for isomorphism and repeating if failed.

Isomorphism takes $O(k! k)$ time (brute force) or $O(k^(O(d log d)))$ as bounded degree (from Luki 1982).

We can extend this to a disconnected $H = H_1 union H_2 union dots union H_m$. After deleting the red edges, look for a component to match to (is isomorphic to) $H_1$, then $H_2$ and so on.

#thm[
  There are Monte Carlo algorithms with false negatives that solve bounded degree subgraph isomorphism in $cal(O)^*(2^(d k) k!)$ and $cal(O)^*(2^(d k) k^(cal(O)(d log d)))$
]

 #todo[
  thank god for OCR (from photo on phone)
 ]

 We can also use this on graphs without bounded degree.

 #definition(title: [Cutting of $q$ Connect Vertices])[
  Input: Given a graph $G$ on $n$ vertices, $q, k in NN$

  Parameter: $q + k$

  Question: Is there a set $X subset.eq V(G)$ with $|X| <= k$ such that $G - X$ has a connected component with exactly $q$ vertices?
 ]

 The problem was introduced by Danial Marx in 2006 and is known to be W[1]-hard for $q$ or $k$ alone. Marx also gave a $cal(O)^*((q+k)^(cal(O)(q)))$ algorithm in 2006.

 Let $Y$ be a connected component of size $q$ in $G - X$.

Color all edges and a good coloring is such that all edges of $Y$ are green and all of $X$ to $Y$ are red (everything else is immaterial). This gives a $1/ (q^2 + k q)$ odds of good coloring and hence a $cal(O)^*(k^2 + k q)$ algorithm.

But we can be faster. Consider coloring all the vertices. A good coloring has the $Y$ vertices be green and $X$ be red. Then, we can delete the red-green edges and check for a connected component.

This gives the odds of a good coloring to be $1/(2^(q+k))$ and hence, an algorithm in $cal(O)^*(2^(q + k))$ time.

#remark[
  This would probably be publishable in 2006 or 2007 but Marx didn't know about random separation and now this is a classic exercise in the textbook (and has no other reference).
]

== Divide and Color
This idea tries to combine divide and conquer with color coding to get fast randomized Algorithms. We will consider it on the $k$-path problem with parameter $k$ (the length of path we are looking for).

Let $P$ be on $l$-path in $G$, with end points $u, v$.

Partition $V(G)$ into two parts $L, R$ uniformly at random.

We hope that the *first* $ceil(l/2)$ vertices of $P$ are in $L$ and the rest in $R$. This has probability $1/2^l$.

Now we recursively look for path of length $ceil(l/2)$ and $floor(l/2)$ in $G[L]$ and $G[R]$.

But how do we know they will patch together? By changing the question!

For $X subset.eq V(G), l in {1,2,dots, k}$ and $u, v in X$, let
$
D_(X, l)[u, v] := "True" <==> "there is an" l-"vertex path from" u "to" v "in" G[X]
$

This means, once we have $D_(V(G), k)$ then we can just iterate over all the pairs of vertices and if any is true, we are done.

However, that would be very slow... so instead we compute an approximate version $tilde(D)_(x, l)$ where
$
tilde(D)_(x, l)[u,v] = "True" => D_(x,l)[u,v] = "True"\
D_(x,l)[u,v] = "True" => tilde(D)_(x, l)[u,v] = "True" "with high probability"\
$

Let $(L, R)$ be a partition of $X$. Let $A$ be an $|L| times |L|$ matrix, $B$ be a $|R| times |R|$ matrix. We define $A join B$ to be the $|X| times |X|$ boolean matrix where $[u,v]$ entry is True if and only if $u in L$, $v in R$ and there is edge between $x, y in E(G)$ with $x in L, y in R$, $A[u,x] = B[y, v] = "True"$.

This means $(D_(L, ceil(L/2)) join D_(R, floor(L/2)))[u, v] = "True"$ if and only if $G[X]$ has an $l$ path from $u$ to $v$ where first $ceil(l/2)$ vertices are in $L$ and the rest are in $R$.

This implies (but not the other way) $D_(X, l)[u,v] = "True"$.

#psudo(title: "Simple Random Path")[
  + def SRP($X$, $l$):
    + If $l=1$: return $tilde(D)_(X, l)[v,v] = "True"$ for all $v in X$ and "False" otherwise.
    + Partition $X$ into $L, R$ uniformly at random
    + $tilde(D)_(L, ceil(L/2)) = "SRP"(L, ceil(L/2))$
    + $tilde(D)_(R, floor(L/2)) = "SRP"(R, floor(L/2))$
    + return $tilde(D)_(X, l) = tilde(D)_(L, ceil(L/2)) join tilde(D)_(R, floor(L/2))$
]

The recursion is $T(l) = 2 T(l/2) + n^c => T(l) = l dot n^c = cal(O)(n^(c+1))$.

Wait $P = "NP"$? Not really. Notice that our algorithm's success is not guaranteed. Looking at the tree, it is $(1/(2^l))^(log l) = 1/2^(l log l)$.

This gives an runtime of $cal(O)^*(2^(l log l)) = cal(O)^*(2^(k log k)) = cal(O)^*(k^k)$ which is a lot, lot worse than our original $cal(O)^*((2e)^k)$ color coding algorithm.

So what do we do? Our main issue is that the randomization keeps happening. Perhaps, let's front load the randomization.

#psudo(title: "Fast Random Path")[
+ def $"FRP"(X,l)$:
  + If $l = 1$: return $tilde(D)_(X, l)[v,v] = "True"$ for all $v in X$ and "False" otherwise.
  + Set $tilde(D)_(X, l)[u,v] = "False"$ for all $u, v in X$
  + Repeat $f(l,k)$ times:
    + partition $X$ into $L, R$ uniformly at random
    + $tilde(D)_(L, ceil(l/2)) = "FRP"(L, ceil(l/2))$
    + $tilde(D)_(R, floor(l/2)) = "FRP"(R, floor(l/2))$
    + $tilde(D')_(X, l) = tilde(D)_(L, ceil(l/2)) join tilde(D)_(R, floor(l/2))$
    + $tilde(D)_(X,l)[u,v] = tilde(D)_(X,l)[u,v] or tilde(D')_(X, l)[u,v]$ for all $u, v in X$
  + return $tilde(D)_(X, l)$
]

The idea is that (based on $f(l,k)$) that we have a massive tree but we only need one subtree to succeed.

Let's say success for a node is just partitioning well, rest of the work is the job of it's children.

The probability of success of an arbitrary node in one try is $1/2^l$. Thus, the probability of failure in $f(l,k)$ tries is $(1 - 1/2^l)^(f(l,k))$.

Choose $f(l,k) = 2^l log(4 k)$.

This mke the probability of failure to be $<= 1/(4 k)$.

Thus, probability that some node of the $k$-node skeleton fails is $1/4$ by the union bound.

This, probability that none of the skeleton fails, that is our algorithm finds the path is $3/4$.

Let's now look at the running time.

$
T(l,k) &<= 2^l log(4 k) 2 T(l/2, k) + n^c\
=> T(l,k) &= 4^(l + o(l+k)) n^d\
&< 4^(k + o(k)) n^d\
&< 4^(k + o(k)) n^d
$

This gives an $cal(O)^*(4^k)$ algorithm.

The state of the art is $cal(O)^*(1.618^k)$ where $1.618$ is the golden ratio.