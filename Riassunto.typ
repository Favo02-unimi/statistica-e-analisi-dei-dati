#import "@preview/gentle-clues:0.8.0": *
#import "@preview/cetz:0.2.2"
#import "@preview/codly:0.2.0": *

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
#show: gentle-clues.with(
  breakable: true
)

// box colorati
#let nota(body) = { info(title: "Nota")[#body] }
#let attenzione(body) = { warning(title: "Attenzione")[#body] }
#let informalmente(body) = { conclusion(title: "Informalmente")[#body] }
#let dimostrazione(body) = { memo(title: "Dimostrazione")[#body] }

// testo matematico colorato
#let mg(body) = text(fill: green, $#body$)
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

  #text("Ultima modifica:")
  #datetime.today().display("[day]/[month]/[year]")
]))

#set par(linebreaks: "optimized")

// impostazioni pagine
#set page(
  numbering: "1",
  number-align: bottom + right,
  header: [
    #set text(8pt)
    _Statistica e Analisi dei dati_
    #h(1fr)
    _Luca Favini, Matteo Zagheno_
  ],
  footer: [
    #set text(8pt)

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

    #context[
      _ #currentH() _
      #h(1fr)
      #text(12pt)[#counter(page).display("1")]
    ]
  ],
)

#heading(outlined: false, bookmarked: false, numbering: none, "Statistica e Analisi dei dati")

_Insegnamento del corso di laurea triennale in Informatica, Università degli studi di Milano. Tenuto dal Professore Dario Malchiodi, anno accademico 2023-2024._

La statistica si occupa di raccogliere, analizzare e trarre conclusioni su dati, attraverso vari strumenti:

- #link(<descrittiva>)[Statistica descrittiva]: esposizione e *condensazione* dei dati, cercando di limitarne l'incertezza;
- #link(<probabilità>)[Calcolo delle probabilità]: creazione e analisi di modelli in situazioni di *incertezza*;
- #link(<inferenziale>)[Statistica inferenziale]: *approssimazione* degli esiti mancanti, attraverso modelli probabilistici;
- _Appendice: #link(<modelli>)[Cheatsheet variabili aleatorie e modelli]:_ riassunto formule e proprietà delle variabili aleatorie e dei modelli;
- _Appendice: #link(<python>)[Cheatsheet Python]:_ raccolta funzioni/classi Python utili ai fini dell'esame _(e non)_;
- _Appendice: #link(<matematica>)[Cheatsheet matematica]:_ trucchi per risolvere/semplificare equazioni, serie, integrali.

// indice
#outline(
  title: "Indice",
  indent: auto
)

#pagebreak()

= Statistica descrittiva <descrittiva>

/ Popolazione: insieme di elementi da analizzare, spesso troppo numerosa per essere analizzata tutta
/ Campione: parte della popolazione estratta per essere analizzata, deve essere rappresentativo
/ Campione casuale (semplice): tutti i membri della popolazione hanno la stessa possibilità di essere selezionati

== Classificazione dei dati: qualitativi e quantitativi <quantitativi>

/ Dati quantitativi \/ Scalari \/ Numerici: l'esito della misurazione è una quantità numerica
  / Discreti: si lavora su valori singoli (spesso interi), ad esempio: _numeri di figli_
  / Continui: si lavora su range di intervalli, ad esempio: _peso_ o _altezza_

/ Dati qualitativi \/ Categorici \/ Nominali: l'esito della misurazione è un'etichetta
  / Booleani \/ Binari: due valori possibili, ad esempio: _sesso_
  / Nominali \/ Sconnessi: valori *non* ordinabili, ad esempio: _nome_
  / Ordinali: valori ordinabili, ad esempio: _livello di soddisfazione_

#nota[Spesso alcuni dati _numerici_ vengono considerati _qualitativi_, dato che non ha senso effettuare su di essi considerazioni algebriche o numeriche. Un esempio potrebbe essere la data di nascita. ]

== Frequenze

=== Frequenze assolute e relative <frequenze>

=== Frequenze cumulate <cumulata>

==== Funzione cumulativa empirica

=== Frequenze congiunte e marginali

=== Stratificazione

== Grafici

== Indici di centralità <indice-centralita>

Sono indici che danno un'idea approssimata dell'ordine di grandezza (quindi dove ricadono) dei valori esistenti.

=== Media campionaria <media>

Viene indicata da $overline(x)$, ed è la *media aritmetica* di tutte le osservazioni del campione.

$ overline(x) = 1 / n sum_(i=1)^(n) x_i $

La media opera linearmente, quindi può essere scalata ($dot a$) e/o traslata ($+ b$):

$ forall i space y_i = a x_i + b => overline(y) = a overline(x) + b $

Non è un stimatore robusto rispetto agli outlier.
Può essere calcolata solo con #link(<quantitativi>)[dati quantitativi].

=== Mediana campionaria

È il valore a *metà* di un dataset ordinato in ordine crescente, ovvero un valore $>=$ e $<=$ di almeno la metà dei dati.

Dato un dataset di dimensione $n$ la mediana è:
  - l'elemento in posizione $(n+1)/2$ se n è dispari
  - la media aritmetica tra gli elementi in posizione $n/2$ e $n/2 + 1$ se n è pari

È robusta rispetto agli outlier ma può essere calcolata solo su _campioni ordinabili_.

=== Moda campionaria

È l'osservazione che compare con la maggior frequenza. Se più di un valore compare con la stessa frequenza allora tutti quei valori sono detti modali.

== Indici di dispersione

Sono indici che misurano quanto i valori del campione si discostano da un valore centrale.

=== Scarto assoluto medio

Per ogni osservazione, lo scarto è la distanza dalla media: $x_i - overline(x)$.
La somma di tutti gli scarti farà sempre $0$.

$ sum_(i=1)^n x_i - overline(x) quad = quad sum_(i=1)^n x_i - sum_(i=1)^n overline(x) quad = quad n overline(x) - n overline(x) quad = 0 $

=== Varianza campionaria

Misura di quanto i valori si discostano dalla media campionaria

$ s^2 = 1/(n-1)sum_(i=1)^n (x_i - overline(x))^2 $

Metodo alternativo per calcolare la varianza:

$ s^2 = 1/(n-1)sum_(i=1)^n (x_i^2 - n overline(x)^2) $

#nota[Verrebbe intuitivo applicare il _valore assoluto_ ad ogni scarto medio, ma questo causa dei problemi. Per questo motivo la differenza viene elevata al _quadrato_, in modo da renderla sempre positiva.]

La varianza _non_ è un operatore lineare: la traslazione non ha effetto mentre la scalatura si comporta: $ s_y^2 = a^2 s_x^2 $

==== Varianza campionaria standard <varianza-standard>

È possibile applicare alla varianza campionaria la radice quadrata, ottenendo la varianza campionaria standard.

$ s = sqrt(s^2) $

#attenzione[Applicando la radice quadrata solo dopo l'elevamento a potenza, non abbiamo reintrodotto il problema dei valori negativi: $sqrt(a^2) quad != quad (sqrt(a))^2 = a$]

=== Coefficiente di variazione

Valore *adimensionale*, utile per confrontare misure di fenomeni con unità di misura differenti.

$ s^* = frac(s, |overline(x)|) $

#nota[Sia la #link(<varianza-standard>)[varianza campionaria standard] che la #link(<media>)[media campionaria] sono dimensionali, ovverro hanno unità di misura. Dividendoli tra loro otteniamo un valore adimensionale.]

=== Quantile

Il quantile di ordine $alpha$ (con $alpha$ un numero reale nell'intervallo $[0,1]$) è un valore $q_alpha$ che divide la popolazione in due parti, proporzionali in numero di elementi ad $alpha$ e (1-$alpha$) e caratterizzate da valori rispettivamente minori e maggiori di $q_alpha$.

/ Percentile: quantile descritto in percentuale
/ Decile: popolazione divisa in 10 parti con ugual numero di elementi
/ Quartile: popolazione divisa in 4 parti con ugual numero di elementi

#nota[
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
  )]

== Indici di correlazione

/ Campione bivariato: campione formato da coppie ${ (x_1, y_1), ..., (x_n, y_n) }$.
/ Correlazione: relazione tra due variabili tale che a ciascun valore della prima corrisponda un valore della seconda seguendo una certa regolarità.

=== Covarianza campionaria <covarianza>

È un valore numerico che fornisce una misura di quanto le due variabili varino assieme.
Dato un campione bivariato definiamo la *covarianza campionaria* come:

$ "Cov"(x, y) = 1/(n-1)sum_(i=1)^n (x_i-overline(x))(y_i-overline(y)) $

Metodo alternativo di calcolo:

$ "Cov"(x, y) = 1/(n-1)sum_(i=1)^n (x_i y_i - n overline(x y)) $

#informalmente[
  Intuitivamente c'è una *correlazione diretta* se al crescere di $x$ cresce anche $y$ o al descrescere di $x$ decresce anche $y$, dato che il contributo del loro prodotto alla sommatoria sarà positivo. Quindi se $x$ e $y$ hanno segno concorde allora la correlazione sarà _diretta_, altrimenti _indiretta_.
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
  Una relazione diretta/indiretta non è necessariamente _lineare_, può essere anche _logaritmica_ o seguire altre forme.
]

=== Indice di correlazione di Pearson (indice di correlazione lineare) <correlazione-lineare>

Utilizziamo l'indice di correlazione di Pearson per avere un valore _adimensionale_ che esprime una correlazione. Possiamo definirlo anche come una misura normalizzata della covarianza nell'intervallo $[-1, +1]$. ρ è *insensibile* alle trasformazioni lineari.

