//       !!! IMPORTANT !!!
// Typst Compiler Version 0.11.0

#import "@preview/gentle-clues:0.8.0": *
#import "@preview/cetz:0.2.2"
#import "@preview/codly:0.2.0": *
#import "@preview/equate:0.2.0": equate

// pdf metadata
#set document(
  title: "Statistica e Analisi dei dati",
  author: ("Luca Favini", "Matteo Zagheno"),
)

// codly setup
#show: codly-init.with()
#codly(
  languages: (python: (name: "Python", color: blue, icon: none)),
  zebra-color: white,
  stroke-width: 1.5pt,
  stroke-color: blue,
  enable-numbers: false
)

// evidenziare link
#show link: it => {
  if type(it.dest) != str {
    // link interni
    underline(it, stroke: 1.5pt + blue)
  }
  else {
    // link esterni
    underline(it, stroke: 1.5pt + red)
  }
}

// evidenziare link nell'indice
#show outline.entry: it => {
  underline(it, stroke: 1.5pt + blue)
}

// settings box colorati
#show: gentle-clues.with(breakable: true)

// settings equazioni
#show: equate.with(breakable: true)

// box colorati
#let nota(body) = { info(title: "Nota")[#body] }
#let attenzione(body) = { warning(title: "Attenzione")[#body] }
#let informalmente(body) = { conclusion(title: "Informalmente")[#body] }
#let dimostrazione(body) = { memo(title: "Dimostrazione")[#body] }

// testo matematico colorato
#let mg(body) = text(fill: olive, $#body$)
#let mm(body) = text(fill: maroon, $#body$)
#let mo(body) = text(fill: orange, $#body$)
#let mr(body) = text(fill: red, $#body$)
#let mp(body) = text(fill: purple, $#body$)
#let mb(body) = text(fill: blue, $#body$)

// numerazione titoli
#set heading(numbering: "1.1.")

// pagina iniziale (titolo)
#page(align(left + horizon, block(width: 90%)[

  #text(3em)[*Statistica e Analisi dei dati*]
  #text(1.5em)[Università degli studi di Milano - Informatica]

  #link("https://github.com/Favo02")[
    #text(1.5em, "Luca Favini")
  ]
  #text(", ")
  #link("https://github.com/tsagae")[
    #text(1.5em, "Matteo Zagheno")
  ]
  #text(", ")
  #link("https://github.com/Gallja")[
    #text(1.5em, "Andrea Galliano")
  ]

  #text("Ultima modifica:")
  #datetime.today().display("[day]/[month]/[year]")
]))

#set par(linebreaks: "optimized")

// impostazioni pagine
#let numberingH(c)={
  return numbering(c.numbering,..counter(heading).at(c.location()))
}

#let currentH(level: 1)={
  let elems = query(selector(heading).after(here()))

  if elems.len() != 0 and elems.first().location().page() == here().page() {
    return [#numberingH(elems.first()) #elems.first().body]
  } else {
    elems = query(selector(heading).before(here()))
    if elems.len() != 0 {
      return [#numberingH(elems.last()) #elems.last().body]
    }
  }
  return ""
}

#set page(
  numbering: "1",
  number-align: bottom + right,
  header: [
    #set text(8pt)
    _Statistica e Analisi dei dati_
    #h(1fr)
    #context[_ #currentH() _]
  ],
  footer: [
    #set text(8pt)

    #context[
      _Luca Favini, Matteo Zagheno - #datetime.today().display("[day]/[month]/[year]")_
      #h(1fr)
      #text(12pt)[#counter(page).display("1")]
    ]
  ],
)

#heading(outlined: false, bookmarked: false, numbering: none, "Statistica e Analisi dei dati")

La statistica si occupa di raccogliere, analizzare e trarre conclusioni su dati, attraverso vari strumenti:

- #link(<descrittiva>)[Statistica descrittiva]: esposizione e *condensazione* dei dati, cercando di limitarne l'incertezza;
- #link(<probabilità>)[Calcolo delle probabilità]: creazione e analisi di modelli in situazioni di *incertezza*;
- #link(<inferenziale>)[Statistica inferenziale]: *approssimazione* degli esiti mancanti, attraverso modelli probabilistici;
- _Appendice: #link(<modelli>)[Cheatsheet variabili aleatorie e modelli]:_ riassunto formule e proprietà delle variabili aleatorie e dei modelli;
- _Appendice: #link(<python>)[Cheatsheet Python]:_ raccolta funzioni/classi Python utili ai fini dell'esame _(e non)_;
- _Appendice: #link(<matematica>)[Cheatsheet matematica]:_ trucchi per risolvere/semplificare equazioni, serie, integrali;
- _Appendice: #link(<esercizi>)[Esercizi]:_ come svolegere gli esercizi dell'esame.

#heading(outlined: false, bookmarked: false, numbering: none, "Autori, Ringraziamenti e Licenza")

/ Autori: #link("https://github.com/Favo02")[Luca Favini], #link("https://github.com/tsagae")[Matteo Zagheno], #link("https://github.com/Gallja")[Andrea Galliano] _(Appendice Python)_
/ Ringraziamenti: #link("https://github.com/Catu42")[Martina Provini] _(appunti)_, #link("https://github.com/ceri01")[Daniele Ceribelli] _(appunti)_
/ Sorgente e Licenza: #link("https://github.com/Favo02/statistica-e-analisi-dei-dati")[github.com/Favo02/statistica-e-analisi-dei-dati] (#link("https://creativecommons.org/licenses/by/4.0/")[CC-BY-4.0])
/ Ultima modifica: #datetime.today().display("[day]/[month]/[year]")

// indice
#outline(
  title: "Indice",
  indent: auto
)

#pagebreak()

// TODO: roba da sistemare!!!
/*

cosa vuol dire che lo stimatore non è deviato? questo vuol dire che stimando molte volte usando lo stimatore, allora la media delle stime ottenute è molto vicino al vero valore di p

omega: insieme degli esiti
algebra: insieme di eventi, quindi insieme di sottoinsiemi di omega

aggiungere in correzione di bessel: corregge la stima della varianza campionaria, provando a fare i conti esce che serve il n-1

dimostrazione teorema proprietà totali

dimostrazione eventi indipendenti
indipendenza a più eventi (non si estende per transitività)

indipendenza variabili aleatorie

regola empirica (e grafico) per normale

distribuzione uniforme continua: tutti gli esiti non sono equiprobabili (gli esiti sono tutti 0 inun punto)

quantile di una variabile aleatoria: inverso della funzione di ripartizione
da quantile descrittivo a quello di un va: quello che è una percentuale, diventa una probabilità
quindi F^-1 passa dalla probabilità (quindi il percento del quantile) all'evento associato alla probabilità (x_q)

specificare meglio la differenza tra quantile (x_q) e livello (q)

funzione di ripartizione va, aggiungere proprietà: continua da destra

*/

= Statistica descrittiva <descrittiva>

/ Popolazione: insieme di elementi da _analizzare_, spesso troppo numerosa per essere analizzata tutta
/ Campione: _parte_ della popolazione estratta per essere analizzata, deve essere rappresentativo
/ Campione casuale (semplice): tutti i membri della popolazione hanno la _stessa probabilità_ di essere selezionati
/ Campione stratificato: vengono individuate delle _categorie_ e si forma un campione facendo in modo che tutte le categorie siano proporzionalmente rappresentate

== Classificazione dei dati: qualitativi e quantitativi <quantitativi>

/ Dati quantitativi \/ Scalari \/ Numerici: l'esito della misurazione è una quantità numerica
  / Discreti: si lavora su valori singoli (spesso interi), ad esempio: _numeri di figli_
  / Continui: si lavora su range di intervalli, ad esempio: _peso_ o _altezza_

/ Dati qualitativi \/ Categorici \/ Nominali: l'esito della misurazione è un'etichetta
  / Booleani \/ Binari: due valori possibili, ad esempio: _sesso_
  / Ordinali: valori ordinabili, ad esempio: _livello di soddisfazione_
  / Nominali \/ Sconnessi: valori *non* ordinabili, ad esempio: _nome_

#nota[
  Spesso alcuni dati _numerici_ vengono considerati _qualitativi_, dato che non ha senso effettuare su di essi considerazioni algebriche o numeriche. Un esempio potrebbe essere la data di nascita
]

== Frequenze <frequenze>

/ Frequenza assoluta: _occorrenza assoluta di un carattere_, ovvero il numero di volte che un certo valore appare in un campione di dati

/ Frequenza relativa: rapporto tra la _frequenza assoluta_ di un dato e il la _dimensione del campione_ (quindi è sempre compresa tra $0$ e $1$)

=== Frequenze cumulate e Funzione cumulativa empirica

/ Frequenza cumulata: somma delle _frequenze assolute_ di tutti i valori _inferiori o uguali_ a un determinato valore, rappresenta il numero totale di osservazioni fino a quel valore

#attenzione[
  È possibile calcolare la _frequenza cumulata_ solo in caso di dati _ordinabili_
]

/ Funzione cumulativa (o di ripartizione) empirica: funzione $hat(F) : bb(R) -> [0,1]$ che, per ogni valore, mostra la proporzione del campione che è minore o uguale a quel valore
$ hat(F)(x) = (\#{x_i <= x})/n = 1/n sum_(i=1)^n I_(-infinity, x] (x_i) $

#nota[
  $I_A : bb(R) -> {0,1}$ indica la #link(<indicatrice>)[funzione indicatrice] dell'insieme $A$, ovvero vale $0 space forall a in.not A$ e $1 space forall a in A$
]

#nota[
  È possibile vedere la funzione cumulativa empirica come una stima della #link(<funzione-ripartizione>)[funzione di ripartizione], infatti ne è un buon #link(<stimatore>)[stimatore] consistente in media quadratica
]

=== Frequenze conguinte e marginali

Prendiamo in considerazione due caratteri dell'insieme di osservazioni:

/ Frequenza congiunta assoluta/relativa: numero di osservazioni in cui i due caratteri assumono dei determinati valori _(dati in corsivo nella tabella sottostante)_

/ Frequenze marginali: somme delle frequenze congiunte lungo le righe o le colonne di una tabella di contingenza, rappresentando la frequenza totale di ciascuna variabile _(dati in giallo nella tabella sottostante)_

#figure(caption: "Tabella di contingenza")[
  #table(
    columns: 5,
    inset: 10pt,
    align: horizon,

    table.cell(colspan: 2, rowspan: 2, []),

    table.cell(colspan: 2, fill: silver, [*Capelli*]), [],
    table.cell(fill: silver, [*Chiari*]), table.cell(fill: silver, [*Scuri*]),

    table.cell(fill: yellow, [*Tot Occhi*]),

    table.cell(rowspan: 3, fill: silver, [*Occhi*]),
    table.cell(fill: silver, [*Verdi*]), [_5_], [_3_],
    table.cell(fill: yellow, [8]),

    table.cell(fill: silver, [*Marroni*]), [_2_], [_42_],
    table.cell(fill: yellow, [44]),

    table.cell(fill: silver, [*Azzurri*]), [_8_], [_1_],
    table.cell(fill: yellow, [9]),

    [], table.cell(fill: yellow, [*Tot Capelli*]),
    table.cell(fill: yellow, [15]),
    table.cell(fill: yellow, [46]),
    table.cell(fill: yellow, [61])
  )
]

== Indici di centralità <indice-centralita>

Sono indici che danno un'idea approssimata dell'_ordine di grandezza_, intorno a quale valore si colloca l'insieme dei valori esistenti.

=== Media campionaria <media>

Viene indicata da $overline(x)$, ed è la *media aritmetica* di tutte le osservazioni del campione.

$ overline(x) = 1 / n sum_(i=1)^(n) x_i $

La media opera linearmente, quindi può essere scalata ($dot a$) e/o traslata ($+ b$):

$ forall i space y_i = a x_i + b => overline(y) = a overline(x) + b $

#nota[
  Può essere calcolata solo con #link(<quantitativi>)[dati quantitativi].
]

#attenzione[
  La media non è un indice robusto rispetto agli *outlier* <outlier>, ovvero i dati fuori scala, che la influenzano pesantemente
]

=== Mediana campionaria

È il valore nella *posizione di mezzo* di un dataset ordinato in ordine crescente, ovvero un valore $>=$ e $<=$ di almeno la metà dei dati.

Dato un dataset di dimensione $n$ la mediana è:
  - l'elemento in posizione $(n+1)/2$ se n è dispari
  - la media aritmetica tra gli elementi in posizione $n/2$ e $n/2 + 1$ se n è pari

#nota[
  È robusta rispetto agli #link(<outlier>)[_outlier_] ma può essere calcolata solo su _campioni ordinabili_
]

=== Moda campionaria

È l'osservazione che compare con la *maggior frequenza*. Se più di un valore compare con la stessa frequenza allora tutti quei valori sono detti modali.

== Quantili

Il quantile di ordine $alpha$ (con $alpha$ un numero reale nell'intervallo $[0,1]$) è un valore $q_alpha$ che *divide* la popolazione in due parti, proporzionali in numero di elementi ad $alpha$ e (1-$alpha$) e caratterizzate da valori rispettivamente *minori* e *maggiori* di $q_alpha$.

/ Percentile: quantile descritto in percentuale
/ Decile: popolazione divisa in 10 parti con ugual numero di elementi
/ Quartile: popolazione divisa in 4 parti con ugual numero di elementi

#attenzione[
  È richiesto un ordinamento totale nel campione
]

/ Range: distanza tra il punto minimo e il punto massimo
/ Range interquartile (IQR): distanza tra il primo e il terzo quartile

== Indici di dispersione

Sono indici che misurano quanto i valori del campione si _discostano_ da un _valore centrale_.

=== Scarto assoluto medio

Per ogni osservazione, lo *scarto* è la distanza dalla media: $x_i - overline(x)$.
La somma di tutti gli scarti farà sempre $0$:

$ sum_(i=1)^n x_i - overline(x) quad = quad sum_(i=1)^n x_i - sum_(i=1)^n overline(x) quad = quad n overline(x) - n overline(x) quad = 0 $

#informalmente[
  Questo indice è ovviamente _inutile_, dato che vale sempre $0$, è utile per introdurre il concetto di _scarto_, ovvero la distanza di un'osservazione dalla media
]

=== Varianza campionaria

Misura di quanto i valori si _discostano_ dalla media campionaria

$ s^2 = 1/(n-1) sum_(i=1)^n (x_i - overline(x))^2 $

Metodo alternativo per calcolare la varianza:

$ s^2 = 1/(n-1) (sum_(i=1)^n x_i^2 - n overline(x)^2) $

#dimostrazione[
  $ sum^n_(i=1) (mb(x_i) - mo(overline(x)))^2 &= sum_(i=1)^n (mb(x^2_i) - 2 mb(x_i) mo(overline(x)) + mo(overline(x)^2)) \
    &= sum_(i=1)^n x_i^2 - mp(2 overline(x) underbrace(sum_(i=1)^n x_i, = n overline(x))) + mg(sum_(i=1)^n overline(x)^2) \
    &= sum_(i=1)^n x_i^2 - mp(2 overline(x) dot n overline(x)) + mg(n overline(x)^2) \
    &= sum_(i=1)^n x_i^2 - mp(cancel(2) n overline(x)^2) + mg(cancel(n overline(x)^2)) \
    &= sum_(i=1)^n x_i^2 - n overline(x)^2 $
]

#informalmente[
  Verrebbe intuitivo applicare il _valore assoluto_ ad ogni scarto medio, ma questo causa dei problemi. Per questo motivo la differenza viene elevata al _quadrato_, in modo da renderla sempre positiva
]

La varianza _non_ è un operatore lineare: la traslazione ($+ b$) non ha effetto mentre la scalatura ($dot a$) si comporta:
$ forall i space y_i = a x_i + b => s^2_y = a^2 s^2_x $


==== Correzione di Bessel <bessel>

Perchè si divide per $mr(n-1)$ e non $n$?

Introduciamo la formula della *varianza* (NON campionaria):
$ sigma^2 = 1/mr(n) sum_(i=1)^n  (x_i - overline(x))^2 $

Se calcoliamo la _varianza_ di tutti i possibili _campioni_ di una popolazione e poi facciamo la media, *non* otteniamo la _varianza_ di tutta la _popolazione_. Questo invece avviene calcolando la varianza campionaria:

$ s^2 = sigma^2 n/(n-1) $
$ s^2 = 1/mr(n-1) sum_(i=1)^n (x_i - overline(x))^2 $

#informalmente[
  Un campione è composto da un _minore_ numero di elementi rispetto all'intera popolazione, quindi la dispersione rispetto al valore medio è _inferiore_. Per questo motivo è necessario _correggere_ la varianza
]

==== Varianza campionaria standard (deviazione standard campionaria) <varianza-standard>

È possibile applicare alla varianza campionaria la radice quadrata, ottenendo la *varianza campionaria standard*. Questo è utile per portare la varianza nella stessa _unità di misura_ dei dati del campione

$ s = sqrt(s^2) $

#attenzione[
  Applicando la radice quadrata solo dopo l'elevamento a potenza, non abbiamo reintrodotto il problema dei valori negativi: $sqrt(a^2) quad != quad (sqrt(a))^2 = a$
]

=== Coefficiente di variazione (deviazione standard relativa)

Valore *adimensionale*, utile per confrontare misure di fenomeni con _unità di misura differenti_.

$ s^* = s / (|overline(x)|) $

#nota[
  Sia la #link(<varianza-standard>)[varianza campionaria standard] che la #link(<media>)[media campionaria] sono dimensionali, ovverro hanno unità di misura. Dividendoli tra loro otteniamo un valore adimensionale
]

=== Altri indici di dispersione

/ Intervallo di varianzione: differenza tra il _più grande_ e il _più piccolo_ valore del campione

/ Scarto interquartile: lunghezza dell'intervallo in cui è presente la _metà centrale dei dati_, ovvero la differenza tra il _25-esimo_ e il _75-esimo_ percentile

== Indici di correlazione

/ Campione bivariato: campione formato da coppie ${ (x_1, y_1), ..., (x_n, y_n) }$

/ Relazione/Correlazione: relazione tra due variabili tale che a ciascun valore della prima corrisponda un valore della seconda seguendo una certa regolarità
  - *diretta*: a _piccoli_ valori di $x$ corrispondono _piccoli_ valori di $y$ e viceversa
  - *indiretta*: a _piccoli_ valori di $x$ corrispondono _grandi_ valori di $y$ e viceversa

=== Covarianza campionaria <covarianza>

È un valore numerico che fornisce una misura di quanto le due variabili _varino assieme_.
Dato un campione bivariato definiamo la *covarianza campionaria* come:

$ "Cov"(x, y) = 1/(n-1)sum_(i=1)^n (x_i-overline(x))(y_i-overline(y)) $

#nota[
  Si divide per $n-1$ per lo stesso motivo della _varianza_: la #link(<bessel>)[correzione di Bessel]
]

Metodo alternativo di calcolo:

$ "Cov"(x, y) = 1/(n-1)sum_(i=1)^n (x_i y_i - n overline(x y)) $

#dimostrazione[
  - *diretta*: _piccoli con piccoli_ e _grandi con grandi_
  $ (x_i <= overline(x) and y_i <= overline(y)) or (x_i > overline(x) and y_i > overline(y)) $
  da cui:
  - $ x_i - overline(x) <= 0 and y_i - overline(y) <= 0 quad => quad (x_i - overline(x))(y_i - overline(y)) >= 0 $
  - $ x_i - overline(x) > 0 and y_i - overline(y) > 0 quad => quad (x_i - overline(x))(y_i - overline(y)) > 0 $
  quindi in entrambi i casi: $ (x_i - overline(x))(y_i - overline(y)) >= 0 $

  - *indiretta*: _piccoli con grandi_ e _grandi con piccoli_
  $ (x_i <= overline(x) and y_i >= overline(y)) or (x_i > overline(x) and y_i < overline(y)) $
  da cui:
  - $ x_i - overline(x) <= 0 and y_i - overline(y) >= 0 quad => quad (x_i - overline(x))(y_i - overline(y)) <= 0 $
  - $ x_i - overline(x) > 0 and y_i - overline(y) < 0 quad => quad (x_i - overline(x))(y_i - overline(y)) < 0 $
  quindi in entrambi i casi: $ (x_i - overline(x))(y_i - overline(y)) <= 0 $

  Quindi dal osservando _il segno_ è possibile capire la _relazione_ del campione.
]

- $"Cov"(x, y) > 0$ probabile correlazione diretta
- $"Cov"(x, y) tilde.eq 0$ correlazione improbabile
- $"Cov"(x, y) < 0$ probabile correlazione indiretta

#figure(caption: [Correlazione lineare _diretta_ (sinistra) e _indiretta_ (destra)],
[
  #box(cetz.canvas({
    import cetz: *

    plot.plot(
      size: (4,4),
      x-tick-step: 2,
      y-tick-step: 2,
      axis-style: "school-book",
      {
        plot.add(((-5,-5), (5,5)), style: (stroke: 2pt + red))
        plot.annotate(draw.circle((0, 0), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((0.37, 0.4), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((1, 1.2), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-1, -1.5), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((2, 2.4), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-2, -2.2), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((3, 3.6), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-3, -3.3), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((4, 4.8), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-4, -4.4), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((0.5, 0.6), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-0.8, -1.0), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((1.5, 1.3), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-1.7, -1.8), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((2.5, 2.7), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-2.6, -2.4), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((3.3, 3.9), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-3.5, -3.1), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((4.2, 4.6), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-4.3, -4.7), fill: gray, radius: 0.2))
    })
  }))
  #box(cetz.canvas({
    import cetz: *

    plot.plot(
      size: (4,4),
      x-tick-step: 2,
      y-tick-step: 2,
      axis-style: "school-book",
      {
        plot.add(((-5,5), (5,-5)), style: (stroke: 2pt + red))
        plot.annotate(draw.circle((0, 0), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((0.4, -0.5), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((1.2, -1.5), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-1.5, 1.8), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((2.3, -2.6), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-2.4, 2.2), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((3.6, -3.8), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-3.8, 3.5), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((4.7, -4.3), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-4.5, 4.2), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((0.2, -0.2), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-0.6, 0.7), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((1.3, -1.1), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-1.8, 2.0), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((2.7, -2.9), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-2.9, 2.6), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((3.8, -4.0), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-4.0, 3.7), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((4.3, -4.5), fill: gray, radius: 0.2))
        plot.annotate(draw.circle((-4.7, 4.4), fill: gray, radius: 0.2))
    })
  }))
])

#nota[
  Una relazione diretta/indiretta non è necessariamente _lineare_, può essere anche _logaritmica_ o seguire altre forme
]

=== Indice di correlazione di Pearson (indice di correlazione lineare) <correlazione-lineare>

