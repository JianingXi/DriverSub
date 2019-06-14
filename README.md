# DriverSub
Inferring subgroup specific driver genes from heterogeneous cancer samples via subspace learning with subgroup indication


![image](https://github.com/JianingXi/DriverSub/blob/master/bin/Fig1.jpg)

Developer: Jianing Xi <jnxi@xidian.edu.cn> from School of Computer Science and Technology, Xidian University

## Instructions to DriverSub (version 1.0.0)

Requirement
------------------------
* 4GB memory
* MATLAB R2015a or later

Input data
------------------------
mutation matrix of a cohort of cancer samples
The files `./InputData/D01_brca.mat` and `./InputData/D02_blca.mat` contain the TCGA somatic mutation data matrix of breast cancers (BRCA) [1] and bladder cancers (BLCA) [x], which are downloaded from [cBioPortal](http://www.cbioportal.org/data_sets.jsp) [3].

run DriverSub
------------------------
To apply DriverSub, please run the Matlab script file `./demo.m` and the results will be automatically saved in file `./Output/result_[cancer_file_name].mat` after the program is finished.

Output variables
------------------------
In file `./output/result_[cancer_name].mat`, there are four output variables:

1. `Mutation_Score`
Since the distances between the output vectors and the origin of the subspace can be used to discriminate driver genes, DriverSub gives the normalized mutation scores for the investigated genes through the output variable `Mutation_Score`.

2. `SubgroupSpec`
Since the coordinate values in different dimensions of the vectors can indicate the subgroups specificities of the related genes, DriverSub also yields the subgroup indices of the investigated genes through the output variable `SubgroupSpec`.


3. `Predicted_Driver_Genes`
The variable `Predicted_Driver_Genes` contains the predicted driver genes, which are selected as the top 500 ranked genes, according to their `Mutation_Score`.

4. `SubgroupSp_Predicted_Genes`
The variable `SubgroupSp_Predicted_Genes` contains the indications of subgroup specificities of the top 500 predicted genes, according to the variable `SubgroupSpec`.


References
------------------------
[1] Cancer Genome Atlas Network and others (2012). Comprehensive molecular portraits of human breast tumours. Nature, 490(7418), 61.
[2] Cancer Genome Atlas Research Network and others (2014). Comprehensive molecular characterization of urothelial bladder carcinoma. Nature, 507(7492), 315.
[3] Gao, J., Aksoy, B. A., Dogrusoz, U., Dresdner, G., Gross, B., Sumer, S. O., Sun, Y., Jacobsen, A., Sinha, R., Larsson, E., et al. (2013). Integrative analysis of complex cancer genomics and clinical profiles using the cbioportal. Sci. Signal, 6(269), pl1¨Cpl1.