$ rho(x,y) = 1/(n-1)(sum_(i=1)^n (x_i-overline(x))(y_i-overline(y)))/(s_x s_y) = s_(X Y) / (s_X s_Y) $

Dove $s$ è la varianza campionaria standard.

// TODO: differenza tra s_x e s_X

- $rho tilde.eq +1$ probabile correlazione linearmente diretta
- $rho tilde.eq 0$ correlazione improbabile
- $rho tilde.eq -1$ probabile correlazione linearmente indiretta

#attenzione[L'#link(<correlazione-lineare>)[indice di correlazione lineare] ($rho$) cattura *solo* relazioni dirette/indirette _lineari_ ed è insensibile alle trasformazioni lineari.]

#attenzione[
   La #link(<covarianza>)[covarianza campionaria] o l'#link(<correlazione-lineare>)[indice di correlazione lineare] $tilde.eq 0$ non implicano l'indipendenza del campione, ma è vero il contrario:
  $ "Cov"(x, y) tilde.eq 0 quad arrow.r.double.not quad "Indipendenza" $
  $ rho(x, y) tilde.eq 0 quad arrow.r.double.not quad "Indipendenza" $
  $ "Indipendenza" quad arrow.r.double quad rho(x, y) tilde.eq "Cov"(x, y) tilde.eq 0 $
]

== Indici di eterogeneità

/ Massima eterogeneità: il campione è composto da tutti elementi diversi
/ Minima eterogeneità: il campione non contiene due elementi uguali _(campione omogeneo)_

L'eterogeneità può essere calcolata anche su un insieme di dati qualitativi.

=== Indice di Gini (per l'eterogeneità) <gini>

$ I = 1 - sum_(j=1)^n f_j^2 $

Dove $f_j$ è la #link(<frequenze>)[frequenza relativa] di $j$ ed $n$ è il numero di elementi distinti. Quindi $forall j, 0 <= f_j <= 1$. Prendiamo in considerazione i due estremi:

- eterogeneità _minima_ (solo un valore con frequenza relativa 1): $ I = 1 - 1 = 0 $
- eterogeneità _massima_ (tutti i valori hanno la stessa frequenza relativa $1/n$ dove $n$ è la dimensione del campione): $ I = quad 1 - sum_(j=1)^n (1/n)^2 quad =  quad 1 - n/n^2 quad = quad (n-1)/n $

Generalizzando, $I$ non raggiungerà mai $1$: $ 0 <= I <= (n-1)/n < 1 $

Dal momento che l'indice di Gini tende a $1$ senza mai arrivarci introduciamo l'*indice di Gini normalizzato*, in modo da arrivare a $1$ nel caso di eterogeneità massima: $ I' = n/(n-1)I $

=== Entropia <entropia>

$ H = quad sum_(j=1)^n f_j log(1/f_j) quad = quad sum_(j=1)^n - f_j log(f_j) $

Dove $f_j$ è la #link(<frequenze>)[frequenza relativa] e $n$ è il numero di elementi distinti.
L'entropia assume valori nel range $[0, log(n)]$ quindi utilizziamo l'*entropia normalizzata* per confrontare due misurazioni con diverso numero di elementi distinti $n$.

$ H' = 1/log(n) H $

#nota[
  In base alla base del logaritmo utilizzata, l'entropia avrà unità di misura differente:
  - $log_2$: bit
  - $log_e$: nat
  - $log_10$: hartley
]

#informalmente[
  Intuitivamente sia l'#link(<gini>)[indice di Gini] che l'#link(<entropia>)[entropia] sono una _"media pesata"_ tra la frequenza relativa di ogni elemento ed un peso: la _frequenza stessa_ nel caso di Gini e il _logaritmo del reciproco_ nell'entropia. La frequenza relativa è già nel range $[0, 1]$, quindi non c'è bisogno di dividere per il numero di elementi.
]

== Indici di concentriazione

Un indice di concentrazione è un indice statistico che misura in che modo un _bene_ è distribuito nella _popolazione_.

/ Distruzione del bene: $a_1, a_2, ... a_n$ indica la quantità ordinata in modo *non decrescente*, del bene posseduta dall'individuo $i$
/ Media: $overline(a)$ indica la quantità media posseduta da un individuo
/ Totale: $"TOT" = n overline(a)$ indica il totale del bene posseduto

- Concentrazione _massima_ (*sperequato*): un individuo possiete tutta la quantità $a_(1..n-1) = 0, quad a_n = n overline(a)$
- Concentrazione _minima_ (*equo*): tutti gli individui possiedono la stessa quantità $a_(1..n) = overline(a)$

=== Curva di Lorentz <lorenz>

La curva di Lorenz è una rappresentazione *grafica* della _distribuzione_ di un bene nella popolazione.

Dati:
- $F_i = i/n$: posizione percentuale dell'osservazione i nell'insieme
- $Q_i = 1/"TOT" limits(sum)_(k=1)^i a_k$

La tupla $(F_i, Q_i)$ indica che il $100 dot F_i%$ degli individui detiene il $100 dot Q_i%$ della quantità totale.

Inoltre: $forall i, space 0 <= Q_i <= F_i <= 1$.

#informalmente[
  Possiamo vedere $F_i$ come _"quanta"_ popolazione è stata analizzata fino all'osservazione $i$, espressa nel range $[0, 1]$.
  $Q_i$ è invece una #link(<cumulata>)[_"frequenza cumulata"_] della ricchezza, fino all'osservazione $i$.
]

#figure(caption: [Curva di Lorentz],
  cetz.canvas({
    import cetz: *

    plot.plot(
      size: (4,4),
      x-tick-step: 1,
      y-tick-step: 1,
      axis-style: "school-book",
      {
        plot.add(((0,0), (1,1)), line: "spline", style: (stroke: 2pt + green), label: "Minima")
        plot.add(((0,0), (0.6, 0.2), (1,1)), line: "spline", style: (stroke: 2pt + orange), label: "Media")
        plot.add(((1,0), (1,1)), line: "spline", style: (stroke: 2pt + red), label: "Massima")
    })
  })
)

=== Indice di Gini (per la concentrazione)

Dato che la #link(<lorenz>)[curva di Lorenz] non assume mai alcun valore nella parte di piano superiore alla retta che collega $(0,0)$ a $(1,1)$, allora introduciamo l'*indice di Gini*, che invece assume valori nel range $[0, 1]$.

Anche esso indica la _concetrazione_ di un bene nella popolazione.

$ G = quad (limits(sum)_(i=1)^(n-1) F_i - Q_i) / (limits(sum)_(i=1)^(n-1) F_i) $

È possibile riscrivere il denominatore come:

$ sum_(i=1)^(n-1) F_i quad = quad 1/n sum_(i=1)^(n-1) i quad = quad 1/n (n(n-1))/2 quad = quad (n-1) / 2 $

Ottendendo come formula alternatica:

$ G = quad 2 / (n-1) sum_(i=1)^(n-1) F_i - Q_i $

#informalmente[
  Facendo un parallelo con la #link(<lorenz>)[curva di Lorenz], possiamo vedere $F_i - Q_i$ come la distanza tra la bisettrice ($F_i$) e la ricchezza dell'osservazione $i$ ($Q_i$). La somma di queste distanze viene poi _"normalizzata"_, dividendo per $(n-1) / 2$.
]

=== Analisi della varianza (ANOVA)

Dato un campione, è possibile suddividerlo in più _gruppi_ ed effettuare delle analisi sulle _diversità_ tra i vari gruppi. Ad esempio, dato un campione di dati sulla natalità, si potrebbe analizzare formando gruppi per regione o per reddito.

L'analisi della varianza (*ANOVA* - ANalysis Of VAriance) è un insieme di tecniche statistiche che permettono, appunto, di confrontare due o più _gruppi_ di dati. Definiamo a questo scopo:

/ Numerosità dei gruppi: dato un campione diviso in $G$ gruppi, ognuno ha numerosità $n_1, ..., n_G$

/ Osservazione: viene definita $x_i^g$ come l'$i$-esima osservazione del $g$-esimo gruppo

/ Media campionaria di tutte le osservazioni: la media del campione $ overline(x) = 1/n sum_(g=1)^G  sum_(i=1)^n_g x_i^g $

/ Media campionaria di un gruppo: la media dei valori del gruppo $ overline(x)_g = 1/n_g sum_(i=1)^n_g x_i^g $

/ Somme degli scarti:

  - Somma *totale* degli scarti (tra _ogni elemento_ e la _media di tutto il campione_): $ "SS"_T = sum_(g=1)^G sum_(i=1)^n_g (x_i^g - overline(x))^2 $
  - Somma degli scarti *entro/within* i gruppi (tra _ogni elemento_ e la _media del proprio gruppo_): $ "SS"_W = sum_(g=1)^G sum_(i=1)^n_g (x_i^g - overline(x)^g)^2 $
  - Somma degli scarti *tra/between* i gruppi (tra la _media di ogni gruppo_ e _la media del campione_, "pesato" per la _numerosità_ del gruppo): $ "SS"_B = sum_(g=1)^G n_g (overline(x)^g - overline(x))^2 $

Vale la seguente regola: $"SS"_T = "SS"_W + "SS"_B$.

/ Indici di variazione:

  - *Total* (la varianza totale del campione):  $ ("SS"_T)/(n-1) $
  - *Within* (la varianza di ogni elemento del gruppo): $ ("SS"_W)/(n-G) $
  - *Between* (la varianza tra ogni gruppo e il campione completo): $ ("SS"_B)/(G-1) $