Utilizziamo l'indice di correlazione di Pearson per avere un valore _adimensionale_ che esprime una correlazione. Possiamo definirlo anche come una _misura normalizzata_ della covarianza nell'intervallo $[-1, +1]$.

$ rho(x,y) = 1/(n-1)(limits(sum)_(i=1)^n (x_i-overline(x))(y_i-overline(y)))/(s_x s_y) $

Dove $s$ è la varianza campionaria standard.

- $rho tilde.eq +1$ probabile correlazione linearmente diretta
- $rho tilde.eq 0$ correlazione improbabile
- $rho tilde.eq -1$ probabile correlazione linearmente indiretta

#attenzione[
  L'#link(<correlazione-lineare>)[indice di correlazione lineare] ($rho$) cattura *solo* relazioni dirette/indirette _lineari_ ed è insensibile alle trasformazioni lineari
]

#attenzione[
   La #link(<covarianza>)[covarianza campionaria] o l'#link(<correlazione-lineare>)[indice di correlazione lineare] $tilde.eq 0$ non implicano l'indipendenza del campione, ma è vero il contrario:
  $ "Cov"(x, y) tilde.eq 0 quad arrow.r.double.not quad "Indipendenza" $
  $ rho(x, y) tilde.eq 0 quad arrow.r.double.not quad "Indipendenza" $
  $ "Indipendenza" quad arrow.r.double quad rho(x, y) tilde.eq "Cov"(x, y) tilde.eq 0 $
]

Formula alternativa:
$ rho = (limits(sum)_(i=1)^n x_i y_i - n overline(x) overline(y)) / (sqrt((limits(sum)_(i=1)^n x_i^2 - n overline(x)^2) (limits(sum)_(i=1)^n y_i^2 - n overline(y)^2))) $

== Indici di eterogeneità <eterogeneita>

Non ha senso analizzare concentrazione o dispersione per dati #link(<quantitativi>)[qualitativi], ma possiamo analizzare l'eterogeneità:

/ Massima eterogeneità: il campione è composto da tutti elementi _diversi_
/ Minima eterogeneità: il campione contiene solo elementi _uguali_ (campione _omogeneo_)

=== Indice di Gini (per l'eterogeneità) <gini>

$ I = 1 - sum_(i=1)^n f_i^2 $

Dove $f_i$ è la #link(<frequenze>)[frequenza relativa] di $i$ ed $n$ è il numero di elementi distinti. Quindi $forall i, 0 <= f_i <= 1$. Prendiamo in considerazione i due estremi:

- eterogeneità _minima_ (solo un valore con frequenza relativa 1): $ I = 1 - 1 = 0 $
- eterogeneità _massima_ (tutti i valori hanno la stessa frequenza relativa $1/n$ dove $n$ è la dimensione del campione): $ I = quad 1 - sum_(i=1)^n (1/n)^2 quad =  quad 1 - n/n^2 quad = quad (n-1)/n $

Generalizzando, $I$ non raggiungerà mai $1$: $ 0 <= I <= (n-1)/n < 1 $

Dal momento che l'indice di Gini tende a $1$ senza mai arrivarci ($n-1$ è sempre minore di $n$) introduciamo l'*indice di Gini normalizzato*, in modo da arrivare a $1$ nel caso di eterogeneità massima, con dominio $[0, 1]$: $ I' = n/(n-1)I $

=== Entropia <entropia>

$ H = quad sum_(i=1)^n f_i log(1/f_i) quad = quad - sum_(i=1)^n f_i log(f_i) $

Dove $f_i$ è la #link(<frequenze>)[frequenza relativa] e $n$ è il numero di elementi distinti.
L'entropia assume valori nel range $[0, log(n)]$ quindi utilizziamo l'*entropia normalizzata* per confrontare due misurazioni con diverso numero di elementi distinti $n$.

$ H' = 1/log(n) H $

#nota[
  In base alla base del logaritmo utilizzata, l'entropia avrà unità di misura differente:
  - $log_2$: bit
  - $log_e$: nat
  - $log_10$: hartley
]

#informalmente[
  Intuitivamente sia l'#link(<gini>)[indice di Gini] che l'#link(<entropia>)[entropia] sono una _"media pesata"_ tra la frequenza relativa di ogni elemento ed un peso: la _frequenza stessa_ nel caso di Gini e il _logaritmo del reciproco_ nell'entropia. La frequenza relativa è già nel range $[0, 1]$, quindi non c'è bisogno di dividere per il numero di elementi
]

== Indici di concentrazione

Un indice di concentrazione misura in che modo un _bene_ è distribuito nella _popolazione_.

/ Distribuzione del bene: $a_1, a_2, ... a_n$ indica la quantità ordinata in modo *non decrescente*, del bene posseduta dall'individuo $i$
/ Media: $overline(a)$ indica la quantità media posseduta da un individuo
/ Totale: $"TOT" = n overline(a)$ indica il totale del bene posseduto
/ Caso sperequo: concentrazione _massima_, un individuo possiete tutta la quantità $ a_(1..n-1) = 0, quad a_n = n overline(a) $
/ Caso equo: concentrazione _minima_, tutti gli individui possiedono la stessa quantità $ a_(1..n) = overline(a) $

=== Curva di Lorentz <lorenz>

La curva di Lorenz è una rappresentazione *grafica* della _distribuzione_ di un bene nella popolazione.

Dati:
- $F_i = i/n$: posizione percentuale dell'i-esima nell'insieme
- $Q_i = 1/"TOT" limits(sum)_(k=1)^i a_k$: quantità di bene cumulata fino all'i-esima osservazione

La tupla $(F_i, Q_i)$ indica che il $100 dot F_i%$ degli individui detiene il $100 dot Q_i%$ della quantità totale.

Inoltre: $forall i, space 0 <= Q_i <= F_i <= 1$.

#informalmente[
  Possiamo vedere $F_i$ come _"quanta"_ popolazione è stata analizzata fino all'osservazione $i$, espressa nel range $[0, 1]$.
  $Q_i$ è invece una #link(<frequenze>)[_"frequenza cumulata"_] della ricchezza, fino all'osservazione $i$
]

#figure(caption: [Curva di Lorentz],
  cetz.canvas({
    import cetz: *

    plot.plot(
      name: "lorentz",
      size: (4,4),
      x-tick-step: 1,
      y-tick-step: 1,
      axis-style: "school-book",
      {
        plot.add(((0,0), (1,1)), line: "spline", style: (stroke: 2pt + green), label: "Minima")
        plot.add(((0,0), (0.6, 0.2), (1,1)), line: "spline", style: (stroke: 2pt + orange), label: "Media")
        plot.add(((0,0), (0.98,0)), line: "spline", style: (stroke: 2pt + red), label: "Massima")
        plot.add-anchor("11", (1,1))
        plot.add-anchor("10", (1,0))
    })
    draw.circle("lorentz.11", fill: red, stroke: none, radius: .1)
    draw.circle("lorentz.10", fill: white, stroke: red, radius: .1)
  })
)

=== Indice di Gini (per la concentrazione)

Dato che la #link(<lorenz>)[curva di Lorenz] _non assume mai_ alcun valore nella parte di piano superiore alla _bisettrice_, allora introduciamo l'*indice di Gini*, che trasforma la rappresentazione grafica in un _indice numerico_ che assume valori nel range $[0, 1]$.

Anche esso indica la _concetrazione_ di un bene nella popolazione.

$ G = (limits(sum)_(i=1)^(n-1) F_i - Q_i) / (limits(sum)_(i=1)^(n-1) F_i) $

#nota[
  È possibile riscrivere il denominatore come:
  $ sum_(i=1)^(n-1) F_i quad = quad 1/n sum_(i=1)^(n-1) i quad = quad 1/cancel(n) (cancel(n)(n-1))/2 quad = quad (n-1) / 2 $
]


Ottendendo come formula alternativa:

$ G = 2 / (n-1) sum_(i=1)^(n-1) F_i - Q_i $

#informalmente[
  Facendo un parallelo con la #link(<lorenz>)[curva di Lorenz], possiamo vedere $F_i - Q_i$ come la distanza tra la bisettrice ($F_i$) e la ricchezza dell'osservazione $i$ ($Q_i$). La somma di queste distanze viene poi _"normalizzata"_, dividendo per $(n-1) / 2$
]

=== Analisi della varianza (ANOVA)

L'analisi della varianza (*ANOVA* - ANalysis Of VAriance) permette di analizzare un campione suddiviso in due o più _gruppi_ e capire se ci sono sostanziali differenze di un'attributo nei vari gruppi.

#informalmente[
  Ad esempio, dato un campione di dati sulla _natalità_, si potrebbe analizzare formando gruppi per _regione_ o per _reddito_ e cercare l'influenza di questi fattori sulla natalità stessa
]

/ Numerosità dei gruppi: dato un campione diviso in $G$ gruppi, ognuno ha numerosità $n_1, ..., n_G$
/ Numerosità totale: numero totale delle osservazioni $n_1 + ... + n_G = n$
/ Osservazione: viene definita $x_i^g$ come l'$i$-esima osservazione del $g$-esimo gruppo

Possiamo calcolare alcuni indici e analizzarne i risultati:

/ Media campionaria di tutte le osservazioni: la media del campione $ overline(x) = 1/n sum_(g=1)^G  sum_(i=1)^n_g x_i^g $

/ Media campionaria di un gruppo: la media dei valori del gruppo $ overline(x)_g = 1/n_g sum_(i=1)^n_g x_i^g $

/ Somme degli scarti:

  - Somma *totale* degli scarti (tra _ogni elemento_ e la _media di tutto il campione_): $ "SS"_T = sum_(g=1)^G sum_(i=1)^n_g (x_i^g - overline(x))^2 $
  - Somma degli scarti *entro/within* i gruppi (tra _ogni elemento_ e la _media del proprio gruppo_): $ "SS"_W = sum_(g=1)^G sum_(i=1)^n_g (x_i^g - overline(x)^g)^2 $
  - Somma degli scarti *tra/between* i gruppi (tra la _media di ogni gruppo_ e _la media del campione_, "pesato" per la _numerosità_ del gruppo): $ "SS"_B = sum_(g=1)^G n_g (overline(x)^g - overline(x))^2 $

Vale la seguente regola: $"SS"_T = "SS"_W + "SS"_B$.

/ Varianza:

  - *Total* (la varianza totale del campione): $ s_T^2 = ("SS"_T)/(n-1) $
  - *Within* (la varianza di ogni elemento del gruppo): $ s_W^2 = ("SS"_W)/(n-G) $
  - *Between* (la varianza tra ogni gruppo e il campione completo): $ s_B^2 = ("SS"_B)/(G-1) $

L'ipotesi alla base è che dati $G$  gruppi, sia possibile scomporre la varianza in due componenti: _Varianza interna ai gruppi_ (varianza *Within*) e _Varianza tra i gruppi_ (varianza *Between*).

#informalmente[
  Analizzando diversi gruppi attraverso l'ANOVA, si possono raggiungere due conclusioni:
  - i gruppi risultano significativamente *diversi* tra loro: la _varianza between_ $s_W^2$ contribuisce più significativamente alla varianza totale $s_T^2$ (il fenomeno è legato a caratteristiche proprie di ciascun gruppo)
  - i gruppi risultano *omogenei*: la _varianza within_ $s_W^2$ contribuisce più significativamente alla varianza totale $s_T^2$ (il fenomeno è legato a caratteristiche proprie di tutti i gruppi)
]

== Alberi di decisione

Un albero di decisione è un *classificatore* (ovvero un processo che assegna una classe ad un oggetto) che sfrutta gli indici di #link(<eterogeneita>)[eterogeneità] per costruire la propria struttura efficacemente. Sono composti da:
- *nodi interni*: domanda sull'osservazione _(anche su più attributi)_ con risposta binaria
- *foglie*: classe a cui l'oggetto viene assegnato

Le domande vengono scelte e valutate in base all'_omogenetità_ dei _sottoinsiemi_ creati da essa, più i gruppi sono omogenei, _migliore_ è la domanda.

== Analisi dei classificatori

Dato un _classificatore binario_ che divide in due classi (positiva e negativa) e un _insieme di oggetti_ di cui è *nota* la classificazione, possiamo valutare la sua _bontà_ tramite il numero di casi classificati in modo _errato_. La classificazione errata può essere:
- *falso negativo*: oggetto _positivo_ classificato come _negativo_
- *falso positivo*: oggetto _negativo_ classificato come _positivo_

#nota[
  Il peso di un falso positivo può *non* essere lo stesso di un falso negativo, si pensi al caso di una malattia contagiosa: un _falso negativo_ (ignaro della malattia) sarà molto più pericoloso di un _falso positivo_ (che verrà scoperto con ulteriori analisi)
]

Introduciamo la *matrice di confusione*, che riassume la bontà del classificatore:

#figure(caption: [Matrice di confusione])[
  #table(
    columns: 5,
    inset: 10pt,
    align: horizon,

    table.cell(colspan: 2, rowspan: 2, stroke: none, []),
    table.cell(colspan: 2, fill: silver, [*Valore effettivo*]),
    table.cell(rowspan: 2, stroke: none, []),

    [Positivo],
    [Negativo],

    table.cell(rowspan: 2, fill: silver, [*Predizione del classificatore*]),

    [Positivo],
    [Veri positivi (VP)],
    [Falsi positivi (FP)],
    [_Totali classificati positivi (TOT CP)_],

    [Negativo],
    [Falsi negativi (FN)],
    [Veri negativi (VN)],
    [_Totali classificati negativi (TOT CN)_],

    table.cell(colspan: 2, stroke: none,  []),
    [_Totale positivi (TP)_],
    [_Totale negativi (TN)_],
    [_Totale casi (TOT casi)_],
  )
]

/ Sensibilità: capacità del classificatore di predire bene i positivi $"VP"/"TP"$
/ Specificità: capacità del classificatore di predire bene i negativi $"VN"/"TN"$

È possibile valutare la *bontà* di un classificatore _graficamente_ attraverso il _punto_:

$ (1 - "Specifità", "Sensibilità") quad = quad (1 - "VN"/"TN", "VP"/"TP") quad = quad ("FP"/"TN", "VP"/"TP") $

=== Casi particolari

/ Classificatori costanti: associano indiscriminatamente gli oggetti ad una classe (positiva o negativa)
/ Classificatore positivo (CP): tutti i casi sono classificati come positivi
  - _Sensibilità_: $1$, _Specificitià_: $0$, _Punto_ $(1,1)$ #box(circle(radius: 2.5pt, fill: green, stroke: 1pt + black))
/ Classificatore negativo (CN): tutti i casi sono classificati come negativi
  - _Sensibilità_: $0$, _Specificitià_: $1$, _Punto_ $(0, 0)$ #box(circle(radius: 2.5pt, fill: red, stroke: 1pt + black))
/ Classificatore ideale (CI): tutti i casi sono classificati correttamente
    - _Sensibilità_: $1$, _Specificitià_ $1$, _Punto_ $(0,1)$ #box(circle(radius: 2.5pt, fill: blue, stroke: 1pt + black))
/ Classificatore peggiore (CE): tutti i casi sono classificati erroneamente
    - _Sensibilità_: $0$, _Specificitià_ $0$, _Punto_ $(1, 0)$ #box(circle(radius: 2.5pt, fill: gray, stroke: 1pt + black))
/ Classificatore casuale: ogni caso viene assegnato in modo casuale
    - _Sensibilità_: $0.5$, _Specificitià_ $0.5$, _Punto_ $(1/2, 1/2)$ #box(circle(radius: 2.5pt, fill: yellow, stroke: 1pt + black))

#figure(caption: [Rappresentazione classificatori],
  cetz.canvas({
    import cetz: *

    plot.plot(
      name: "classificatori",
      size: (4,4),
      x-tick-step: 0.5,
      y-tick-step: 0.5,
      axis-style: "school-book",
      {
        plot.add(((0,0), (1,1)), style: (stroke: silver))
        plot.add-anchor("00", (0,0))
        plot.add-anchor("11", (1,1))
        plot.add-anchor("01", (0,1))
        plot.add-anchor("10", (1,0))
        plot.add-anchor("55", (0.5,0.5))
    })

    draw.circle((0, 0), fill: red, radius: .1)
    draw.circle((4, 4), fill: green, radius: .1)
    draw.circle((0, 4), fill: blue, radius: .1)
    draw.circle((4, 0), fill: gray, radius: .1)
    draw.circle((2, 2), fill: yellow, radius: .1)
    draw.content("classificatori.00", [*Negativo*], anchor: "south-west", padding: .2)
    draw.content("classificatori.11", [*Positivo*], anchor: "west", padding: .2)
    draw.content("classificatori.01", [*Ideale*], anchor: "west", padding: .2)
    draw.content("classificatori.10", [*Peggiore*], anchor: "south", padding: .3)
    draw.content("classificatori.55", [*Casuale*], anchor: "west", padding: .2)
  }))

Un classificatore è tanto più efficace quanto più si avvicina al classificatore ideale.

#attenzione[
  Il classificatore peggiore è, in realtà, un classificatore ideale: basta invertirlo
]

=== Classificatori a soglia (Curva ROC)

Un classificatore a soglia discrimina un caso in base ad una *soglia* stabilita a priori, in caso la misurazione sia _superiore_ alla soglia allora verrà classificato _positivamente_, altrimenti _negativamente_.

Per trovare il valore con cui _fissare_ la soglia, possiamo sfruttare questo metodo:

- definiamo $theta$ come una generica soglia, che ha intervallo $[theta_min, theta_max]$
  - utilizzando $theta_min$ tutti i casi saranno positivi, ottenento un classificatore positivo #box(circle(radius: 2.5pt, fill: green, stroke: 1pt + black))
  - utilizzando $theta_max$ tutti i casi saranno negativi, ottenento un classificatore negativo #box(circle(radius: 2.5pt, fill: red, stroke: 1pt + black))
- definiamo $D$ come una discretizzazione di questo intervallo continuo

Per ogni soglia $theta in D$ è possibile calcolare la _sensibilità_ e _specificità_. Questo classificatore viene quindi _rappresentato_ sul piano cartesiano attraverso il _punto_ $(1 - "Specifità", "Sensibilità")$.

Il risultato è una *curva*, detta *ROC* (Receiver Operator Carapteristic) #box(line(length: 10pt, stroke: 2pt + red), inset: (bottom: 3pt)), che ha sempre come estremi in $(0,0)$ (caso in cui viene usato $theta_max$) e $(1,1)$ (caso in cui viene usato $theta_min$).

Per misurare la _bontà_ del classificatore (in modo _indipendente_ dalla soglia scelta) viene misurata l'area di piano sotto la curva (*AUC* - Area Under the ROC Curve #box(rect(height: 7pt, width: 15pt, fill: rgb("#FFCDD2")))), più si avvicina a $1$, _migliore_ è il classificatore.

#figure(caption: [Curva ROC],
  cetz.canvas({
    import cetz: *

    plot.plot(
      name: "curvaroc",
      size: (4,4),
      x-tick-step: 0.5,
      y-tick-step: 0.5,
      axis-style: "school-book",
      fill-below: true,
      {
        plot.add(((0,0), (1,1)), style: (stroke: silver))
        plot.add(((0,0), (0.01, 0.05), (0.05, 0.3), (0.1, 0.5), (0.15, 0.6), (0.3, 0.8), (0.4, 0.85), (0.7, 0.92), (0.8, 0.94), (0.90, 0.97), (1,1)), style: (stroke: 2pt + red, fill: rgb("#FFCDD2")), fill: true, fill-type: "axis")
        plot.add-anchor("00", (0,0))
        plot.add-anchor("11", (1,1))
        plot.add-anchor("01", (0,1))
        plot.add-anchor("10", (1,0))
        plot.add-anchor("55", (0.5,0.5))
    })

    draw.circle((0, 0), fill: red, radius: .1)
    draw.circle((4, 4), fill: green, radius: .1)
    draw.circle((0, 4), fill: blue, radius: .1)
    draw.circle((4, 0), fill: gray, radius: .1)
    draw.circle((2, 2), fill: yellow, radius: .1)
    draw.content("curvaroc.00", [*Negativo*], anchor: "south-west", padding: .2)
    draw.content("curvaroc.11", [*Positivo*], anchor: "west", padding: .2)
    draw.content("curvaroc.01", [*Ideale*], anchor: "west", padding: .2)
    draw.content("curvaroc.10", [*Peggiore*], anchor: "south", padding: .3)
    draw.content("curvaroc.55", [*Casuale*], anchor: "west", padding: .2)
  }))

#attenzione[
  La curva è "spezzettata" dato che le soglie provate sono un _numero finito_, una discretizzazione dell'intervallo $[theta_min, theta_max]$
]

#informalmente[
  Per trovare la _soglia migliore_, proviamo diversi valori della soglia $theta$, calcoliamo per ognuna il punto sul piano e teniamo la _migliore_.

  I diversi tentativi disegnano la _curva ROC_, maggiore è l'_area sotto la curva AUC_, migliore è il _classificatore_ (indipendentemente dalla soglia scelta)
]

#nota[
  Un _caso particolare _dei classificatori a soglia sono i *classificatori probabilistici*, dove la quantità assegnata agli oggetti (il valore con cui viene confrontata la soglia) è la _probabilità_ di appartenere ad una data _classe_
]

== Trasformazione dei dati

Dato un insieme di dati $X = {x_1, ..., x_n}$, trasformare significa trovare una funzione $g : X -> X'$ che trasforma $X$ in $Y = {x_1', ..., x_n'}$, dove $g(x_i) = x_i'$.

#attenzione[
  La funzione $g$ che effettua la trasformazione *deve* essere *iniettiva*, altrimenti più dati distinti potrebbero essere mappati sullo stesso valore, causando una modifica alle frequenze
]

=== Trasformazioni lineari

Date due costanti $a, b in bb(R)$, allora $g(x) = a x + b$, da cui possiamo derivare:

/ Cambiamento di origine (traslazione):
  - per $k>0$, viene traslata a sinistra con $x -> x - k$ e a destra con $x -> x + k$
  - _media_, _mediana_ e _quantili_ vengono traslati della stessa quantità
  - _range_, _distanza interquartile_, _varianza_, _deviazione standard_ rimangono invariati

/ Cambiamento di scala (dilatazione o concentrazione):
  - per $h in bb(R)^+$, applichiamo $x -> x/h$:
    - se $h > 1$ allora è una concentrazione
    - se $h < 1$ allora è una dilatazione
    - se $h < x_min$ allora $forall x_i > 1$
    - se $h > x_max$ allora $forall x_i < 1$
  - _media_, _mediana_, _quantili_, _range_, _distanza interquartile_ e _deviazione standard_ vengono scalati della stessa quantità $1/h$
  - _varianza_ viene scalata di $1/(h^2)$

/ Cambiamento di origine e scala: se i nostri valori sono nel _range_ $(a,b)$ e li vogliamo nell'_intervallo_ $(c, d)$ allora possiamo:
  $ x -> c + (d-c)/(b-a) (x-a) $

