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

// box colorati
#let nota(body) = { info(title: "Nota")[#body] }
#let attenzione(body) = { warning(title: "Attenzione")[#body] }
#let informalmente(body) = { conclusion(title: "Informalmente")[#body] }

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
  #text(" - ")
  #link("https://github.com/Favo02/statistica-e-analisi-dei-dati")[Codice sorgente]

]))

// impostazioni pagine
#set page(
  numbering: "1",
  header: [
    #set text(8pt)
    #set align(right)
    _Statistica e Analisi dei dati_
  ],
)

#heading(outlined: false, bookmarked: false, numbering: none, "Statistica e Analisi dei dati")

_Insegnamento del corso di laurea triennale in Informatica, Università degli studi di Milano. Tenuto dal Professore Dario Malchiodi, anno accademico 2023-2024._

La statistica si occupa di raccogliere, analizzare e trarre conclusioni su dati, attraverso vari strumenti:

- #link(<descrittiva>)[Statistica descrittiva]: esposizione e *condensazione* dei dati, cercando di limitarne l'incertezza;
- #link(<probabilità>)[Calcolo delle probabilità]: creazione e analisi di modelli in situazioni di *incertezza*;
- #link(<inferenziale>)[Statistica inferenziale]: *approssimazione* degli esiti mancanti, attraverso modelli probabilistici;
- _Appendice: #link(<python>)[Cheatsheet Python]:_ raccolta funzioni/classi Python utili ai fini dell'esame _(e non)_.

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

== Indici di centralità

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

$ op("Cov")(x, y) = 1/(n-1)sum_(i=1)^n (x_i-overline(x))(y_i-overline(y)) $

Metodo alternativo di calcolo:

$ op("Cov")(x, y) = 1/(n-1)sum_(i=1)^n (x_i y_i - n overline(x y)) $

#informalmente[
  Intuitivamente c'è una *correlazione diretta* se al crescere di $x$ cresce anche $y$ o al descrescere di $x$ decresce anche $y$, dato che il contributo del loro prodotto alla sommatoria sarà positivo. Quindi se $x$ e $y$ hanno segno concorde allora la correlazione sarà _diretta_, altrimenti _indiretta_.
]

- $op("Cov")(x, y) > 0$ probabile correlazione diretta
- $op("Cov")(x, y) tilde.eq 0$ correlazione improbabile
- $op("Cov")(x, y) < 0$ probabile correlazione indiretta

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
  $ op("Cov")(x, y) tilde.eq 0 quad arrow.r.double.not quad op("Indipendenza") $
  $ rho(x, y) tilde.eq 0 quad arrow.r.double.not quad op("Indipendenza") $
  $ op("Indipendenza") quad arrow.r.double quad rho(x, y) tilde.eq op("Cov")(x, y) tilde.eq 0 $
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
/ Totale: $op("TOT") = n overline(a)$ indica il totale del bene posseduto

- Concentrazione _massima_ (*sperequato*): un individuo possiete tutta la quantità $a_(1..n-1) = 0, quad a_n = n overline(a)$
- Concentrazione _minima_ (*equo*): tutti gli individui possiedono la stessa quantità $a_(1..n) = overline(a)$

=== Curva di Lorentz <lorenz>

La curva di Lorenz è una rappresentazione *grafica* della _distribuzione_ di un bene nella popolazione.

Dati:
- $F_i = i/n$: posizione percentuale dell'osservazione i nell'insieme
- $Q_i = 1/op("TOT") limits(sum)_(k=1)^i a_k$

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

== Introduzione

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

== Probabilità

= Statistica inferenziale <inferenziale>

= Cheatsheet Python <python>
