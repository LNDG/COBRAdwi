#!/bin/bash

InputDir=$1
OutputDir=$2

cd ${InputDir}

subjfiles=( $(find * -maxdepth 1 -name "*.nii.gz") )

for i in ${subjfiles[@]}
do

filename=$(basename $i)
subid=$(echo "$filename" | cut -c1-14)
echo ${subid}

OUTDIR=${OutputDir}/BIDS/sub-${subid}/dwi

mkdir -p ${OUTDIR}/

Commonbase=$(echo "$filename" | cut -f 1 -d '.')

mrconvert ${i} ${OUTDIR}/sub-${subid}_acq-AP_dwi.mif -strides +1,2,3,4 -force -json_export ${OUTDIR}/sub-${subid}_acq-AP_dwi.json -export_grad_mrtrix ${OUTDIR}/sub-${subid}_acq-AP_dwi.b -fslgrad ${Commonbase}.bvec ${Commonbase}.bval -export_grad_fsl ${OUTDIR}/sub-${subid}_acq-AP_dwi.bvecs ${OUTDIR}/sub-${subid}_acq-AP_dwi.bvals

done

cd ${InputDir}