/ Standardizzazione: caso particolare del cambiamento di origine e scala: si scala rispetto alla _deviazione standard_ e si trasla a sinistra rispetto alla _media_, in modo da ottenere un insieme di _media_ $0$ e _deviazione_ $1$:
  $ x -> (x - overline(x))/(sigma_x) $

#figure(caption: "Effetti delle trasformazioni sugli indici")[
  #table(
    columns: 4,
    inset: 10pt,
    align: horizon,

    table.cell(colspan: 2, fill: silver, [*Indice*]),
    table.cell(fill: silver, [$g(x) = x + k$]),
    table.cell(fill: silver, [$g(x) = h x$]),

    [Media], [$overline(x)$], [$overline(x) + k$], [$h overline(x)$],
    [Mediana], [$m_x$], [$m_x + k$], [$h m_x$],
    [Moda], [$M_x$], [$M_x + k$], [$h M_x$],
    [Quantile], [$q_x$], [$q_x + k$], [$h q_x$],
    [Varianza], [$s^2_x$], [$s^2_x$], [$h^2 s^2_x$],
    [Dev. std.], [$s_x$], [$s_x$], [$|h| s_x$],
    [Range], [$r_x$], [$r_x$], [$h r_x$],
    [IQR], [$"IQR"_x$], [$"IQR"_x$], [$h "IQR"_x$],
  )
]

=== Trasformazioni logaritmiche

Quando i valori di un campione sono molto grandi oppure molto distanti è possibile trasformali in maniera logaritmica: $x -> log x$

#nota[
  Può risultare utile anche perchè eventuali prodotti/quozienti diventano somme/sottrazioni tra i rispettivi logaritmi
]

== Grafici

=== Diagramma a barre

Rappresenta graficamente la _tabella delle frequenze_, è opportuno utilizzarlo in caso di *attributi qualitativi non ordinati*.

L'uso delle _frequenze relative_ permette di confrontare situazioni in cui il numero di osservazioni è variabile, quindi ha senso sovrapporre grafici di campioni diversi.

Si utilizza per gli indici (asse delle x) con attributo qualitativo ma non ordinato.

```python
publisher_order = ['Hanna-Barbera', 'ABC Studios', 'Dark Horse Comics',
                   'Image Comics', 'Marvel Comics', 'DC Comics',
                   'George Lucas', 'Rebellion',
                   'Star Trek', 'Universal Studios']
publisher_rel_freq.loc[publisher_order,:].plot.bar(legend=False)
plt.show()
```
#nota[
- Se utilizzo plot.bar su value.counts ottengo un ordinamento non crescente sulle frequenze
- Se utilizzo plot.bar sul dataframe ottengo un ordinamento in base ai valori e una legenda dell'asse delle ascisse (che si puo togliere con legend=False)
]

=== Aerogramma (grafico a torta)

Grafico alternativo per le frequenze dei valori qualitativi

```python
gender_freq.plot.pie(y='Abs. frequence', colors=['pink', 'blue'])
plt.show()
```

=== Istogramma

Per rappresentare graficamente le tabelle delle frequenze di dati quantitativi, usiamo ancora ``` plot.bar```
Tuttavia è molto probabile che il risultato non sia ottimale in quanto le barre hanno uno spessore che puo suggerire un interpretazione fuorviante secondo cui le frequenze non facciano riferimento ad un anno ma a un intervallo.

```python
first_app_freq = heroes_with_year['First appearance'].value_counts()
plt.bar(first_app_freq.index, first_app_freq.values)
plt.show()
```

Si utilizza in questi casi un grafico a bastoncini in cui ogni punto è evidenziato da un segmento verticale che lo congiunge con l'asse delle ascisse. Lo si genera con ``` plt.vlines(listaIndici, yiniziale, listaValori)```.
Eventualmente si puo sovrapporre con un ``` plt.plot``` che rappresenta un cerchio.

```python
plt.vlines(first_app_freq.index, 0, first_app_freq.values)
plt.show()
```

Ulteriore problema che ricorre spesso nei dati quantitativi sono i numerosi valori distinti per un valore piccolissimo (ad esempio tra 81.01 e 81).
Risulta piu sensato calcolare le frequenze di intervalli di possibili valori, aggregando quindi i valori ma non sarebbe corretto perché daremmo l'impressione che un certo valore ha una frequenza alta.

Alcuni insiemi hanno troppi valori distinti per poter usare il metodo del grafico poligonale/a barre. Suddividiamo i valori in gruppi/classi e poi rappresentiamo con un grafico il numero di valori dei dati appartenenti a ciascuna classe.

Come scegliere li numero di classi:
- Se troppo poche classi perdo molte informazioni sui valori effettivi
- Se troppe classi ottengo frequenze troppo basse per ottenere delle informazioni dal grafico
Di solito si scelgono tra le 5 e le 10 classi. È prassi scegliere classi della stessa lunghezza.
I valori al bordo di una classe di chiamano estremi della classe.

Convenzione di inclusione a sinistra: classe include il suo estremo sinistro ma non quello destro.

Utilizziamo quindi un istogramma, generabile con ``` .hist()```.

Come argomento a hist possiamo specificare i bins, cioe i sotto intervalli espressi o come differenza tra gli intervalli.

``` .hist()``` in modo automatico raggruppa i dati, calcola le frequenze e le rappresenta.

es ``` bins=50``` oppure come con ``` np.stack((np.arange(0, 200, 20)), …)``` posso specificare gli intervalli.

- ``` np.hstack``` permette di giustapporre due o piu array numpy
- ``` np.arange``` permette di creare un array con valori che variano tra i primi due argomenti secondo il terzo argomento

```python
heroes['Weight'].hist(bins=50)
plt.show()
heroes['Weight'].hist(bins=np.hstack((np.arange(0, 200, 20),
                                      np.arange(200, 500, 50),
                                      np.arange(500, 1000, 100))))
plt.show()
```

#nota[
  Nell'istogramma è l'area di ogni barra a essere legata alla frequenza. Se le barre hanno basi della stessa lunghezza, le aree sono proporzionali all'altezza
]

=== Diagramma di Pareto

// TODO: diagramma di pareto (catu pagina frequenze congiunte e marginali)
Le frequenze assolute/relative e cumulate di una variabile categorica possono essere considerate congiuntamente generando un diagramma di Pareto, ordinando i dati per frequenza decrescente su uno stesso sistema di riferimento in cui l'asse delle ascisse fa riferimento ai valori.
In questo sistema si sovrappongono il diagramma a barre delle frequenze assolute/relative e la linea spezzata he collega i valori delle frequenze cumulate

```python
eye_color = heroes['Eye color']
eye_color_freq = eye_color.value_counts(normalize=True)
eye_color_freq[eye_color_freq>.02].cumsum().plot()
eye_color_freq[eye_color_freq>.02].plot.bar()
plt.show()
```

La linea spezzata non arriva sempre all'ordinata 1 (considerando le frequenze relative) in quanto consideriamo solo un sottoinsieme dei dati dato il possibile gran numero di dati con una frequenza bassa e quindi trascurabile.

Voglio pero considerare un sottoinsieme del mio campione, per avere una risposta succinta non considero quindi tutti i valori distinti il cui numero potrebbe essere molto elevato ma con molti valori con una frequenza relativa trascurabile.

Per far arrivare il diagramma di Pareto fino all'ordinata unitaria si attua una normalizzazione in particolare dividiamo tutte le frequenze per la sommatoria.

La normalizzazione tipicamente si ottiene:
- dividendo per la somma, in modo che i dati trasformati hanno somma 1
- dividere per il massimo, in modo che i dati trasformati siano < 1

```python
norm_eye_color_freq = eye_color_freq[eye_color_freq>.02]/sum(eye_color_freq[eye_color_freq>.02])
norm_eye_color_freq.cumsum().plot()
norm_eye_color_freq.plot.bar()
plt.show()
```

In generale un diagramma di Pareto permette di identificare gli elementi piu rilevanti in termini di frequenze all'interno di un insieme di osservazioni.

Tuttavia dobbiamo considerare che non stiamo tenendo in considerazione tutte le osservazioni, considerandole tutte scirebbe un grafico poco leggibile.

```python
def my_pareto(data, threshold=0.02, renormalize=False):
    freq = data.value_counts(normalize=True)
    freq = freq[freq > threshold]
    if renormalize:
        freq = freq / sum(freq)
    freq.cumsum().plot()
    freq.plot.bar()
my_pareto(heroes['Eye color'], threshold=0)
```

=== Box plot

// TODO: boxplot (catu pagina coefficienti di variazione)
È possibile visualizzare un campione attraverso un *box plot*, partendo dal basso composto da:
- eventuali _outliers_, rappresentati con le `x` prima del baffo
- il _baffo_ "inferiore", che parte dal valore minimo e raggiunge il primo quartile
- il _box_ (scatola), che rappresenta le osservazioni comprese tra il primo e il terzo quartile
- la linea che divide in due il box, che rappresenta la _mediana_
- il _baffo_ "superiore", che parte terzo quartile e raggiunge il massimo
- eventuali _outliers_ "superiori", rappresentati con le `x` dopo il baffo

#figure(caption: [Grafico boxplot],
  cetz.canvas({
    import cetz: *
    plot.plot(size: (4,4), x-tick-step: none, y-tick-step: none, {
      plot.add-boxwhisker((
        x: 1,
        outliers: (7, 65, 69),
        min: 20, max: 60,
        q1: 25,
        q2: 33,
        q3: 50))
    })
  })
)

Il box plot permette di evidenziare la centralità delle osservazioni e la loro dispersione in termini di range interquartile (L'estensione della box) e di intervallo di variazione dei dati / range, definito come la distanza tra MAX e MIN

```python
year.plot.box(whis='range')
plt.show()
```

#nota[
 Di default il box plot analizza ed esclude gli outlier, per evitare cioe specifichiamo l'argomento whis='range'. Un valore è un outlier se la sua distanza dalla mediana è più di una costante moltiplicata per il range interquartile. Per visualizzare il box plot in modo orizzontale usiamo vert=False
]

=== Simmetria

=== Q-Q plot

// TODO: diagrammi Q-Q (catu pagina indici di eterogeneità)
Un diagramma Q-Q / Quantile-Quantile è una rappresentazione grafica utilizzata per verificare se due campioni seguano una medesima distribuzione.

Ogni asse lo associo con un campione, segnando i punti come incontro dei due percentili. Prendendo come riferimento la bisettrice del primo e del terzo quadrante, se i punti sono vicini ad essa, allora posso dire che la popolazione è plausibilmente la stessa
Questi diagrammi si basano sul fatto che i quantili campionari rappresentano l'approssimazione di quantili teorici che considerandoli tutti individuano univocamente la distribuzione dei dati.

Se due campioni hanno un'uguale distribuzione allora estraendo da entrambi il quantile di un livello si dovranno ottenere due numeri molto vicini.

Oltre a mostrare il comportamento relativo di due variabili ed aiutarci nella rappresentazione, è utile per riconoscere i valori anomali/outliner.

```python
import statsmodels.api as sm
sm.qqplot_2samples(marvel_sample, dc_sample, line='45')
plt.show()
```

#nota[
  Normalizzando i dati si possono notare piu facilmente valori fuori scala
]

=== Scatter plot

Considerando due serie con un medesimo indice, individuiamo un punto sul piano dato dai valori delle due serie. Oppure considerando una riga fissata, quindi un individuo, voglio analizzare la relazione tra due attributi dell'individuo.

Ripetendo la stessa cosa per tutti gli individui, otteniamo una nuvola di punti: Abbiamo otteniamo un diagramma di dispersione o scatter plot.

Non sto cercando una relazione deterministica, ma una tendenza.
Se esistesse una qualunque relazione lineare, otterrei esattamente una retta congiungendo i punti.

Generiamo uno scatter plot da un dataframe invocando ``` plot.scatter()``` indicando come argomenti i nomi dei caratteri da considerare.

```python
heroes[heroes['Gender']=='M'].plot.scatter('Height', 'Weight')
plt.show()
```

= Calcolo delle probabilità <probabilità>

== Calcolo combinatorio

Analizzare _come_ e in _quanti_ modi si possono effettuare raggruppamenti di elementi.

/ Principio di enumerazione (principio fondamentale del calcolo combinatorio): se dobbiamo compiere $t$ esperimenti e per ognuno di essi ci possono essere $s_i$ possibili risultati, il numero di risultati totali è $s_1 dot s_2 dot ... dot s_t$

#informalmente[
  Vogliamo selezionare $k$ elementi da un insieme $A$ di $n$ elementi:

  / Disposizioni: l'ordine è importante $(a, b) != (b, a)$
  / Combinazioni: l'ordine _non_ è importante $(a, b) = (b, a)$
  / Permutazioni: tutti gli elementi vengono disposti $k = n$

  È possibile sia _avere_ che _non avere_ delle *ripetizioni* in tutti i casi
]

=== Disposizioni

Dato un insieme di $n$ oggetti distinti $A = { a_1, ..., a_n }$, vogliamo selezionare $k$ oggetti (con $k <= n$), tenendo in cosiderazione l'*ordine*.

/ Disposizione senza ripetizioni (semplici): gli oggetti di $A$ possono essere usati una volta sola $ d_(n,k) = n! / (n-k)! $

#dimostrazione[
  $ d_(n,k) &= n(n-1)(n-2)...(n-k+1) \
    &= mb(n(n-1)(n-2)...(n-k+1)) dot mb((n-k)(n-k-1)...(1))/mo((n-k)(n-k-1)...(1)) \
    &= mb(n!) / mo((n-k)!) $
]

/ Disposizione con ripetizione: gli oggetti di $A$ possono essere usati più di una volta $ D_(n,k) = underbrace(n dot n dot ... dot n, k "volte") = n^k $

#attenzione[
  In questo caso $k$ può essere $> n$
]

=== Combinazioni

Dato un insieme di $n$ oggetti distinti $A = { a_1, ..., a_n }$, vogliamo selezionare $k$ oggetti (con $k <= n$), *senza* considerare l'ordine.

#nota[
  Il numero di combinazioni $c_(n,k)$ è sempre minore del numero di disposizioni $d_(n,k)$, dato che l'ordine non conta
]

/ Combinazione senza ripetizioni (semplici): gli oggetti di $A$ possono essere usati una volta sola $ c_(n,k) = binom(n, k) $

#nota[
  $binom(n, k)$ viene detto *coefficiente binomiale*, ovvero il numero _sottoinsiemi_ $k$ che si possono formare da un _insieme_ di $n$ elementi
]

#dimostrazione[
  $ c_(n,k) = d_(n,k) / k! = n!/(k! dot (n-k)!) = binom(n, k) $
]

/ Combinazione con ripetizioni: gli oggetti di $A$ possono venir usati più di una volta $ C_(n,k) = (n+k-1)! / (k! dot (n-1)!) = binom(n + k - 1, k) $

#attenzione[
  In questo caso $k$ può essere $> n$
]

=== Permutazioni

Dato un insieme di $n$ oggetti $A = { a_1, ..., a_n }$, una *permutazione* è una sequenza _ordinata_ in cui compaiono _tutti_ gli oggetti (quindi vogliamo selezionare $k$ elementi).

/ Permutazioni semplici (senza ripetizioni): l'insieme $A$ non contiene elementi duplicati $ P_n = n(n-1)(n-2)...(1) = n! $

/ Permutazioni di oggetti distinguibili a gruppi (con ripetizioni): l'insieme $A$ contiene $k$ gruppi di oggetti indistinguibili, ognuno con numerosità $n_1, ..., n_k$ (con $limits(sum)_(i=1)^k n_i = n)$, allora dobbiamo disporre tutti questi elementi $ P_(n:n_1, ..., n_k) = n! / (n_1 ! dot ... dot n_k !) = binom(n, (n_1, ..., n_k)) $

#nota[
  $binom(n, (n_1, ..., n_k))$ viene detto *coefficiente multinomiale*
]

== Elementi di probabilità

/ Esito $omega in Omega$: risultato effettivo di un esperimento
/ Evento $E subset.eq Omega$: è un qualsiasi insieme formato da tutti, alcuni o nessuno dei possibili esiti di un esperimento
/ Probabilità: quantificazione dell'incertezza di un evento
/ Spazio campionario $Omega$ (insieme degli esiti o insieme universo): è l'insieme di tutti gli esiti possibili. Può essere _finito_ o _infinito_, _continuo_ o _discreto_

#informalmente[
  _Esempio_: lanciando un dado, l'_esito_ è il numero risultante, un _evento_ può essere "esce 3 o 6" e la _probabilità_ di questo evento è $2/6$
]

/ Evento certo $E = Omega$: si verifica sempre
/ Evento impossibile $E = emptyset$: non si verifica mai

#nota[
  Indichiamo sempre con una _minuscola_ un _esito_, mentre con una _maiuscola_ un _evento_
]

Dati degli eventi, è possibile applicare le operazioni e proprietà degli insiemi su di essi:

/ Unione $E union F$: quando si verifica l'evento $E$ o l'evento $F$
/ Intersezione $E sect F$: quando si verificano entrambi gli eventi $E$ ed $F$
/ Mutualmente esclusivi $E sect F = emptyset$: i due eventi sono _mutualmente esclusivi_
/ Differenza $E - F$: si verifica l'evento $E$, ma l'evento $F$ non si verifica (l'operazione di sottrazione non è commutativa, $E - F != F - E$)
/ Complemento $Omega - E = E^c = overline(E)$: quando l'evento $E$ non si verifica
/ Sottoinsieme $E subset.eq F = E -> F$: quando si verifica $E$, allora si verifica anche $F$
/ Proprietà per unione e intersezione:
  / Commutatività: $E union F = F union E$
  / Associatività: $(D union E) union F = D union (F union E)$
  / Distrbutività: $D union (E sect F) = (D union E) sect (D union F)$
  / De Morgan: $overline(E union F) = overline(E) sect overline(F)$: l'evento che si verifica quando non si verifica $E$ o $F$ è lo stesso evento che si verifica quando non si verifica $E$ e non si verifica $F$

È possibile dare diverse _interpreazioni_ alla probabilità:

/ Approccio soggettivista: la probabilità di un esito non è oggettiva: è il livello di _fiducia_ che un soggetto _(lo studioso)_ ripone nel verificarsi di un evento

/ Approccio frequentista: la probabilità di un esito è una _proprietà_ dell'esito stesso: viene calcolata come il rapporto tra il numero di casi _favorevoli_ e il numero di casi _possibili_ ripetendo l'esperimento un numero di volte tendente all'infinito

=== Algebra di eventi

Un algebra di eventi $A$ è un insieme di eventi ${E_1, E_2, ...}$ a cui sono associate delle operazioni che soddisfa le proprietà:

- $forall E in A, space E subset.eq Omega$: ogni evento appartenente all'_algebra_ $A$ appartiene all'insieme di tutti gli _eventi possibili_ $Omega$
- $Omega in A$: l'insieme di tutti gli _eventi possibili_ $Omega$ appartiene all'_algebra_ $A$
- $forall E in A, space overline(E) in A$: chiusura rispetto al _complemento_
- $forall E, F in A, space E union F in A$: chiusa rispetto all'_unione_
- $forall E, F in A, space E sect F in A$: chiusura rispetto all'_intersezione_

#nota[
  La chiusura rispetto all'_intersezione_ non è una vera proprietà, ma deriva dalla chiusura rispetto all'_unione_ a cui viene applicata la _legge di De Morgan_
]

#nota[
  Se la chiusura sull'_unione_ vale anche per $|Omega| = infinity
$, allora $A$ viene chiamata $sigma$-algebra
]

#attenzione[
  L'algebra degli eventi non è un _vero_ insieme di eventi, ma è un _"dizionario"_ che sfruttiamo per definire quali _operazioni_ e _variabili_ sono ammesse su un $Omega$
]

=== Assiomi di Kolmogorov

Definiamo la funzione *probabilità* $P : A -> [0,1]$, che stabilisce la probabilità che un evento avvenga. $P : A -> [0,1]$ è una funzione di probabilità se e solo se:

1. La probabilità di un evento è sempre _positiva_ $ forall E in A, quad P(E) >= 0 $
  #attenzione[
    Grazie al secondo assioma, viene imposto il limite superiore di $1$, quindi: $ forall E in A, quad 0 <= P(E) <= 1 $
  ]
2. Lo spazio degli esiti contiene necessariamente tutti i possibili esiti: $ P(Omega) = 1 $
3. La probabilità che avvengano due eventi disguinti è la somma delle loro probabilità: $ forall E, F in A, quad (E sect F) = emptyset quad => quad P(E union F) = P(E) + P(F) $
  #nota[
    Il terzo assioma è generalizzabile come la probabilità che accadano diversi eventi _distinti_ $E_i, E_j$ e _disgiunti_ $E_i sect E_j = emptyset$ è la _somma_ delle loro probabilità:
    $ P(limits(union.big)_(i=1)^n E_i) = sum_(i=1)^n P(E_i) $
  ]

#attenzione[
  Formalmente la funzione probabilità è definita $P : A -> bb(R)^+$ (numeri _reali positivi_), applicando gli assiomi il _codominio_ viene ristretto a $[0, 1]$
]

=== Teoremi derivati dagli assiomi

/ Probabilità del complemento: $ forall E in A, space P(overline(E)) = 1 - P(E) $

#dimostrazione[
  $ E sect overline(E) = emptyset, quad E union overline(E) &= Omega "(definizione complemenatre)" \
  P(Omega) &= 1 "(per secondo assioma)" \
  P(E union overline(E)) = P(E) + P(overline(E)) &= 1 "(per terzo assioma)" \
  P(overline(E)) &= 1 - P(E) $
]

/ Probabilità dell'evento impossibile: $ P(emptyset) = 0 $

#dimostrazione[
  $ P(Omega) &= 1 "(per secondo assioma)" \
  P(emptyset) &= P(overline(Omega)) \
  &= 1 - P(Omega) \
  &= 1 - 1 = 0 $
]

/ Proprietà di monotonicità: $ forall E, F in A |  E subset.eq F => P(E) <= P(F) $

/ Probabilità dell'unione di eventi: $ forall E, F in A, space P(E union F) = P (E) + P (F) − P(E sect F) $

#dimostrazione[
  È possibile riscrivere $E union F$ come $E union (overline(E) sect F)$, quindi:
  $ mb(P(E union F) &= P(E) + P(overline(E) sect F)) "(per terzo assioma)" $
  È possibile riscrivere $F$ come $(E sect F) union (overline(E) sect F)$, quindi:
  $ mo(P(F) = P(E sect F) + P(overline(E) sect F)) "(per terzo assioma)" $
  Sottraendo membro a membro le due equazioni otteniamo:
  $ mb(P(E union F)) - mo(P(F)) = mb(P(E) + cancel(P(overline(E) sect F))) - mo(P(E sect F) - cancel(P(overline(E) sect F))) $
  Quindi:
  $ P(E union F) = P(E) + P(F) - P(E sect F) $
]

