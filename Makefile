all: foxhunt

foxhunt: foxhunt.bas
	decbpp < foxhunt.bas > redistribute/foxhunt.bas

ifneq ("$(wildcard /media/share1/COCO/drive0.dsk)", "")
	decb copy -tr redistribute/foxhunt.bas /media/share1/COCO/drive0.dsk,FOXHUNT.BAS
endif
	cat redistribute/foxhunt.bas
