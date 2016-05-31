import itertools  
import random
import csv
from pandas import DataFrame

output_file = raw_input("What do you want to call this file?")  
input_file = raw_input("What is the sequence file called?")													#Name this the Participant #
carryover_abstract = []
with open(input_file, 'rb') as csvfile:						#Name this the sequence for that Participant #
	spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
	for row in spamreader:
		str = ''.join(row)
		carryover_abstract.append(str)

formats = ['schema','word','image']
directions = ['left','right','ahead','shRight','shLeft','slLeft','sLright']
stimuli_1 = range(1,22)
stimuli_2 = range(1,22)
stimuli_3 = range(1,22)
stimuli_4 = range(1,22)
stimuli_5 = range(1,22)
stimuli_6 = range(1,22)
stimuli_7 = range(1,22)
stimuli_8 = range(1,22)
stimuli_9 = range(1,22)
stimuli_A = range(1,22)
stimuli_B = range(1,22)
stimuli_C = range(1,22)
stimuli_D = range(1,22)
stimuli_E = range(1,22)
stimuli_F = range(1,22)
stimuli_G = range(1,22)
stimuli_H = range(1,22)
stimuli_I = range(1,22)
stimuli_J = range(1,22)
stimuli_K = range(1,22)
stimuli_0 = range(1,22)

column_1 = []
column_2 = []
column_3 = []


for i in carryover_abstract:
	if i == '1' or i == '2' or i == '3' or i == '4' or i == '5' or i == '6' or i == '7':
		column_1.append('schema')
	elif i == '8' or i == '9' or i == '0' or i == 'A' or i == 'B' or i == 'C' or i == 'D':
		column_1.append('word')
	elif i == 'E' or i == 'F' or i == 'G' or i == 'H' or i == 'I' or i == 'J' or i == 'K':
		column_1.append('image')
	else:
		continue


for i in carryover_abstract:
	if i == '1' or i == '8' or i == 'E':
		column_2.append('left')
	elif i == '2' or i == '9' or i == 'F':
		column_2.append('right')
	elif i == '3' or i == '0' or i == 'G':
		column_2.append('ahead')
	elif i == '4' or i == 'A' or i == 'H':
		column_2.append('shRight')
	elif i == '5' or i == 'B' or i == 'I':
		column_2.append('shLeft')
	elif i == '6' or i == 'C' or i == 'J':
		column_2.append('slLeft')
	elif i == '7' or i == 'D' or i == 'K':
		column_2.append('slRight')
	else:
		continue

for i in carryover_abstract:
	if i == '0':
		x = random.choice(stimuli_0)
		column_3.append(x)
		stimuli_0.remove(x)
	if i == '1':
		x = random.choice(stimuli_1)
		column_3.append(x)
		stimuli_1.remove(x)
	if i == '2':
		x = random.choice(stimuli_2)
		column_3.append(x)
		stimuli_2.remove(x)	
	if i == '3':
		x = random.choice(stimuli_3)
		column_3.append(x)
		stimuli_3.remove(x)
	if i == '4':
		x = random.choice(stimuli_4)
		column_3.append(x)
		stimuli_4.remove(x)
	if i == '5':
		x = random.choice(stimuli_5)
		column_3.append(x)
		stimuli_5.remove(x)
	if i == '6':
		x = random.choice(stimuli_6)
		column_3.append(x)
		stimuli_6.remove(x)
	if i == '7':
		x = random.choice(stimuli_7)
		column_3.append(x)
		stimuli_7.remove(x)
	if i == '8':
		x = random.choice(stimuli_8)
		column_3.append(x)
		stimuli_8.remove(x)
	if i == '9':
		x = random.choice(stimuli_9)
		column_3.append(x)
		stimuli_9.remove(x)
	if i == 'A':
		x = random.choice(stimuli_A)
		column_3.append(x)
		stimuli_A.remove(x)
	if i == 'B':
		x = random.choice(stimuli_B)
		column_3.append(x)
		stimuli_B.remove(x)
	if i == 'C':
		x = random.choice(stimuli_C)
		column_3.append(x)
		stimuli_C.remove(x)
	if i == 'D':
		x = random.choice(stimuli_D)
		column_3.append(x)
		stimuli_D.remove(x)
	if i == 'E':
		x = random.choice(stimuli_E)
		column_3.append(x)
		stimuli_E.remove(x)
	if i == 'F':
		x = random.choice(stimuli_F)
		column_3.append(x)
		stimuli_F.remove(x)
	if i == 'G':
		x = random.choice(stimuli_G)
		column_3.append(x)
		stimuli_G.remove(x)
	if i == 'H':
		x = random.choice(stimuli_H)
		column_3.append(x)
		stimuli_H.remove(x)
	if i == 'I':
		x = random.choice(stimuli_I)
		column_3.append(x)
		stimuli_I.remove(x)
	if i == 'J':
		x = random.choice(stimuli_J)
		column_3.append(x)
		stimuli_J.remove(x)
	if i == 'K':
		x = random.choice(stimuli_K)
		column_3.append(x)
		stimuli_K.remove(x)
	if i == 'L':
		x = random.choice(stimuli_L)
		column_3.append(x)
		stimuli_L.remove(x)

l1 = column_1
l2 = column_2
l3 = column_3

df = DataFrame({'format': l1, 'direction': l2, 'number':l3})
df


df.to_excel(output_file+'.xlsx', sheet_name='sheet1', index=False)