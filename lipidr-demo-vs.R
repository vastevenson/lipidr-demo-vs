# All credit goes to Ahmed Mohamed for this awesome R library!
# visit lipidr.org for more info

dir_path = getwd()
dir_name = "/lipidr-demo-vs"
print(dir_path)
dm_path = paste(dir_path,dir_name,"/test_data_matrix.csv",
                sep="")
ta_path = paste(dir_path,dir_name,"/test_annotation_data.csv",
                sep="")

# install lipidr
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("lipidr")

d <- as_lipidomics_experiment(read.csv(dm_path))
d <- add_sample_annotation(d, ta_path)
# visualize lipid intensity across the samples 
# https://www.lipidr.org/articles/examples/mw_integration.html
plot_samples(d, type="tic", log=TRUE)

d <- set_logged(d, "Area", TRUE)
d <- set_normalized(d, "Area", TRUE)
plot_samples(d, "boxplot")
mvaresults = mva(d, measure="Area", method="PCA")
plot_mva(mvaresults, color_by="SampleType", components = c(1,2))

two_group <- de_analysis(d, Cancer-Benign, Cancer-Metastasis)
plot_results_volcano(two_group)