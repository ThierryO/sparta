fit_maes_trend<-function(records, time_periods=NULL, min_sp=5){
  
  # fits the method described in Maes et al 2012 (Biol Cons 145: 258-266)
  # I checked this by comparing the results against those in Maes et al SI
  # I've added a sampling theory to estimate p-values.
  # the function returns numbers of sites in 2 time periods (out of the well-sampled ones), the %trend and p-value
  require(reshape2)
  
  if(is.null(time_periods)) stop('No time periods supplied to fit_maes_trend')
  
  # Create a vector of all the years to include
  for (i in 1:length(row.names(time_periods))) {
    run<-time_periods[i,1]:time_periods[i,2]
    if (exists('all_years')){
      all_years <- c(all_years,run)
    }else{
      all_years <- run
    }
  }
  
  
  # Subset data to years needed
  records<-records[records$tpnew %in% all_years,]
  
  splityr <- mean(c(max(time_periods[1,]),min(time_periods[2,])))
    
  # which time period is each record in?
  records$tp[records$tpnew<splityr & records$tpnew<splityr]<-1
  records$tp[records$tpnew>=splityr & records$tpnew>=splityr]<-2
    
  records<-records[!is.na(records$tp),]
  # convert the records into a 3D array
  rc <- acast(records, Species ~ Site ~ tp, fun=occurrence, value.var=2)

  # what is the observed species richness in each cell in each year
  rc1 <- apply(rc, c(2,3), sum)
  
  # which sites are well-sampled? (defined as having at least min_sp species in BOTH time periods)
  well_sampled <- as.numeric(dimnames(rc1)[[1]][apply(rc1, 1, function(x) all(x>=min_sp))])
  
  # look at just the data for these well-sampled cells
  rc2 <- rc[,dimnames(rc)[[2]] %in% well_sampled,]
  
  # how many sites for each species in each time period?
  rc3 <- apply(rc2, c(1,3), sum)
  
  # calculate the relative distribution in each time period
  # the denominator is the total number of unqiue site-species combos within the well-sampled set (for each period)
  rd <- apply(rc3, 2, function(x) x/sum(x))
  
  # the trend is the % difference in the two relative distributions
  trend <- 100 * (rd[,2]-rd[,1])/rd[,1]    
  
  # we can assess the significance of this method as follows
  # first we assume the distribution of each species is equal among poorly-sampled and well-sampled sites
  # Under the null hypothesis that total proportion of sites has not changed,
  # we can calculate the binomial probability of the 'estimated number of successes
  # estimated number of successes is defined here as nsr2 (number of sites recorded in t2)
  # where the number of trials = nS[2]
  
  pval <- mapply(FUN=pbinom, q=rc3[,2], prob=rd[,1], MoreArgs=list(size=sum(rc3[,2])))
  
  #these are one-tailed: convert them to one-tailed
  pval <- one_to_two_tail(pval)
  

  Maes <- data.frame(gridcells1=rc3[,1], relDist1=rd[,1], gridcells2=rc3[,2], relDist2=rd[,1], change=trend, pval=pval) 
  attr(Maes, 'GridCellSums') <- colSums(rc3)
  attr(Maes, 'wellsampled') <- length(well_sampled)
  return(Maes)
}

one_to_two_tail <- function(p) ifelse(p<0.5, p*2, (1-p)*2)
