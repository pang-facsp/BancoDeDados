
all: aula1.pdf aula2.pdf aula3.pdf aula4.pdf aula5.pdf


aula1.pdf: aula1.md
	pandoc -t beamer --slide-level=2 -f markdown head.md aula1.md -o aula1.pdf

aula2.pdf: aula2.md
	pandoc -t beamer --slide-level=2 -f markdown head2.md aula2.md -o aula2.pdf

aula3.pdf: aula3.md
	pandoc -t beamer --slide-level=2 -f markdown head3.md aula3.md -o aula3.pdf

aula4.pdf: aula4.md
	pandoc -t beamer --slide-level=2 -f markdown head4.md aula4.md -o aula4.pdf

aula5.pdf: aula5.md
	pandoc -t beamer --slide-level=2 -f markdown aula5.md -o aula5.pdf