=== Spazi di probabilità ed Esiti equiprobabili <spazio-probabilita>

Definiamo lo *spazio di probabilità* come la tripla $(Omega, A, P)$ composta dallo spazio di _esiti possibili_ $Omega$, l'_algebra_ $A$ e la _funzione probabilità_ $P$.

/ Spazio equiprobabile: uno spazio è _equiprobabile_ se gli eventi elementari (gli elementi $Omega$) hanno tutti la _stessa_ probabilità: $ P(E) = 1/N quad quad P({E_1, ..., E_k}) = k/N $

#dimostrazione[
  Si dimostra con il secondo assioma di _Kolmogorov_:
  $ P(Omega) = 1 = P({e_1}) + ... + P({e_N}) = sum_(i=1)^N P({e_i}) $
]

#nota[
  Uno spazio può essere _equiprobabile_ solo se $Omega$ è un _insieme finito_
]

== Probabilità condizionata

Dati due eventi $E, F$, la probabilità che si verifichi l'evento $E$ _sapendo_ che _si è verificato_ l'evento $F$ è detta *probabilità condizionata*: $ P(E|F) = P(E sect F) / P(F) $

#nota[
  - $P(E|F)$ si legge _"probabilità di $E$ dato $F$"_
  - $E$ si dice evento _condizionato_
  - $F$ si dice evento _condizionante_
]

#attenzione[
  In caso $P(F) = 0$, ovvero $F = emptyset$, allora $P(E|F) = "indefinita"$
]

#informalmente[
  Intuitivamente $P(E|F)$ è la probabilità che preso un punto qualsiasi all'interno di $F$, il punto appartenga a $E sect F$, quindi $(E sect F) / F$
]

=== Regola di fattorizzazione

Dati due eventi $E, F in Omega$, la probabilità che accadano _entrambi_ (la loro intersezione) è data dalla regola di _fattorizzazione_:

$ P(E sect F) = P(F) dot P(E|F) $

#informalmente[
  A differenza di una possibilità condizionata "semplice", _non sappiamo_ se $F$ si sia già verificato o meno, quindi dobbiamo considerare anche la _sua possibilità_ oltre a quella condizionata di $E$
]

=== Teorema delle probabilità totali

Dato $Omega$ partizionato in $F_1, ..., F_n$ partizioni disguinte, la probabilità che accada un evento $E in Omega$ è:

$ P(E) = sum_(i=1)^n P(F_i) dot P(E|F_i)  $

#nota[
  Insieme $A$ partizionato: $limits(union.big)_(i=1)^n F_i = A$ con $forall i, j, space  i != j, space F_i sect F_j = emptyset$. L'_unione_ di tutte le partizioni è uguale all'insieme iniziale e tutte le partizioni sono _disgiunte_
]

#figure(caption: [
  Probabilità di $E$:
  $ P(E) =
  mp(P(F_1)) dot P(mr(E)|mp(F_1)) + mb(P(F_2)) dot P(mr(E)|mb(F_2)) + mg(P(F_3)) dot P(mr(E)|mg(F_3))\
  =(mp(1/3) dot mr(0)) + (mb(1/3) dot mr(1/6)) + (mg(1/3) dot mr(1/2)) = 2/9\
   $
], [
  #cetz.canvas({
    import cetz.draw: *

    rect((0, 0), (2,3), fill: rgb(255, 0, 255, 20))
    rect((2, 0), (4,3), fill: rgb(0, 0, 255, 20))
    rect((4, 0), (6,3), fill: rgb(0, 255, 0, 20))
    circle((4.5,1.5), stroke: red, fill: rgb(255, 0, 0, 20), name: "E")
    content((6.3,3.3), $ Omega $)
    content("E", $ mr(E) $)
    content((1, 0.3), $ mp(F_1) $)
    content((3, 0.3), $ mb(F_2) $)
    content((5, 0.3), $ mg(F_3) $)
  })
])

È possibile esprimere $E$ come:

$ P(E) = mr(P(E sect F)) &+ mb(P(E sect overline(F))) \
  = mr(P(E | F) P(F)) &+ mb(P(E | overline(F)) P(mo(overline(F)))) \
  = P(E | F) P(F) &+ P(E | overline(F)) P(mo(1-P(F))) $

Altre trasformazioni utili:

$ (E sect F) union (E sect overline(F)) = E sect (F union overline(F)) = E sect Omega = E $

$ (E sect F) sect (E sect overline(F)) = E sect (F union overline(F)) = E sect emptyset = emptyset $

=== Teorema di Bayes

Dato $Omega$ partizionato in $F_1, ..., F_n$ partizioni disguinte, e un evento $E$, la probabilità che accada una certa $F_i subset.eq Omega $ è:

$ P(F_i | E) &= (P(E | F_i) P(F_i)) / mr(P(E)) \
 &= (P(E | F_i) P(F_i)) / mr(limits(sum)_(i=1)^n P(E | F_i) P(F_i)) $

#figure(caption: [
  Probabilità di $F_2$:
  $ P(F_2) =
  (mp(P(E|F_2)) dot mb(P(F_2))) / mr(P(E)) \
  = (mp(P(E sect F_2) / P(F_2)) mb(P(F_2))) / mr((P(F_1) dot P(E|F_1)) + (P(F_2) dot P(E|F_2)) + (P(F_3) dot P(E|F_3))) \
  = (mp((1/6 dot 1/3) / (1/3)) mb(1/3)) / mr(2/9) = 1/4
   $
], [
  #cetz.canvas({
    import cetz.draw: *

    rect((0, 0), (2,3))
    rect((2, 0), (4,3), fill: rgb(0, 0, 255, 20))
    rect((4, 0), (6,3))
    circle((4.5,1.5), stroke: red, fill: rgb(255, 0, 0, 20), name: "E")
    content((6.3,3.3), $ Omega $)
    content("E", $ mr(E) $)
    content((1, 0.3), $ F_1 $)
    content((3, 0.3), $ mb(F_2) $)
    content((5, 0.3), $ F_3 $)
    content((3.8, 1.5), $ mp(E|F_2) $)
  })
])

=== Classificatore naive-Bayes

Possiamo generalizzare il _teorema di Bayer_ per ricavarne un *classificatore*: date delle _caratteristiche_ $X_1, ..., X_n$ che assumono valore $x_1, ..., x_n$, vogliamo assegnare l'oggetto $y_k$ alla _classe_ che massimizza la probabilità:

$ P(Y = y_k | X_1 = x_1, ..., X_n = x_n) $

Applicando il teorema di _Bayes_:

$ = (P(X_1 = x_1, ..., X_n = x_n | Y = y_k) dot P(Y = y_k)) / P(X_1 = x_1, ..., X_n = x_n) $

La formula viene semplificata in modo "ingenuo" _(naive)_, assumendo che le caratteristiche siano #link(<eventi-indipendenti>)[eventi indipendenti] $P(X_1 = x_1 and X_2 = x_2 | Y) = P(X_1 = x_1 | Y) dot P(X_2 = x_2 | Y)$:

$ = (P(Y = y_k) dot limits(product)_(i=1)^n P(X_i = x_i | Y = y_k)) / P(X_1 = x_1, ..., X_n = x_n) $

#informalmente[
  Questa _assunzione_ è, appunto, _ingenua_: ad esempio, una persona con i capelli chiari è _più probabile_ che abbia anche gli occhi chiari rispetto ad una persona con i capelli scuri. Le due caratteristiche _non_ sono _indipendenti_.

  Come capire _formalmente_ se due eventi (o più) eventi sono _indipendenti_ è descritto nel #link(<eventi-indipendenti>)[paragrafo successivo]
]

Per trovare la classe alla quale _assegnare_ l'oggetto, bisogna calcolare la probabilità per ogni possibile $y_k$ e trovare il massimo $k^*$:

$ k^* = arg max_k P(Y = y_k) dot product_i^n P(X_i = x_i | Y = y_k) $

#nota[
  Dato che ci interessa solo $y_k$ massimo e il _denominatore_ non dipende da $k$, allora possiamo _ignorarlo_ dato che non influenzerà la scelta del masssimo
]

=== Eventi indipendenti <eventi-indipendenti>

Quando il verificarsi di un evento $F$ _non influenza_ la probabilità del verificarsi di un altro evento $E$, allora gli eventi si dicono *indipendenti*:
$ P(E | F) = P(E) $
$ P(E sect F) = P(E) dot P(F) $

#nota[
  Sfruttando le formule viste in precedenza, è possibile verificare che i conti tornino:
  $ P(E) = mr(P(E sect F)) / P(F) = mr(P(E) dot cancel(P(F))) / cancel(P(F)) = P(E) $
]

#informalmente[
  È molto difficile rappresentare _graficamente_ attraverso _diagrammi di Venn_ eventi indipendenti, meglio non farlo :)
]

/ Proprietà:

- Se $E$ è indipendente da $F$, $F$ è indipendente da $E$
- Se $E$ e $F$ sono indipendenti, allora anche $E$ e $overline(F)$ sono indipendenti

=== Indipendenza a tre o più eventi

Tre eventi $E, F, G$ sono _indipendenti_ se valgono le proprietà:

- $P(E sect F sect G) = P(E) dot P(F) dot P(G)$
- $P(E sect F) = P(E) dot P(F)$
- $P(F sect G) = P(F) dot P(G)$
- $P(E sect G) = P(E) dot P(G)$

È possibile _estendere_ la definizione ad un numero _arbitrario_ di eventi:

Gli eventi $E_1, ..., E_n$ si dicono indipendenti se per ogni loro sottogruppo $E_a_1, ..., E_a_r$ con $1 <= a_1 <= ... <= a_r <= n$ vale l'equazione:

$ P(sect.big_(i=1)^r E_(a i)) = product_(i=1)^r P(E_a_i) $

== Variabili aleatorie

Una _variabile aleatoria_ o _casuale_ (random variable) è una variabile che può assumere un valore _diverso_ non prevedibile ogni osservazione. Permettono di codificare gli _esiti_ numericamente.

Dato uno #link(<spazio-probabilita>)[spazio di probabilità] $(Omega, A, P)$, una variabile aleatoria è $X : Omega -> bb(R)$ che associa ad ogni _esito_ un _numero reale_.

#attenzione[
  Non tutte le funzioni definite come $X : Omega -> bb(R)$ rappresentano una _variabile aleatoria_
]

/ Specificazioni: _valori_ che possono essere assunti da una variabile aleatoria
/ Supporto: l'_insieme_ delle _specificazioni_, dove la probabilità non sia nulla $P(X = x_i) != 0$

#nota[
  È possibile calcolare il _supporto_ di una variabile aleatoria *discreta* calcolando l'_insieme_ di punti in cui la #link(<funzione-massa>)[funzione di massa] non assuma valore nullo
]

==== Funzione indicatrice <indicatrice>

Dati $A, B$ due insiemi tali che $A subset.eq B$, la funzione indicatrice di $A$ rispetto a $B$ è la funzione $I : B -> {0, 1}$ che vale:

$ I_(A) (x) = cases(1 "se" x in A, 0 "se" x in.not A) $

#informalmente[
  La _funzione indicatrice_ agisce da _filtro_, "limitando il dominio". Quando viene _moltiplicata_ con una probabilità la _annulla_ o la _lascia inalterata_.

  Ad esempio, la probabilità di un _dado_ è: $P(X = x) = 1/6 dot mr(I_({1, ..., 6}(x)))$, la funzione indicatrice _annulla_ la probabilità di $1/6$ in caso $x$ non sia nel "dominio" del dado ($1 <= x <= 6$)
]

=== Variabili aleatorie discrete <aleatorie-discrete>

Una variabile aleatoria si dice discreta se il suo supporto è un insieme _discreto_, ovvero è composto da _punti isolati_. Dato $[m,n]$ il range di valori che possono _essere assunti_ dalla variabile $X$, vale:

$ 1 = P(Omega) = P(union.big_(i=m)^n {X = i}) = sum_(i=m)^n P(X = i) $

==== Funzione di massa di probabilità <funzione-massa>

Data una variabile aleatoria discreta $X$ con supporto $D$, la sua _funzione di massa di probabilità_ $P_X : bb(R) -> [0,1]$ è la funzione che associa ad ogni valore $x in bb(R)$ la probabilità che l'esito di $X$ ne sia uguale:
$ forall x in bb(R), quad p_(X)(x) = P(X = x) dot I_(D)(x) $

*Proprietà* che la funzione di massa di probabilità deve _rispettare_:

- non può essere *negativa*:
  $ forall x in bb(R), f_(X)(x) >= 0 $
- la *somma* della funzione di massa per tutti i valori che $x$ può assumere deve fare $1$:
  $ sum_(x in D) f_(X)(x) = 1 $

#figure(caption: [Grafico funzione di massa di probabilità di un dado],
  cetz.canvas({
    import cetz: *

    plot.plot(
      name: "massa",
      size: (4,4),
      x-tick-step: 1,
      y-tick-step: 0.1666,
      x-min: 0,
      x-max: 6,
      y-min: 0,
      y-max: 1,
      axis-style: "school-book",
      {
        plot.add-anchor("1", (1, 0.1666))
        plot.add-anchor("2", (2, 0.1666))
        plot.add-anchor("3", (3, 0.1666))
        plot.add-anchor("4", (4, 0.1666))
        plot.add-anchor("5", (5, 0.1666))
        plot.add-anchor("6", (6, 0.1666))

        plot.add-anchor("01", (1, 0))
        plot.add-anchor("02", (2, 0))
        plot.add-anchor("03", (3, 0))
        plot.add-anchor("04", (4, 0))
        plot.add-anchor("05", (5, 0))
        plot.add-anchor("06", (6, 0))

        plot.add-anchor("00", (0, 0))
        plot.add-anchor("inf", (7.5, 0))
    })

    draw.line("massa.00", "massa.06", stroke: red)
    draw.line("massa.06", "massa.inf", stroke: (paint: red, dash: "dashed"))
    draw.line("massa.01", "massa.1", stroke: (dash: "dashed"))
    draw.line("massa.02", "massa.2", stroke: (dash: "dashed"))
    draw.line("massa.03", "massa.3", stroke: (dash: "dashed"))
    draw.line("massa.04", "massa.4", stroke: (dash: "dashed"))
    draw.line("massa.05", "massa.5", stroke: (dash: "dashed"))
    draw.line("massa.06", "massa.6", stroke: (dash: "dashed"))

    draw.circle("massa.1", fill: red, radius: .07)
    draw.circle("massa.2", fill: red, radius: .07)
    draw.circle("massa.3", fill: red, radius: .07)
    draw.circle("massa.4", fill: red, radius: .07)
    draw.circle("massa.5", fill: red, radius: .07)
    draw.circle("massa.6", fill: red, radius: .07)

    draw.circle("massa.01", fill: white, radius: .07)
    draw.circle("massa.02", fill: white, radius: .07)
    draw.circle("massa.03", fill: white, radius: .07)
    draw.circle("massa.04", fill: white, radius: .07)
    draw.circle("massa.05", fill: white, radius: .07)
    draw.circle("massa.06", fill: white, radius: .07)

    draw.content("massa.1", [$1/6$], anchor: "south", padding: 0.3)
    draw.content("massa.2", [$1/6$], anchor: "south", padding: 0.3)
    draw.content("massa.3", [$1/6$], anchor: "south", padding: 0.3)
    draw.content("massa.4", [$1/6$], anchor: "south", padding: 0.3)
    draw.content("massa.5", [$1/6$], anchor: "south", padding: 0.3)
    draw.content("massa.6", [$1/6$], anchor: "south", padding: 0.3)
  }))

==== Funzione di ripartizione <funzione-ripartizione>

Data una variabile aleatoria $X$, la sua _funzione di ripartizione_ o _distribuzione cumulativa_ $F_X : bb(R) -> [0, 1]$ è la funzione che associa ad ogni valore $x in bb(R)$ la probabilità che l'esito di $X$ ne sia minore o uguale:
$ forall x in bb(R), quad F_(X)(x) = P(X <= x) $

*Proprietà* che la funzione di ripartizione deve _rispettare_:

- è una funzione a scalini con punti di discontinuità sul supporto della variabile
- è una funzione monotona crescente:
  $ forall x_1 < x_2, space F(x_1) <= F(x_2) $
- probabilità per un _valore maggiore_ di una certa soglia o compreso tra due estremi sfruttando il complementare:
  $ P(X>x) = 1 - P(X <= x) = 1 - F(x) $
  $ P(a < X <= b) = P(X <= b) - P(X <= a) = F(b) - F(a) $
- può essere riscritta come la somma della _funzione di massa_ di tutti i valori minori o uguali:
  $ F(a) = sum_(x <= a) p(x) $
- assume $0$ e $1$ come estremi:
  $ lim_(x -> -infinity) F(x) = 0, quad lim_(x -> +infinity) F(x) = 1 $

#figure(caption: [Grafico funzione di ripartizione di un dado],
  cetz.canvas({
    import cetz: *

    plot.plot(
      name: "ripartizione",
      size: (4,4),
      x-tick-step: 1,
      y-tick-step: 0.1666,
      axis-style: "school-book",
      x-min: 0,
      x-max: 6,
      y-min: 0,
      y-max: 1,
      {
        plot.add-anchor("1", (1, 0.1666))
        plot.add-anchor("2", (2, 0.3333))
        plot.add-anchor("3", (3, 0.5))
        plot.add-anchor("4", (4, 0.6666))
        plot.add-anchor("5", (5, 0.8333))
        plot.add-anchor("6", (6, 1))

        plot.add-anchor("00", (0, 0))
        plot.add-anchor("01", (1, 0))
        plot.add-anchor("02", (2, 0.1666))
        plot.add-anchor("03", (3, 0.3333))
        plot.add-anchor("04", (4, 0.5))
        plot.add-anchor("05", (5, 0.6666))
        plot.add-anchor("06", (6, 0.8333))

        plot.add-anchor("66", (6.5, 1))
        plot.add-anchor("6inf", (7.2, 1))
    })

    draw.line("ripartizione.00", "ripartizione.01", stroke: red)
    draw.line("ripartizione.1", "ripartizione.02", stroke: red)
    draw.line("ripartizione.2", "ripartizione.03", stroke: red)
    draw.line("ripartizione.3", "ripartizione.04", stroke: red)
    draw.line("ripartizione.4", "ripartizione.05", stroke: red)
    draw.line("ripartizione.5", "ripartizione.06", stroke: red)
    draw.line("ripartizione.6", "ripartizione.66", stroke: red)
    draw.line("ripartizione.66", "ripartizione.6inf", stroke: (paint: red, dash: "dashed"))

    draw.circle("ripartizione.1", fill: red, radius: .07)
    draw.circle("ripartizione.2", fill: red, radius: .07)
    draw.circle("ripartizione.3", fill: red, radius: .07)
    draw.circle("ripartizione.4", fill: red, radius: .07)
    draw.circle("ripartizione.5", fill: red, radius: .07)
    draw.circle("ripartizione.6", fill: red, radius: .07)

    draw.content("ripartizione.1", [$1/6$], anchor: "south", padding: 0.3)
    draw.content("ripartizione.2", [$2/6$], anchor: "south", padding: 0.3)
    draw.content("ripartizione.3", [$3/6$], anchor: "south", padding: 0.3)
    draw.content("ripartizione.4", [$4/6$], anchor: "south", padding: 0.3)
    draw.content("ripartizione.5", [$5/6$], anchor: "south", padding: 0.3)
    draw.content("ripartizione.6", [$1$], anchor: "south", padding: 0.3)
  }))

==== Valore atteso

Il _valore atteso_ di una variabile aleatoria $X$ è un _indice dimensionale_ di #link(<indice-centralita>)[centralità] delle _specificazioni_ della variabile aleatoria.

$ E[X] = sum_i x_i dot P(X = x_i) = sum_i x_i dot p(x_i) $

#informalmente[
  Il _valore atteso_ è semplicemente la _"media pesata"_ per ogni possibile valore nel _dominio_ (specificazione) di una variabile aleatoria
]

#nota[
  - $mu$: media dell'intera popolazione
  - $overline(X)$: media di un campione (media campionaria)
  - $E[overline(X)] = mu$: il valore atteso della media campionaria stima $mu$
  - $E[X] = E[overline(X)] = mu$: il valore attesso della variabile aleatoria stima il valore atteso della media campionaria, quindi stima $mu$
]

*Proprietà* del valore atteso: <proprieta-valore-atteso>

- il _valore atteso_ di una funzione indicatrice è uguale alla _probabilità dell'evento_: $ E[I_A] = P(A) $
  #dimostrazione[
    $ E[I] &= 1 dot P(I=1) + 0 dot P(I=0) \
      &= P(I=1) = P(A) $
  ]
- il _valore atteso_ di una variabile aleatoria discreta $X$ opera in modo _lineare_: $ Y = a dot X + b quad quad  E[Y] = a dot E[X] + b $
  #dimostrazione[
    $ E[Y] &= sum_i (a x_i +b) P(X = x_i) \
      &= a sum_i x_i P(X = x_i) + b sum_i P(X = x_i) \
      &= a E[X] + b sum_i p(x_i) \
      &= a E[X] + b dot 1 $
  ]
- data una qualsiasi _funzione_ reale $g$ e una variabile aleatoria $X$ con funzione di massa $p$, allora vale: $ E[g(X)] = sum_i g(x_i) dot p(x_i) $
- data una qualsiasi _funzione_ reale $g$ di due variabili e due variabili aleatorie discrete $X, Y$, allora vale: $ E[g(X, Y)] = sum_x sum_y g(x,y) dot p(x,y) $

==== Varianza

Sia $X$ una variabile aleatoria di media $mu$, la varianza $sigma^2$ di $X$ è:
$ "Var"(X) = G_X^2 = E[(X - mu)^2] $
$ "Var"(X) = E[X^2] - E[X]^2 $

#dimostrazione[
  $ "Var"(X) &= E[(X - mu)^2] \
  &= E[X^2 - 2 mu X + mu^2] \
  &= E[X^2] - 2 mu E[X] + mu^2 \
  &= E[X^2] - 2mu^2 + mu^2 \
  &= E[X^2] - E[X]^2 \
  &= (sum_i x_i^2 dot P(X = x_i)) - E[X]^2 $
]

*Proprietà* varianza:

- la varianza della funzione indicatrice è la probabilità dell'_evento_ moltiplicata per la probabilità dell'_evento complementare_ $ "Var"(I) = P(A) dot P(overline(A)) $
  #dimostrazione[
    $ "Var"(I) &= E[I^2] - E[I]^2 \
      &= E[I] - E[I]^2 \
      &= E[I](1 - E[I]) \
      &= P(A)[1 - P(A)] \
      &= P(A) P(overline(A)) $
  ]
