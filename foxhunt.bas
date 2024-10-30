
	' FOX HUNT
	' An original game in BASIC for the Tandy Color Computer 3
	' By Rick Adams
	'

	' Reset machine on BREAK
	on brk goto 6000

	' Modify HPRINT
	include "hprint.bas"

	' Double speed poke
	poke &hffd9, 0

	' Init graphics
	hscreen 2

	' Allocate memory for graphics
	hbuff 1, 1760 ' Game grid
	hbuff 2, 100  ' Fox

	' Clear screen
10	hcls

	' Title
	hcolor 5 ' Cyan
	hprint (0, 0), "Fox Hunt"
	hprint (27, 0), "by Rick Adams"

	' Seed the random number generator
	r = rnd(-timer)

	' Place the "fox" somewhere randomly
20	fi = int(17 * rnd(0)) + 1 ' X = Random number 1-17
	fj = int(10 * rnd(0)) + 1 ' Y = Random number 1-10

	' But not too close to the starting position
	d = int(sqr((fi - 1)^2 + (fj - 1)^2) / 2)
	if d < 3 then
		goto 20
	end if

	' Zero moves so far
	m = 0

	'Draw grid
	gosub 4000

	' Starting position
	i = 1
	j = 1

	' Highlight current square
100	gosub 3000

	' Has game been won yet?
	if fi <> i or fj <> j or a <> 13 then

		' Continue game
		goto 100

	end if

	' You win! Play again?
	x = 24 + (i - 1) * 16 - 3
	y = 24 + (j - 1) * 16 - 3
	hput (x, y)-(x + 12, y + 12), 2

	hcolor 5 ' Cyan
	hprint (0, 0), "        "
	hprint (27, 0), "             "
	hprint (5, 1), "You win! Fox found in" + Str$(m) + " moves"
	hprint (6, 23), "Press any key to play again"
	exec &hadfb ' Block until key is pressed
	c$ = inkey$
	goto 10

	' Blank out palettes
1000	palette 0, 0
	palette 1, 0
	palette 4, 0
	palette 7, 0
	return

	' Restore palettes
2000	palette 0, 0  ' Black
	palette 1, 53 ' Pale yellow
	palette 4, 63 ' White
	palette 7, 38 ' Orange
	return

	' Highlight square at i, j
3000	t = (t + 1) and 7
	x = 24 + (i - 1) * 16 - 3
	y = 24 + (j - 1) * 16 - 3
	oi = i
	oj = j
	gosub 7000 ' Update position
	if (t and 2) and i = oi and j = oj then
		hline (x, y)-(x + 12, y + 12), preset, b ' Blank out cursor
	else
		hcolor 4 ' White
		hline (x, y)-(x + 12, y + 12), pset, b ' Draw cursor
	end if
	return

	' Draw grid
4000	hcolor 4 ' White
	gosub 1000 ' Don't display anything till we're done
	if g = 0 then
		hdraw "BM21,21R12D12L12U12" ' Draw first cell
		hget (21, 21)-(33, 33), 1 ' Get it
		gosub 8000 ' Draw fox
		hget (21, 21)-(33, 33), 2 ' Get it
		for x = 21 to 277 step 16 ' Stamp first cell across the top row
			hput (x, 21)-(x + 12, 33), 1
		next
		hget (21, 21)-(289, 33), 1 ' Get that whole top row
		g = 1 ' Don't bother doing all that on subsequent games
	end if
	for y = 21 to 165 step 16 ' Stamp rows of cells down the screen
		hput (21, y)-(289, y + 12), 1
	next
	gosub 2000 ' Display the whole grid at once
	return

	' Reset the machine
6000	poke &h71, 0
	exec &h8c1b

	' Execute keyboard command
7000	a = 0
	s$ = inkey$
	if s$ <> "" then
		a = asc(s$)
	end if
	if j > 1 and a = 94 then	' uparrow (move up)
		j = j - 1
	end if
	if j < 10 and a = 10 then	' downarrow (move down)
		j = j + 1
	end if
	if i > 1 and a = 8 then		' leftarrow (move left)
		i = i - 1
	end if
	if i < 17 and a = 9 then	' rightarrow (move right)
		i = i + 1
	end if
	if a = 13 then			' ENTER
		hcolor 5 ' Cyan
		d = int(sqr((fi - i)^2 + (fj - j)^2) / 2)
		hprint (3 + (i - 1) * 2, 3 + (j - 1) * 2), chr$(asc("0") + d)
		m = m + 1
		hprint (13, 1), str$(m) + " moves"
	end if
	return

	' Draw the fox
8000	hdraw "BM22,33C4U12R10D12BLC7L8BM23,22C4RC7RC4R5C7RC4RBM23,23RC7RC4R5C7RC4RBM23,24C7RC1RC7RC4R3C7RC1RC7R0BM23,25R8DL8BM23,27RC1R2C7R3C1R2C7R0"
	hdraw "BM23,28C1RBR2RC7RC1R0BR2RBM23,29R4C7RC1R3BM23,30C4RC1R3C7RC1R3C4RBM23,31R2C7RC1RC7RC1RC7RC4RBM23,32RC7R2BR2R3C4R"
	return
