% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MAPE2.0.R
\name{MAPE2.0}
\alias{MAPE2.0}
\title{Perform the Meta-Analysis for Pathway Enrichment}
\usage{
MAPE2.0(
  arraydata = NULL,
  clinical.data = NULL,
  label = NULL,
  pmtx = NULL,
  pathway = c(Biocarta.genesets, GOBP.genesets, GOCC.genesets, GOMF.genesets,
    KEGG.genesets, Reactome.genesets),
  data.type = c("continuous", "discrete"),
  mixed = NULL,
  mix.type = NULL,
  covariate = NULL,
  ref.level,
  paired,
  ind.method,
  select.group,
  tail = "abs",
  resp.type = c("twoclass", "multiclass", "continuous", "survival"),
  method = c("CPI", "MAPE"),
  enrichment = c("KS", "Fisher's exact"),
  DEgene.number = 200,
  stat = c("Fisher", "maxP", "minP", "rth", "AW Fisher"),
  rth.value = NULL,
  permute = F,
  nperm = 500,
  size.min = 15,
  size.max = 500,
  qvalue.cal = c("estimate", "permutation")
)
}
\arguments{
\item{arraydata}{The arraydata is a list of microarray data sets. Each microarray data set can be
either an ExpressionSet or a list. If the microarray data set is a list, then it includes
five elements as follows: 1)x-exprs data 2)y- the phenotype of interests
3)z- censoring.status if applicable. 1 stands for the event occurred and 0 stands
for censored. 4)geneid 5)samplename If the microarray data set is in an ExpressionSet
format, the users need to 1) store the phenotype of interests in the slot
'label'. 2) store the censor data is the slot 'censoring.status' if applicable}

\item{clinical.data}{Clinical data files}

\item{label}{Label selected from clinical.data}

\item{pmtx}{Option for uploading p-value matrix.}

\item{pathway}{The pathway databases}

\item{data.type}{It is one of the two values: 'continuous','discrete'.}

\item{resp.type}{The phenotype of interest.It is one of the four values: 'twoclass','multiclass',
'continuous','survival'.}

\item{method}{The method for overall analysis. It is one of the two values: 'CPI','MAPE'.}

\item{enrichment}{The method for pathway enrichment analysis. It is one of the two values: 'KS',
'Fisher's exact'.}

\item{DEgene.number}{For Fisher's exact method, the number of differentially expressed genes
identified from each studies.}

\item{stat}{The meta-analysis statistic to be used to combine multiple studies. For MAPE, it is
one of the five values: 'minP','maxP','rth','Fisher','AW Fisher'.For CPI, AW Fisher's method is the only option.}

\item{rth.value}{The value of the rth statistic if the meta-anlaysis statistic is 'rth'.
For example,rth.value = 2.}

\item{permute}{Whether to use permutation to calculate p-values. By default, it is false.}

\item{nperm}{Number of permutations to be performed.}

\item{size.min}{The minimum size of pathways to be considered. The default value is 15.}

\item{qvalue.cal}{The method to calculate the q-values if permute is true. The default method is to
calcuate the q-values based on the permutation method. If qvalue.cal='estimate', the q-values
were estimated based on the Storey's method.}

\item{size}{max The maximum size of pathways to be considered. The default value is 500.}
}
\value{
The qvalue and pvalue of each pathway including Meta qvalue and Meta pvalue.
}
\description{
This is the first major function in the MetaPath2.0 package which combines the Meta-analysis
for Pathway Enrichment (MAPE) methods introduced by Shen and Tseng (2010) and the
Comparative Pathway Integrator (CPI) method introduced by Fang and Tseng (2016).
The default function is CPI which performs MAPE_P (integrating multiple studies at pathway level)
with Adaptively Weighted Fisher's method as Meta-analysis statistics. The other function, MAPE,
automatically performs MAPE_G (integrating multiple studies at gene level), MAPE_P and
MAPE_I (a hybrid method integrating MAEP_G and MAPE_P methods).
}
\details{
For MAPE, in the simulation and real data analyses in the paper, MAPE_G and MAPE_P have complementary
advantages and detection power depending on the data structure. In general, the integrative
form of MAPE_I is recommended to use. In the case that MAPE_G (or MAPE_P) detects almost
none pathway, the integrative MAPE_I does not improve performance and MAPE_P (or MAPE_G)
should be used.
}
\examples{
data(Psychiatry_disease_filtered)
data(pathways)
CPI_result = MAPE2.0(arraydata = Psychiatry_diseases$expr, clinical.data = Psychiatry_diseases$clinical,
                    label = "response",pmtx = NULL,pathway = c(Biocarta.genesets,GOBP.genesets,GOCC.genesets,GOMF.genesets,
                    KEGG.genesets,Reactome.genesets),data.type ="continuous", resp.type = "twoclass",method = "CPI",
                    ind.method = rep("limma",length(Psychiatry_diseases$expr)),paired = rep(FALSE,length(Psychiatry_diseases$expr)),
                    select.group = c("CASE","CTRL"),ref.level ="CTRL",tail="abs",
                    enrichment = "Fisher's exact", DEgene.number = 400,stat = "AW Fisher")
}
\author{
Kui Shen, Xiangrui Zeng and George Tseng.
}