L'ipotesi alla base è che dati $G$  gruppi, sia possibile scomporre la varianza in due componenti: _Varianza interna ai gruppi_ (varianza *Within*) e _Varianza tra i gruppi_ (varianza *Between*).

#informalmente[
  Analizzando diversi gruppi attraverso l'ANOVA, si possono raggiungere due conclusioni:
  - i gruppi risultano significativamente *diversi* tra loro: la _varianza between_ contribuisce più significativamente alla varianza totale (il fenomeno è legato a caratteristiche proprie di ciascun gruppo)
  - i gruppi risultano *omogenei*: la _varianza within_ contribuisce più significativamente alla varianza totale (il fenomeno è legato a caratteristiche proprie di tutti i gruppi)
]

```python
import numpy as np

def anova(groups):
    all_elements = pd.concat(groups)
    sum_total = sum((all_elements - all_elements.mean())**2)
    sum_within = sum([sum((g - g.mean())**2) for g in groups])
    sum_between = sum([len(g) * (g.mean()-all_elements.mean())**2 for g in groups])
    assert(np.abs(sum_total - sum_within - sum_between) < 10**-5)
    n = len(all_elements)
    total_var = sum_total / (n-1)
    within_var = sum_within / (n-len(groups))
    return (total_var, within_var*(n-len(groups))/(n-1))
```

== Alberi di decisione

// TODO: fare la parte sugli alberi

== Classificatori

Dato un _classificatore binario_ che divide in due classi (positiva e negativa) e un _insieme di oggetti_ di cui è *nota* la classificazione, possiamo valutare la sua bontà tramite il numero di casi classificati in modo errato. La classificazione errata può essere:
- *Falso negativo*: oggetto _positivo_ classificato come _negativo_
- *Falso positivo*: oggetto _negativo_ classificato come _positivo_

#nota[
  Il peso di un falso positivo può *non* essere lo stesso di un falso negativo, si pensi al caso di una malattia contagiosa: un _falso negativo_ sarà molto più pericoloso di un _falso positivo_ (che verrà scoperto con ulteriori analisi).
]

Introduciamo la *matrice di confusione*, che riassume la bontà del classificatore:

#figure(caption: [Matrice di confusione],
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,

    table.cell(colspan: 2, rowspan: 2, stroke: none, []),
    table.cell(colspan: 2, fill: silver, [*Valore effettivo*]),
    table.cell(rowspan: 2, stroke: none, []),

    [Positivo],
    [Negativi],

    table.cell(rowspan: 2, fill: silver, [*Predizione del classificatore*]),

    [Positivo],
    [Veri positivi (VP)],
    [Falsi positivi (FP)],
    [_Totali classificati positivi (TOT CP)_],

    [Negativi],
    [Falsi negativi (FN)],
    [Veri negativi (VN)],
    [_Totali classificati negativi (TOT CN)_],

    table.cell(colspan: 2, stroke: none,  []),
    [_Totale positivi (TP)_],
    [_Totale negativi (TN)_],
    [_Totale casi (TOT casi)_],
  )
)

```python
pd.DataFrame(metrics.confusion_matrix(Y_test, preds))
```

/ Sensibilità: capacità del classificatore di predire bene i positivi $"VP"/"TP"$
/ Specificità: capacità del classificatore di predire bene i negativi $"VN"/"TN"$

È possibile valutare la bontà di un classificatore attraverso il punto:

$ (1 - "Specifità", "Sensibilità") quad = quad (1 - "VN"/"TN", "VP"/"TP") quad = quad ("FP"/"TN", "VP"/"TP") $

=== Casi particolari

/ Classificatore costante: associa indiscriminatamente gli oggetti ad una classe (positiva o negativa)
/ Classificatori positivi (CP): tutti i casi sono classificati come positivi
  - _Sensibilità_: $1$, _Specificitià_: $0$, _Punto_ $(1,1)$ #box(circle(radius: 2.5pt, fill: green, stroke: 1pt + black))
/ Classificatori negativi (CN): tutti i casi sono classificati come negativi
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

=== Classificatori a soglia (Curva ROC)

Un classificatore a soglia discrimina un caso in base ad una *soglia* stabilita a priori, in caso la misurazione sia _superiore_ alla soglia allora verrà classificato _positivamente_, altrimenti _negativamente_.

Per trovare il valore con cui _fissare_ la soglia, possiamo sfruttare questo metodo:

- definiamo $theta$ come una generica soglia
- è necessario stabilire un intervallo $[theta_min, theta_max]$
  - utilizzando $theta_min$ tutti i casi saranno positivi, ottenento un classificatore positivo #box(circle(radius: 2.5pt, fill: green, stroke: 1pt + black))
  - utilizzando $theta_max$ tutti i casi saranno negativi, ottenento un classificatore negativo #box(circle(radius: 2.5pt, fill: red, stroke: 1pt + black))
- definiamo $D$ come una discretizzazione di questo intervallo continuo

Per ogni soglia $theta in D$ è possibile calcolare la _sensibilità_ e _specificità_. Questo classificatore viene quindi _rappresentato_ sul piano cartesiano attraverso il _punto_ $(1 - "Specifità", "Sensibilità")$.

Il risultato è una *curva*, detta *ROC* (Receiver Operator Carapteristic) #box(line(length: 10pt, stroke: 2pt + red), inset: (bottom: 3pt)), che ha sempre come estremi in $(0,0)$ (caso in cui viene usato $theta_max$) e $(1,1)$ (caso in cui viene usato $theta_min$).

Per misurare la _bontà_ del classificatore viene misurata l'area di piano sotto la curva (*AUC* - Area Under the ROC Curve #box(rect(height: 7pt, width: 15pt, fill: rgb("#FFCDD2")))), più si avvicina a $1$, _migliore_ è il classificatore.

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

== Trasformazione dei dati

// TODO: trasformazione dei dati

== Grafici

// TODO: fare i grafici

= Calcolo delle probabilità <probabilità>

== Calcolo combinatorio

Analizzare _come_ e in _quanti_ modi si possono effettuare raggruppamenti di elementi.

/ Principio di enumerazione (principio fondamentale del calcolo combinatorio): se dobbiamo compiere $t$ esperimenti e per ognuno di essi ci possono essere $s_i$ possibili risultati, il numero di risultati totali è $s_1 dot s_2 dot ... dot s_t$

#informalmente[
  Vogliamo selezionare $k$ elementi da un insieme $A$ di $n$ elementi:

  / Disposizioni: l'ordine è importante $(a, b) != (b, a)$
  / Combinazioni: l'ordine _non_ è importante $(a, b) = (b, a)$
  / Permutazioni: tutti gli elementi vengono disposti $k = n$

  È possibile sia _avere_ che _non avere_ delle *ripetizioni* in tutti i casi.
]

=== Disposizioni

Dato un insieme di $n$ oggetti distinti $A = { a_1, ..., a_n }$, vogliamo selezionare $k$ oggetti (con $k <= n$), tenendo in cosiderazione l'*ordine*.

/ Disposizione senza ripetizioni (semplici): gli oggetti di $A$ possono essere usati una volta sola $ d_(n,k) = n! / (n-k)! $

/ Disposizione con ripetizione: gli oggetti di $A$ possono essere usati più di una volta $ D_(n,k) = n^k $

=== Combinazioni

Dato un insieme di $n$ oggetti distinti $A = { a_1, ..., a_n }$, vogliamo selezionare $k$ oggetti (con $k <= n$), *senza* considerare l'ordine.

#nota[
  Il numero di combinazioni $c_(n,k)$ è sempre minore del numero di disposizioni $d_(n,k)$, dato che l'ordine non conta.
]

/ Combinazione senza ripetizioni (semplici): gli oggetti di $A$ possono essere usati una volta sola $ c_(n,k) = d_(n,k) / k! = n!/(k! dot (n-k)!) = vec(n, k) $

#nota[$vec(n, k)$ viene detto *coefficiente binomiale*]

/ Combinazione con ripetizioni: gli oggetti di $A$ possono venir usati più di una volta $ C_(n,k) = (n+k-1)! / (k! dot (n-1)!) = vec(n + k - 1, k) $

=== Permutazioni

Dato un insieme di $n$ oggetti $A = { a_1, ..., a_n }$, una *permutazione* è una sequenza _ordinata_ in cui compaiono _tutti_ gli oggetti (quindi vogliamo selezionare $k$ elementi).

/ Permutazioni semplici (senza ripetizioni): l'insieme $A$ non contiene elementi duplicati $ P_n = n! $

/ Permutazioni di oggetti distinguibili a gruppi (con ripetizioni): l'insieme $A$ contiene $k$ gruppi di oggetti indistinguibili, ognuno con numerosità $n_1, ..., n_k$ (con $sum_(i=1)^k n_i = n)$, allora dobbiamo disporre tutti questi elementi $ P_(n:n_1, ..., n_k) = n! / (n_1 ! dot ... dot n_k !) = vec(n, (n_1, ..., n_k)) $

#nota[$vec(n, (n_1, ..., n_k))$ viene detto *coefficiente multinomiale*]

== Elementi di probabilità

/ Esito $omega in Omega$: risultato effettivo di un esperimento
/ Evento $E subset.eq Omega$: è un qualsiasi insieme formato da tutti, alcuni o nessuno dei possibili esiti di un esperimento
/ Probabilità: quantificazione dell'incertezza di un evento
/ Spazio campionario $Omega$ (insieme degli esiti o insieme universo): è l'insieme di tutti gli esiti possibili. Può essere _finito_ o _infinito_, _continuo_ o _discreto_

