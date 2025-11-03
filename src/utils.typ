// Tim Xie, Fall 2025
// Please direct any questions to xie@berkeley.edu

// improved code blocks
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let section_counter = counter("sectioncounter")
#let section_points = state("sectionpoints", ())

#let add_points = p => {
  let section = section_counter.get().at(0) - 1

  section_points.update(it => {
    for i in range(it.len(), section + 1) {
    it.push(0)
  }

    it.at(section) += p

    return it
  })
}



// q/a
#let colorblue = rgb("#2A40E2")

// print, screen, sol
// print will disable syntax highlighting for code blocks
#let docmode = state("mode", "sol")

// utils
#let hstack(..items) = {
  stack(dir: ltr, spacing: 0.75cm, ..items)
}

#let info(body) = block[
  #block(
    fill: rgb("#ebebeb"),
    stroke: none,
    inset: 8pt,
    radius: 0pt,
    width: 100%,
  )[#body]
]

#let boxed(color: colorblue, body) = {
  align(center, rect(stroke: stroke(thickness:0.5pt,paint:color))[#body])
}

#let callout(t, body) = {
  let color = if t == "Definition" {
    rgb("6993BF")
  } else if t == "Formula" {
    rgb("DD4466")
  } else if t == "Method" {
    rgb("59B279")
  } else if t == "Example" {
    rgb("808C80")
  } else {
    rgb("969696")
  }

  let bgcolor = if t == "Definition" {
    rgb("E8EDF4")
  } else if t == "Formula" {
    rgb("F4E8EC")
  } else if t == "Method" {
    rgb("E8F4EC")
  } else if t == "Example" {
    rgb("F6F6F6")
  } else {
    rgb("F0F0F0")
  }

  block(
    fill: bgcolor,
    stroke: (left: stroke(thickness: 2.5pt, paint: color)),
    inset: (left: 10pt, right: 8pt, top: 8pt, bottom: 8pt),
    outset: (left: -2.5pt),
    radius: 0pt,
    width: 100%,
  )[
    #text(t, fill: color, weight: 600)
    #v(-6pt)

    #body
  ]
}



#let subtitle(t) = [
  #v(6pt)
  #set text(size: 11.5pt, weight: 600)
  #show raw: set text(size: 9.5pt, weight: 600)

  #t
  #v(-6pt)
] 


#let pp = subtitle("Practice Problems")

#let section(title, height: auto, number: false, content) = {
  block(height: height)[
    #if number == true [
    #section_counter.step()
    #context {
    let points = section_points.final().at(section_counter.get().at(0) - 1, default: 0)

    let pstr = if points == 1 { "point" } else { "points" }
    add_points(0.0)
    text(section_counter.display("1. ") + "[" + repr(points) + " " + pstr + "]  " + title, size: 14.5pt, weight: 500, tracking: -0.01em)
  }

  ] else [
    #text(title, size: 14.5pt, weight: 500, tracking: -0.01em)
  ]

    #v(-6pt)
    #content
  ]
}

#let ans(answer) = {
  context[
  #if docmode.get() == "sol" [
  #v(3pt)
  #text(fill: colorblue)[#answer]
]
]
}


#let _getheight(question, height, ansheight) = {
  // must have context when run
  let h = if docmode.get() == "sol" { 
    if ansheight == auto { auto }
    else { ansheight - measure(question).height - 12pt }
  } else {
    if height == auto { auto }
    else { height - measure(question).height - 12pt }
  }

  return h
}

#let _getptstr(points) = {
  return if points == 1 { "pt" } else { "pts" }
}

#let question(question, answer, 
  ansbox: false,
  height: auto, ansheight: auto,
  points: "") = {
  let pstr = _getptstr(points)

  context {
  let h = _getheight(question, height, ansheight)

  block(width: 100%)[
    #if points != "" [
    #context add_points(points);
    #text("[" + repr(points) + " " + pstr + "] ", weight: 500) #text(question)
  ] else [
    #question
  ]
    #v(-2pt)

    #if ansbox == true {
    box(width: 100%, stroke: stroke(thickness: 0.5pt, paint: if docmode.get() == "sol" { colorblue } else { black }), height: h, inset: (left: 7pt, top: 5pt, bottom: 7pt))[
      #ans(answer)
    ]
  } else {
    box(width: 100%, stroke: none, height: h)[
      #ans(answer)
    ]
  }

    #if not ansbox { v(8pt) }
  ]
}
}

