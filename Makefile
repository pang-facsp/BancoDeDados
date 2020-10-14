
all: aula1.pdf aula2.pdf aula3.pdf aula4.pdf aula5.pdf aula6.pdf aula7.pdf aula8.pdf aula9.pdf aula10.pdf aula11.pdf


aula1.pdf: aula1.md
	pandoc -t beamer --slide-level=2 -f markdown head.md aula1.md -o aula1.pdf

aula2.pdf: aula2.md
	pandoc -t beamer --slide-level=2 -f markdown head2.md aula2.md -o aula2.pdf

aula3.pdf: aula3.md
	pandoc -t beamer --slide-level=2 -f markdown head3.md aula3.md -o aula3.pdf

aula4.pdf: aula4.md
	pandoc -t beamer --slide-level=2 -f markdown head4.md aula4.md -o aula4.pdf

aula5.pdf: aula5.md
	pandoc -t beamer --slide-level=2 -f markdown head5.md aula5.md -o aula5.pdf

aula6.pdf: aula6.md head6.md
	pandoc -t beamer --slide-level=2 -f markdown head6.md aula6.md -o aula6.pdf

aula7.pdf: aula7.md head7.md
	pandoc -t beamer --slide-level=2 -f markdown head7.md aula7.md -o aula7.pdf

aula8.pdf: aula8.md head8.md
	pandoc -t beamer --slide-level=2 -f markdown head8.md aula8.md -o aula8.pdf

aula9.pdf: aula9.md head9.md
	pandoc -t beamer --slide-level=2 -f markdown head9.md aula9.md -o aula9.pdf

aula10.pdf: aula10.md head10.md
	pandoc -t beamer --slide-level=2 -f markdown head10.md aula10.md -o aula10.pdf

aula11.pdf: aula11.md head11.md
	pandoc -t beamer --slide-level=2 -f markdown head11.md aula11.md -o aula11.pdf
