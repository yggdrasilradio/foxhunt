1ONBRKGOTO6000:POKE&HE010,&H26:POKE&HE011,&H02:POKE&HE012,&H32:POKE&HE013,&H62:POKE&HE014,&H10:POKE&HE015,&H8E:POKE&HE016,&HFE:POKE&HE017,&H19:POKE&HE018,&H39:POKE&HEF68,&HBD:POKE&HEF69,&HE0:POKE&HEF6A,&H10
2POKE&HEF6B,&H12:POKE&HF015,&H21:POKE&HFFD9,0:HSCREEN2:HBUFF1,1760:HBUFF2,100
10HCLS:HCOLOR5:HPRINT(0,0),"Fox Hunt":HPRINT(27,0),"by Rick Adams":R=RND(-TIMER)
20FI=INT(17*RND(0))+1:FJ=INT(10*RND(0))+1:D=INT(SQR((FI-1)^2+(FJ-1)^2)/2):IFD<3 THENGOTO20
21M=0:GOSUB4000:I=1:J=1
100GOSUB3000:IFFI<>I OR FJ<>J OR A<>13 THENGOTO100
101X=24+(I-1)*16-3:Y=24+(J-1)*16-3:HPUT(X,Y)-(X+12,Y+12),2:HCOLOR5:HPRINT(0,0),"        ":HPRINT(27,0),"             ":HPRINT(5,1),"You win! Fox found in"+STR$(M)+" moves":HPRINT(6,23),"Press any key to play again"
102EXEC&HADFB:C$=INKEY$:GOTO10
1000PALETTE0,0:PALETTE1,0:PALETTE4,0:PALETTE7,0:RETURN
2000PALETTE0,0:PALETTE1,53:PALETTE4,63:PALETTE7,38:RETURN
3000T=(T+1)AND7:X=24+(I-1)*16-3:Y=24+(J-1)*16-3:OI=I:OJ=J:GOSUB7000:IF(T AND2)AND I=OI AND J=OJ THENHLINE(X,Y)-(X+12,Y+12),PRESET,B ELSEHCOLOR4:HLINE(X,Y)-(X+12,Y+12),PSET,B
3001RETURN
4000HCOLOR4:GOSUB1000:HDRAW"BM21,21R12D12L12U12":HGET(21,21)-(33,33),1:GOSUB8000:HGET(21,21)-(33,33),2:FORX=21TO277STEP16:HPUT(X,21)-(X+12,33),1:NEXT:HGET(21,21)-(289,33),1:FORY=37TO165STEP16:HPUT(21,Y)-(289,Y+12),1
4001NEXT:GOSUB2000:RETURN
6000POKE&H71,0:EXEC&H8C1B
7000A=0:S$=INKEY$:IFS$<>"" THENA=ASC(S$)
7001IFJ>1AND A=94 THENJ=J-1
7002IFJ<10AND A=10 THENJ=J+1
7003IFI>1AND A=8 THENI=I-1
7004IFI<17AND A=9 THENI=I+1
7005IFA=13 THENHCOLOR5:D=INT(SQR((FI-I)^2+(FJ-J)^2)/2):HPRINT(3+(I-1)*2,3+(J-1)*2),CHR$(ASC("0")+D):M=M+1:HPRINT(13,1),STR$(M)+" moves"
7006RETURN
8000HDRAW"BM22,21C4D12BM32,21D12BM22,21R9BM23,22RC7RC4R5C7RC4R0BM23,23RC7RC4R5C7RC4R0BM23,24C7RC1RC7RC4R3C7RC1RC7R0":HDRAW"BM23,25R8BM23,26R8BM23,27RC1R2C7R3C1R2C7R0BM23,28C1R2C0RC1RC7RC1RC0RC1RBM23,29R4C7RC1R3BM23,30C4RC1R3C7RC1R3C4R0"
8001HDRAW"BM23,31R2C7RC1RC7RC1RC7RC4RBM23,32RC7R3C0RC7R3C4R0BM23,33C7R8":RETURN
