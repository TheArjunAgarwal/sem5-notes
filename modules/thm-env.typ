#import "theorems.typ": *
#show: thm-rules
#import "@preview/gentle-clues:1.2.0": *

#show figure.where(kind:"thmenv"): set align(start)



#let thm-args = (padding: (x: 0.5em, y: 0.6em), outset: 0.9em, counter: "thm", base-level: 1, stroke: 1pt)

#let thm = thm-plain("Theorem",  fill: rgb("#b9cbe1").lighten(50%), ..thm-args)

#let lem = thm-plain("Lemma", fill: rgb("#b9cbe1").lighten(50%), ..thm-args)

#let prop = thm-plain("Proposition", fill: rgb("#b9cbe1").lighten(50%), ..thm-args)

#let cor = thm-plain("Corollary", fill: rgb("#b9cbe1").lighten(50%), ..thm-args)

#let conj = thm-plain("Conjecture", fill: rgb("#b9cbe1").lighten(50%), ..thm-args)

#let ex = thm-def("Example", fill: rgb("#ffeeee").lighten(50%), ..thm-args)

#let algo = thm-def("Algorithm", fill: rgb("#E9AEB6").lighten(50%), ..thm-args)

#let claim = thm-def("Claim", fill: rgb("#E3B778").lighten(50%), ..thm-args)

#let rmk = thm-def("Remark", fill: rgb("#eeeeee").lighten(50%), ..thm-args)

#let defn = thm-def("Definition", fill: rgb("#ffffdd").lighten(50%), ..thm-args)

#let prob = thm-def("Problem", fill: rgb("#eeeeee").lighten(50%), ..thm-args)

#let exer = thm-def("Exercise", fill: rgb("#eeeeee").lighten(50%), ..thm-args)

#let ques = thm-def("Question", fill: rgb("#eeeeee").lighten(50%), ..thm-args)

#let fact = thm-def("Fact", fill: rgb("#eeeeee").lighten(50%), ..thm-args)

#let todo = thm-plain("TODO", fill: rgb("#ddaa77").lighten(50%), padding: (x: 0.2em, y: 0.2em), outset: 0.4em).with(numbering: none)
#let proof = thm-proof("Proof")
#let soln = thm-proof("Solution")

// i have no idea how this works but it seems to work ¯\_(ツ)_/¯
// Was a note left by Evan. I will not be making any changes here.
#let recall-thm(target-label) = {
  context {
    let el = query(target-label).first()
    let loc = el.location()
    let thms = query(selector(<meta:thm-env-counter>).after(loc))
    let thmloc = thms.first().location()
    let thm = thm-stored.at(thmloc).last()
    (thm.fmt)(
      thm.name, link(target-label, str(thm.number)), thm.body, ..thm.args.named(),
    )
  }
}

// Custom environments using theoretic
#let definition(title: none, ..args) = clue(
  accent-color: rgb("#A7C957"),
  header-color: rgb("#A7C957"),
  body-color: rgb("#A7C957").lighten(90%),
  title: if title != none {[Definition: #title]} else {[Definition]},
  breakable : true,
  ..args
)

#let exercise(title: none,..args) = clue(
  accent-color: rgb("#F4A259"),
  header-color: rgb("#F4A259"),
  body-color: rgb("#F4A259").lighten(90%),
  title: if title != none {[Exercise : #title]} else {[Exercise]},
  breakable : true,
  ..args
)
#let example(title: none,..args) = clue(
  accent-color: rgb("#FFD972"),
  header-color: rgb("#FFD972"),
  body-color: rgb("#FFD972").lighten(90%),
  title: if title != none {[Example : #title]} else {[Example]},
  breakable : true,
  ..args
)
#let solution(..args) = clue(
  accent-color: rgb("#E9AEB6"),
  header-color: rgb("#E9AEB6"),
  body-color: rgb("#E9AEB6").lighten(90%),
  title: "Solution",
  breakable : true,
  ..args
)
#let remark(title: none,..args) = clue(
  accent-color: rgb("#B5B9D3"),
  header-color: rgb("#B5B9D3"),
  body-color: rgb("#B5B9D3").lighten(90%),
  title: if title != none {[Remark: #title]} else {[Remark]},
  breakable : true,
  ..args
)

#let idea(title : none, ..args) = clue(
  accent-color: rgb("#C1E1C1"),
  title: if title != none {[Idea : #title]} else {[Idea]},
  breakable : true,
  ..args
)

#let note(..args) = clue(
  accent-color: rgb("#D9D9A0"),
  title: "Side Note",
  breakable : true,
  ..args
)

#import "@preview/lovelace:0.3.0": *

#let psudo(title:none, ..psudo-args) = pseudocode-list(booktabs: true, title: smallcaps[#title], indentation: 2em, hooks: .5em, ..psudo-args)