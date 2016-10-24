## BLEU computation script
Code extracted from the [Thot package] (https://github.com/daormar/thot)

# Instructions:
`make`

``
thot_calc_bleu -r <string> -t <string> [-sm] [-v]

-r <string>       File containing the reference sentences

-t <string>       File containing the system translations

-sm               Calculate smoothed BLEU.

-v                Verbose mode
``