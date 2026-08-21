#import "modules/notes.typ": *
#import "@preview/physica:0.9.8": *


#show: thm-rules

#let pm = $plus.minus$

#show: noteworthy.with(
  paper-size: "a4",
  language: "EN",
  title: "Statistical Mechanics",
  author: "Arjun Maneesh Agarwal",
  prof : "Ronak Soni",
  course-desc: [

  ],
  contact-details: "thearjunagarwal.github.io",
  toc-title: "Table of Contents"
)

= Lecture 1, 20 August

The basic principle of stat mech is: For a closed system in equilibrium, the probability of finding it in a state $i$ with energy $E_i$ is
$
PP(E_i) = e^(- beta E_i)/(sum_i e^(- beta E_i))
$

where $i$ is a classical orbit or $ket(i)$ is an energy eigenstate.

This is called the canonical ensemble.

Partition function $Z(beta) = sum_i e^(- beta E_i)$.

Free energy $F = - T log Z(beta)$ where $T = 1/beta$.

Energy $E = (sum_i E_i e^(- beta E_i))/2 = - partial_beta Z/ Z = - partial_beta log(2)$

Entropy $
S = - sum_i p_i log(p_i) \
= beta sum p_i E_i + sum p_i log(2)\
beta E - beta F\
=> F = E - T S
$

== "second" law
Notice,
$
dot(p_i) = sum_(j) tilde(D)_(i, j) p_j \
tilde(D)_(i, j) p_j = D_(i,j) p_j = p_i D(i, j) 
$

To prevent getting screwed by under-determination, we impose $D_(i,j) = D_(j,i)$.

For $p_i != p_j$:
$
d_(i,j). = (tilde(D)_(i, j) p_j)/(p_j - p_i)
$

$dot(p)_i = sum_j D_(i,j) (p_j - p_i)$

$
dot(S) = - sum (dot(p_i) log(dot(p_i)) + p_i ((dot(p_i))/p_i))\
= - sum D_(i , j) (p_j - p_i ) log(p_i)\
= 1/2 sum D_(i, j) (p_j - p_i) (log 1/p_i - log 1/p_j)
$

We will prove at some later stage that $dot(S) > 0$.

Note, this is not the second law.

If $p_i (t)$ is at equilibrium, then we have the 2nd law of thermodynamics.

Stat mech entropy is more general of a concept that reduces to thermo entropy for liquid states.

== Extensivity
$
E_i = sum_(a=1)^n E_i_a
$
where $i$ is a multi-index.

Then, $
Z = sum_(i_1) sum_(i_2) dots sum_(i_n) e^(-beta E_a E_i_a) = product_(a=1)^n sum_(i_a) e^(- beta E_i_a)
$

and note
$
log(Z) = sum_a log(Z_a)
$

