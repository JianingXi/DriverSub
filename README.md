# DriverSub
Inferring subgroup specific driver genes from heterogeneous cancer samples via subspace learning with subgroup indication


![image](https://github.com/JianingXi/DriverSub/blob/master/bin/splash.jpg)

Developer: Jianing Xi <xjn@nwpu.edu.cn>

School of Mechanical Engineering and Center for OPTical IMagery Analysis and Learning (OPTIMAL),

Northwestern Polytechnical University, China

## Instructions to DriverSub (version 1.0.0)

Citing this work
------------------------
Jianing Xi, Xiguo Yuan, Minghui Wang, Ao Li, Xuelong Li, Qinghua Huang, Inferring subgroup specific driver genes from heterogeneous cancer samples via subspace learning with subgroup indication, *Bioinformatics*, Volume 36, Issue 6, 15 March 2020, Pages 1855–1863,  https://doi.org/10.1093/bioinformatics/btz793

Requirement
------------------------
* 4GB memory
* MATLAB R2015a or later

Input data Generation
------------------------

The script `./GenerateInputData.m` can generate input data file from raw data, where the mutations of a cohort of cancer samples are download from [cBioPortal database](http://www.cbioportal.org/data_sets.jsp) [1].

### 1. Loading raw data of mutations

Here we have provided raw data of TCGA somatic mutations of two cancer types, breast cancers (BRCA) [2] and bladder cancers (BLCA) [3], downloaded from cBioPortal [1], which are located at:

* `./cBioPortal_RawData/brca_tcga_pub/data_mutations_extended.txt`,
* `./cBioPortal_RawData/blca_tcga_pub/data_mutations_extended.txt`.

Through the script `./GenerateInputData.m` with function `./bin/P01_LoadRawMut.m`, the raw data can be loaded into Matlab Workspace.

### 2. Generating input data

After the raw data are loaded, the script `./GenerateInputData.m` with function `./bin/P02_GenerateMutData.m` can 
generate the mutation matrix of BRCA and BLCA as `./InputData/D01_brca.mat` and `./InputData/D02_blca.mat`. The two generated `.mat` files are the input data of DriverSub.


Subgroup specific driver gene analysis by DriverSub
------------------------

### 1. Run DriverSub

To apply DriverSub, please run the Matlab script file `./demo.m` and the results will be automatically saved in file `./Output/result_[cancer_file_name].mat` after the program is finished.

### 2. Input Arguments

* `X_mat`: the mutation matrix of cancer samples (sample x gene);
* `K_dim`: the number of subgroups, predefined by users;
* `lambda_Z`: the tuning parameter for the sparisity of matrix Z;
* `lambda_W`: the tuning parameter for preventing overfitting of matrix W;
* `L_norm`: the index of which type of regularization on output vector zi is choosen, where there are two options `L1` and `L2`;
* `W_init`: the user-defined random initialization of matrix W, and the function will generates a random matrix if `W_init` is not included.


### 3. Output variables
In file `./output/result_[cancer_name].mat`, there are four output variables:

* `Mutation_Score`: since the distances between the output vectors and the origin of the subspace can be used to discriminate driver genes, DriverSub gives the normalized mutation scores for the investigated genes through the output variable `Mutation_Score`.

* `SubgroupSpec`: since the coordinate values in different dimensions of the vectors can indicate the subgroups specificities of the related genes, DriverSub also yields the subgroup indices of the investigated genes through the output variable `SubgroupSpec`.


* `Predicted_Driver_Genes`: the variable `Predicted_Driver_Genes` contains the predicted driver genes, which are selected as the top 500 ranked genes, according to their `Mutation_Score`.

* `SubgroupSp_Predicted_Genes`: the variable `SubgroupSp_Predicted_Genes` contains the indications of subgroup specificities of the top 500 predicted genes, according to the variable `SubgroupSpec`.

* `Z_mat`: the variable `Z_mat` contains the output vectors of the investigated genes and the coordinate values can represent the mutation profiles among samples, formed as matrix format.

* `W_mat`: the variable `W_mat` contains the parameters of the subspace learning and can be used to indicate subgroup samples, formed as matrix format.


Subgroup Prediction Assessment
------------------------

Expect that the subgroup annotations for bladder cancer is not available, we have collected the available subgroup annotations for breast cancer from [UCSC Xena](https://xenabrowser.net/) in file `./SubgroupAnnotations/GT01_brca.mat`, as the ground truth in respect to data file `./InputData/D01_brca.mat`.

The script file `./SubgroupAssessment.m` is used to assess subgroup prediction performance. It will automatically draw the figure of association between the inferrd subgroups and the subgroup annotations, which is saved as `Fig_SubgroupAssessment.png`.

![image](https://github.com/JianingXi/DriverSub/blob/master/bin/Fig_SubgroupAssessment.png)


References
------------------------
[1] Gao, J., Aksoy, B. A., Dogrusoz, U., Dresdner, G., Gross, B., Sumer, S. O., Sun, Y., Jacobsen, A., Sinha, R., Larsson, E., et al. (2013). Integrative analysis of complex cancer genomics and clinical profiles using the cbioportal. Sci. Signal, 6(269), pl1-pl1.

[2] Cancer Genome Atlas Network and others (2012). Comprehensive molecular portraits of human breast tumours. Nature, 490(7418), 61.

[3] Cancer Genome Atlas Research Network and others (2014). Comprehensive molecular characterization of urothelial bladder carcinoma. Nature, 507(7492), 315.