- la varianza non opera in modo _lineare_: $ "Var"(a X + b) = a^2 "Var"(X) $
  #dimostrazione[
    $ "Var"(a X + b) &= E[(a X +b - mu)^2] \
      &= E[(a X + b - E[a X + b])^2] \
      &= E[(a X + cancel(b) - a mu - cancel(b))^2] \
      &= E[a^2 (X - mu)^2] \
      &= a^2 E[(X - mu)^2] \
      &= a^2 "Var"(X) $
  ]
- la varianza della _media campionaria_ vale: $ "Var"(overline(X)) = "Var"(X)/n $
  #dimostrazione[
    $ "Var"(overline(X)) &= "Var"(1/n sum_(i=1)^n X_i) \
      &= 1/n^2 "Var"(sum_(i=1)^n X_i) \
      &= 1/n^cancel(2) dot cancel(n) "Var"(X) \
      &= "Var"(X)/n $
    infatti
    $ "Var"(sum_(i=1)^n X_i) &= "Var"(X_1 + ... + X_n) \
      &= "Var"(X_1) + ... + "Var"(X_n) \
      &= n "Var"(X) != "Var"(n X) $
  ]

/ Deviazione standard: la deviazione standard $sigma$ è calcolata come la radice quadrata della _varianza_: $ sigma_X = sqrt("Var"(X)) $

Anche la deviazione standard non opera in modo lineare:
$ sigma_(a X + b) = sqrt(a^2 "Var"(X)) = |a| sigma_X $

=== Variabili aleatorie multivariate
// TODO: rivedere proprietà valore atteso, varianza, covarianza tra più variabili

Oltre alle #link(<aleatorie-discrete>)[variabili aleatorie *univariate*], è possibile utilizzare un _vettore_ di lunghezza arbitraria, ottenendo una variabile aleatoria *multivariata*.

#nota[
  Quando il vettore è lungo $2$ elementi, la variabile aleatoria si dice *bivariata*
]

==== Funzione di ripartizione congiunta

Sia $A$ una variabile aleatoria bivariata formata da $X,Y$ variabili aleatorie _univariate discrete_, allora la loro _funzione di ripartizione conguinta_ è:

$ F_"X,Y" (x,y) = P(X <= x, Y <= y) $

#nota[
  La virgola dentro la probabilità denota l'intersezione: $ P(X <= x, Y <= y) = P(X <= x sect Y <= y) $
]

È possibile _estendere_ a variabili aleatorie _multivariate_ di dimensione arbitraria:
$ F_(X_1, ..., X_n)(x_1, ..., x_n) = P(X_1 <= x_1, ..., X_n <= x_n) $

#informalmente[
  Si dice _funzione di ripartizione (o massa)_ *marginale* quando da una _funzione di ripartizione (o massa)_ *congiunta* estraggo una _funzione di ripartizione (o massa)_ di una variabile *univariata*
]

Possiamo ottenere una $F_(X)(x)$ *funzione di ripartizione marginale* di $X$:
$ lim_(y -> +infinity) F_"X,Y" (x,y) =  F_X (x) $

#dimostrazione[
  $ lim_(y -> +infinity) F_"X,Y" (x,y) &= mr(lim_(y -> +infinity)) P(X <= x, mr(Y <= y)) \
  &= P(X <= x) space dot mr(lim_(y -> +infinity) P(Y <= y)) \
  &= P(X <= x) dot mr(Omega) \
  &= P(X <= x) \
  &= F_X (x) $
]

==== Funzione di massa di probabilità congiunta

Siano $X,Y$ due variabili aleatorie _univariate discrete_, allora la loro _funzione di massa di probabilità congiunta_ $p: bb(R) times bb(R) -> [0, 1]$ è:

$ p_(X,Y) (x,y) = P(X = x, Y = y) $

È possibile _estendere_ a variabili aleatorie _multivariate_ di dimensione arbitraria:
$ p_(X_1, ..., X_n)(x_1, ..., x_n) = P(X_1 = x_1, ..., X_n = x_n) $

Possiamo ottenere una $p_(X)(x)$ *funzione di massa di probabilità marginale* di $X$ nel seguente caso:
$ sum_(y_i in D) p_(X,Y) (x,y) = p_X (x) $

#dimostrazione[
  $ sum_(y_i in D) p_(X,Y) (x,y) &= mr(sum_(y_i in D)) P({X = x} sect mr({Y = y})) \
    &= P({X = x} sect space mr(union.big_(y_i in D) {Y = y})) \
    &= P({X = x} dot mr(Omega)) \
    &= P({X = x}) \
    &= p_X (x) $
]

==== Indipendenza

Due variabili aleatorie $X, Y$ si dicono *indipendenti* se $forall A, B subset.eq RR, space X in A$ e $Y in B$ sono #link(<eventi-indipendenti>)[indipendenti]:

$ P(X in A, Y in B) = P(X in A) dot P(Y in B) $
$ P(X <= A, Y <= B) = P(X <= A) dot P(Y <= B) $
$ p(x,y) = p_(X)(x) dot P_(Y)(y) $
$ F(a,b) = F_(X)(a) dot F_(Y)(b) $

#nota[
  Questi risultati sono _dimostrabili_ usando gli _assiomi delle probabilità_
]

È possibile _estendere_ a variabili aleatorie _multivariate_ di dimensione arbitraria:
$ P(X_1 in A_1, ..., X_n in A_n) = product_(i=1)^n P(X_i in A_i) $

==== Valore atteso

Il valore atteso della _somma_ di variabili aleatorie discrete è:
$ E[sum_i X_i] = sum_i E[X_i] $

Il valore atteso del _prodotto_ di variabili aleatorie discrete è:
$ E[product_i X_i] = product_i E[X_i] $

==== Covarianza

Siano $X$ e $Y$ due variabili aleatorie di media $mu_X$ e $mu_Y$, la loro _covarianza_ è:
$ "Cov"(X, Y) = E[(X - mu_X)(Y - mu_Y)] $
$ "Cov"(X, Y) = E[X Y] - E[X] E[Y] $

#dimostrazione[
  $ "Cov"(X, Y) &= [X Y - mu_X Y - mu_Y X + mu_X mu_Y] \
    &= E[X Y] - mu_X E[Y] - mu_y E[X] + mu_X mu_Y \
    &= E[X Y] - E[X] E[Y] $
]

*Proprietà* della covarianza:

- simmetria: $ "Cov"(X, Y) = "Cov"(Y, X) $
- generalizzazione concetto di varianza: $ "Cov"(X, X) = "Var"(X) $
- non è lineare, è possibile solo scalarla:
  - $"Cov"(a X + b, Y) = a "Cov"(X, Y)$
    #dimostrazione[
      $ "Cov"(a X + b, Y) &= E[(a X + b) Y] - E[a X + b] E[Y] \
        &= a E[X Y] + cancel(b) - a E[X] E[Y] - cancel(b) \
        &= a(E[X Y] - E[X] E[Y]) \
        &= a "Cov"(X, Y) $
    ]
  - $"Cov"(X + Y, Z) = "Cov"(X, Z) + "Cov"(Y, Z)$
  - $"Cov"(limits(sum)_i X_i, limits(sum)_j X_j) = limits(sum)_i limits(sum)_j "Cov"(X_i, Y_j)$

==== Varianza <multivariate-varianza>

Siano $X$ e $Y$ due variabili aleatorie la loro _varianza_ della loro _somma_ è:
$ "Var"(X + Y) = "Var"(X) + "Var"(Y) + 2 "Cov"(X, Y) $
$ "Var"(X - Y) = "Var"(X) + "Var"(Y) - 2 "Cov"(X, Y) $

È possibile _estendere_ a variabili aleatorie _multivariate_ di dimensione arbitraria:
$ "Var"(sum_i^n X_i) = sum_i^n "Var"(X_i) + sum_i^n sum_(j, j != i)^n "Cov"(X_i, X_j) $

=== Variabili aleatorie continue <aleatorie-continue>

Una variabile aleatoria si dice *continua* quando ha un _supporto *non* numerabile_.

==== Funzione densità di probabilità

#informalmente[
  La #link(<funzione-massa>)[funzione di massa] (come spiegato sotto) non ha più senso per le _variabili aleatorie continue_, quindi lo stesso concetto prende il nome di _funzione densità di probabilità_
]

Siccome $X$ deve per forza assumere un valore in $bb(R)$, allora la _funzione di densità_ $f_"X" : bb(R) -> bb(R)^+$ deve rispettare:
$ P(X in bb(R)) = integral_(-infinity)^(+infinity) f_(X)(x) dif x = 1 $

Per variabili aleatorie _continue_ non ha senso cercare la probabilità assunta da un _singolo valore_, infatti:
$ P(X = a) = integral_a^a f_(X)(x) dif x = 0 $

Per questo motivo si ragiona in termini di _intervalli_ di probabilità:
$ P(a <= X <= b) = integral_a^b f_(X)(x) dif x $

==== Funzione di ripartizione

Data una variabile aleatoria $X$, la sua _funzione di ripartizione_ o _distribuzione cumulativa_ $F_X : bb(R) -> [0, 1]$ è la funzione che associa ad ogni valore $x in bb(R)$ la probabilità che l'esito di $X$ ne sia minore o uguale:
$ forall x in bb(R), quad F_(X)(x) = P(X <= x) $

La funzione di ripartizione $F$ viene calcolata come l'_integrazione_ della funzione di densità $f$ fino ad una soglia:
$ F(a) &= P(X <= a) = integral_(-infinity)^a f_(X)(x) dif x $

Quindi la *funzione di densità* è uguale alla derivata della funzione di ripartizione $F$:
$ f_(X)(a) = F'(a) $

*Proprietà* che la funzione di ripartizione deve _rispettare_:

- è una funzione monotona crescente continua:
  $ forall x_1 < x_2, space F(x_1) <= F(x_2) $
  #attenzione[
    Non è più una funzione a scalini, non ha discontinuità
  ]
- probabilità per un _valore maggiore_ di una certa soglia o compreso tra due estremi sfruttando il complementare:
  $ P(X>x) = 1 - P(X <= x) = 1 - F(x) $
  $ P(a < X <= b) = P(X <= b) - P(X <= a) = F(b) - F(a) $
- assume $0$ e $1$ come estremi:
  $ lim_(x -> -infinity) F(x) = 0, quad lim_(x -> +infinity) F(x) = 1 $

==== Valore atteso

Il _valore atteso_ di una variabile aleatoria continua vale:
$ E[X] = integral_(-infinity)^(+infinity) x dot f_(X)(x) dif x $

#nota[
  Formula alternativa per il valore atteso:
  $ E(X) = integral_0^(+infinity) 1 - F_(X)(x) dif x $
]

#nota[
  Valgono le stesse proprietà del valore atteso per le #link(<proprieta-valore-atteso>)[variabili aleatorie discrete]:
  - opera in modo _lineare_: $ Y = a dot X + b quad quad  E[Y] = a dot E[X] + b $
  - data una qualsiasi _funzione_ reale $g$ e una variabile aleatoria $X$ con funzione di densità $f$, allora vale: $ E[g(X)] = sum_i g(x_i) dot f(x_i) $
]

==== Varianza

La _varianza_ di una variabile aleatoria continua vale:
$ "Var"(X) = E[(X - mu)^2] = integral_(-infinity)^(+infinity) (x - mu)^2 f_(X)(x) dif x $

==== Disuguaglianza di Markov <disuguaglianza-markov>

#informalmente[
  Permette di ottenere un limite superiore alla probabilità dalla sola conoscenza del valore atteso
]

Sia $X$ una _variabile aleatoria_ $X >= 0$, allora $forall a > 0 in bb(R)$, vale:
$ P(X >= a) <= E[X] / a $

#nota[
  Possiamo trarre che:
  $ P(X < a) space = space 1 - P(X >= a) space >= space 1 - E[x] / a $
]

#dimostrazione[
  Variabili aleatorie *discrete*:
  $ E[X] &= sum_(mr(x>=0)) x dot p(x) \
    &= sum_(mr(x < a)) x dot p(x) + sum_(mr(x >= a)) x dot p(x)
         quad >= quad sum_(mb(x >= a)) mb(x) dot p(x))
        quad &>= quad sum_(mb(x >= a)) mb(a) dot p(x)) \
    & & = a dot sum_(x >= a) p(x) \
    & & = a dot P(X >= a) $
  Quindi
  $ mr(E[X]) >= mb(mp(a) dot P(X >= a)) quad => quad mb(P(X >= a)) <= mr(E[X]) / mp(a) $
]

#dimostrazione[
  Variabili aleatorie *continue*:
  $ E[X] &= integral_(mr(-infinity))^(mr(+infinity)) x f_X (x) dif x \
    &= integral_(mr(0))^(mr(a)) x f_X (x) dif x + integral_(mr(a))^(mr(+infinity)) x f_X (x) dif x
        quad >= quad integral_(mb(a))^(mb(+infinity)) mb(x) f_X (x) dif x
        quad &>= quad integral_(mb(a))^(mb(+infinity)) mb(a) f_X (x) dif x \
    & &= a integral_(a)^(+infinity) f_X (x) dif x \
    & &= a dot P(X >= a) $
  Quindi $ mr(E[X]) >= mb(mp(a) dot P(X >= a)) quad => quad mb(P(X >= a)) <= mr(E[X]) / mp(a) $
]


==== Disuguaglianza di Chebyshev <chebyshev>

#informalmente[
  Permette di ottenere un limite superiore alla probabilità che il valore di una variabile aleatoria si discosti dal suo valore atteso di una quantità maggiore o uguale a una soglia scelta
]

Sia $X$ una _variabile aleatoria_ di valore atteso $E[X] = mu$ e varianza $"Var"(X) = sigma^2$, allora:
$ forall r > 0, quad P(|X - mu| >= r) <= sigma^2 / r^2 $

#informalmente[
  $|X - mu|$ è la distanza tra la variabile aleatoria e il suo valore atteso
]

#nota[
  Un'_applicazione_ della _disuguaglianza di Chebyshev_ riguarda la _deviazione standard_: esprime l'andamento della probabilità allontanandosi dal valore attesi di quantità ripetute della deviazione standard:
  $ P(|X - mu| >= k sigma) <= 1/k^2 $
]

#dimostrazione[
  Partendo dalla #link(<disuguaglianza-markov>)[disuguaglianza di Markov]:
  $ P(X >= a) <= E[X] / a $
  Al posto della costante $mb(a)$, usiamo la costante $mb(r^2)$:
  $ P(X >= mb(r^2)) <= E[X] / mb(r^2) $
  Al posto della variabile aleatoria $mp(X)$, usiamo $mp(Y = (X - mu)^2)$:
  $ P(mp((X - mu)^mg(2)) >= r^mg(2)) &<= E[mp((X - mu)^2)] / r^2 \
    P(mg(|X - mu |) >= mg(r)) &<= mr(E[(X - mu)^2]) / r^2 \
    P(|X - mu| >= r) &<= mr(sigma^2) / r^2 $
]

=== Modelli di distribuzione discreti

Alcune _distribuzioni/modelli_ di variabili aleatorie sono molto _frequenti_, di conseguenza esistono dei risultati notevoli.

==== Modello di Bernoulli $X tilde B(p)$ <bernoulliano>

La variabile aleatoria può assumere solo due specificazioni: *fallimento* o *successo*, ovvero il loro supporto è $D_X = { 0, 1 }$. Il parametro $p$ indica la probabilità che $X = 1$ con $p in [0, 1]$

$ mr(X tilde B(p)) $

/ Funzione di massa:
$ p_X (x) = P(X = x) &= mr(p^x (1-p)^((1-x)) I_{0,1} (x)) \
  &= cases(1-p quad "per " x=0, p quad "per " x=1, 0 quad "altrimenti") $

/ Funzione di ripartizione:
$ F_X (x) = P(X <= x) &= mr((1 - p) I_[0,1)(x) + I_([1, +infinity))(x)) \
  &= cases(0 quad "se " x < 0, 1-p quad "se " 0 <= x < 1, 1 quad "se " x >= 1 ) $

/ Valore atteso:
$ E[X] = mr(p) $

#dimostrazione[
  $ E[X] &= sum_x x dot P(X = x) \
  &= 0 dot P(X = 0) + 1 dot P(X = 1) \
  &= 1 dot P(X = 1) = p $
]

/ Varianza:
$ "Var"(X) = mr(p(1-p)) $

#dimostrazione[
  $ "Var"(X) &= E[(X - mu)^2] \
  &= E[(X - p)^2] \
  &= sum_x (x-p)^2 dot P(X=x) \
  &= (0-p)^2 dot P(X = 0) + (1-p)^2 dot P(X=1) \
  &= p^2(1-p) + p(1-p)^2 \
  &= p(1-p) (cancel(p) + 1 cancel(-p)) = p(1-p) $
]

==== Modello binomiale $X tilde B(n, p)$ <binomiale>

Il modello ripete $n$ volte un *esperimento bernulliano indipendente* di probabilità $p$, dove $n$ e $p$ sono i due parametri del modello. La variabile aleatoria $X$ assume il *numero di successi*, quindi il supporto è $D_X = {0, ..., n}$.

$ mr(X tilde B(n, p)) $

/ Funzione di massa:
$ p_X (x) = P(X = x) = mr(binom(n, x) p^x (1-p)^((n-x)) I_{0, ..., n} (x)) $

#figure(caption: [Funzione di massa modello binomiale], image("imgs/binomiale-massa.png",  width: 40%))

#informalmente[
  Ci servono $n-x$ insuccessi, quindi $(1-p)^(n-x)$ e ci servono $x$ successi, quindi $p^x$. Ma non ci interessa l'ordine con il quale avvengono _insuccessi_ e _successi_, quindi utilizziamo il _coefficiente binomiale_ $binom(n,x)$
]

/ Funzione di ripartizione:
$ F_X (x) &= P(X <= x) = \
  &= sum_(i=0)^floor(x) p_X (i) dot I_[0, n](x) + I_((n, +infinity))(x) \
  &= mr(sum_(i=0)^floor(x) binom(n, i) p^i (1-p)^(n-i) dot I_[0,n] (x) + I_((n, +infinity)) (x)) \
  &= cases(
    limits(sum)_(i=0)^floor(x) p_X (i) quad "per " x <= n,
    1 quad "per " x > n
  )
$

#attenzione[
  Nella formula della funzione di ripartizione, $p_X$ indica la _funzione di massa_, solo $p$ indica la _probabilità di successo_
]

/ Valore atteso:
$ E[X] = mr(n p) $

#dimostrazione[
  $ E[X] &= E[sum_i^n X_i] \
  &= sum_i^n E[X_i] = n dot p $
]

/ Varianza:
$ "Var"(X) = mr(n p (1-p)) $

/ Riproducibilità:
Siano $X_1 tilde B(n, p)$ e $X_2 tilde B(m, p)$ indipendenti, allora:
$ X_1 + X_2 = sum_(i=1) ^n X_(1,i) + sum_(j=1)^m X_(2,j) = sum_(i=1)^(n+m) Y_i = Y $
dove $Y tilde B(n+m, p)$
  #nota[
    Per la riproduzione, il parametro $n$ può essere diverso ogni variabile, ma il parametro $p$ deve essere uguale
  ]

==== Modello uniforme discreto $X tilde U(n)$ <uniforme-discreto>

Tutti gli esiti della variabile aleatoria discreta sono *equiprobabili*, dove il parametro $n$ è il numero dei possibili esiti, con $n in bb(N) backslash {0}$. Ogni esito possibile viene mappato su un numero naturale, la variabile assume il numero associato all'*esito dell'esperimento*, quindi il supporto del modello è $D_X = {1, ..., n}$.

$ mr(X tilde U(n)) $

/ Funzione di massa:
$ p_X (x) = P(X = x) = mr(1/n I_{1, ..., n} (x)) $


#figure(caption: [Funzione di massa modello uniforme discreto], image("imgs/uniforme-discreto-massa.png", width: 40%))

/ Funzione di ripartizione:
$ F_X (x) = P(X <= x) = mr(floor(x) / n I_[1, n] (x) + I_((n, +infinity)) (x)) $

#dimostrazione[
  $ forall x <= n quad F_X (x) &= P(X <= x) \
    &= sum_(i=1)^floor(x) P(X = i) \
    &= 1/n sum_(i=1)^floor(x) i \
    &= 1^floor(x) dot 1/n = floor(x)/n $
]

#figure(caption: [Funzione di ripartizione modello uniforme discreto], image("imgs/uniforme-discreto-ripartizione.png", width: 40%))

/ Valore atteso:
$ E[x] = mr((n+1)/2) $

#dimostrazione[
  $ E[X] &= sum_(i=1)^n i dot P(X=i) \
   &= sum_(i=1)^n i dot 1/n \
   &= 1/n sum_(i=1)^n i \
   &= 1/cancel(n) dot (cancel(n)(n+1))/2 = (n+1)/2 $
]

#nota[
  $ E[X^2] = ((n+1)(2n+1))/6 $
]

/ Varianza:
$ "Var"(X) = mr((n^2 - 1)/12) $

#dimostrazione[
  $ "Var"(X) &= E[X^2] - E[X]^2 \
    &= ((n+1)(2n+1))/6 - ((n+1)/2)^2 \
    &= (n+1)((2n+1)/6 - (n+1)/n) \
    &= (n+1)((4n + 2 - 3n - 3) / 12) \
    &= (n+1)((n-1)/12) = (n^2 - 1)/12 $
]

==== Modello geometrico $X tilde G(p)$ <geometrico>

La variabile assume il *numero di insuccessi consecutivi* prima che si verifichi un successo in una serie di #link(<bernoulliano>)[esperimenti Bernoulliani] *indipendenti* e *identicamente distribuiti* (i.i.d.) di parametro $p in (0, 1]$. Il supporto del modello è $D_X = {0, ..., +infinity}$.

$ mr(X tilde G(p)) $

/ Funzione di massa:
$ p_X (x) = P(X = x) = mr(p(1-p)^x I_{0, ..., +infinity} (x)) $

#informalmente[
  La funzione di massa equivale a calcolare le probabilità che accadano $x$ _insuccessi_, quindi $(1-p)^x$ a cui succede un _successo_ $dot p$, ottenenendo $p dot (1-p)^x$
]

#figure(caption: [Funzione di massa modello geometrico], image("imgs/geometrico-massa.png", width: 40%))

/ Funzione di ripartizione:
$ F_X (x) = P(X <= x) = mr((1 - (1-p)^(floor(x)+1)) I_[0, +infinity) (x)) $

#nota[
  $ F_X (x) = F_X (floor(x)) $
]

#figure(caption: [Funzione di ripartizione modello geometrico], image("imgs/geometrico-ripartizione.png", width: 40%))

