Models <-
function (MMdata,min.L,nyr,MM=T,LL=T, od=F, V=F){
  # the standard MM, as year-monad (ym) resolution
  if (MM){
    MM <- fit_LadybirdMM2(MMdata, nsp=min.L, nyr, od=F, V=F)
    names(MM) <- c('trend','trendSE','zscore','p','intercept','interceptSE','yearZero','cvg','pCombosUsed','SiteDatecombos','n_Obs')
    names(MM) <- paste('MM_', names(MM), sep='')
    output <- MM
  }
  if(LL){
    # Create a new value of year centred on the median year
    # This increases the stability of the model
    medianYear <- median(unique(as.numeric(MMdata$year)))
    MMdata$year <- as.numeric(MMdata$year)
    MMdata$cYr <- MMdata$year - medianYear
        
    #Concept is numeric, as we are looking at presence and absence of the target species
    LL_model <- summary(glm(as.numeric(CONCEPT) ~ cYr + log2(L), binomial, data=MMdata, subset = L>0))$coef
    ####DEBUGGING###    
    M2<-glm(as.numeric(CONCEPT) ~ cYr + log2(L), binomial, data=MMdata, subset = L>0)  
    M2<<-M2
    
    if(exists('output')){
       output <- c(output, LL_trend=LL_model[2,1],LL_trendSE=LL_model[2,2],LL_z=LL_model[2,3],LL_p=LL_model[2,4],LL_intercept=LL_model[1,1],LL_interceptSE=LL_model[1,2],LL_interceptZ=LL_model[1,3],LL_interceptP=LL_model[1,4],LL_Log2L=LL_model[3,1],LL_Log2L_SE=LL_model[3,2],LL_Log2L_Z=LL_model[3,3],LL_Log2L_P=LL_model[3,4],LL_yearZero=medianYear)
    }else{
       output <- c(LL_trend=LL_model[2,1],LL_trendSE=LL_model[2,2],LL_z=LL_model[2,3],LL_p=LL_model[2,4],LL_intercept=LL_model[1,1],LL_interceptSE=LL_model[1,2],LL_interceptZ=LL_model[1,3],LL_interceptP=LL_model[1,4],LL_Log2L=LL_model[3,1],LL_Log2L_SE=LL_model[3,2],LL_Log2L_Z=LL_model[3,3],LL_Log2L_P=LL_model[3,4],LL_yearZero=medianYear)
    }
  }
  return(output)
}