#let mcq(question, choices, answer, 
  vertical: false, cols: none, colwidths: none,
  multi: false, symbs: none,
  ansbox: false,
  height: auto, ansheight: auto,
  explanation: "",
  points: "",) = {

  let length = choices.len()
  let pstr = _getptstr(points)

  context {
  let h = _getheight(question, height, ansheight)

  let items = range(length).map(i => [
    #let fill = if docmode.get() == "sol" and answer.contains(i) { colorblue } else { white }
    #let strokecolor = if docmode.get() == "sol" and answer.contains(i) { colorblue } else { black }

    #box(height: 7.5pt, width: 12pt,
      align(horizon)[
        #align(left)[
          #if symbs == none {
          if multi {
          square(size: 8.75pt, stroke: stroke(thickness: 0.5pt, paint: strokecolor), fill: fill)
        } else {
          circle(radius: 4.75pt, stroke: stroke(thickness: 0.5pt, paint: strokecolor), fill: fill)
        }
        } else {
          if symbs.at(i) {
          square(size: 8.75pt, stroke: stroke(thickness: 0.5pt, paint: strokecolor), fill: fill)
        } else {
          circle(radius: 4.75pt, stroke: stroke(thickness: 0.5pt, paint: strokecolor), fill: fill)
        }
        }]
      ]
    )
  ])

  set enum(numbering: (..nums, last) => [#items.at(last - 1)])

  block(width: 100%)[
    #if points != "" [
    #context add_points(points);
    #text("[" + repr(points) + " " + pstr + "] ", weight: 500) #text(question)
  ] else [
    #question
  ]

    #v(-2pt)
    #grid(
      columns: if colwidths != none { colwidths } else { range(if cols != none { cols } else { if vertical { 1 } else { choices.len() }}).map(_ => 1fr) },
      row-gutter: 10pt,

      ..choices.enumerate().map(((i, c)) =>
        enum.item(i + 1)[#c]
      )
    )
  ]

  if ansbox == true  {
  box(width: 100%, stroke: stroke(thickness: 0.5pt, paint: if docmode.get() == "sol" { colorblue } else { black }), height: h, inset: (left: 7pt, top: 5pt, bottom: 7pt))[
    #ans(explanation)
  ]
} else if explanation != "" {
  box(width: 100%, stroke: none, height: h)[
    #ans(explanation)
  ]
}

  v(8pt)
}
}

#let ansbank(cols: 3, choices: ("",)) = [
  #box([
    #set enum(
      numbering: (..nums, last) => [
      #text(weight: "bold", numbering("A", last))
      #h(4pt)
    ]
    )

    #grid(columns: range(cols).map(_ => 1fr),
      row-gutter: 8pt, 

      ..choices.enumerate().map(((i, c)) =>
        enum.item(i + 1)[#c]
      )
    )], stroke: stroke(thickness: 0.5pt), inset: 6pt)
]

#let blank(width, placeholder, answer: none) = [
  #context[
  #box(width: width, stroke: (bottom: 0.5pt), outset: (y: 2pt, x: 1.5pt))[
    #align(center)[
      #text(
        baseline: -1.5pt,
        raw(if docmode.get() == "sol" and answer != none { answer } else { placeholder }))
    ]
  ]
]
]


#let nextpage(text: [See next page]) = {
  box(width: 100%)[
    #align(right)[#stack(dir: ltr, spacing: 5pt, smallcaps(text), [$arrow.r.long$])]
  ]
}

#let blankpage(text: [This page intentionally left blank

  The exam begins on the next page.
]) = {
  box(width: 100%, height: 95%)[
    #align(horizon)[#align(center)[
      #text
    ]]
  ]
}




#let bubble(content, color) = [
  #box(content, fill: color.mix(white).transparentize(65%), radius: 3pt, inset: 2.5pt, stroke: stroke(paint: color, thickness: 0.5pt), baseline: 2.5pt)
]
