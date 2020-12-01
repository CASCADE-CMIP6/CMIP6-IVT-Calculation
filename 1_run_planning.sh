#!/bin/bash
#SBATCH -C knl
#SBATCH -N 17
#SBATCH -q debug
#SBATCH -t 00:30:00
#SBATCH -A m1517
#SBATCH -J 1_run_planning

# bring a TECA install into your environment. Note this will not work if you
# have other HDF5, NetCDF or Python modules loaded
# change the following paths to point to your TECA install
module swap PrgEnv-intel PrgEnv-gnu
module use /global/cscratch1/sd/loring/teca_testing/deps/cf_reader_performance/modulefiles/
module load teca/cf_reader_performance

# print the commands as they execute, and error out if any one command fails
set -e
set -x

# configure HDF5 file locking if on Cori (CFS)community file system
# This is not needed on Cori Lustre scratch file system
export HDF5_USE_FILE_LOCKING=FALSE

# run the probe to determine number size of the dataset
time srun -N 17 -n 1024 \
    teca_metadata_probe --z_axis_variable plev \
        --input_file HighResMIP_ECMWF_ECMWF-IFS-HR_highresSST-present_r1i1p1f1_6hrPlevPt.mcf
