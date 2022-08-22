from Bio import SeqIO
import pandas as pd
import numpy as np

#Load the data contiaing mutants with no spaces and delimited by - in a column named Mutations
data = read_table("./SenRWT.txt", '\t')

# Load the amino acid sequence of your construct
Sequence = "TIEVQRWEDKFEIKPGVWVYVPSVEARKVGGKILQAVRNKWIPPLYFYHLRTGGHLKAARLHLKSDFFAVVDIKQFFQSTSRSRITRDLKSYFTYSQAREISTFSTVRNLSHSPHKHVLPFGFVQSPILATLCLDKSYFGSLLRRLNKHHDLKLSVFMDDVIISSNNLAQLQAAYDEALVAMRKSGYQANMSKTQAPSSKISVFNLTLSKGVMKVTSQKMSDFLIDFYSSNYEPHRIGVKNYVEAVNPGQAKLFKL"

#Create the data from and set the mutation column to string type. 
data = pd.DataFrame(data)
data["Mutations"] = data["Mutations"].astype(str)
print(data)

#Define the mutate function
def mutate(sequence, mutations, list_or_string='string'):
    if (list_or_string == 'string'):
        mutations = mutations.split('-')

    mut_sequence = list(sequence)
    for mut in mutations:
        curr_res = mut[0]
        mut_res = mut[-1]
        mut_pos = mut[1:-1]
        mut_sequence[int(mut_pos)-1] = mut_res

    return ''.join(mut_sequence)
  
#Append a sequence column to the dataframe. 
data["Sequence"] = data.apply(lambda row: mutate(Sequence, row['Mutations']), axis=1)
print(data)

#Write the dataframe to a csv file: 
data.to_csv('WithSequence.csv', index=False)
