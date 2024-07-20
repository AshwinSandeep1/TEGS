#!/bin/bash 
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -p newnodes
cd "/nobackup1/asandeep"
module add julia/1.8.5
julia --project=. /nobackup1/asandeep/TEGS_runs/run_files/comparison_modeling_methods/Run_NL_model.jl