#informalmente[
  _Esempio_: lanciando un dado, l'_esito_ è il numero risultante, un _evento_ può essere "esce 3 o 6" e la _probabilità_ di questo evento è $2/6$.
]

/ Evento certo $E = Omega$: si verifica sempre
/ Evento impossibile $E = emptyset$: non si verifica mai

#nota[
  Indichiamo sempre con una _minuscola_ un _esito_, mentre con una _maiuscola_ un _evento_.
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
// TODO: da rivedere e da riscrivere

Un algebra di eventi $A$ è un insieme di eventi ${E_1, E_2, ...}$ a cui sono associate delle operazioni che soddisfa le proprietà:

- $forall E in A, space E subset.eq Omega$: ogni evento appartenente all'_algebra_ $A$ appartiene all'insieme di tutti gli _eventi possibili_ $Omega$
- $Omega in A$: l'insieme di tutti gli _eventi possibili_ $Omega$ appartiene all'_algebra_ $A$
- $forall E in A, space overline(E) in A$: chiusura rispetto al _complemento_
- $forall E, F in A, space E union F in A$: chiusa rispetto all'_unione_
- $forall E, F in A, space E sect F in A$: chiusura rispetto all'_intersezione_

#nota[La chiusura rispetto all'_intersezione_ non è una vera proprietà, ma deriva dalla chiusura rispetto all'_unione_ a cui viene applicata la _legge di De Morgan_]

#nota[Se la chiusura sull'_unione_ vale anche per $|Omega| = infinity
$, allora $A$ viene chiamata $sigma$-algebra]

#informalmente[
  L'algebra degli eventi non è un _vero_ insieme di eventi, ma è un _"dizionario"_ che sfruttiamo per definire quali _operazioni_ e _variabili_ sono ammesse su un $Omega$
]

=== Assiomi di Kolmogorov

Definiamo la funzione *probabilità* $P : A -> [0,1]$, che stabilisce la probabilità che un evento avvenga.

$P : A -> [0,1]$ è una funzione di probabilità se e solo se:

1. $forall E in A, 0 <= P(E) <= 1$: la frequenza è sempre _positiva_ e compresa tra $0$ e $1$
2. $P(Omega) = 1$: un evento che si verifica tutte le $n$ volte: $n/n = 1$
3. $forall E, F in A, space (E sect F) = emptyset space => space P(E union F) = P(E) + P(F)$

#nota[
  La probabilità che accadano diversi eventi _distinti_ $E_i, E_j$ e _disgiunti_ $E_i sect E_j = emptyset$ è la _somma_ delle loro probabilità:
  $ P(limits(union.big)_(i=1)^n E_i) = sum_(i=1)^n P(E_i) $
]

#nota[
  Formalmente la funzione probabilità è definita $P : A -> bb(R)^+$ (numeri _reali positivi_), applicando gli assiomi il _codominio_ viene ristretto a $[0, 1]$.

  In modo analogo, il _primo assioma_ stabilisce che il risultato dell'applicazione della funzione debba essere _positiva_, senza imporre un _limite superiore_, che poi viene aggiunto dal _secondo assioma_
]

=== Teoremi derivati dagli assiomi

/ Probabilità del complemento: $ forall E in A, space P(overline(E)) = 1 - P(E) $

/ Probabilità dell'evento impossibile: $ P(emptyset) = 0 $

/ Proprietà di monotonicità: $ forall E, F in A |  E subset.eq F => P(E) <= P(F) $

/ Probabilità dell'unione di eventi: $ forall E, F in A, space P(E union F) = P (E) + P (F) − P(E sect F) $

// TODO: fare dimostrazioni dei teoremi/proprietà

=== Spazi di probabilità ed Esiti equiprobabili <spazio-probabilita>

Definiamo lo *spazio di probabilità* come la tripla $(Omega, A, P)$ composta dallo spazio di _esiti possibili_ $Omega$, l'_algebra_ $A$ e la _funzione probabilità_ $P$.

/ Spazio equiprobabile: uno spazio è _equiprobabile_ se gli eventi elementari (gli elementi $Omega$) hanno tutti la _stessa_ probabilità: $ P(E) = 1/N quad quad P({E_1, ..., E_k}) = k/N $

Si dimostra con il secondo assioma di _Kolmogorov_:

$ P(Omega) = 1 = P({e_1}) + ... + P({e_N}) = sum_(i=1)^N P({e_i}) $

#nota[Uno spazio può essere _equiprobabile_ solo se $Omega$ è un _insieme finito_]

== Probabilità condizionata

Dati due eventi $E, F$, la probabilità che si verifichi l'evento $E$ sapendo che _si è verificato_ l'evento $F$ è detta *probabilità condizionata*: $ P(E|F) = P(E sect F) / P(F) $

#nota[
  - $P(E|F)$ si legge _"probabilità di $E$ dato $F$"_
  - $E$ si dice evento _condizionato_
  - $F$ si dice evento _condizionante_
]

#attenzione[In caso $P(F) = 0$, ovvero $F = emptyset$, allora $P(E|F) = "indefinita"$]

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

#nota[Insieme $A$ partizionato: $limits(union.big)_(i=1)^n F_i = A$ con $forall i, j, space  i != j, space F_i sect F_j = emptyset$. L'_unione_ di tutte le partizioni è uguale all'insieme iniziale e tutte le partizioni sono _disgiunte_]

#figure(caption: [
  Probabilità di $E$:
  $ P(E) =
  (mr(P(F_1)) dot mb(P(E|F_1))) + (mr(P(F_2)) dot mb(P(E|F_2))) + (mr(P(F_3)) dot mb(P(E|F_3)))\
  =(mr(1/3) dot mb(0)) + (mr(1/3) dot mb(1/6)) + (mr(1/3) dot mb(1/2)) = 2/9\
   $
], image("probabilita-totali.png", width: 40%))

È possibile esprimere $E$ come:

$ P(E) = mr(P(E sect F)) &+ mb(P(E sect overline(F))) \
  = mr(P(E | F) P(F)) &+ mb(P(E | overline(F)) P(mo(overline(F)))) \
  = P(E | F) P(F) &+ P(E | overline(F)) P(mo(1-P(F))) $

Altre trasformazioni utili:

$ (E sect F) union (E sect overline(F)) = E sect (F union overline(F)) = E sect Omega = E $

$ (E sect F) sect (E sect overline(F)) = E sect (F union overline(F)) = E sect emptyset = emptyset $

=== Teorema di Bayes

Dato $Omega$ partizionato in $F_1, ..., F_n$ partizioni disguinte, e un evento $E$, la probabilità che accada una certa $F_k subset.eq Omega $ è:

$ P(F_k | E) &= (P(E | F_k) P(F_k)) / mr(P(E)) \
 &= (P(E | F_k) P(F_k)) / mr(limits(sum)_(i=1)^n P(E | F_i) P(F_i)) $

#figure(caption: [
  Probabilità di $F_2$:
  $ P(F_2) =
  mr(P(E|F_2)) dot mb(P(F_2)) / mp(P(E)) \
  = (mr(P(E sect F_2) / P(F_2)) mb(P(F_2))) / mp((P(F_1) dot P(E|F_1)) + (P(F_2) dot P(E|F_2)) + (P(F_3) dot P(E|F_3))) \
  = (mr((1/6 dot 1/3) / (1/3)) mb(1/3)) / mp(2/9) = 1/4
   $
], image("probabilita-totali.png", width: 40%))

=== Classificatore naive-Bayes

Possiamo generalizzare il _teorema di Bayer_ per ricavarne un *classificatore*: date delle _caratteristiche_ $X_1, ..., X_n$ che assumono valore $x_1, ..., x_n$, vogliamo assegnare l'oggetto $y_k$ alla _classe_ che massimizza la probabilità:

$ P(Y = y_k | X_1 = x_1, ..., X_n = x_n) $

Applicando il teorema di _Bayes_:

$ = (P(X_1 = x_1, ..., X_n = x_n | Y = y_k) dot P(Y = y_k)) / P(X_1 = x_1, ..., X_n = x_n) $

La formula viene semplificata in modo "ingenuo" _(naive)_, assumendo che le caratteristiche siano #link(<eventi-indipendenti>)[eventi indipendenti] $P(X_1 = x_1 and X_2 = x_2 | Y) = P(X_1 = x_1) dot P(X_2 = x_2)$:

$ = (P(Y = y_k) dot limits(product)_(i=1)^n P(X_i = x_i | Y = y_k)) / P(X_1 = x_1, ..., X_n = x_n) $

#informalmente[
  Questa _assunzione_ è, appunto, _ingenua_: ad esempio, una persona con i capelli chiari è _più probabile_ che abbia anche gli occhi chiari rispetto ad una persona con i capelli scuri. Le due caratteristiche _non_ sono _indipendenti_.

  Come capire _formalmente_ se due eventi (o più) eventi sono _indipendenti_ è descritto nel #link(<eventi-indipendenti>)[paragrafo successivo].
]

Per trovare la classe alla quale _assegnare_ l'oggetto, bisogna calcolare la probabilità per ogni possibile $y_k$ e trovare il massimo:

$ = arg max_k P(Y = y_k) dot product_i^n P(X_i = x_i | Y = y_k) $

#nota[
  Dato che ci interessa solo $y_k$ massimo e il _denominatore_ non dipende da $k$, allora possiamo _ignorarlo_ dato che non influenzerà la scelta del masssimo
]

