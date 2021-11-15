
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Visualize Research

<!-- badges: start -->
<!-- badges: end -->

This repository collects visualizations for research findings that I
made for teaching. Each semester we encounter new studies and discuss
them with our students in class. Unfortunately, some researchers do not
visualize their research to transport findings to a broader audience.
For teaching purposes, I started to visualize those on my own.

## Engelhardt & Lörz 2021

Engelhardt & Lörz (2021) diskutieren die Auswirkungen von Studienkosten
auf herkunftsspezifische Ungleichheiten und vergleichen dabei wir sich
die Befög Reform auf die Studienaufnahme und der Studienfachwahl
auswirkt.

Die folgende Liniendiagramm zeigt, wie sich wie sich die Anzahl an
Studierenden in ausgewählten Fächern jeweils vor und nach der Befög
Reform (1983) entwickelt haben und visualisiert Tabelle 1 in Engelhardt
& Lörz (2021).

![](man/figures/Engelhardt_Lörz_2021.png)

Orginalarbeit: Engelhardt, C. & Lörz, M. (2021): Auswirkungen von
Studienkosten auf herkunftsspezifische Ungleichheiten bei der
Studienaufnahme und der Studienfachwahl, Köln Z Soziol, 73, S. 285–305.

    #> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
    #> ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
    #> ✓ tibble  3.1.5     ✓ dplyr   1.0.7
    #> ✓ tidyr   1.1.3     ✓ stringr 1.4.0
    #> ✓ readr   2.0.1     ✓ forcats 0.5.1
    #> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    #> x dplyr::filter() masks stats::filter()
    #> x dplyr::lag()    masks stats::lag()
    #> # A tibble: 15 × 7
    #>    Ranking Fach                               `1976` `1978` `1980` `1983` `1986`
    #>      <int> <chr>                               <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
    #>  1      15 Medizin                              9.67   9.62   9.22  13.7   15.1 
    #>  2      14 Jura                                 5.53   4.91   5.25   4.32   3.61
    #>  3      13 Maschinenbau                         6.15   6.75   8.3    6.15   5.99
    #>  4      12 Elektrotechnik                       1.35   1.64   1.32   1.23   1.3 
    #>  5      11 Mathematik/Informatik                4.84   5.83   5.49   3.09   3.59
    #>  6      10 Biologie/Chemie/Pharmazie            6.77   7.98   8.46   6.97   7.02
    #>  7       9 Physik/Geowissenschaft               6.87   6.01   6.2    6.96   7.67
    #>  8       8 Wirtschaftswissenschaft              7.68   7.96   8.42   1.21  12.5 
    #>  9       7 Architektur/Bauingenieurwesen        3.98   4.35   3.76   3.28   3.37
    #> 10       6 Psychologie                         18.9   16.9   15.3   11.8   10.8 
    #> 11       5 Sozialwissenschaft                   5.71   4.69   6.28   9.26   8.77
    #> 12       4 Kultur-/Sprachwissenschaft           7.99   8.82   8.15   7.45   7.83
    #> 13       3 Kunst/Gestaltung                     4.58   4.67   4.64   4.86   5.7 
    #> 14       2 EWS/Sport                            6.41   5.48   5.58   6.05   3.96
    #> 15       1 Agrar-/Ernährungs-/Forstwissensch…   3.54   4.41   3.66   2.81   2.82

``` r
ggplot(data=df_long, aes(x=year, y = outcome, group=Fach)) +
  geom_line(color = "gray")+
  geom_line(data = df_long %>% filter(differences <= -1.2 | differences > 1),
            aes(color = Fach))+
  geom_point(data = df_long %>% filter(differences <= -1.2 | differences > 1),
            aes(color = Fach))+
  facet_grid(. ~ development)+
  geom_vline(xintercept=4, linetype='dashed', col = 'black')+
  annotate("text", x = 4.05, y = 19, label = "Bafög   Reform", size = 4)+
  theme_minimal(base_size = 14)+
  geom_label_repel(data = df_long %>% filter(year == "1983" & development == "Zunahme" & differences >= 1),
                   aes(label = Fach, color = Fach),
                   #hjust = -1.0,
                   #vjust = 0.5,
                   fontface = "bold",
                   size = 3)+
  geom_label_repel(data = df_long %>% filter(year == "1983" & development == "Abnahme" & differences <= -1.2),
             aes(label = Fach, color = Fach),
             #hjust = -1.0,
             #vjust = 0.5,
             fontface = "bold",
             size = 3)+
  labs(title = "Studierende nach Studienrichtung zwischen 1976 und 1986",
       guides = FALSE,
       caption = "(Nach Engelhardt & Lörz 2021)") +
  xlab("Jahr")+
  ylab("Studierende (%)")+
  theme(legend.position="none")+
  #scale_color_viridis(discrete=TRUE, option="viridis")+
  scale_color_manual(values=c("#001219","#005f73", "#0a9396", "#94d2bd",
                              "#ee9b00","#bb3e03", "#457b9d", "#1d3557"))+
  theme(strip.text.x = element_text(size = 14))
```

<img src="man/figures/unnamed-chunk-3-1.png" width="100%" />