#dimostrazione[
  Possiamo calcolare la funzione di ripartizione $P(X <= x)$ come $1 - P(X > x)$:

  $ mb(P(X > x)) &= sum_(i = x+1)^(+infinity) p_X (i) \
    &= sum_(i = x+1)^(+infinity) p(1-p)^i \
    &= p sum_(i = x+1)^(+infinity) (1-p)^i \
    &= p sum_(i = x+1)^(+infinity) (1-p)^i dot mp(((1-p)^(x+1))/((1-p)^(x+1))) \
    &= p mp((1-p)^(x+1)) sum_(i = x+1)^(+infinity) ((1-p)^i)/mp((1-p)^(x+1)) \
    &= p(1-p)^(x+1) sum_(i=mg(x+1))^(+infinity) (1-p)^(i- mp((x+1))) \
    &= p(1-p)^(x+1) sum_(i=mg(0))^(+infinity) (1-p)^i \
    &= p(1-p)^(x+1) dot 1/(cancel(1)-(cancel(1)-p)) \
    &= cancel(p)(1-p)^(x+1) dot 1/cancel(p) = mb((1-p)^(x+1)) $

  Quindi: $ P(X <= x) = 1 - mb(P(X > x)) = 1 - mb((1-p)^(x+1)) $
]

/ Valore atteso:

$ E[X] = mr((1-p)/p) $

#dimostrazione[
  Usando la definizione:
  $ E[X] &= sum_(i=0)^(+infinity) i dot p_X (i) \
    &= sum_(i=0)^(+infinity) i p (1-p)^i \
    &= p dot mb(sum_(i=0)^(+infinity) i (1-p)^i) \
    &= cancel(p) dot mb((1-p)/p^cancel(2)) = (1-p)/p $

  #nota[
    Nel punto #text(blue)[evidenziato di blu] abbiamo usato il lemma:
    $ limits(sum)_(i=0)^(+infinity) i alpha^i = alpha/(i-alpha)^2 $
  ]
]

/ Varianza:
$ "Var"(X) = mr((1-p)/p^2) $

/ Assenza di memoria:

Il numero di _fallimenti consecutivi_ (anche se elevato) durante la ripetizione dell'#link(<bernoulliano>)[esperimento Bernoulliano] non ci fornisce _nessuna informazione_ sugli esperimenti successivi.

Quindi la probabilità di costante insuccesso dell'$i + j$-esimo esperimento non è condizionata dalle probabilità di costante insuccesso dell'$i$-esimo:

$ P(X >= x + y | X >= x) = P(X >= y) $

#dimostrazione[
  $ P(X >= x + y | X >= x) &= P(X >= x + y, X >= x) / P(X > x) \
    &= P(X >= x + y) / P(X >= x) \
    &= (1-p)^(cancel(floor(x)) + floor(y))/cancel((1-p)^floor(x)) \
    &= (1-p)^(floor(y)) = P(X >= y) $
]

==== Modello di Poisson $X tilde P(lambda)$ <poisson>

La variabile assume il *numero di eventi* che si verificano in un dato intervallo di tempo _(ignoto, non contribuisce al modello)_, sapendo che *mediamente* se ne verificano un numero $lambda in (0, +infinity)$. Tutti gli eventi sono *indipendenti*.
Il modello ha supporto $D_X = {0, ..., +infinity}$.

$ mr(X tilde P(lambda)) $

/ Funzione di massa:
$ p_X (x) = P(X = x)= mr(e^(-lambda) dot (lambda^x)/x! I_{0, ..., +infinity} (x)) $

#figure(caption: [Funzione di massa modello di Poisson], image("imgs/poisson-massa.png", width: 40%))

/ Valore atteso:

$ E[X] = mr(lambda) $

#dimostrazione[
  Usando la definizione:
  $ E[X] &= sum_(i=0)^(+infinity) i dot p_X (i) \
    &= sum_(i=1)^(+infinity) i e^(-lambda) (lambda^i)/i! \
    &= e^(-lambda) sum_(i=1)^(+infinity) i (lambda^i)/i! \
    &= e^(-lambda) sum_(i=1)^(+infinity) cancel(i) (lambda^i)/(cancel(i)(i-1)!) \
    &= e^(-lambda) sum_(i=1)^(+infinity) (lambda (lambda^(i-1)))/(i-1)! \
    &= lambda e^(-lambda) sum_(i=1)^(+infinity) (lambda^(i-1))/(i-1)! $

  Poniamo $j = i-1$ e applichiamo lo sviluppo in serie di Taylor:

  $ &= lambda e^(-lambda) sum_(j=0)^(+infinity) (lambda^j)/(j!) \
    &= lambda e^(-lambda) e^lambda = lambda $

  #nota[
    Dal secondo passaggio in poi l'indice della sommatoria $i$ parte da 1 e non da 0. Questo perché moltiplicando tutto per $i$ se $i = 0$ il contributo alla sommatoria sarà nullo
  ]
]

/ Varianza:
$ "Var"(X) = mr(lambda) $

#dimostrazione[
  $ E[X^2] = sum_(i=1)^(+infinity) i^2 e^(-lambda) (lambda^i)/i! = mb(lambda^2 + lambda) $

  $ "Var"(X) = mb(E[X^2]) - E[X]^2 = mb(lambda^2 + lambda) - (lambda)^2 = lambda $
]

/ Approssimazione #link(<binomiale>)[binomiale]:

È possibile usare una variabile aleatoria di Poisson per approssimare una variabile aleatoria #link(<binomiale>)[binomiale] di parametri $(n, p)$, quando $n$ è molto grande e $p$ molto piccolo.

$ X tilde B(n, p) approx X tilde P(n dot p) $

#dimostrazione[
  Poniamo $lambda = n p$.
  $ P(X = i) &= binom(n, i) p^i (1-p)^(n-i) \
    &= binom(n, i)(lambda/n)^i (1- lambda/n)^(n-i) \
    &= (n(n-1)...(n-i+1)cancel((n-i)!))/(cancel((n-i)!) dot i!) dot lambda^i / n^i (1-lambda/n)^(n-i) \
    &= (n(n-1)...(n-i+1))/n^i dot lambda^i / i! dot (1-lambda/n)^(n-i) \
    &= mo(n/n dot (n-1)/n dot ... dot (n-i+1)/n) dot lambda^i / i! dot (1-lambda/n)^(mb(n)-mp(i)) $
  Dato che $n -> +infinity$ allora $mb((1-lambda/n)^n) approx e^(-lambda)$, $mp((1-lambda/n)^i) approx 1$, $mo(n/n dot (n-1)/n dot ... dot (n-i+1)/n) approx 1 $
  Allora:
  $ &= mo(1) dot lambda^i/i! dot mb(e^(-lambda)) dot mp(1) \
  &= P(X = i) approx lambda^i/i! e^(-lambda) $
]

/ Riproducibilità:
Date due variabili aleatorie $X_1 tilde P(lambda_1)$ e $X_2 tilde P(lambda_2)$ indipendenti, allora: $ X_1 + X_2 tilde P(lambda_1 + lambda_2) $

Se le due variabili aleatorie sono anche identicamente distribuite allora: $ X_1 + X_2 tilde P(2lambda) $

==== Modello ipergeometrico $X tilde H(n, M, N)$ <ipergeometrico>

La variabile assume il numero di *oggetti corretti* estratti da un'urna di oggetti binari _(corretti o scorretti)_ durante un'*estrazione senza reimmissione* dopo $n$ estrazioni. Il supporto del modello è ${max(0, n-M), ..., min(n, N)}$ e i parametri sono:
- $n in bb(N)^+$: numero di estrazioni
- $N in {0, ..., n}$: numero di oggetti _"corretti"_
- $M in {0, ..., n}$: numero di oggetti _"errati"_

$ mr(X tilde H(n, M, N)) $

#nota[
  In caso ci fossero reimmissioni è possibile usare il #link(<binomiale>)[modello binomiale]
]

#informalmente[
  Il #text(blue)[minor numero] di oggetti _corretti_ estraibili è: $max(0, "estrazioni" - "errati") = mb(max(0, n - M))$.

  Il #text(purple)[massimo numero] di oggetti _corretti_ estraibili è: $min("estrazioni", "corretti") = mp(min(n, N))$.

  Di conseguenza, il supporto del modello è: $ {mb(max(0, n-M)), ..., mp(min(n, N))} $
]

#nota[
  È possibile indicare il modello anche come $X tilde I(n, M, N)$
]

/ Funzione di massa:

$ p_X (x) = P(X = x) =  mr((binom(N, x) binom(M, n-x)) / binom(N+M, n) I_{0, ..., n} (x)) $

#figure(caption: [Funzione di massa modello ipergeometrico], image("imgs/ipergeometrica-massa.png", width: 40%))

#informalmente[
  - $binom(N, x)$ rapresenta il numero di modi in cui è possibile estrarre $x$ oggetti _corretti_ su $N$ _corretti_ totali
  - $binom(M, n-x)$ rapresenta il numero di modi in cui è possibile estrarre $n-x$ (quindi i rimanenti) oggetti _errati_ su $M$ _errati_ totali
  - $binom(N+M, n)$ rappresenta il _totale_ delle possibili estrazioni di $n$ oggetti dal totale $N+M$ degli oggetti
]

#dimostrazione[
  Per dimostrare la funzione di massa di basiamo sul calcolo delle disposizioni semplici di $T$ _oggetti_ su $w$ _posti_.
  #nota[
    Stiamo usando nuovi nomi per le variabili, che andremo a riconvertire alla fine:
    - Oggetti totali: $T = N+M$
    - Posti totali (estrazioni): $w = n$
    - Oggetti corretti: $C = N$
    - Oggerri errati: $T-C = M$
    - Posti oggetti corretti: $g = x$
    - Posti oggetti errati: $w-g = n-x$
  ]
  Dato che siamo in uno #link(<spazio-probabilita>)[spazio equiprobabile], vale la legge: $ P(E) = (|E|) / mo(|Omega|) $
  Dove l'insieme degli eventi possibili è:
  $ mo(|Omega|) = T! / (T-w)! $
  E tutte le possibili sequenze di $w$ oggetti di cui $g$ corretti:
  $ |E| = mb(o_1) dot mp(o_2) dot mg(o_3) $
  Dove:
  - $o_1$ sono tutti i modi di scegliere le $g$ posizioni in cui compare un oggetto corretto
    $ mb(o_1) = binom(w, g) $
  - $o_2$ è il numero di scelte possibili per gli oggetti corretti da destinare alle $g$ posizioni senza che siano reimmessi
    $ mp(o_2) = C! / (C-g)! $
  - $o_3$ è il numero di scelte possibili per gli oggetti errati da destinare alle posizioni rimanenti
    $ mg(o_3) = (T-C)! / ((T-C) - (w-g))! $
  Quindi:
  $ P(E) = (|E|) / mo(|Omega|) &= mb(binom(w, g)) dot mp(C! / (C-g)!) dot mg((T-C)! / ((T-C) - (w-g))!) dot mo((T-w)! / T!) \
    &= (binom(C, g) binom(T-C, w-g)) / binom(T, w) = (binom(N, i) binom(M, n-i)) / binom(N+M, n) $
]

/ Valore atteso:
$ E[X] = mr((n dot N)/(N+M)) $

#dimostrazione[
  Scomponiamo la variabile in $n$ variabili #link(<bernoulliano>)[aleatorie bernoulliane] _NON indipendenti_ definite:
  $ X_i = cases(1 quad "oggetto corretto", 0 quad "oggetto errato") $
  Essendo bernoulliane, vale:
  $ P(X_i = 1) = M / (N+M) = E[X_i] = p $
  Quindi:
  $ E[X] &= E[sum_(i=1)^n X_i] \
    &= sum_(i=1)^n E[X_i] \
    &= n dot p \
    &= n N/(N+M) $
]

/ Varianza:
$ "Var"(X) &= mr((n (N + M - n) N M) / ((N + M)^2 (N + M - 1))) $

#nota[
  Per $N+M -> infinity$ il modello si semplifica in un #link(<binomiale>)[modello binomiale]
]

#dimostrazione[
  Scomponiamo la variabile in $n$ variabili #link(<bernoulliano>)[aleatorie bernoulliane] _NON indipendenti_ come per il valore atteso.
  $ "Var"(X_i) &= E[X_i] (1-E[X_i]) \
    &= (N/(N+M)) (1 - N / (N+M)) \
    &= M / (N+M) dot M / (N+M) \
    &= mo((N M) / (N+M)^2) $
  Non essendo indipendenti, è necessario usare la #link(<multivariate-varianza>)[formula generale] della somma di variabili aleatorie:
  $ mp("Var"(sum_(i=1)^n X_i)) = mg(sum_(i=1)^n) mo("Var"(X_i)) + mg(sum_i^n sum_(i != j)^n) mb("Cov"(X_i, X_j)) $
  Sappiamo che:
  $ mb("Cov"(X_i, X_j)) &= E[X_i dot X_j] - E[X_i] dot E[X_j] \
   &= mr(- (N M) / ((N + M - 1)(N+M)^2)) $
  Quindi:
  $ mp("Var"(X)) &= mg(n) mo((N M)/(N+M)^2) - mg(n(n-1)) dot mr((N M) / ((N+M-1)(N+M)^2)) \
   &= (n N M) / (N + M)^2 (1 - (n-1)/(N+M-1)) \
   &= n (n/(N+M)) (M/(N+M)) (1- (n-1)/(N+M-1)) \
   &= n p (1-p) (1 - (n-1)/(N+M-1)) \
   &= (n (N + M - n) N M) / ((N + M)^2 (N + M - 1)) $
]

=== Modelli di distribuzione continui

Alcune _distribuzioni/modelli_ di variabili aleatorie sono molto _frequenti_, di conseguenza esistono dei risultati notevoli.

==== Modello uniforme continuo $X tilde U(a,b)$ <uniforme-continuo>

La variabile assume un valore nell'*intervallo* $[a,b]$, di conseguenza il supporto è $D_X = [a, b]$. Tutti gli esiti della variabile aleatoria continua sono *equiprobabili*.

$ mr(X tilde U(a,b)) $

/ Funzione di densità di probabilità:
$ f_X (x) = mr(1/(b-a) I_[a,b] (x)) $

#attenzione[
  La funzione di _densità_ *non* è la _probabilità_ nel punto, ma è l'_ordinata_ della funzione in quel punto, che poi deve essere _integrata_ in un intervallo per ottenere la probabilità
  $ P(X = x) != f(x), quad P(X = x) = 0 $
  $ P(a <= X <= b) = integral_a^b f(x) dif x $
]

#figure(caption: [Funzione di densità modello uniforme continuo], image("imgs/uniforme-continuo-densita.png", width: 40%))

#dimostrazione[
  Sappiamo che la $limits(integral)_(-infinity)^(+infinity) f_X (x) dif x$ deve essere uguale a $1$, quindi possiamo ricavare la funzione di densità $f_X$, sostituendola con l'incognita $alpha$:

  $ integral_(-infinity)^(+infinity) a &= integral_(a)^(b) alpha dif x \
     &= alpha integral_(a)^(b) 1 dif x \
     &= alpha[x]^b_a \
     &= alpha (b-a) \
     &= alpha = 1/(b-a) $

  Possiamo quindi ricavare $f_X$: $ f_X (x) = 1/(b-a) $
]

/ Funzione di ripartizione:
$ F_X (x) = P(X <= x) = mr((x-a)/(b-a) I_[a,b] (x) + I_((b,+infinity)) (x)) $

#figure(caption: [Funzione di ripartizione modello uniforme continuo], image("imgs/uniforme-continuo-ripartizione.png", width: 40%))

#dimostrazione[
  $ F_X (x) &= integral_(a)^(x) f_(X)(y) dif y \
    &= integral_(a)^(x) 1 / (b-a) dif y \
    &= 1 / (b-a) integral_(a)^(x) 1 dif y \
    &= 1 / (b-a) [y]^x_a = (x-a)/(b-a) $
]

/ Valore atteso:
$ E[X] = mr((b + a) / 2) $

#dimostrazione[
  $ E[X] &= integral_a^b f_X (x) dif x \
    &= integral_a^b x dot 1/(b-a) dif x \
    &= 1/(b-a) integral_a^b x dif x \
    &= 1/(b-a) dot [x^2 / 2]_a^b \
    &= 1/(b-a) dot (b^2 - a^2)/2 \
    &= 1/cancel(b-a) dot ((a+b)cancel((b-a)))/2 \
    &= (a+b) / 2 $
]

#nota[
  $ E[X^2] = (a^2 + a b + b^2) / 3  $
]

/ Varianza:
$ "Var"(X) = mr(((b-a)^2)/12) $


==== Modello esponenziale $X tilde E(lambda)$ <esponenziale>

La variabile assume il *tempo di attesa* tra due eventi, che mediamente accadono ogni $lambda in (0, +infinity)$ unità di tempo. La probabilità che questa attesa si _allunghi_ decresce in maniera _esponenziale_. Il supporto è $D_X = [0, +infinity)$.

$ mr(X tilde E(lambda)) $

/ Funzione di densità:
$ f_X (x) = mr(lambda e^(-lambda x) I_[0, +infinity) (x)) $

#attenzione[
  La funzione di _densità_ *non* è la _probabilità_ nel punto, ma è l'_ordinata_ della funzione in quel punto, che poi deve essere _integrata_ in un intervallo per ottenere la probabilità
  $ P(X = x) != f(x), quad P(X = x) = 0 $
  $ P(a <= X <= b) = integral_a^b f(x) dif x $
]

#figure(caption: [Funzione di massa modello esponenziale], image("imgs/esponenziale-densita.png",  width: 40%))

/ Funzione di ripartizione:
$ F_X (x) = mr((1 - e^(-lambda x)) I_[0, +infinity) (x)) $

#dimostrazione[
  $ F_X (x) &= integral_0^x f_X (u) dif u \
    &= integral_0^x lambda e^(-lambda u) dif u $
  Risolvo per sostituzione, con $z = lambda u$, quindi $u = z/lambda$ e $dif u = 1/lambda dif z$:
  $ &= integral_0^(lambda x) cancel(lambda) e^(-z) 1/cancel(lambda) dif z \
    &= [-e^(-z)]_0^(lambda x) \
    &= -e^(-lambda x) - e^0 = 1 - e^(-lambda x) $
]

#figure(caption: [Funzione di massa modello esponenziale], image("imgs/esponenziale-ripartizione.png",  width: 40%))

/ Valore atteso:
$ E[X] = mr(1/lambda) $

#dimostrazione[
  $ E[X] &= integral_0^(+infinity) x f_X (x) dif x $
  Risolvo per parti:
  $ &= [-x e^(-lambda x)]_0^(+infinity) + integral_0^(+infinity) e^(-lambda x) dif x \
    &= integral_0^(+infinity) e^(-lambda x) dif x \
    &= 1/lambda dot underbrace(integral_0^(+infinity) lambda e^(-lambda x) dif x, "per definizione di densità" =1) = 1/lambda $
]

#nota[
  $ E[X^2] = 2/lambda^2 $
]

/ Varianza:
$ "Var"(X) = mr(1/lambda^2) $

#dimostrazione[
  $ "Var"(X) = E[X^2] - E[X]^2 = 2/lambda^2 - 1/lambda^2 = 1/lambda^2 $
]

/ Assenza di memoria:

Unica distribuzione continua con questa proprietà:
$ P(X >= s + t | X >= s) = P(X >= t) $

#dimostrazione[
  $ P(X >= s + t | X >= s) &= P(X >= t) \
    P(X >= s + t, X >= s)/P(X >= s) &= P(X >= t) \
    P(X >= s + t)/P(X >= s) &= P(X >= t) \
    P(X >= s + t) &= P(X >= t) dot P(X >= s) $
  Ricordiamo che $P(X>= x) = 1- F_X (x) = e^(-lambda x)$
  Quindi:
  $ e^(-lambda (s+t)) = e^(-lambda t) dot e^(-lambda s) $
  Che non è altro che l'identità, come volevasi dimostrare
]

/ Scalatura:
Sia $X tilde E(lambda)$ e $Y = a X$ (scalatura con $a > 0$), allora $ Y tilde E(lambda/a) $

#dimostrazione[
  $ F_Y (x) &= P(Y <= x) \
    &= P(a X <= x) \
    &= P(X <= x/a) $
  $ F_X (x/a) &= 1 - e^(-lambda x/a) \
    &= 1 - e^(-lambda/a x) $
  Sostituiamo $lambda' = lambda/a$, per cui:
  $ F_Y (x) = 1-e^(-lambda' x) ==> Y tilde E(lambda') = E(lambda/a) $
]

/ Proprietà su massimo e minimo:
Siano $X_1, ..., X_n$ variabili aleatorie indipendenti e sia $Y$ il massimo di esse $Y = max_i X_i$, allora:
$ F_Y (x) = product_(i=1)^n F_(X_i) (x) $

Nel caso le variabili aleatorie siano _indipendenti identicamente distribuite_, allora:
$ F_Y (x) = F_X (x)^n $

Siano $X_1, ..., X_n$ variabili aleatorie indipendenti e sia $Z$ il minimo di esse $Z = min_i X_i$, allora:
$ F_Z (x) = 1 - product_(i=1)^n (1 - F_(X_i) (x)) $

Nel caso le variabili aleatorie siano _indipendenti identicamente distribuite_, allora:
$ F_Z (x) = 1- (1-F_X (x))^n $

Siano $X_1, ..., X_n$ variabili aleatorie indipendenti e sia $Z = min_i X_i$. Se $forall i, X_i tilde E(lambda_i)$, allora:
$ Z tilde E(sum_(i=1)^n lambda_i) $

Se $X tilde E(lambda)$ e $Y = c X$ con $c in R^+$, allora $Y$ è una variabile aleatoria esponenziale di parametro $lambda/c$:
$ F_Y (x) = 1 - e^(-lambda/c x) $

==== Modello Gaussiano (o normale) $X tilde N(mu, sigma)$ <gaussiano>

Facendo *tante osservazioni* dello *stesso fenomeno*, misureremo molte volte valori vicini alla media, mentre sempre meno volte valori lontani da essa. Graficando le probabilità otteniamo la classica forma a *campana*.

Formalizzando questo concetto in una variabile aleatoria, otteniamo una distribuzione normale o Gaussiana. I parametri $mu$ e $sigma$ descrivono la forma della campana, essendo la _media_ (quindi il centro) e la _deviazione standard_ (quindi la larghezza).

#attenzione[
  Questo modello non ha funzione indicatrice, è definito su tutto $bb(R)$
]

$ mr(X tilde N(mu, sigma)) $

/ Funzione di densità:
$ f_X (x) = mr(1/(sigma sqrt(2 pi)) dot e^(-(x-mu)^2 / (2 sigma^2))) $

#attenzione[
  La funzione di _densità_ *non* è la _probabilità_ nel punto, ma è l'_ordinata_ della funzione in quel punto, che poi deve essere _integrata_ in un intervallo per ottenere la probabilità
  $ P(X = x) != f(x), quad P(X = x) = 0 $
  $ P(a <= X <= b) = integral_a^b f(x) dif x $
]