// TODO: classificatore naive-bayes in Python (appunti michele)

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

Una _variabile aleatoria_ o _casuale_ (random variable) è una variabile che assume un valore _diverso_ ogni osservazione. Permettono di codificare gli _eventi_ in termini di numeri reali.

Dato uno #link(<spazio-probabilita>)[spazio di probabilità] $(Omega, A, P)$, una variabile aleatoria è $X : Omega -> bb(R)$ che associa ad ogni _esito_ un _numero reale_.

#attenzione[
  Non tutte le funzioni definite come $X : Omega -> bb(R)$ rappresentano una _variabile aleatoria_
]

/ Specificazioni: _valori_ che possono essere assunti da una variabile aleatoria
/ Supporto: l'_insieme_ delle _specificazioni_, dove la probabilità non sia nulla $P(X = x_i) != 0$

#nota[
  È possibile calcolare il _supporto_ di una variabile aleatoria *discreta* calcolando l'_insieme_ di punti in cui la #link(<funzione-massa>)[funzione di massa] non assuma valore nullo
]

=== Variabili aleatorie discrete <aleatorie-discrete>

Una variabile aleatoria si dice discreta se il suo supporto è finito e numerabile (ovvero ha un numero finito di valori possibili). Dato $[m,n]$ il range di valori che possono _essere assunti_ dalla variabile $X$, vale:

$ 1 = P(Omega) = P(union.big_(i=m)^n {X = i}) = sum_(i=m)^n P(X = i) $

==== Funzione indicatrice

Dati $A, B$ due insiemi tali che $A subset.eq B$, la funzione indicatrice di $A$ rispetto a $B$ è la funzione $I : B -> {0, 1}$ che vale:

$ I_(A(x)) = cases(1 "se" x in A, 0 "se" x in.not A) $

#informalmente[
  La _funzione indicatrice_ agisce da _filtro_, "limitando il dominio". Quando viene _moltiplicata_ con una probabilità la _annulla_ o la _lascia inalterata_.

  Ad esempio, la probabilità di un _dado_ è: $P(X = x) = 1/6 dot mr(I_({1, ..., 6}(x)))$, la funzione indicatrice _annulla_ la probabilità di $1/6$ in caso $x$ non sia nel "dominio" del dado ($1 <= x <= 6$)
]

==== Funzione di massa di probabilità <funzione-massa>

Data una variabile aleatoria discreta $X$ con supporto $D$, la sua _funzione di massa di probabilità_ $P_X : bb(R) -> [0,1]$ è la funzione che associa ad ogni valore $x in bb(R)$ la probabilità che l'esito di $X$ ne sia uguale:
$ forall x in bb(R), space p_(X)(x) = P(X = x) dot I_(D)(x) $

#attenzione[
  La funzione di massa di probabilità *NON* vale per le #link(<aleatorie-continue>)[variabili aleatorie continue]
]

*Proprietà* che la funzione di massa di probabilità deve _rispettare_:

- $forall x in bb(R), f_(X)(x) >= 0$: non può essere negativa
- $limits(sum)_(x in D) f_(X)(x) = 1$: la somma della funzione di massa per tutti i valori che $x$ può assumere deve fare $1$

// TODO: grafico funzione massa

==== Funzione di ripartizione <funzione-ripartizione>

Data una variabile aleatoria $X$, la sua _funzione di ripartizione_ o _distribuzione cumulativa_ $F_X : bb(R) -> [0, 1]$ è la funzione che associa ad ogni valore $x in bb(R)$ la probabilità che l'esito di $X$ ne sia minore o uguale:
$ forall x in bb(R), space F_(X)(x) = P(X <= x) $

#attenzione[
  La funzione di ripartizione è _valida_ sia per le #link(<aleatorie-discrete>)[variabili aleatorie discrete] che per le #link(<aleatorie-continue>)[variabili aleatorie continue]
]

#nota[
  È possibile calcolare la probabilità per un _valore maggiore_ di una certa soglia sfruttando il complementare:
  $ P(X>x) = 1 - P(X <= x) = 1 - F(x) $
]

#nota[
  È possibile calcolare la probabilità per un valore _compreso_ tra due estremi:
  $ P(a < X <= b) = P(X <= b) - P(X <= a) = F(b) - F(a) $
]

La funzione di ripartizione può essere vista come la _somma_ applicando alla _funzione di massa_ tutti i valori minori uguali di un certo valore $a$:

$ F(a) = sum_(x <= a) p(x) $

#informalmente[
  Per una variabile aleatoria discreta, $F$ è una _funzione a gradini_, costante tra gli intervalli dei valori assunti da $X$, che salta di $p(x)$ ad ogni nuovo valore
]

// grafico funzione di ripartizione

==== Valore atteso

Il _valore atteso_ di una variabile aleatoria $X$ è un _indice dimensionale_ di #link(<indice-centralita>)[centralità] delle _specificazioni_ della variabile aleatoria.

$ E[X] = sum_i x_i dot P(X = x_i) = sum_i x_i dot p(x_i) $

#informalmente[
  Il _valore atteso_ è semplicemente la _"media pesata"_ per ogni possibile valore nel _dominio_ (specificazione) di una variabile aleatoria
]

#nota[
  Il valore atteso può essere indicato con $E$ o con $mu$
]

*Proprietà* del valore atteso:

- il _valore atteso_ di una funzione indicatrice è uguale alla _probabilità dell'evento_: $ E[I_A] = P(A) $
- il _valore atteso_ di una variabile aleatoria discreta $X$ opera in modo _lineare_: $ Y = a dot X + b quad quad  E[Y] = a dot E[X] + b $
- data una qualsiasi _funzione_ reale $g$ e una variabile aleatoria $X$ con funzione di massa $p$, allora vale: $ E[g(X)] = sum_i g(x_i) dot p(x_i) $
- data una qualsiasi _funzione_ reale $g$ di due variabili e due variabili aleatorie discrete $X, Y$, allora vale: $ E[g(X, Y)] = sum_x sum_y g(x,y) dot p(x,y) $

==== Varianza

Sia $X$ una variabile aleatoria di media $mu$, la varianza di $X$ è:
$ "Var"(X) = G_X^2 = E[(X - mu)^2] $

#nota[
  Formula alternativa per la varianza: $ "Var"(X) &= E[(X - mu)^2] \
  &= E[X^2 - 2 mu X + mu^2] \
  &= E[X^2] - 2 mu E[X] + mu^2 \
  &= E[X^2] - 2mu^2 + mu^2 \
  &= E[X^2] - E[X]^2 \
  &= sum_i x_i^2 dot P(X = x_i) - (sum_i x_i dot P(X = x_i))^2 $
]

*Proprietà* varianza:

- la varianza della funzione indicatrice è la probabilità dell'_evento_ moltiplicata per la probabilità dell'_evento complementare_ $ "Var"(I) = P(A) dot P(overline(A)) $
- la varianza non opera in modo lineare: $ "Var"(a X + b) = a^2 "Var"(X) $

/ Deviazione standard: $sigma_X = sqrt("Var"(X))$

=== Variabili aleatorie multivariate

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

#nota[
  Si dice _funzione di ripartizione (o massa)_ *marginale* quando da una _funzione di ripartizione (o massa)_ *congiunta* estraggo una _funzione di ripartizione (o massa)_ di una variabile *univariata*
]

Possiamo ottenere una $F_(X)(x)$ *funzione di ripartizione marginale* di $X$ nel seguente caso:

$ lim_(y -> +infinity) F_"X,Y" (x,y) &= mr(lim_(y -> +infinity)) P(X <= x, mr(Y <= y)) \
&= P(X <= x) space dot mr(lim_(y -> +infinity) P(Y <= y)) \
&= P(X <= x) dot mr(Omega) \
&= P(X <= x) \
&= F_X (x) $

==== Funzione di massa di probabilità congiunta

Siano $X,Y$ due variabili aleatorie _univariate discrete_, allora la loro _funzione di massa di probabilità congiunta_ $p: bb(R) times bb(R) -> [0, 1]$ è:

$ p_(X,Y) (x,y) = P(X = x, Y = y) $

È possibile _estendere_ a variabili aleatorie _multivariate_ di dimensione arbitraria:
$ p_(X_1, ..., X_n)(x_1, ..., x_n) = P(X_1 = x_1, ..., X_n = x_n) $

Possiamo ottenere una $p_(X)(x)$ *funzione di massa di probabilità marginale* di $X$ nel seguente caso:

$ sum_(y_i in D) p_(X,Y) (x,y) &= mr(sum_(y_i in D)) P({X = x} sect mr({Y = y})) \
  &= P({X = x} sect space mr(union.big_(y_i in D) {Y = y})) \
  &= P({X = x} dot mr(Omega)) \
  &= P({X = x}) \
  &= p_X (x) $

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

#nota[
  Formula alternativa:
  $ "Cov"(X, Y) &= [X Y - mu_X Y - mu_Y X + mu_X mu_Y] \
    &= E[X Y] - mu_X E[Y] - mu_y E[X] + mu_X mu_Y \
    &= E[X Y] - E[X] E[Y]
  $
]

*Proprietà* della covarianza:

- simmetria: $"Cov"(X, Y) = "Cov"(Y, X)$
- generalizzazione concetto di varianza: $"Cov"(X, X) = "Var"(X)$
- linearità:
  - $"Cov"(a X, Y) = "Cov"(X, a Y) = a "Cov"(X, Y)$
  - $"Cov"(X + Y, Z) = "Cov"(X, Z) + "Cov"(Y, Z)$

