#import "modules/notes.typ": *

#show: thm-rules

#let pm = $plus.minus$
#let pdif = $partial$

#show: noteworthy.with(
  paper-size: "a4",
  language: "EN",
  title: "Quantum Computing",
  author: "Arjun Maneesh Agarwal",
  prof : "Bijita Sharma",
  course-desc: [
    Assignments: 25\%,
    Quizzes (2): 25\%,
    Final Exam: 50\%
  ],
  contact-details: "thearjunagarwal.github.io",
  toc-title: "Table of Contents"
)

= A Brief Overview of Quantum Mechanics
== States and wave functions
In a classical system, we can talk about the position or time or velocity of a particle.

However, in the quantum setting, the position and time are described as a probability by something called a wave function which is denoted by $psi(x,t)$.

The time evolution is these systems is described by Schrodinger's equations (which were given by Erwin Schrodinger in 1926 and lead to a Nobel in 1933).
$
i planck (pdif psi)/(pdif t) = - planck/(2m) (pdif^2 psi)/(pdif x^2) + v psi
$

where $planck = h/(2pi) = 1.054373 times 10^(-34) J "sec"$ is the reduced Planck constant.

== Statistical Interpretation
This interpretation was given by Max Born in 1926, who got a Nobel in 1954.

$|psi(x,t)|^2$ represents the probability of finding the particle at $x$ at time $t$. Thus,

$
P_(a,b) = integral_a^b |psi(x,t)|^2 dif x
$

is the probability of finding a particle in between $a$ and $b$.

To normalize, divide by constant so that $integral_(-oo)^oo |psi(x,t)|^2 dif x$.

#thm[
  $psi(x, t=0)$ once normalized, stays normalized.
]
#proof[
  $
  dif/(dif t) integral_(-oo)^oo |psi(x,t)|^2 dif x\
  = integral_(-oo)^oo pdif/(pdif t) |psi(x,t)|^2 dif x\
  $

  Notice,
  $
  pdif/(pdif t) |psi|^2 = pdif/(pdif t) (psi^* psi) = (pdif psi^*)/(pdif t) psi +  psi^* (pdif psi)/(pdif t)
  $

  
]