/ Funzione di ripartizione:
#attenzione[
  Non è nota una forma analitica
]

$ F_X (x) = P(X <= x) = mr(integral_(-infinity)^x 1 / (sigma sqrt(2 pi)) dot e^((- (x - mu)^2)/(2 sigma^2)) dif x) $

#nota[
  Data una qualsiasi variabile aleatoria $X tilde N(mu, sigma)$, è possibile trovare la funzione di ripartizione #link(<normale-standard>)[standard]:
  $ F_X (x) = Phi((x-mu)/sigma) $

  #dimostrazione[
  $ F_X (x) &= P(X <= x) \
    &= P((X-mu)/sigma <= (x-mu)/sigma) \
    &= P(Z <= (x - mu)/sigma) \
    &= F_Z ((x-mu)/sigma) = Phi((x-mu)/sigma) $
  ]
]

/ Valore atteso:
$ E[X] = mr(mu) $

/ Varianza:
$ "Var"(X) = mr(sigma^2) $

/ Riproducibilità:
Date le variabili aleatorie $X_1, ... X_n$ gaussiane e indipendenti, dove $forall i, X_i tilde N(mu_i, sigma_i)$, allora:
$ Y tilde N(sum_(i=1)^n mu_i, sqrt(sum_(i=1)^n sigma^2_i)) $

#nota[
  Questa proprietà è condivisa dal modello #link(<binomiale>)[binomiale] e #link(<ipergeometrico>)[ipergeometrico]
]

/ Eventi simmetrici:
Una qualsiasi variabile che segue la distribuzione normale ha una curva _simmetrica_ rispetto al centro ($mu$), di conseguenza:
$ F_X (-x) = 1 - F_X (x) $

#figure(caption: [Le due parti non evidenziate della curva sono identiche, quindi $F(-1) = 1 - F(1)$], image("imgs/normale-simmetria.png",  width: 40%))

===== Distribuzione normale standard <normale-standard>

Siano $X tilde N(mu, sigma^2)$ e $Y = a X + b$ con $a,b in bb(R), a != 0$, allora:
$ Y tilde N(a mu +b, a^2, sigma^2) $

Data una qualsiasi variabile aleatoria di distribuzione normale, possiamo calcolare la sua *standardizzazione*, indicata con $Z$:
$ Z = (X - mu)/sigma = Z tilde N(0,1) $

#dimostrazione[
  Valore atteso:
  $ E[Z] &= 1/sigma E[X] - mu/sigma \
    &= 1/sigma (E[X] - mu) \
    &= 1/sigma (mu - mu) = 0 $
  Varianza:
  $ "Var"(Z) &= 1/sigma^2 "Var"(X) \
    &= 1/cancel(sigma^2) cancel("Var"(X)) = 1 $
]

/ Funzione di ripartizione $Phi$:

La *funzione di densità* e la *funzione di ripartizione* di una variabile aleatoria normale standard si indicano con $phi_Z (x)$ e $Phi_Z (x)$:
$ Phi_Z (x) = mr(1/sqrt(2 pi) integral_(-infinity)^x e^(-(u^2)/2) dif u) $

#informalmente[
  Portando una curva normale in una curva standard, _perdiamo informazione_ (la curva standard è appunto standard, sempre uguale). Per non perdere informazioni, viene applicata la _stessa trasformazione_ direttamente al parametro della funzione $Phi$ nota della variabile standardizzata:
  $ F_X (x) = Phi_Z ((x-mu)/sigma) $

  La dimostrazione non è altro che applicare la stessa trasformazione da entrambe le parti della funzione di probabilità, in modo da ricondurci alla funzione nota $F_Z$:
  $ P(X <= x) = P((X-mu)/sigma <= (x-mu)/sigma) $
]

#nota[
  Si può usare la stessa tecnica per calcolare la probabilità tra due insiemi:
  $ P(a <= x <= b) = Phi(b) - Phi(a) $
]

=== Teorema centrale del limite <teorema-centrale-limite>

Siano $X_1, ... X_n$ variabili aleatorie _indipendenti identicamente distribuite_, ovvero $forall i, E[X_i] = mu, "Var"(X_i) = sigma^2$.
Allora, per $n -> +infinity$ le variabili sono distribuite in modo *approssimativamente normale*:
$ sum_(i=1)^n X_i tilde.dot N(n dot mu, sigma sqrt(n)) $

#attenzione[
  In caso volessimo stimare una media campionaria $overline(X)$ <tcl-media-campionaria>, allora otteniamo:
  $ overline(X) tilde.dot N(mu, sigma/sqrt(n)) $

  #dimostrazione[
    Sappiamo che:
    $ overline(X) = 1/mb(n) sum_(i=1)^n X_i $
    Quindi per linearità:
    $ overline(X) &tilde.dot N((cancel(n) mu)/mb(cancel(n)), (sigma sqrt(n))/mb(n)) \
      overline(X) &tilde.dot N(mu, sigma / sqrt(n)) $
  ]
]

#attenzione[
  // TODO: sistemare questa roba
  In caso di _scalatura/traslazione_ della variabile aleatoria approssimata, l'_approssimazione_ è:
  $ X = overline(X) = 1/n sum_(i=1)^n X_i $
  $ X &tilde.dot N(n mu, sigma sqrt(n)) \
    mb(a) X + mp(b) &tilde.dot N(mb(a) (n mu) + mp(b), mb(|a|) sigma sqrt(n)) $
]

Questa distribuzione si può standardizzare:
$ ((limits(sum)_(i=1)^n X_i) - n mu) / (sigma sqrt(n)) tilde.dot N(0,1) $

Quindi per $n$ grande e $x$ qualsiasi, vale l'approssimazione:
$ P(((limits(sum)_(i=1)^n X_i) - n mu) / (sigma sqrt(n)) < x) approx Phi(x) $

#informalmente[
  Quando abbiamo una *generica* variabile aleatoria $X$ che segue una _distribuzione ignota_, allora possiamo vederla come la *somma di tante osservazioni* $X_1, ..., X_n$, ognuna con $E[X_i] = E[X]$ e $"Var"(X_i) = "Var"(X)$. Ogni osservazione è una variabile aleatoria *indipendente e identicamente distribuita*.

  Facendo tante osservazioni, grazie al teorema centrale del limite, possiamo approssimare la somma $sum_i X_i$ come una distribuzione normale

  #attenzione[
    Non stiamo approssimando la _variabile_ aleatoria $X$, ma la _somma_ di tante sue osservazioni $sum_i X_i$
  ]
]

#nota[
  È possibile approssimare una variabile #link(<binomiale>)[binomiale] $X tilde B(n, p)$ con $n$ grande utilizzando il teorema:
  $ X = sum_(i=1)^n X_i tilde.dot N(n p, sqrt(n p (1-p))) \
  (x - n p)/sqrt(n p (1-p)) tilde.dot N(0,1) $
]

= Statistica inferenziale <inferenziale>

La statistica inferenziale vuole _analizzare_ e _trarre risultati_ da campioni selezionati da _grandi popolazioni_. Viene ipotizzato che i valori numerici del campione seguano dei _modelli_, quindi vengono trattati come *variabili aleatorie* di una distribuzione non conosciuta $F$.

/ Inferenza: processo di induzione con cui si cerca di _formare delle ipotesi_, ovvero a partire da specifiche manifestazioni si cerca di determinare la verità generale

/ Popolazione: grande insieme di oggetti descritti da una variabile aleatoria $X tilde F$

/ Campione: _sottoinsieme_ della popolazione usato per studiare le leggi. Si estraggono i campioni in modo casuale (per questo motivo si assume indipendenza). Viene descritto come una successione di variabili aleatorie $X_1, ... X_n$ _indipendenti identicamente distribuite_, con $n$ grandezza del campione

La statistica inferenziale permette di capire quale distribuzione descrivere le osservazioni, attraverso due metodologie:

- *Statistica inferenziale non parametrica* _(non trattata nel corso)_: la distribuzione $F$ è completamente sconosciuta

- *Statistica inferenziale parametrica*: della distribuzione $F$ è conosciuta solo la famiglia, mentre sono sconosciuti i parametri. Indichiamo la distrbuzione con $F(theta)$, dove $theta$ è il parametro sconosciuto di cui stimiamo il valore:
  - *stima puntuale*: forniamo un numero molto vicino a $theta$
  - *stima per intervalli*: forniamo un intervallo di valori in cui ricade $theta$

#nota[
  Spesso ci interessa un valore che _dipende_ dal parametro ignoto $theta$, non $theta$ stesso. Questo valore lo indichiamo come $tau(theta)$
]

/ Statistica / Stimatore: funzione $t : D_X^n -> bb(R)$ che dati dei valori, stima il valore che ci interessa: $ t(x_1, ..., x_n) = hat(tau) approx tau(theta) $

#nota[
  Dato che il campionamento è casuale, diversi campioni $(x_1, ..., x_n)$ della stessa popolazione danno $hat(tau)$ diversi, per cui $hat(tau) approx tau(theta)$
]

/ Variabile aleatoria per stimatore: indichiamo con $T$ la variabile aleatoria che indica una stima, ricevendo delle variabili aleatorie (non più dei valori):
$ T = t(X_1, ..., X_n) = hat(t) approx tau(theta) $

== Stimatori non deviati <stimatore>

Uno stimatore $T$ è *non deviato* (*non distorto* o *corretto*) per $tau(theta)$ se e solo se:
$ E[t(X_1, ..., X_n)] = tau(theta) $

#nota[
  $E[t(X_1, ..., X_n)]$ descrive la *centralità* della stima, quindi per essere corretta deve posizionarsi attorno a $tau(theta)$
]

#attenzione[
  Quando due stimatori sono *non* deviati, allora si possono confrontare attraverso la loro *varianza*
]

=== Media campionaria

Un ottimo stimatore *non deviato* per stimare il *valore atteso*, indipendentemente dalla distribuzione, è quello della media:
$ t(x_1, ..., x_n) = overline(X) = 1/n sum_(i=1)^n x_i quad quad tau(theta) = E[X] $

#dimostrazione[
  $ E[T] &= E[1/n sum_(i=1)^n X_i] \
    &= 1/n E[sum_(i=1)^n X_i] \
    &= 1/n sum_(i=1)^n E[X_i] = cancel(n/n) dot E[X] $
]

Abbiamo dimostrato che lo stimatore non è deviato. Per valutarne la bontà ne calcoliamo la varianza:

$ "Var"(overline(X)) = "Var"(1/n sum_(i=1)^n X_i) = "Var"(X)/n $

Quindi per $n -> +infinity$ la varianza tende a 0: per campioni più grandi il risultato è più preciso.

#informalmente[
  La varianza di uno stimatore non distorto descrive le *"oscillazioni"* intorno a $tau(theta)$
]

== Bias e Scarto quadratico medio (MSE)

Il *bias* è una misura di quanto uno stimatore tende a _sottostimare_ o _sovrastimare_ $tau(theta)$, è definito come:
$ b_tau(theta) (T) = E[T] - tau(theta) $

#attenzione[
  Il bias di uno _stimatore_ *non* distorto è $0$
]

L'errore quadratico medio (MSE) è un'altra misura dell'errore che uno stimatore compie stimando $tau(theta)$. È definito come:
$ "MSE"_tau(theta) (T) = E[(T_n - tau(theta))^2] $
$ "MSE"_tau(theta) (T) = "Var"(T_n) + b_tau(theta) (T_n)^2 $

#dimostrazione[
  $ "MSE"_tau(theta) &= E[(T - tau(theta))^2] \
    &= E[(mb(T - E[T]) + mp(E[T] - tau(theta)))^2] \
    &= E[mb((T-E[T])^2) + 2 mb((T- E[T])) mp((E[T] - tau(theta))) + mp((E[T] - tau(theta))^2)] \
    &= mo(E[(T - E[T])^2]) + cancel(2(E[T] - tau(theta))mr(E[T-E[T]])) + mg((E[T] - tau(theta))^2) $
  Sappiamo che $mr(E[X - E[X]]) = 0$, allora:
  $ mo(E[(T - E[T])^2]) + mg((E[T] - tau(theta))^2) =\
   mo("Var"(T)) + mg(underbrace((E[T] - tau(theta))^2, "bias")) $
]

#informalmente[
  Lo scarto quadratico medio e il bias sono due metodi per calcolare la _bontà_ di uno _stimatore_.

  Se immaginiamo la quantità da stimare come un bersaglio, possiamo vedere:
  - il _bias_ come la distanza tra centro del bersaglio e il punto in cui "mira" lo stimatore
  - lo _scarto quadratico medio_, la precisione dei "colpi" attorno al punto "mirato"
]

== Consistenza in media quadratica

La consistenza in media quadratica implica che non solo lo stimatore è *corretto in media*, ma anche che le sue *variazioni* attorno al valore stimato $tau(theta)$ diminuiscono con l'aumentare del campione ${X_1, ..., X_n}$, quindi uno stimatore gode della proprietà di *consistenza in media quadratica* se:
$ lim_(n->infinity) "MSE"_tau(theta) (T_n) = 0 $

#informalmente[
  Se all'aumentare delle osservazioni, l'_errore diminuisce_ sempre di più (fino a tendere a $0$), allora lo stimatore è consistente in media quadratica
]

/ Consistenza debole: uno stimatore è debolmente consistente rispetto a $tau(theta)$ se
  $ forall epsilon > 0, quad lim_(n -> +infinity) P(tau(theta) - epsilon <= T <= tau(theta) + epsilon) = 1 $

  #nota[
    La consistenza in media quadratica _implica_ la _consistenza debole_

    #dimostrazione[
      $ P(-epsilon <= T - tau(theta) <= epsilon) &= P(|T - tau(theta)| <= epsilon) \
        &= P((T - tau(theta))^2 <= epsilon^2) \
        &= 1 - P((T - tau(theta))^2 > epsilon) $
      Per la #link(<disuguaglianza-markov>)[disuguaglianza di Markov]:
      $ = 1 - P((T - tau(theta))^2 > epsilon) &>= 1 - (E[(T - tau(theta))^2])/epsilon^2 \
        &>= 1 - mb("MSE"_tau(theta) (T))/epsilon^2 $
      Dato che $limits(lim)_(n -> infinity) mb("MSE"_tau(theta) (T)) = 0$, allora:
      $ 1 - mb(0) = 1 $
    ]
  ]

== Legge dei grandi numeri

#informalmente[
  Date $n$ osservazioni $X_1, ..., X_n$ con $n -> infinity$, allora la media campionaria $overline(X)_n$ converge al valore atteso di ogni $X_i$: $ lim_(n->+infinity) overline(X)_n = E[X_i] = mu $
]

=== Legge forte dei grandi numeri:
Data una media campionaria $overline(X)_n$ su $n$ elementi, se $n -> +infinity$ allora la probabilità che essa stimi $E[X] = mu$ vale 1:
$ P(lim_(n->+infinity) overline(X)_n = mu) = 1 $

#nota[
  Quindi per campioni di grandezza infinita, la _media campionaria_ non è una _variabile aleatoria_ ma una _costante_
]

=== Legge debole dei grandi numeri:
Data una media campionaria $overline(X)_n$ su $n$ elementi, se $n -> +infinity$ allora la probabilità che essa stimi $E[X] = mu$ con un errore $>$ di un $epsilon$ fissato vale 9:

$ lim_(n->+infinity) P(abs(overline(X)_n - mu) > epsilon) = 0 $

#informalmente[
  Questo risultato è semplicemente "l'inverso" della _legge forte dei grandi numeri_, se la stima è sempre corretta $P(...) = 1$, allora l'errore non è mai superiore $P(...) = 0$ ad $epsilon$
]

== Taglia minima di un campione

Data una variabile aleatoria $X$ vogliamo stimare la taglia minima $n$ di un campione tale che abbia probabilità molto alta di avere il valore di $overline(X)$ molto vicino al valore atteso $mu$:
$ P(|overline(X)_n - mu| <= epsilon) >= 1 - delta $

=== Con teorema del limite centrale:

Troviamo prima la probabilità, per poi confrontarla con $1 - delta$:

$ P(abs(overline(X)- mu) <= epsilon) &= P(-epsilon <= overline(X) - mu <= epsilon) $

Per calcolare questa _probabilità_, vogliamo ricondurci ad una _distribuzione nota_ e sfruttare la sua _funzione di ripartizione_. Dato che la media campionaria è una somma, possiamo sfruttare il #link(<teorema-centrale-limite>)[teorema centrale del limite] per ricavare una #link(<gaussiano>)[distribuzione normale], #link(<normale-standard>)[standardizzarla] e usare $Phi$ per calcolare la probabilità.

Quindi, come dimostrato in #link(<tcl-media-campionaria>)[precendeza], sappiamo che:
$ overline(X) tilde.dot N(mo(mu), mp(sigma/sqrt(n))) $

Normalizziamo la $overline(X)$ all'interno della probabilità:
$ P(-epsilon/(sigma/sqrt(n)) <= mb((overline(X) - mo(mu)) / mp(sigma/sqrt(n))) <= epsilon/(sigma/sqrt(n))) &= P((-epsilon sqrt(n))/sigma <= mb(Z) <= (epsilon sqrt(n))/sigma)\
&= Phi((epsilon sqrt(n))/sigma) - Phi(-(epsilon sqrt(n))/sigma)\
&= Phi((epsilon sqrt(n))/sigma) - (1 - Phi((epsilon sqrt(n))/sigma))\
&= Phi((epsilon sqrt(n))/sigma) - 1 + Phi((epsilon sqrt(n))/sigma)\
&= 2 Phi((epsilon sqrt(n))/sigma) - 1 $

Confrontiamolo con $1 - delta$:

$ 2 Phi((epsilon sqrt(n))/sigma) - 1 >= 1 - delta \
Phi((epsilon sqrt(n))/sigma) >= 1 - delta/2 \
(epsilon sqrt(n))/sigma >= Phi^(-1)(1 - delta/2) \
n >= sigma^2/epsilon^2 dot (Phi^(-1)(1 - delta/2))^2 $

#nota[
  $Phi^(-1)(x)$ è l'inversa della funzione di ripartizione della #link(<normale-standard>)[normale standard], che è uguale al quantile di livello $x$.
  In questo caso vale $Phi^(-1)(1- delta/2) = "quantile di livello" 1 - delta/2$
]

=== Con disuguaglianza di Chebyshev:

Data una variabile aleatoria discreta o continua $X$, con $E[X] = mu$ e $"Var"(X) = sigma^2$, allora per la #link(<chebyshev>)[disuguaglianza di Chebyshev]:
$ forall epsilon > 0, quad P(abs(X - mu) >= epsilon) <= (sigma^2)/(epsilon^2) $

Al posto di usare una variabile generica $X$, utilizziamo la media campionaria $overline(X)$, sostituendo $"Var"(X) = sigma^2$ con $"Var"(overline(X)) = (sigma^2)/n$:
$ forall epsilon > 0, quad mb(P(abs(overline(X) - mu) >= epsilon)) <= (sigma^2)/(n epsilon^2) $

Possiamo trasformare la #text(red)[probabilità che vogliamo trovare] per renderla uguale:
$ mr(P(abs(overline(X) - mu) < epsilon)) &= 1 - mb(P(abs(overline(X) - mu) >= epsilon)) <= mg((sigma^2)/(n epsilon^2)) \
1 - mb(P(abs(overline(X) - mu) >= epsilon)) &>= mg(1 - (sigma^2)/(n epsilon^2)) >= 1 - delta $

#attenzione[
  Effettuando il complementare, viene invertito anche il segno della disequazione ed effettuato il #text(olive)[complementare della quantità]
]

Quindi:
$ 1 - (sigma^2)/(n epsilon^2) >= 1 - delta \
  (sigma^2)/(n epsilon^2) < delta \
  n >= sigma^2 / (delta epsilon^2) $

== Metodo plug-in

Il metodo plug in (o di sostituzione), permette di "costruire" uno _stimatore_ partendo da uno _noto_ o da una _stima di un suo parametro_.

#nota[
  Non abbiamo visto questo metodo nel dettaglio
]

#informalmente[
  Esempio: popolazione = $X tilde B(m,p)$ dove conosco solo $m$, devo trovare $p$:

  Dato che $E[overline(X)] = E[X] = m p$
  $ p = E[overline(X)] dot 1/m $

  Grazie alla linearità del valore atteso:

  $ p = E[overline(X)] dot 1/m = E[overline(X) dot 1/m] $

  Quindi $T = 1/m dot overline(X)$ è uno stimatore non distorto per $p$
]

#informalmente[
  Esempio: abbiamo lo stimatore $S = overline(X)$ e il suo valore atteso $E[S] = a/2 + 4$

  Vogliamo ottenere uno stimatore $T$ non deviato per $a$, quindi:
  $ T = 2S - 4 quad E[T] = a $
]

== Metodo di massima verosomiglianza
// TODO: metodo di massima verosomiglianza

== Processo di Poisson
// TODO: processo di poisson

#pagebreak()
// numerazione appendici
#set heading(numbering: "A.1.")
#counter(heading).update(0)

= Cheatsheet variabili aleatorie e modelli <modelli>

== Variabili aleatorie

=== Proprietà del valore atteso

- il _valore atteso_ di una funzione indicatrice è uguale alla _probabilità dell'evento_:
  $ E[I_A] = P(A) $
- il _valore atteso_ di una variabile aleatoria discreta $X$ opera in modo _lineare_:
  $ Y = a dot X + b quad quad  E[Y] = a dot E[X] + b $
- data una qualsiasi _funzione_ reale $g$ e una variabile aleatoria $X$ con funzione di massa $p$, allora vale:
  $ E[g(X)] = sum_i g(x_i) dot p(x_i) $
  $ E[X^2] = sum_i x_i^2 dot p(x_i) $
  $ E[ |X| ] = sum_i |x_i| dot p(x_i) $
- data una qualsiasi _funzione_ reale $g$ di due variabili e due variabili aleatorie discrete $X, Y$, allora vale: $ E[g(X, Y)] = sum_x sum_y g(x,y) dot p(x,y) $
- il valore atteso della _somma_ di variabili aleatorie discrete è:
  $ E[sum_i X_i] = sum_i E[X_i] $
- il valore atteso del _prodotto_ di variabili aleatorie discrete è:
  $ E[product_i X_i] = product_i E[X_i] $

=== Proprietà della varianza

- la varianza della funzione indicatrice è la probabilità dell'_evento_ moltiplicata per la probabilità dell'_evento complementare_
  $ "Var"(I) = P(A) dot P(overline(A)) $
- la varianza non opera in modo lineare:
  $ "Var"(a X + b) = a^2 "Var"(X) $
