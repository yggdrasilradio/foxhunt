1PCLEAR1:ONBRKGOTO6000:POKE&HE010,&H26:POKE&HE011,&H02:POKE&HE012,&H32:POKE&HE013,&H62:POKE&HE014,&H10:POKE&HE015,&H8E:POKE&HE016,&HFE:POKE&HE017,&H19:POKE&HE018,&H39:POKE&HEF68,&HBD:POKE&HEF69,&HE0:POKE&HEF6A,&H10
2POKE&HEF6B,&H12:POKE&HF015,&H21:POKE&HFFD9,0:HSCREEN2:HBUFF1,100
10HCLS0:HCOLOR5:HPRINT(0,0),"Fox Hunt":HPRINT(27,0),"by Rick Adams":R=RND(-TIMER):FI=INT(16*RND(0))+2:FJ=INT(9*RND(0))+2:M=0:GOSUB4000:I=1:J=1
100GOSUB3000:IFFI<>I OR FJ<>J OR A<>13 THENGOTO100
101HCOLOR7:HPRINT(3+(I-1)*2,3+(J-1)*2),"F":HCOLOR5:HPRINT(0,0),"        ":HPRINT(27,0),"             ":HPRINT(5,1),"You win! Fox found in"+STR$(M)+" moves":HPRINT(6,23),"Press any key to play again":EXEC&HADFB
102C$=INKEY$:GOTO10
3000T=(T+1)AND7:X=24+(I-1)*16-3:Y=24+(J-1)*16-3:IFT AND4 THENHLINE(X,Y)-(X+12,Y+12),PRESET,B ELSEHCOLOR4:HLINE(X,Y)-(X+12,Y+12),PSET,B:GOSUB7000
3001RETURN
4000HCOLOR4:HLINE(21,21)-(33,33),PSET,B:HGET(21,21)-(33,33),1:FORY=21TO165STEP16:FORX=21TO277STEP16:HPUT(X,Y)-(X+12,Y+12),1,PSET:NEXT:NEXT:RETURN
6000POKE&H71,0:EXEC&H8C1B
7000A=0:S$=INKEY$:IFS$<>"" THENA=ASC(S$)
7001IFJ>1AND A=94 THENJ=J-1
7002IFJ<10AND A=10 THENJ=J+1
7003IFI>1AND A=8 THENI=I-1
7004IFI<17AND A=9 THENI=I+1
7005IFA=13 THENHCOLOR5:D=INT(SQR((FI-I)^2+(FJ-J)^2)/2):HPRINT(3+(I-1)*2,3+(J-1)*2),CHR$(ASC("0")+D):M=M+1:HPRINT(13,1),STR$(M)+" moves"
7006RETURN
