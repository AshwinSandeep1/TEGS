#!/bin/bash 
#SBATCH -n 40
#SBATCH -N 1
#SBATCH -p sched_mit_ase
cd "/nobackup1/asandeep"
module add julia/1.8.5 gurobi/8.1.1
julia --project=. /nobackup1/asandeep/TEGS_runs/run_files/comparison_modeling_methods/trial_model.jl