- la varianza della somma di due variabili aleatorie $X$ e $Y$ vale:
  $ "Var"(X + Y) = "Var"(X) + "Var"(Y) + 2 "Cov"(X, Y) $
  $ "Var"(X - Y) = "Var"(X) + "Var"(Y) - 2"Cov"(X,Y) $
  #attenzione[
    Se le variabili sono _indipendenti identicamente distribuite_, allora la covarianza vale $0$
  ]
- la varianza della somma di più variabili aleatorie vale:
  $ "Var"(sum_i^n X_i) = sum_i^n "Var"(X_i) + sum_i^n sum_(j, j != i)^n "Cov"(X_i, X_j) $
- la varianza della media campionaria è: $ "Var"(overline(X)) = "Var"(1/n sum_(i=1)^n X_i) = 1/n^2 "Var"(sum_(i=1)^n X_i) = 1/n^2 dot n "Var"(X) = "Var"(X)/n $

=== Proprietà della covarianza

- la covarianza è simmetrica:
  $ "Cov"(X, Y) = "Cov"(Y, X) $
- la covarianza di una variabile aleatoria con sè stessa è uguale alla varianza:
  $ "Cov"(X, X) = "Var"(X) $
- opera in modo lineare:
  $ "Cov"(a X, Y) = "Cov"(X, a Y) = a "Cov"(X, Y) $
  $ "Cov"(X + Y, Z) = "Cov"(X, Z) + "Cov"(Y, Z) $

== Modelli

- #link(<bernoulliano>)[Modello di Bernoulli]: $X tilde B(p)$
  #grid(columns: 2, row-gutter: 15pt, column-gutter: 5pt, align: horizon + left,
    [- Massa:], [$p^x (1-p)^((1-x)) I_{0, 1} (x)$],
    [- Ripartizione:], [$(1-p) I_[0,1)(x) + I_([1, +infinity)) (x)$],
    [- Valore atteso:], [$p$],
    [- Varianza:], [$p(1-p)$]
  )

- #link(<binomiale>)[Modello binomiale]: $X tilde B(n, p)$
  #grid(columns: 2, row-gutter: 15pt, column-gutter: 5pt, align: horizon + left,
    [- Massa:], [$binom(n, x) p^x (1-p)^((n-x)) I_{0, ..., n} (x)$],
    [- Ripartizione:], [$limits(sum)_(i=0)^floor(x) binom(n, i) p^i (1 - p)^((n-i)) I_[0, n] (x) + I_((n, +infinity)) (x)$],
    [- Valore atteso:], [$n p$],
    [- Varianza:], [$n p(1-p)$],
    [- Proprietà:], [riproducibilità]
  )

- #link(<uniforme-discreto>)[Modello uniforme discreto]: $X tilde U(n)$
  #grid(columns: 2, row-gutter: 15pt, column-gutter: 5pt, align: horizon + left,
    [- Massa:], [$1/n I_{1, ..., n} (x)$],
    [- Ripartizione:], [$floor(x)/n I_[1, n] + I_((n, +infinity)) (x)$],
    [- Valore atteso:], [$(n+1)/2$],
    [- Varianza:], [$(n^2 - 1)/12$]
  )

- #link(<geometrico>)[Modello geometrico]: $X tilde G(p)$
  #grid(columns: 2, row-gutter: 15pt, column-gutter: 5pt, align: horizon + left,
    [- Massa:], [$p(1-p)^x I_{0, ..., +infinity} (x)$],
    [- Ripartizione:], [$(1-(1-p) ^ (floor(x) + 1)) I_[0, +infinity) (x)$],
    [- Valore atteso:], [$(1-p)/p$],
    [- Varianza:], [$(1-p)/p^2$],
    [- Proprietà:], [assenza di memoria]
  )

- #link(<poisson>)[Modello di Poisson]: $X tilde P(lambda)$
  #grid(columns: 2, row-gutter: 15pt, column-gutter: 5pt, align: horizon + left,
    [- Massa:], [$e^(-lambda) dot (lambda^x)/(x!) I_{0, ..., +infinity} (x)$],
    [- Ripartizione:], [_non vista nel corso_],
    [- Valore atteso:], [$lambda$],
    [- Varianza:], [$lambda$],
    [- Proprietà:], [approssimazione binomiale, riproducibilità]
  )

- #link(<ipergeometrico>)[Modello ipergeometrico]: $X tilde H(n, M, N)$
  #grid(columns: 2, row-gutter: 15pt, column-gutter: 5pt, align: horizon + left,
    [- Massa:], [$(binom(N, x) binom(M, n-x)) / binom(N + M, n) I_{0, ..., n} (x)$],
    [- Ripartizione:], [_non vista nel corso_],
    [- Valore atteso:], [$(n dot N) / (N + M)$],
    [- Varianza:], [$(n(N + M - n)N M) / ((N+M)^2 (N + M - 1))$]
  )

- #link(<uniforme-continuo>)[Modello uniforme continuo]: $X tilde U(a,b)$
  #grid(columns: 2, row-gutter: 15pt, column-gutter: 5pt, align: horizon + left,
    [- Massa:], [$1 / (b-a) I_[a,b] (x)$],
    [- Ripartizione:], [$(x-a) / (b-a) I_[a,b] (x) + I_((b, +infinity)) (x)$],
    [- Valore atteso:], [$(b+a) / 2$],
    [- Varianza:], [$(b-a)^2 / 12$]
  )

- #link(<esponenziale>)[Modello esponenziale]: $X tilde E(lambda)$
  #grid(columns: 2, row-gutter: 15pt, column-gutter: 5pt, align: horizon + left,
    [- Massa:], [$lambda e^(-lambda x) I_[0, +infinity) (x)$],
    [- Ripartizione:], [$(1 - e^(-lambda x)) I_[0, +infinity) (x)$],
    [- Valore atteso:], [$1/lambda$],
    [- Varianza:], [$1/lambda^2$],
    [- Proprietà:], [assenza di memoria, scalatura, proprietà su massimo e minimo]
  )

- #link(<gaussiano>)[Modello Gaussiano]: $X tilde G(mu, sigma)$
  #grid(columns: 2, row-gutter: 15pt, column-gutter: 5pt, align: horizon + left,
    [- Massa:], [$1 / (sigma sqrt(2 pi)) e^(-(x-mu)^2 / (2 sigma^2))$],
    [- Ripartizione:], [$limits(integral)_(-infinity)^(x) 1 / (sigma sqrt(2 pi)) e^(-(x-mu)^2 / (2 sigma^2)) dif x$],
    [- Valore atteso:], [$mu$],
    [- Varianza:], [$sigma^2$],
    [- Proprietà:], [standardizzazione, riproducibilità]
  )

#figure(caption: "Forma grafici dei modelli")[
  #image("imgs/forma-modelli.png", width: 70%)
]

= Cheatsheet Python <python>

/ Calcolo combinatorio\: utilità:
  ```python
  from math import factorial as fact
  from scipy.special import binom
  # fattoriale
  fact(5) # 120
  # coefficiente binomiale
  binom(5, 2) # 10
  ```

/ Calcolo combinatorio\: combinazioni/disposizioni/permutazioni: solo il numero
  ```python
  # N = numerosità insieme da cui pescare
  # k = numero oggetti da estrarre

  from scipy.special import comb, perm

  # combinazioni, con o senza ripetizioni (ordine non conta)
  comb(N, k, repetition=False)

  # disposizioni (o permutazioni in caso k = N) SENZA RIPETIZIONI (ordine conta)
  perm(N, k)
  ```

/ Calcolo combinatorio\: combinazioni/disposizioni/permutazioni: calcolati davvero
  ```python
  from itertools import product, permutations, combinations, combinations_with_replacement

  # prodotto cartesiano tra insiemi
  product(set1, set2, ..., repeat=1)
  product("ABC", "123", "xy") # ['A1x', 'A1y', 'A2x', 'A2y', 'A3x', 'A3y', 'B1x', 'B1y', 'B2x', 'B2y', 'B3x', 'B3y', 'C1x', 'C1y', 'C2x', 'C2y', 'C3x', 'C3y']
  product([0,1], repeat=3) # ['000', '001', '010', '011', '100', '101', '110', '111']

  # disposizioni (o permutazioni in caso n=None o n = len(set1)) SENZA RIPETIZIONI (ordine conta)
  permutations(set1, n=None)
  permutations("ABC") # ['ABC', 'ACB', 'BAC', 'BCA', 'CAB', 'CBA']
  permutations("ABC", 2) # ['AB', 'AC', 'BA', 'BC', 'CA', 'CB']
  # in caso ci siano duplicati nell'iterabile passato, allora questo metodo NON restituisce le permutazioni di oggetti distinguibili a gruppi
  permutations("ABA") # sbagliato: ['ABA', 'AAB', 'BAA', 'BAA', 'AAB', 'ABA']

  # combinazioni SENZA ripetizioni
  combinations(set1, n)
  combinations("ABC", 2) # ['AB', 'AC', 'BC']

  # combinazioni CON ripetizioni
  combinations_with_replacement(set1, n)
  combinations_with_replacement("ABC", 2) # ['AA', 'AB', 'AC', 'BB', 'BC', 'CC']
  ```

/ Librerie:
  ```python
  import pandas as pd
  import matplotlib.pyplot as plt
  import numpy as np
  import scipy.stats as st
  import statsmodels.api
  import sklearn
  import itertools
  ```

/ Lettura dati:
  ```python
  data = pd.read_csv('file_path/fileName.csv', delimiter=',', decimal=',', quotechar='"')
  ```
  Per avere il numero di righe nel _dataset_:
  ```python
  len(data)
  ```
  Per avere a disposizione gli attributi in corrispondenza ai loro valori mancanti nel _dataset_:
  ```python
  valMancanti = {col : len(data[col]) - len(data[col].dropna()) for col in data.columns}

  dataF = pd.DataFrame(index = valMancanti.keys(), data = valMancanti.values(), columns = ['mancanti'])
  ```

  In alternativa, possibile utilizzare i metodi _*isna().sum()*_ per soddisfare la medesima richiesta:
  ```python
  valMancanti = {col : data[col].isna().sum() for col in data.columns}
  ```

  Frequenze assolute di un dato *qualitativo* in formato tabulare:
  ```python
  data['attributo'].value_counts()
  ```

  Frequenze assolute di un dato *qualitativo* con grafico:
  ```python
  data['attributo'].value_counts().plot.bar()
  ```

  Frequenze relative:
  ```python
  data['attributo'].value_counts(normalize = True)
  ```

  Frequenze assolute di un dato *quantitativo* in formato tabulare:
  ```python
  data['attributo'].value_counts(bins = 20)
  ```

/ Indici di centralità:

  Moda di un carattere:
  ```python
  data['attributo'].mode()
  ```

  Media campionaria di un carattere:
  ```python
  data['attributo'].mean()
  ```

  Mediana di un carattere:
  ```python
  data['attributo'].median()
  ```

/ Indici di dispersione:

  Varianza campionaria:
  ```python
  data['attributo'].var()
  ```

  Deviazione standard campionaria:
  ```python
  data['attributo'].std()
  ```

/ Quantili:

  Quantile di un certo livello:
  ```python
  data['attributo'].quantile(0.25) #in questo caso restituisce il primo quartile
  ```

/ Indici di eterogeneità:

  Indice di Gini fra 2 valori distinti:
  ```python
  def gini_2_val(f):
    return 1 - f**2 - (1-f)**2

  x = np.arange(0, 1.01, .01) # start, stop, step
  y = map(gini_2_val, x)
  plt.plot(x, y)
  plt.ylim((0, 0.55))
  plt.show()
  ```

  Indice di Gini:
  ```python
  def gini(series):
    return 1 - sum(series.value_counts(normalize=True).map(lambda f: f**2))

  # import librerie
  # assegnamento a 'data' delle osservazioni del dataset

  gini(data['attributo'])
  ```

  Entropia fra 2 valori distinti:
  ```python
  def entropia_2_val(f):
      return 0 if f in (0, 1) else - f * np.log2(f) - (1-f) * np.log2(1-f)

  x = np.arange(0, 1.01, .01)
  y = map(entropia_2_val, x)
  plt.plot(x, y)
  plt.ylim((0, 1.1))
  plt.show()
  ```

  Entropia:
  ```python
  def entropia(series):
    return sum(series.value_counts(normalize=True).map(lambda f: -f * np.log2(f)))

  # import librerie
  # assegnamento a 'data' delle osservazioni del dataset

  entropia(data['attributo'])
  ```

/ Diagramma di Pareto:

  ```python
  from paretochart import pareto

  freqAttributo = data['attributo'].value_counts()/len(data)
  attributoComune = freqAttributo[freqAttributo > .02].index

  attributoComune = (data['attributo'][data['attributo'].isin(attributoComune)])

  attributoComune_freq = attributoComune.value_counts()/len(attributoComune)

  pareto(attributoComune_freq, labels=attributoComune_freq.index)
  plt.show()
  ```

/ Funzioni utili per grafici:
  ```python
  plt.grid() # mostrare griglia
  np.linspace(start, stop, campioni) # spesso conviene aumentare il numero di campioni (1000)
  plt.axvline(0.5) # linea verticale a x=0.5
  plt.axhline(0.5) # linea verticale a y=0.5
  ```

/ Parametri utili per funzioni di `plt`:
  - `color="red"` o `colors=["red", "blue"]` (in base al grafico): colorare linea/riempimento
  - `linestyle="dashed"` o `linestyles="dashed"`: stile della linea
  - `read_csv()`

/ Analisi degli elementi del dataset:

  Elemento massimo:
  ```python
  dato = data[data['attributo'] == max(data['attributo'])]
  ```

  Elemento minimo:
  ```python
  dato = data[data['attributo'] == min(data['attributo'])]
  ```

  Tutti i valori assumibili da un carattere:
  ```python
  list(data['attributo'].unique())
  ```

  Tipo e forza della correlazione fra 2 caratteri:
  ```python
  data['attributo 1'].corr(data['attributo 2'])
  ```

  Questa riga di codice restituisce il valore di un indice che ci porta a fare le seguenti valutazioni:
  1. Se il valore restituito è circa $1$, è probabile che vi sarà una *_correlazione lineare diretta_* tra i 2 attributi presi in analisi.
  2. Se il valore restituito è circa $0$, significa che fra i 2 attributi presi in analisi vi è una *_correlazione improbabile_*.
  3. Se il valore restituito è circa $-1$, allora è probabile che i 2 attributi godano di una *_probabile correlazione linearmente indiretta_*.


/ Tabelle congiunte:

  Tabella delle frequenze relative congiunte:
  ```python
  pd.crosstab(data['attributo 1'], data['attributo 2'], normalize = True)
  ```

  Tabella delle frequenze assolute congiunte:
  ```python
  pd.crosstab(data['attributo 1'], data['attributo 2'])
  ```

= Cheatsheet matematica <matematica>

== Sommatorie

Proprità sommatoria:
- solo il primo elemento dopo una sommatoria è il suo _"corpo"_:
  $ sum_(i=1)^3 a + b = 3a + b $
  $ sum_(i=1)^3 (a + b) = 3a + 3b $
- somma dei primi $n$ numeri:
  $ sum_(i=1)^n = (n(n+1))/2 $
- associativitià e dissociatività:
  $ sum_(k=n)^m f(k) + sum_(k=n)^m g(k) = sum_(k=n)^m (f(k) + g(k)) $
- distributività:
  $ a dot sum_(k=n)^m f(k) = sum_(k=n)^m (a dot f(k)) $
- scomposizione indici:
  $ sum_(k=n)^(m_1+m_2) f(k) = sum_(k=n)^(m_1) f(k) + sum_(k=m_1+1)^(m_2) f(k) $
- "portare dentro" somme:
  $ (sum_(i=1)^n a) + b = sum_(i=1)^n (a + b/n) $

== Derivate

L'operatore derivata è un _operatore lineare_, ovvero è possibile:
$ (a dot f(x) + b dot g(x))' = a dot f'(x) + b dot g'(x) $

=== Derivate immediate

#align(center)[
  #table(
    columns: (30%, 30%),
    inset: 5pt,
    align: center + horizon,
    table.cell(fill: silver, [$ f(x) $]),
    table.cell(fill: silver, [$ f'(x) $]),
    [$ n in bb(R) $], [$ 0 $],
    [$ x $], [$ 1 $],
    [$ x^a $], [$ a x^(a-1) $],
    [$ e^x $], [$ e^x $],
    [$ a^x $], [$ a^x ln(a) $],
    [$ ln(x) $], [$ 1/x, x > 0 $],
    [$ ln|x| $], [$ 1/x, x != 0 $],
    [$ log_a (x) $], [$ 1/(x ln(a)), x > 0 $],
    [$ |x| $], [$ (|x|) / x, x != 0 $],
    [$ sin(x) $], [$ cos(x) $],
    [$ cos(x) $], [$ -sin(x) $],
    [$ tan(x) $], [$ 1/(cos^2(x)), x != pi/2 + k pi $],
    [$ cot(x) $], [$ - 1 / (sin^2(x)), x != k pi $],
    [$ arcsin(x) $], [$ 1 / sqrt(1-x^2), x in [-1,1] $],
    [$ arccos(x) $], [$ - 1 / sqrt(1-x^2), x in [-1,1] $],
    [$ arctan(x) $], [$ 1/(1+x^2) $]
  )
]

=== Derivate "avanzate"

#align(center)[
  #table(
    columns: (30%, 30%),
    inset: 5pt,
    align: horizon,
    table.cell(fill: silver, [$ f(x) $]),
    table.cell(fill: silver, [$ f'(x) $]),
    [$ f(g(x)) $], [$ f'(g(x)) dot g'(x) $],
    [$ f(x) dot g(x) $], [$ f'(x) dot g(x) + f(x) dot g'(x) $],
    [$ f(x)/g(x) $], [$ (f'(x) dot g(x) - f(x) dot g'(x))/(g^2(x)) $]
  )
]

== Integrali

=== Integrali immediati

#align(center)[
  #table(
    columns: (30%, 30%),
    inset: 5pt,
    align: horizon,
    table.cell(fill: silver, [$ g'(x) $]),
    table.cell(fill: silver, [$ g(x) $]),
    [$ integral 1 dif x $], [$ x + c $],
    [$ integral a dif x $], [$ a x + c $],
    [$ integral x^n dif x $], [$ (x^(n+1))/(n+1) + c $],
    [$ integral 1/x dif x $], [$ ln|x| + c $],
    [$ integral e^x dif x $], [$ e^x + c $],
    [$ integral a^x dif x $], [$ (a^x)(ln(a)) + c $],
    [$ integral sin(x) dif x $], [$ -cos(x) + c $],
    [$ integral cos(x) dif x $], [$ sin(x) + c $],
    [$ integral 1/(cos^2(x)) dif x $], [$ tan(x) + c $],
    [$ integral 1/(1+x^2) dif x $], [$ arctan(x) + c $],
    [$ integral 1/(sqrt(1-x^2)) dif x $], [$ arcsin(x) + c $],
  )
]

=== Integrali "avanzati"

Trucchi per risolvere integrali "composti" (termine improprio):

- controllare se è presente la derivata $f'(x)$ della funzione $f(x)$ nella parte più complessa dell'integrale (quasi sempre a denominatore):
  $ integral (f(x)) / (f'(x)) dif x = ln(|f(x)|) + c $
	 $ integral (f(x))/(1 + f'(x)^2) dif x = arctan(f(x)) + c $

- cercare sempre di portare a numeratore le somme, in modo da poter dividere l'integrale
  $ integral a + b dif x = integral a dif x + integral b dif x $
  $ integral x/(sqrt(x+1)) dif x = integral (t-1)/(sqrt(t)) dif t "(sostituzione)" $

=== Integrazione per sostituzione

- sostituire una certa quantità con $t$
- sostituire tutte le occorrenze rimanenti di $x$, calcolandone il nuovo valore
- sostituire $dif x$, calcolandone il nuovo valore risolvendo l'equazione $dif t = D(t) dif x$
- calcolare l'integrale per $t$
- riportare la soluzione in $x$, sostituendo in modo inverso $t$

$ integral mr(sqrt(x)) / (1 + x) mb(dif x) quad quad t = mr(sqrt(x)) quad quad x = t^2 \
dif t = D(sqrt(x)) mb(dif x) quad quad dif t = 1/(2mr(sqrt(x))) mb(dif x) quad quad dif t = 2mr(sqrt(x)) mb(dif x) quad quad mb(dif x) = 2mr(t) dif t \
= integral t / (1 + t^2) mb(2 t dif t) = ... = 2 mr(t) - 2 arctan(mr(t)) + c = 2 mr(sqrt(x)) - 2 arctan(mr(sqrt(x))) + c $

=== Integrazione per parti

- portare l'integrale nella forma:
  $ integral f(x) dot  g(x) dif x $
- scegliere una funzione da derivare $f$ e una da integrare $g'$
- calcolare derivata $f'$ e integrale $g$
- applicare la formula:
  $ f(x) dot g(x) - integral f'(x) dot g(x) dif x $

= Esercizi <esercizi>

- Dimostrare / trovare se la funzione $f(x)$ è una massa/densità valida
  - sommatoria / integrale = 1
  - è possibile considerare la seconda incognita (quella su cui non si integra) come una costante, quindi portarla fuori dalla sommatoria/integrale
  - sempre positiva $>= 0$ (da dimostrare, non graficamente)

- dimostrare stimatore distorto per $tau(theta)$: $E[T] != tau(theta)$

- calcolare bias: $E[T] - tau(theta)$

- calcolare MSE: $"Var"(T) + "bias"^2$
  - attenzione: quando lo stimatore è ad esempio la media campionaria $overline(X)$, allora calcolare la varianza come $E[T^2] - E[T]^2 = E[overline(X)^2] - E[overline(X)]^2$ è un suicidio, meglio usare direttamente $"Var"(T) = "Var"(overline(X)) = "Var"(X) / n$ dove $n$ è la grandezza dei campioni

- gode della proprietà di consistenza in media quadratica? $lim_(n -> infinity) "MSE" = 0$

- metodo plug-in: lo stimatore è distorto, va "raddrizzato":
  - $E[T] = a/2 + 6 != a$
  - risolviamo per $a$: $T = a/2 + 6$, quindi $T*2 - 6$ è non distorto

- probabilità dell'evento che si verifica quando l'errore in valore assoluto che si compie usando $T$ per stimare $a$ è minore o uguale di $epsilon$:
  - l'errore è lo stimatore meno il suo valore atteso: $T - E[T]$ (il valore atteso $E[T]$, dato che lo stimatore non è distorto è uguale ad $a$)
  - quindi $P(-epsilon < T - E[T] < epsilon)$
  - di solito si trasforma il valore atteso in $mu$ (calcolato in base a quanto vale lo stimatore $T$ rispetto alla media campionaria $overline(X)$)
  - si toglie il valore assoluto
  - si calcola la normale che approssima $T$, attraverso il teorema del limite centrale
  - si porta la normale in normale standard
  - è possibile usare $Phi$ per la probabilità