==== Varianza <multivariate-varianza>

Siano $X$ e $Y$ due variabili aleatorie la loro _varianza_ della loro _somma_ è:
$ "Var"(X + Y) = "Var"(X) + "Var"(Y) + 2 "Cov"(X, Y) $

È possibile _estendere_ a variabili aleatorie _multivariate_ di dimensione arbitraria:
$ "Var"(sum_i^n X_i) = sum_i^n "Var"(X_i) + sum_i^n sum_(j, j != i)^n "Cov"(X_i, X_j) $

=== Variabili aleatorie continue <aleatorie-continue>

Una variabile aleatoria si dice *continua* quando ha un _supporto *non* numerabile_.

==== Funzione densità di probabilità

#informalmente[
  La #link(<funzione-massa>)[funzione di massa] (come spiegato sotto) non ha più senso per le _variabili aleatorie continue_, quindi lo stesso concetto prende il nome di _funzione densità di probabilità_
]

Siccome $X$ deve per forza assumere un valore in $bb(R)$, allora la _funzione di densità_ ( $f_"X" (x)$ ) deve rispettare:
$ P(X in bb(R)) = integral_(-infinity)^(+infinity) f_(X)(x) dif x = 1 $

Per variabili aleatorie _continue_ non ha senso cercare la probabilità assunta da un _singolo valore_, infatti:
$ P(X = a) = integral_a^a f_(X)(x) dif x = 0 $

Per questo motivo si ragiona in termini di _intervalli_ di probabilità:
$ P(a <= X <= b) = integral_a^b f_(X)(x) dif x $

Esiste una relazione tra la #link(<funzione-ripartizione>)[funzione di ripartizione] $F$ (che *vale anche* per le variabili aleatorie continue) con la funzione di densità $f$:
$ F(a) &= P(X <= a) \
  &= P(X in (-infinity, a]) \
  &= integral_(-infinity)^a f_(X)(x) dif x $

Quindi la *funzione di densità* è uguale alla derivata della #link(<funzione-ripartizione>)[funzione di ripartizione] $F$:
$ f_(X)(a) = F'(a) $

==== Valore atteso

Il _valore atteso_ di una variabile aleatoria continua vale:
$ E[X] = integral_(-infinity)^(+infinity) x dot f_(X)(x) dif x $

#nota[
  Formula alternativa per il valore atteso:
  $ E(X) = integral_0^(+infinity) 1 - F_(X)(x) dif x $
]

==== Varianza

La _varianza_ di una variabile aleatoria continua vale:
$ "Var"(X) = E[(X - mu)^2] = integral_(-infinity)^(+infinity) (x - mu)^2 f_(X)(x) dif x $

==== Disuguaglianza di Markov

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
  $ E[X] &= mr(sum_(x>=0) x dot p(x)) \
    &= mr(sum_(x <= a) x dot p(x) + sum_(x >= a) x dot p(x)) &>= mb(sum_(x >= a) x dot p(x)) = \
    & &>= mb(sum_(x >= a) a dot p(x)) = \
    & &>= mb(a dot sum_(x >= a) p(x)) = \
    & &>= mb(a dot P(X >= a)) $
  Quindi $ mr(E[X]) >= mb(mp(a) dot P(X >= a)) quad => quad mb(P(X >= a)) <= mr(E[X]) / mp(a) $
]

#dimostrazione[
  Variabili aleatorie *continue*:
  $ E[X] &= mr(integral_(-infinity)^(+infinity) x f_X (x) dif x) \
    &= mr(integral_(0)^(a) x f_X (x) dif x + integral_(a)^(+infinity) x f_X (x) dif x) &>= mb(integral_(a)^(+infinity) x f_X (x) dif x) = \
    & &>= mb(integral_(a)^(+infinity) a f_X (x) dif x) = \
    & &>= mb(a integral_(a)^(+infinity) f_X (x) dif x) = \
    & &>= mb(a dot P(X >= a)) $
  Quindi $ mr(E[X]) >= mb(mp(a) dot P(X >= a)) quad => quad mb(P(X >= a)) <= mr(E[X]) / mp(a) $
]


==== Disuguaglianza di Chebyshev

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
  $ | X - mu | >= r quad <==> quad ( X - mu )^2 >= r^2  $

  dunque:

  $ mr(P( |X - mu| >= r)) &= mb(P((X - mu)^2 >= r^2)) \
     mb(P((X - mu)^2 >= r^2)) &<= E[(X - mu)^2 / r^2] text("per Markov") \
     mr(P( |X - mu| >= r)) &<= sigma^2 / r^2
  $
]

=== Modelli di distribuzione discreti

Alcune _distribuzioni/modelli_ di variabili aleatorie sono molto _frequenti_, di conseguenza esistono dei risultati notevoli.

==== Modello di Bernoulli $X tilde B(p)$ <bernoulliano>

La variabile aleatoria può assumere solo due specificazioni: *fallimento* o *successo*, ovvero il loro supporto è $D_X = { 0, 1 }$ Il parametro $p$ indica la probabilità che $X = 1$ con $p in [0, 1]$

$ mr(X tilde B(p)) $

/ Funzione di massa:
$ p_X (x) = P(X = x) &= mr(p^x (1-p)^((1-x)) I_{0,1} (x)) \
  &= cases(1-p quad "per " x=0, p quad "per " x=1, 0 quad "altrimenti") $

/ Funzione di ripartizione:
$ F_X (x) = P(X <= x) &= mr((1 - p) I_[0,1](x) + I_((1, +infinity))(x)) \
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

Il modello ripete $n$ volte un *esperimento bernulliano indipendente* di probabilità $p$, dove $n$ e $p$ sono i due parametri del modello. Il supporto del modello è $D_X = {0, 1, ..., n}$.

$ mr(X tilde B(n, p)) $

/ Funzione di massa:
$ p_X (x) = P(X = x) = mr(binom(n, x) p^x (1-p)^((n-x)) I_{0, ..., n} (x)) $

#figure(caption: [Funzione di massa modello binomiale], image("binomiale-massa.png",  width: 40%))

/ Funzione di ripartizione:
$ F_X (x) &= P(X <= x) = \
  &= mr(sum_(i=0)^x p_X (i) dot I_[0, n](x) + I_((n, +infinity))(x)) \
  &= cases(
    limits(sum)_(i=0)^x p_X (i) quad "per " x <= n,
    1 quad "per " x > n
  )
$

#attenzione[
  Nella formula della funzione di ripartizione, $p_X$ indica la _funzione di massa_, solo $p$ indica la _probabilità di successo_
]

/ Valore atteso:
$ E[X] = mr(n dot p) $

#dimostrazione[
  $ E[X] &= E[sum_i^n X_i] \
  &= sum_i^n E[X_i] = n dot p
  $
]

/ Varianza:
$ "Var"(X) = mr(n dot p (1-p)) $

/ Riproducibilità:
Siano $X_1 tilde B(n, p)$ e $X_2 tilde B(m, p)$ indipendenti, allora:
$ X_1 + X_2 = sum_(i=1) ^n X_(1,i) + sum_(j=1)^m X_(2,j) = sum_(i=1)^(n+m) Y_i = Y $
dove $Y tilde B(n+m, p)$

==== Modello uniforme discreto $X tilde U(n)$ <uniforme-discreto>

Tutti gli esiti della variabile aleatoria discreta sono *equiprobabili*, dove il parametro $n$ è il numero dei possibili esiti, con $n in bb(N) backslash {0}$. Il supporto del modello è $D_X = [1, n]$.

$ mr(X tilde U(n)) $

/ Funzione di massa:
$ p_X (x) = P(X = x) = mr(1/n I_{1, ..., n} (x)) $


#figure(caption: [Funzione di massa modello uniforme discreto], image("uniforme-discreto-massa.png", width: 40%))

/ Funzione di ripartizione:
$ F_X (x) = P(X <= x) = mr(floor(x) / n I_[1, n] (x) + I_((n, +infinity)) (x)) $

#dimostrazione[
  $ forall x <= n quad F_X (x) &= P(X <= x) \
    &= sum_(i=1)^floor(x) P(X = i) \
    &= 1/n sum_(i=1)^floor(x) i \
    &= 1^floor(x) dot 1/n = floor(x)/n $
]

#figure(caption: [Funzione di ripartizione modello uniforme discreto], image("uniforme-discreto-ripartizione.png", width: 40%))

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

Il numero di *insuccessi successivi* prima che si verifichi un esprimento positivo in una serie di #link(<bernoulliano>)[esperimenti Bernoulliani] *indipendenti* e *identicamente distribuiti* (i.i.d.<iid>) di parametro $p$ $in (0, 1]$. Il supporto del modello è $D_X = [0, ..., +infinity)$.
// TODO: indipendenti ok, ma identicamente distribuiti cosa vuol dire? anche nel binomale devono iid o solo indipendenti?

$ mr(X tilde G(p)) $

/ Funzione di massa:
$ p_X (x) = P(X = x) = mr(p(1-p)^x I_{0, ..., +infinity} (x)) $

#informalmente[
  La funzione di massa equivale a calcolare le probabilità che accadano $x$ _insuccessi_, quindi $(1-p)^x$ a cui succede un _successo_ $dot p$, ottenenendo $p dot (1-p)^x$.
]

#figure(caption: [Funzione di massa modello geometrico], image("geometrico-massa.png", width: 40%))

