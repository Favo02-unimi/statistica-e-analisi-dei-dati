#import "@preview/gentle-clues:0.8.0": *
#import "@preview/cetz:0.2.2"

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

// pdf metadata
#set document(
  title: "Statistica e Analisi dei dati",
  author: ("Luca Favini", "Matteo Zagheno"),
)

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

== Introduzione

/ Popolazione: insieme di elementi da analizzare, spesso troppo numerosa per essere analizzata tutta
/ Campione: parte della popolazione estratta per essere analizzata, deve essere rappresentativo
/ Campione casuale (semplice): tutti i membri della popolazione hanno la stessa possibilità di essere selezionati

== Classificazione dei dati: qualitativi e quantitativi <quantitativi>

== Frequenze

=== Frequenze assolute e relative <frequenze>

=== Frequenze cumulate

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

#info(title: "Nota")[Verrebbe intuitivo applicare il _valore assoluto_ ad ogni scarto medio, ma questo causa dei problemi. Per questo motivo la differenza viene elevata al _quadrato_, in modo da renderla sempre positiva.]

La varianza _non_ è un operatore lineare: la traslazione non ha effetto mentre la scalatura si comporta così: //TODO: si può scrivere meglio

$ s_y^2 = a^2 s_x^2 $

==== Varianza campionaria standard <varianza-standard>

È possibile applicare alla varianza campionaria la radice quadrata, ottenendo la varianza campionaria standard.

$ s = sqrt(s^2) $

#warning(title: "Attenzione")[Applicando la radice quadrata solo dopo l'elevamento a potenza, non abbiamo reintrodotto il problema dei valori negativi: $sqrt(a^2) quad != quad (sqrt(a))^2 = a$]

=== Coefficiente di variazione

Valore *adimensionale*, utile per confrontare misure di fenomeni con unità di misura differenti.

$ s^* = frac(s, |overline(x)|) $

#info(title: "Nota")[Sia la #link(<varianza-standard>)[varianza campionaria standard] che la #link(<media>)[media campionaria] sono dimensionali, ovverro hanno unità di misura. Dividendoli tra loro otteniamo un valore adimensionale.]

=== Quantile

Il quantile di ordine $alpha$ (con $alpha$ un numero reale nell'intervallo $[0,1]$) è un valore $q_alpha$ che divide la popolazione in due parti, proporzionali in numero di elementi ad $alpha$ e (1-$alpha$) e caratterizzate da valori rispettivamente minori e maggiori di $q_alpha$.


/ Percentile: quantile descritto in percentuale
/ Decile: popolazione divisa in 10 parti con ugual numero di elementi
/ Quartile: popolazione divisa in 4 parti con ugual numero di elementi

#info(title: "Nota")[
  È possibile visualizzare un campione attraverso un *box plot*, partendo dal basso composto da:
  - eventuali _outliers_, rappresentati con le `x` prima del baffo
  - il _baffo_ "inferiore", che parte dal valore minimo e raggiunge il primo quartile
  - il _box_ (scatola), che rappresenta le osservazioni comprese tra il primo e il terzo quartile
  - la linea che divide in due il box, che rappresenta la _mediana_
  - il _baffo_ "superiore", che parte terzo quartile e raggiunge il massimo
  - eventuali _outliers_ "superiori", rappresentati con le `x` dopo il baffo

  #cetz.canvas({
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
  })]

== Indici di correlazione

/ Campione bivariato: campione formato da coppie ${ (x_1, y_1), ..., (x_n, y_n) }$.
/ Correlazione: relazione tra due variabili tale che a ciascun valore della prima corrisponda un valore della seconda seguendo una certa regolarità.

=== Covarianza campionaria <covarianza>

È un valore numerico che fornisce una misura di quanto le due variabili varino assieme.
Dato un campione bivariato definiamo la *covarianza campionaria* come:

$ op("Cov")(x, y) = 1/(n-1)sum_(i=1)^n (x_i-overline(x))(y_i-overline(y)) $

Metodo alternativo di calcolo:

$ op("Cov")(x, y) = 1/(n-1)sum_(i=1)^n (x_i y_i - n overline(x y)) $

#conclusion(title: "Informalmente")[
  Intuitivamente c'è una *correlazione diretta* se al crescere di $x$ cresce anche $y$ o al descrescere di $x$ decresce anche $y$, dato che il contributo del loro prodotto alla sommatoria sarà positivo. Quindi se $x$ e $y$ hanno segno concorde allora la correlazione sarà _diretta_, altrimenti _indiretta_.
]

- $op("Cov")(x, y) > 0$ probabile correlazione diretta
- $op("Cov")(x, y) tilde.eq 0$ correlazione improbabile
- $op("Cov")(x, y) < 0$ probabile correlazione indiretta

#info(title: "Nota")[
  Una relazione diretta/indiretta non è necessariamente _lineare_, può essere anche _logaritmica_ o seguire altre forme.
]

// TODO: grafici di correlazione scatterplot

=== Indice di correlazione di Pearson (indice di correlazione lineare) <correlazione-lineare>

Utilizziamo l'indice di correlazione di Pearson per avere un valore _adimensionale_ che esprime una correlazione. Possiamo definirlo anche come una misura normalizzata della covarianza nell'intervallo $[-1, +1]$. ρ è *insensibile* alle trasformazioni lineari.

$ rho(x,y) = 1/(n-1)(sum_(i=1)^n (x_i-overline(x))(y_i-overline(y)))/(s_x s_y) = s_(X Y) / (s_X s_Y) $

Dove $s$ è la varianza campionaria standard.

// TODO: differenza tra s_x e s_X

- $rho tilde +1$ probabile correlazione linearmente diretta
- $rho tilde 0$ correlazione improbabile
- $rho tilde -1$ probabile correlazione linearmente indiretta

#warning(title: "Attenzione")[L'#link(<correlazione-lineare>)[indice di correlazione lineare] ($rho$) cattura *solo* relazioni dirette/indirette _lineari_ ed è insensibile alle trasformazioni lineari.]

#warning(title: "Attenzione")[La #link(<covarianza>)[covarianza campionaria] o l'#link(<correlazione-lineare>)[indice di correlazione lineare] $tilde.eq 0$ non implicano l'indipendenza del campione, ma è vero il contrario:
$ op("Cov")(x, y) tilde.eq 0 quad arrow.r.double.not quad op("Indipendenza") $
$ rho(x, y) tilde.eq 0 quad arrow.r.double.not quad op("Indipendenza") $
$ op("Indipendenza") quad arrow.r.double quad rho(x, y) tilde.eq op("Cov")(x, y) tilde.eq 0 $

]

== Indici di eterogeneità

/ Massima eterogeneità: il campione è composto da tutti elementi diversi
/ Minima eterogeneità: il campione non contiene due elementi uguali _(campione omogeneo)_

L'eterogeneità può essere calcolata anche su un insieme di dati qualitativi.

=== Indice di Gini (per l’eterogeneità) <gini>

$ I = 1 - sum_(j=1)^n f_j^2 $

Dove $f_j$ è la #link(<frequenze>)[frequenza relativa] di $j$ ed $n$ è il numero di elementi distinti. Quindi $forall j, 0 <= f_j <= 1$. Prendiamo in considerazione i due estremi:

- eterogeneità _minima_ (solo un valore con frequenza relativa 1): $ I = 1 - 1 = 0 $
- eterogeneità _massima_ (tutti i valori hanno la stessa frequenza relativa $1/n$ dove $n$ è la dimensione del campione): $ I = quad 1 - sum_(j=1)^n (1/n)^2 quad =  quad 1 - n/n^2 quad = quad (n-1)/n $

