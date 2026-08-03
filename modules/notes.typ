// All imports
#import "@preview/showybox:2.0.4": showybox
#import "@preview/gentle-clues:1.2.0": *
#import "thm-env.typ":*

// Main noteworthy function
#let noteworthy(
  paper-size: "a4",
  font: "New Computer Modern",
  language: "EN",
  title: none,
  author: none,
  prof: none,
  contact-details: none,
  course-desc: none,
  toc-title: "Table of Contents",
  content,
) = {
  // Document metadata
  set document(
    title: [#title - #author],
    author: author,
    date: auto,
  )

  // Page settings
  set page(
    paper: paper-size,
    header: context {
      if (counter(page).get().at(0) > 1) [
        #grid(
          columns: (1fr, 1fr),
          align: (left, right),
          smallcaps(title), datetime.today().display("[day]/[month]/[year]"),
        )
        #line(length: 100%)
      ]
    },
    footer: context [
      #line(length: 100%)
      #grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [#link(contact-details)[#author]],
        counter(page).display(
          "(1/1)",
          both: true,
        ),
      )
    ],
  )

  // Text settings
  set text(
    font: font,
    size: 12pt,
    lang: language,
  )

  // TOC settings
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }
 
   // Heading settings
  set heading(numbering: "1.")

  // Paragraph settings
  set par(justify: true)

let c1 = rgb("#A7C957")
let c2 = rgb("#FFD972")
  // Title
  showybox(
    frame: (
      border-color: c1.darken(50%),
      body-color: c1.lighten(80%),
    ),
    shadow: (
      offset: 3pt,
    ),
    body-style: (
      align: center,
    ),
    text(weight: "black", size: 15pt, title),
  )
  // Author
  showybox(
  frame: (
    border-color: c2.darken(50%),
    body-color: c2.lighten(80%),
  ),
  width: 100%,
  shadow: (
    offset: 3pt,
  ),
  body-style: (
    align: center,
  ),
  sep: (
    thickness : 0.5pt,
    dash : "dashed"
  ),
  text(weight: "black", size: 15pt, [Notes by #link(contact-details)[#author]]), 
  text(weight: "black", size: 12pt, [based on course by #prof])
)

align(center,[#course-desc])

  // Table of contents
  showybox(
    outline(
      indent: auto,
      title: toc-title,
      depth: 3,
    ),
    breakable: true
  )

  // Main content
  content
}