/ Funzione di ripartizione:
$ F_X (x) = P(X <= x) = mr((1 - (1-p)^(floor(x)+1)) I_[0, +infinity) (x)) $

#nota[
  $ F_X (x) = F_X (floor(x)) $
]

#figure(caption: [Funzione di ripartizione modello geometrico], image("geometrico-ripartizione.png", width: 40%))

#dimostrazione[
  Possiamo calcolare la funzione di ripartizione $P(X <= x)$ come $1 - P(X > x)$:

  $ mb(P(X > x)) &= sum_(i = x+1)^(+infinity) p_X (i) \
    &= sum_(i = x+1)^(+infinity) p(1-p)^i \
    &= p(1-p)^(x+1) dot sum_(i=x+1)^(+infinity) (1-p)^(i-(x+1)) \
    &= p(1-p)^(x+1) sum_(i=0)^(+infinity) (1-p)^i \
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

È un tipo di distribuzione *discreta* che esprime le probabilità che un certo *numero di eventi* si verificano *contemporaneamente* in un dato intervallo di tempo, sapendo che *mediamente* se ne verifica un numero $lambda$. Tutti gli eventi sono *indipendenti*.
Il modello ha supporto $D_X = [0, +infinity)$ e $lambda in (0, +infinity)$

$ mr(X tilde P(lambda)) $

#informalmente[
  Ad esempio, si utilizza una distribuzione di Poisson per misurare il numero di chiamate ricevute in un call-center in un determinato arco temporale.
]

Un dataset segue il _modello di Poisson_ se possiede le seguenti _caratteristiche_:
- la distribuzione ha una forma _asimmetrica_ con una lunga _coda verso destra_
- al crescere di $lambda$ corrisponde _maggiore concentrazione_ di dati intorno al parametro
- la _media_ campionaria è vicina al parametro $lambda$ e la _varianza_ è uguale a $lambda$

/ Funzione di massa:
$ p_X (x) = P(X = x)= mr(e^(-lambda) dot (lambda^x)/x! I_[0, +infinity] (x)) $

#figure(caption: [Funzione di massa modello di Poisson], image("poisson-massa.png", width: 40%))

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
    Dal secondo passaggio in poi l'indice della sommatoria $i$ parte da 1 e non da 0. Questo perché moltiplicando tutto per $i$ se $i = 0$ il contributo alla sommatoria sarà nullo.
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

Descrive l'*estrazione* di oggetti binari da un'urna *senza reimmissioni* (in caso ci fossero reimmissioni, potremmo usare il #link(<binomiale>)[modello binomiale]). I parametri sono:
- $n$: numero di estrazioni
- $N$: numero di oggetti _"corretti"_
- $M$: numero di oggetti _"errati"_

Il supporto del modello è $[max(0, n-M), min(n, N)]$.

$ mr(X tilde H(n, M, N)) $

#informalmente[
  Il #text(blue)[minor numero] di oggetti _corretti_ estraibili è: $max(0, "estrazioni" - "errati") = mb(max(0, n - M))$.

  Il #text(purple)[massimo numero] di oggetti _corretti_ estraibili è: $min("estrazioni", "corretti") = mp(min(n, N))$.

  Di conseguenza, il supporto del modello è: $ [mb(max(0, n-M)), mp(min(n, N))] $
]

#nota[
  È possibile indicare il modello anche come $X tilde I(n, M, N)$
]

/ Funzione di massa:

$ p_X (x) = P(X = x) =  mr((binom(N, x) binom(M, n-x)) / binom(N+M, n) I_{0, ..., n} (x)) $

#figure(caption: [Funzione di massa modello ipergeometrico], image("ipergeometrica-massa.png", width: 40%))

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
// TODO: controllare che sia giusto
$ E[X] = n dot p = mr(n^2 N/(N+M)) $

#dimostrazione[
  Scomponiamo la variabile in $n$ variabili #link(<bernoulliano>)[aleatorie bernoulliane] _NON indipendenti_ definite:
  $ X_i = cases(1 quad "oggetto corretto", 0 quad "oggetto errato") $
  Essendo bernoulliane, vale:
  $ P(X_i = 1) = M / (N+M) = E[X_i] = p $
  Quindi:
  $ E[X] &= E[sum_(i=1)^n X_i] \
    &= sum_(i=1)^n E[X_i] = n dot p $
]

/ Varianza:
// TODO: controllare che sia giusto
$ "Var"(X) &= n p (1-p) (1- (n-1)/(N+M-1)) \
  &= mr((n N/(N+M)) (1-(N/(N+M))) (1- (n-1)/(N+M-1))) $

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
   &= mr((N M) / ((N + M - 1)(N+M)^2)) $
  Quindi:
  $ mp("Var"(X)) &= mg(n) mo((N M)/(N+M)^2) - mg(n(n-1)) dot mr((-N M) / ((N+M-1)(N+M)^2)) \
   &= n p (1-p) (1 - (n-1)/(N+M-1)) $
]

=== Modelli di distribuzione continui

Alcune _distribuzioni/modelli_ di variabili aleatorie sono molto _frequenti_, di conseguenza esistono dei risultati notevoli.

==== Modello uniforme continuo $X tilde U(a,b)$ <uniforme-continuo>

Tutti gli esiti della variabile aleatoria discreta sono *equiprobabili*. Il supporto del modello è $D_X = [a, b]$.

$ mr(X tilde U(a,b)) $

/ Funzione di densità di probabilità:
$ f_X (x) = P(X = x) = mr(1/(b-a) I_[a,b] (x)) $

#figure(caption: [Funzione di densità modello uniforme continuo], image("uniforme-continuo-densita.png", width: 40%))

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

#figure(caption: [Funzione di ripartizione modello uniforme continuo], image("uniforme-continuo-ripartizione.png", width: 40%))

#dimostrazione[
  $ F_X (x) &= integral_(a)^(x) f_(X)(y) dif y \
    &= integral_(a)^(x) 1 / (b-a) dif y \
    &= 1 / (b-a) integral_(a)^(x) 1 dif y \
    &= 1 / (b-a) [y]^x_a = (x-a)/(b-a) $
]

/ Valore atteso:
$ E[X] = mr((a + b) / 2) $

#dimostrazione[
  $ E[X] &= integral_a^b f_X (x) dif x \
    &= integral_a^b x dot 1/(b-a) dif x \
    &= 1/(b-a) integral_a^b x dif x \
    &= 1/(b-a) dot [x^2 / 2]_a^b \
    &= 1/(b-a) dot (b^2 - a^2)/2 \
    &= 1/cancel(b-a) dot ((a+b)cancel((b-a)))/2 \
    &= (a+b) / 2
  $
]

#nota[
  $ E[X^2] = (a^2 + a b + b^2) / 3  $
]

/ Varianza:
$ "Var"(X) = mr(((b-a)^2)/12) $


==== Modello esponenziale $X tilde E(lambda)$ <esponenziale>

Modello di variabili aleatorie continue, rappresenta una distribuzione in cui la funzione di densità ha *forma esponenziale*, spesso $X$ rappresenta il tempo tra il verificarsi di eventi. Il parametro $lambda in bb(R)^+$ indica la forma della _funzione esponenziale_ e il supporto è $D_X = bb(R)^+$.

$ mr(X tilde E(lambda)) $

#informalmente[
  Il modello si usa spesso per modellare il tempo che intercorre tra eventi:

  - $X$ è il _tempo effettivo_ che l'evento ci mette ad avvenire
  - $lambda$ è la _forma della curva_, più è piccola, più è piatta
]

/ Funzione di densità:
$ f_X (x) = mr(lambda e^(-lambda x) I_[0, +infinity) (x)) $

#figure(caption: [Funzione di massa modello esponenziale], image("esponenziale-densita.png",  width: 40%))

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

#figure(caption: [Funzione di massa modello esponenziale], image("esponenziale-ripartizione.png",  width: 40%))

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

Nel caso le variabili aleatorie siano #link(<iid>)[indipendenti identicamente distribuite], allora:
$ F_Y (x) = F_X (x)^n $

Siano $X_1, ..., X_n$ variabili aleatorie indipendenti e sia $Z$ il minimo di esse $Z = min_i X_i$, allora:
$ F_Z (x) = 1 - product_(i=1)^n (1 - F_(X_i) (x)) $

Nel caso le variabili aleatorie siano #link(<iid>)[indipendenti identicamente distribuite], allora:
$ F_Z (x) = 1- (1-F_X (x))^n $

Siano $X_1, ..., X_n$ variabili aleatorie indipendenti e sia $Z = min_i X_i$. Se $forall i, X_i tilde E(lambda_i)$, allora:
$ Z tilde E(sum_(i=1)^n lambda_i) $

Se $X tilde E(lambda)$ e $Y = c X$ con $c in R^+$, allora $Y$ è una variabile aleatoria esponenziale di parametro $lambda/c$:
$ F_Y (x) = 1 - e^(-lambda/c x) $

==== Modello Gaussiano (o normale) $X tilde N(mu, sigma)$ <gaussiano>

Modello estremamente diffuso in natura, ha la classica forma a campana.

#attenzione[
  Questo modello non ha funzione indicatrice, è definito su tutto $bb(R)$
]

$ mr(X tilde N(mu, sigma)) $

/ Funzione di densità:
$ f_X (x) = P(X = x) = mr(1/(sigma sqrt(2 pi)) dot e^(-(x-mu)^2 / (2 sigma^2))) $