Generalizzando, $I$ non raggiungerà mai $1$: $ 0 <= I <= (n-1)/n < 1 $

Dal momento che l'indice di Gini tende a $1$ senza mai arrivarci introduciamo l'*indice di Gini normalizzato*, in modo da arrivare a $1$ nel caso di eterogeneità massima: $ I' = n/(n-1)I $

// TODO: grafico gini

=== Entropia <entropia>

$ H = quad sum_(j=1)^n f_j log(1/f_j) quad = quad sum_(j=1)^n - f_j log(f_j) $

Dove $f_j$ è la #link(<frequenze>)[frequenza relativa] e $n$ è il numero di elementi distinti.
L'entropia assume valori nel range $[0, log(n)]$ quindi utilizziamo l'*entropia normalizzata* per confrontare due misurazioni con diverso numero di elementi distinti $n$.

$ H' = 1/log(n) H $

#info(title: "Nota")[
  In base alla base del logaritmo utilizzata, l'entropia avrà unità di misura differente:
  - $log_2$: bit
  - $log_e$: nat
  - $log_10$: hartley
]

#conclusion(title: "Informalmente")[
  Intuitivamente sia l'#link(<gini>)[indice di Gini] che l'#link(<entropia>)[entropia] sono una _"media pesata"_ tra la frequenza relativa di ogni elemento ed un peso: la _frequenza stessa_ nel caso di Gini e il _logaritmo del reciproco_ nell'entropia. La frequenza relativa è già nel range $[0, 1]$, quindi non c'è bisogno di dividere per il numero di elementi.
]

== Indici di concentriazione

Un indice di concentrazione è un indice statistico che misura in che modo un _bene_ è distribuito nella _popolazione_.

/ Distruzione del bene: $a_1, a_2, ... a_n$ indica la quantità ordinata in modo *non decrescente*, del bene posseduta dall'individuo $i$
/ Media: $overline(a)$ indica la quantità media posseduta da un individuo
/ Totale: $op("TOT") = n overline(a)$ indica il totale del bene posseduto

- Concentrazione _massima_ (*sperequato*): un individuo possiete tutta la quantità $a_(1..n-1) = 0, quad a_n = n overline(a)$
- Concentrazione _minima_ (*equo*): tutti gli individui possiedono la stessa quantità $a_(1..n) = overline(a)$

=== Curva di Lorentz

Dati:
- $F_i = i/n$: posizione percentuale dell'osservazione i nell'insieme
- $Q_i = 1/op("TOT") sum_(k=1)^i a_k$

La tupla $(F_i, Q_i)$ indica che il $100 dot F_i%$ degli individui detiene il $100 dot Q_i%$ della quantità totale.

Inoltre: $forall i 0 <= Q_i <= F_i <= 1$.

//TODO: grafico curva di lorentz

=== Indice di Gini (per la concentrazione)

Dato che la curva di Lorenz non assume mai alcun valore nella parte di piano superiore alla retta che collega $(0,0)$ a $(1,1)$, allora introduciamo l'indice di Gini, che invece assume valori nel range $[0, 1]$.

$ G = quad (limits(sum)_(i=1)^(n-1) F_i - Q_i) / (limits(sum)_(i=1)^(n-1) F_i) $

$ sum_(i=1)^(n-1) F_i quad = quad 1/n sum_(i=1)^(n-1) i quad = quad 1/n (n(n-1))/2 quad = quad (n-1) / 2 $

$ G = quad 2 / (n-1) sum_(i=1)^(n-1) F_i - Q_i $

= Calcolo delle probabilità <probabilità>

= Statistica inferenziale <inferenziale>

= Cheatsheet Python <python>

/ Varianza campionaria: `Series.var()`
/ Devianza standard campionaria: `Series.std()`
/ Indici di centralità e dispersione: `Series.describe()`
/ Quantile: `Series.quantile()`
/ Covarianza: `Series.cov()`
