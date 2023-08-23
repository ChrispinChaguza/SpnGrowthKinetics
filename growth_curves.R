library(readxl)
library(data.table)
library(tidyverse)
#library(RNOmni)
#library(lme4)
#library(lmerTest)
#library(ape)
library(motmot)
#library(phylosignal)
#library(phytools)
library(vioplot)

{
  library(readxl)
  library(data.table)
  library(tidyverse)
  
  set.seed(0)
  
  DDD<-as_tibble(fread("SPN_GROWTH_DATA_PLATES.tsv"))  %>% 
    group_by(ID) %>% arrange(TIME) %>% ungroup() %>% rowwise() %>%
    mutate(ID.FINAL=paste0(SAMPLE,".",ID,".",DAY)) %>% ungroup()
    #dplyr::filter(!(SAMPLE %in% c("PBCN0052")) )
    
  SPN.MM<-as_tibble(read.table("METADATA/SEROTYPE_MLST.tsv",sep="\t",header=TRUE,comment.char="?")) %>%
    dplyr::select(strain,PBCN_nr,Seq_ID,SRA_ID,WGS,MLST,serotype) %>%
    group_by(strain) %>% dplyr::filter(row_number()==1) %>%
    mutate(MLST=ifelse(MLST=="u","Unknown",MLST),serotype=ifelse(serotype=="999","Unknown",serotype))
  SPN.MM
  
  STRAIN.INFO<-as_tibble(fread("./AMELIEKE_FASTA/GPSC_SER_MLST.tsv"))
  STRAIN.INFO
  
  {
    data.frame(ID=NA,
               Method=NA,
               L=NA,
               r=NA,
               t0=NA,
               L0=NA,
               delta.H=NA,
               lag=NA ) %>% 
      dplyr::filter(!is.na(ID)) %>%
      write.table("Growth_features_estimates.tsv",sep="\t",row.names=FALSE)
    
    data.frame(ID=NA,
               Method=NA,
               L=NA,
               r=NA,
               t0=NA,
               L0=NA,
               H=NA,
               lag=NA ) %>% 
      dplyr::filter(!is.na(ID)) %>%
      write.table("Growth_features_estimates_.tsv",sep="\t",row.names=FALSE)
    
    data.frame(ID=NA) %>% dplyr::filter(!is.na(ID)) %>%
      write.table("Growth_features_estimates_failed_samples.tsv",sep="\t",row.names=FALSE)
    
    lgf<-function(L,r,t0,L0,t){
      L0+(L / (1 + exp(-r*(t-t0) )))
    }
    
    f2<-function(par,data){
      with(data,{
        sum(( OD-lgf(par[1],par[2],par[3],par[4],HOURS) )^2)
      })
    }
    
    n.plots<-20; n.col<-5; lc<-0; lp<-1
    
    for( sample.id in unique(DDD$SAMPLE)[!(unique(DDD$SAMPLE) %in% c("Blanc"))] ){
      cat(sample.id," ")
      Selected.sample1<-DDD %>% dplyr::filter(SAMPLE==sample.id) %>% 
        mutate(OD.FINAL=OD) %>% 
        arrange(HOURS) %>% mutate(OD=OD.FINAL) %>% ungroup()
      
      
      if(lc%%n.plots==0){
        if(lc!=length(unique(DDD$SAMPLE)) & lc!=0){
          dev.off()
          lp<-lp+1
        }
      }
      
      if(lc%%n.plots==0){
        pdf(paste0("tmp.xxxx.",lp,".pdf"),width=8.5,height=9.0)
        layout(matrix(1:n.plots,ncol=n.col,byrow=TRUE))
        par(mai=c(0.30,0.55,0.1,0.1))
      }

      
      {
        iRep<-1
        for( sample.rep in unique(Selected.sample1$ID.FINAL) ){
          Selected.sample<-DDD %>% dplyr::filter(SAMPLE==sample.id & ID.FINAL==sample.rep ) %>% 
            mutate(OD.FINAL=OD) %>% 
            arrange(HOURS) %>% mutate(OD=OD.FINAL) %>% ungroup()
          
          Max.time1<-Selected.sample %>% dplyr::filter(ID.FINAL==sample.rep) %>%
            dplyr::filter(OD==max(OD)) %>% dplyr::select(HOURS) %>% as.vector()
          Max.time<-Max.time1$HOURS
          Min.time<-0
          Select.sample.filtered<-Selected.sample %>% ungroup() %>%
            dplyr::filter( ID.FINAL==sample.rep & 
                             OD<=max(OD) & HOURS<=Max.time & HOURS>=as.numeric(Min.time) ) %>% 
            bind_rows(Selected.sample %>% 
                        dplyr::filter(ID.FINAL==sample.rep & 
                                        abs(OD-max(OD))/max(OD)<=5.0/100 & HOURS>Max.time ) 
            ) %>% arrange(TIME)
          
          ## Plot the points first before the fitted lines
          if(iRep==1){
            plot(0,0,cex=0.0001,ylim=c(0,1),xlim=c(0,20),yaxs="i",xaxs="i",pch=21,
                 bg=viridis::inferno(6)[iRep],las=1,bty="n",xlab="Time (hours)",
                 ylab=bquote("Optical density"~"("~"OD"[620]~")"))
            
            mtext(sample.id,font=1,side=3,line=-0.50,xpd=TRUE,cex=0.70)
            
            points(Selected.sample$HOURS,Selected.sample$OD,
                   bg=viridis::inferno(6,alpha = 0.70)[iRep],pch=21,lwd=0.15,cex=1.0)
          }else{
            points(Selected.sample$HOURS,Selected.sample$OD,
                   bg=viridis::inferno(6,alpha = 0.70)[iRep],pch=21,lwd=0.15,cex=1.0)
          }
          iRep<-iRep+1
        }
      }
      
      ## Plot the the fitted lines
      
      SSM1<-data.frame()
      out<-NULL
      
      iRep<-1
      for( sample.rep in unique(Selected.sample1$ID.FINAL) ){
        Selected.sample<-DDD %>% dplyr::filter(SAMPLE==sample.id & ID.FINAL==sample.rep ) %>% 
          mutate(OD.FINAL=OD) %>% 
          arrange(HOURS) %>% mutate(OD=OD.FINAL) %>% ungroup()
        
        Max.time1<-Selected.sample %>% dplyr::filter(ID.FINAL==sample.rep) %>%
          dplyr::filter(OD==max(OD)) %>% dplyr::select(HOURS) %>% as.vector()
        Max.time<-Max.time1$HOURS
        Min.time<-0
        Select.sample.filtered<-Selected.sample %>% ungroup() %>%
          dplyr::filter( ID.FINAL==sample.rep & 
                           OD<=max(OD) & HOURS<=Max.time & HOURS>=as.numeric(Min.time) ) %>% 
          bind_rows(Selected.sample %>% 
                      dplyr::filter(ID.FINAL==sample.rep & 
                                      abs(OD-max(OD))/max(OD)<=5.0/100 & HOURS>Max.time ) 
          ) %>% arrange(TIME)
        
        
        for(rr in c("BFGS","Nelder-Mead","CG","SANN","L-BFGS-B")){ 
          out<-optim(par=c(1,1,1,1),
                     data=Select.sample.filtered,
                     fn=f2,
                     method=rr,
                     lower=c(0.1,1.0,0,0),
                     upper=c(1.0,4.0,10,1.0))
          
          if(!is.null(out) & out$par[2]>0.0 & lgf(out$par[1],
                                                  out$par[2],
                                                  out$par[3],
                                                  out$par[4],40)<2.0 ){
            if(rr=="GFBS" | dim(SSM1)[1]==0){
              SSM1<-data.frame(method=rr,
                               r=out$par[2],
                               ss=sum((Select.sample.filtered$OD-lgf(out$par[1],
                                                     out$par[2],
                                                     out$par[3],
                                                     out$par[4],
                                                     Select.sample.filtered$HOURS ))^2)
              )
            }else{
              SSM1<-SSM1 %>% bind_rows(
                data.frame(method=rr,
                           r=out$par[2],
                           ss=sum((Select.sample.filtered$OD-lgf(out$par[1],
                                                 out$par[2],
                                                 out$par[3],
                                                 out$par[4],
                                                 Select.sample.filtered$HOURS ))^2)
                )
              )
            }
          }
          
        }
        SSM11<-SSM1 %>% arrange(ss) %>% dplyr::filter(ss==min(ss)) %>%
          arrange(r) %>% dplyr::filter(r>0) %>% head(1)
        
        out<-optim(par=c(1,1,1,1),
                   control=list(maxit=20000),
                   hessian=TRUE,
                   data=Select.sample.filtered,
                   fn=f2,
                   method=SSM11$method,
                   lower=c(0.1,1.0,0,0),
                   upper=c(1.0,4.0,10,1.0))
        
        r.sd<-sqrt(diag(solve(out$hessian)))[2]
        
        lagM<-data.frame(HOURS=seq(min(Select.sample.filtered$HOURS),max(Select.sample.filtered$HOURS),length.out=1000),
                         OD=lgf(out$par[1],
                                out$par[2],
                                out$par[3],
                                out$par[4],
                                seq(min(Select.sample.filtered$HOURS),max(Select.sample.filtered$HOURS),length.out=1000) )) %>% 
          dplyr::filter(HOURS>Min.time) %>%
          mutate(lagM=ifelse(OD>=1.50*min(OD),TRUE,FALSE) ) %>% dplyr::filter(lagM) %>% head(1)
        
        Growth.diff<-(max(Select.sample.filtered$OD)-min(Select.sample.filtered$OD))
        Growth.max<-(out$par[1])
        as.data.frame(t(c(sample.id,
                          SSM11$method,
                          out$par[1],
                          out$par[2],
                          out$par[3],
                          out$par[4],
                          out$par[1]-out$par[4],
                          lagM$HOURS) ) ) %>% 
          write.table("Growth_features_estimates.tsv",sep="\t",row.names=FALSE,append=TRUE,col.names=FALSE)
        
        {
          if(iRep==1){
            x.in<-seq(min(Select.sample.filtered$HOURS),max(Select.sample.filtered$HOURS),length.out=100)
            lines(x.in,lgf(out$par[1],out$par[2],out$par[3],out$par[4],x.in ),
                  lwd=2.50,col=viridis::inferno(6)[iRep],xpd=TRUE)
            
            legend("bottom",legend=paste0(SPN.MM[SPN.MM$strain==sample.id,]$serotype,
                                          " (",ifelse(SPN.MM[SPN.MM$strain==sample.id,]$MLST=="Unknown",
                                                      "Unknown ST",paste0("ST",SPN.MM[SPN.MM$strain==sample.id,]$MLST)  ),")"),
                   bty="n",cex=1.0,text.col="#000000")
          }else{
            x.in<-seq(min(Select.sample.filtered$HOURS),max(Select.sample.filtered$HOURS),length.out=100)
            lines(x.in,lgf(out$par[1],out$par[2],out$par[3],out$par[4],x.in ),
                  lwd=2.50,col=viridis::inferno(6)[iRep],xpd=TRUE)
          }
          iRep<-iRep+1
        }
      }
      lc<-lc+1
    }
    if(length(dev.list())!=0){ dev.off() }
  }
}