/ Funzione di ripartizione:
$ F_X (x) = P(X <= x) = mr(integral_(-infinity)^x 1 / (sigma sqrt(2 pi)) dot e^((- (x - mu)^2)/(2 sigma^2)) dif x) $

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
Una qualsiasi variabile che segue la distribuzione normale ha una curva simmetrica rispetto al centro ($mu$), di conseguenza:
$ F_X (-x) = 1 - F_X (x) $

#figure(caption: [Le due parti non evidenziate della curva sono identiche, quindi $F(-1) = 1 - F(1)$], image("normale-simmetria.png",  width: 40%))

===== Distribuzione normale standard

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

/ Ricavare funzione di ripartizione:
Data una qualsiasi variabile aleatoria $X tilde N(mu, sigma)$, è possibile trovare la funzione di ripartizione standard:
$ F_X (x) = Phi((x-mu)/sigma) $

#informalmente[
  Portando una curva normale in una curva standard, _perdiamo informazione_ (la curva standard è appunto standard, sempre uguale). Per non perdere informazioni, viene applicata la _stessa trasformazione_ direttamente al parametro della funzione $Phi$ nota della variabile standardizzata:
  $ F_X (x) = Phi_Z ((x-mu)/sigma) $

  La dimostrazione non è altro che applicare la stessa trasformazione da entrambe le parti della funzione di probabilità, in modo da ricondurci alla funzione nota $F_Z$:
  $ P(X <= x) = P((X-mu)/sigma <= (x-mu)/sigma) $
]

#dimostrazione[
  $ F_X (x) &= P(X <= x) \
    &= P((X-mu)/sigma <= (x-mu)/sigma) \
    &= P(Z <= (x - mu)/sigma) \
    &= F_Z ((x-mu)/sigma) = Phi((x-mu)/sigma) $
]

#nota[
  Si può usare la stessa tecnica per calcolare la probabilità tra due insiemi:
  $ P(a <= x <= b) = Phi((b-mu)/sigma) - Phi((a-mu)/sigma) $
]

=== Teorema centrale del limite

Siano $X_1, ... X_n$ variabili aleatorie #link(<iid>)[indipendenti identicamente distribuite], ovvero $forall i, E[X_i] = mu, "Var"(X_i) = sigma^2$.
Allora, per $n -> +infinity$ le variabili sono distribuite in modo *approssimativamente normale*:
$ sum_(i=1)^n X_i tilde.dot N(n dot mu, sigma sqrt(n)) $

Questa distribuzione si può standardizzare:
$ (limits(sum)_(i=1)^n X_i - n mu) / (sigma sqrt(n)) tilde.dot N(0,1) $

Quindi per $n$ grande e $x$ qualsiasi, vale l'approssimazione:
$ P((limits(sum)_(i=1)^n X_i - n mu) / (sigma sqrt(n)) < x) approx Phi(x) $

#nota[
  È possibile approssimare una variabile #link(<binomiale>)[binomiale] $X tilde B(n, p)$ con $n$ grande utilizzando il teorema:
  $ X = sum_(i=1)^n X_i tilde.dot N(n p, sqrt(n p (1-p))) \
  (x - n p)/sqrt(n p (1-p)) tilde.dot N(0,1) $
]

= Statistica inferenziale <inferenziale>

La statistica inferenziale vuole _analizzare_ e _trarre risultati_ da campioni selezionati da _grandi popolazioni_. Viene ipotizzato che i valori numerici del campione seguano dei _modelli_, quindi vengono trattati come *variabili aleatorie* di una distribuzione non conosciuta $F$.

/ Inferenza: processo di induzione con cui si cerca di _formare delle ipotesi_, ovvero a partire da specifiche manifestazioni si cerca di determinare la verità generale

/ Popolazione: grande insieme di oggetti descritti da una variabile aleatoria $X tilde F$

/ Campione: _sottoinsieme_ della popolazione usato per studiare le leggi. Si estraggono i campioni in modo casuale (per questo motivo si assume indipendenza). Viene descritto come una successione di variabili aleatorie $X_1, ... X_n$ #link(<iid>)[indipendenti identicamente distribuite], con $n$ grandezza del campione

La statistica inferenziale permette di capire quale distribuzione descrivere le osservazioni, attraverso due metodologie:

- *Statistica inferenziale non parametrica* _(non trattata nel corso)_: la distribuzione $F$ è completamente sconosciuta

- *Statistica inferenziale parametrica*: della distribuzione $F$ è conosciuta solo la famiglia, mentre sono sconosciuti i parametri. Indichiamo la distrbuzione con $F(theta)$, dove $theta$ è il parametro sconosciuto di cui stimiamo il valore:
  - *stima puntuale*: forniamo un numero molto vicino a $theta$
  - *stima per intervalli*: forniamo un intervallo di valori in cui ricade $theta$

#nota[
  Spesso ci interessa un valore che dipende dal parametro ignoto $theta$, non $theta$ stesso. Questo valore lo indichiamo come $tau(theta)$
]

/ Statistica / Stimatore: funzione $t : D_X^n -> bb(R)$ che dati dei valori, stima il valore che ci interessa: $ t(x_1, ..., x_n) = accent(tau, hat) approx tau(theta) $

#nota[
  Dato che il campionamento è casuale, diversi campioni $(x_1, ..., x_n)$ della stessa popolazione danno $accent(tau, hat)$ diversi, per cui $accent(tau, hat) approx tau(theta)$
]

/ Variabile aleatoria per stimatore: indichiamo con $T$ la variabile aleatoria che indica una stima, ricevendo delle variabili aleatorie (non più dei valori):
$ T = t(X_1, ..., X_n) = accent(t, hat) approx tau(theta) $

== Stimatori non deviati

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
$ t(x_1, ..., x_n) = 1/n sum_(i=1)^n x_i quad quad tau(theta) = E[X] $

#dimostrazione[
  $ E[T] &= E[1/n sum_(i=1)^n X_i] \
    &= 1/n E[sum_(i=1)^n X_i] \
    &= 1/n sum_(i=1)^n E[X_i] = cancel(n/n) dot E[X] $
]

$ "Var"(1/n sum_(i=1)^n X_i) $

=== Consistenza in media quadratica

Dato un campione ${X_1, ..., X_n}$ da una popolazione $X$ e $theta$ parametro di $X$, chiamiamo $T_n$ la famiglia di stimatori che sono costituiti dalla funzione $t_n$ applicata a $n$ argomenti.

/ Mean Square Error:
Definiamo il valore medio dell'errore quadratico come:
$ "MSE"_tau(theta) = E[(T_n - tau(theta))^2] $

L'MSE può essere definito come:
$ "MSE"_tau(theta) (T_n) = "Var"(T_n) + b_tau(theta) (T_n)^2 $


// TODO: fare anche metodo di massima verosomiglianza

// numerazione appendici
#pagebreak()
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
    Se le variabili sono #link(<iid>)[indipendenti identicamente distribuite], allora la covarianza vale $0$
  ]
- la varianza della somma di più variabili aleatorie vale:
  $ "Var"(sum_i^n X_i) = sum_i^n "Var"(X_i) + sum_i^n sum_(j, j != i)^n "Cov"(X_i, X_j) $

=== Proprietà della covarianza

- la covarianza è simmetrica:
  $ "Cov"(X, Y) = "Cov"(Y, X) $
- la covarianza di una variabile aleatoria con sè stessa è uguale alla varianza:
  $ "Cov"(X, X) = "Var"(X) $
- opera in modo lineare:
  $ "Cov"(a X, Y) = "Cov"(X, a Y) = a "Cov"(X, Y) $
  $ "Cov"(X + Y, Z) = "Cov"(X, Z) + "Cov"(Y, Z) $

== Modelli
// TODO: sistemare nei modelli disreti la I, fare {0, ..., n} al posto di [0, n]

- #link(<bernoulliano>)[Modello di Bernoulli]: $X tilde B(p)$
  #grid(columns: 2, row-gutter: 15pt, column-gutter: 5pt, align: horizon + left,
    [- Massa:], [$p^x (1-p)^((1-x)) I_{0, 1} (x)$],
    [- Ripartizione:], [$(1-p) I_[0,1](x) + I_((1, +infinity)) (x)$],
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
    [- Ripartizione:], [$floor(x)/n I_{1, ..., n} + I_((n, +infinity)) (x)$],
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
// TODO: riguardare valore atteso e varianza (p)
  #grid(columns: 2, row-gutter: 15pt, column-gutter: 5pt, align: horizon + left,
    [- Massa:], [$(binom(N, x) binom(M, n-x)) / binom(N + M, n) I_{0, ..., n} (x)$],
    [- Ripartizione:], [_non vista nel corso_],
    [- Valore atteso:], [$n^2 N/(N+M)$],
    [- Varianza:], [$(N M) / (N + M)^2$]
  )

- #link(<uniforme-continuo>)[Modello uniforme continuo]: $X tilde U(a,b)$
  #grid(columns: 2, row-gutter: 15pt, column-gutter: 5pt, align: horizon + left,
    [- Massa:], [$1 / (b-a) I_[a,b] (x)$],
    [- Ripartizione:], [$(x-a) / (b-a) I_[a,b] (x) + I_((b, +infinity)) (x)$],
    [- Valore atteso:], [$(b-a) / 2$],
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

= Cheatsheet Python <python>

= Cheatsheet matematica <matematica>

= Esercizi

- Dimostrare / trovare se la funzione $f(x)$ è una massa/densità valida
  - sommatoria / integrale = 1
  - è possibile considerare la seconda incognita (quella su cui non si integra) come una costante, quindi portarla fuori dalla sommatoria/integrale
