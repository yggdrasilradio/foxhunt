
'	0				      39
'0	Fox Hunt...................by Rick Adams
'1	....You win! Fox found in NN moves......
'2	........................................
'3	...X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.X....
'4	........................................
'5	...X...............................X....
'6	........................................
'7	...X...............................X....
'8	........................................
'9	...X...............................X....
'10	........................................
'11	...X...............................X....
'12	........................................
'13	...X...............................X....
'14	........................................
'15	...X...............................X....
'16	........................................
'17	...X...............................X....
'18	........................................
'19	...X...............................X....
'20	........................................
'21	...X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.X....
'22	........................................
'23	.....Press any key to play again........

	' Reset machine on BREAK
	pclear 1
	on brk goto 6000

	' Modify HPRINT
	include "hprint.bas"

	' Double speed poke
	poke &hffd9, 0

	' Init graphics
	hscreen 2

	' Clear screen
10	hcls 0

	' Title
	hcolor 5 ' Cyan
	hprint (0, 0), "Fox Hunt"
	hprint (27, 0), "by Rick Adams"

	' Seed the random number generator
	r = rnd(-timer)

	' Place the "fox" somewhere randomly
	fi = int(16 * rnd(0)) + 2 ' X = Random number 2-17
	fj = int(9 * rnd(0)) + 2  ' Y = Random number 2-10

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
	hcolor 7 ' Orange
	hprint (3 + (i - 1) * 2, 3 + (j - 1) * 2), "F"
	hcolor 5 ' Cyan
	hprint (0, 0), "        "
	hprint (27, 0), "             "
	hprint (5, 1), "You win! Fox found in" + Str$(m) + " moves"
	hprint (6, 23), "Press any key to play again"
	exec &hadfb ' Block until key is pressed
	c$ = inkey$
	goto 10

	' Highlight square at i, j
3000	t = (t + 1) and 7
	x = 24 + (i - 1) * 16 - 3
	y = 24 + (j - 1) * 16 - 3
	if t and 4 then
		hline (x, y)-(x + 12, y + 12), preset, b
	else
		hcolor 4 ' White
		hline (x, y)-(x + 12, y + 12), pset, b

		' Update position
		gosub 7000
	end if
	return

	' Draw grid
4000	for j0 = 1 to 10
		y = 24 + (j0 - 1) * 16 - 3
		for i0 = 1 to 17
			x = 24 + (i0 - 1) * 16 - 3
			hcolor 4 ' White
			hline (x, y)-(x + 12, y + 12), pset, b
		next
	next
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
