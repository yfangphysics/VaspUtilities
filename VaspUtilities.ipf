#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.
function vaspbands(path1,fname1,path2,fname2,fermilevel)
    string path1,fname1,path2,fname2
    variable fermilevel  //fermilevel
    variable a,i,t,j,k
    string str,fword,nkpts,nbnds
    Open/R a path1 + ":" + fname1
    for(i=0;i<5;i++)
	     FReadLine a, str
	 endfor
	 FReadLine a, str
	 i=0
	 t=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        t=t+1
	        if(t==2)
	            nkpts=fword
	        endif
	        if(t==3)
	            nbnds=fword
	        endif
	     endif 
	     i=i+1
	 while(t<3)
	 make/d/n=(str2num(nkpts),str2num(nbnds)) w
	 for(i=0;i<str2num(nkpts);i++)
	     FReadLine a, str
	     FReadLine a, str
	     for(j=0;j<str2num(nbnds);j++)
	         FReadLine a, str
	          k=0
	          t=0
	          do
	              fword=stringfromlist(k,str," ")
	              if (stringmatch(fword,"")!=1)
	                  t=t+1
	                  if(t==2)
	                      w[i][j]=str2num(fword)
	                  endif
	              endif 
	              k=k+1
	          while(t<2)
	     endfor
	 endfor
	 for(i=0;i<str2num(nbnds);i++)
	     make/d/n=(str2num(nkpts)) tmp
	     tmp=w[p][i]-fermilevel
	     duplicate tmp $"wave"+num2str(i)
	     killwaves tmp
	 endfor
	 killwaves w
	 close a
	 Open/R a path2 + ":" + fname2
	 make/d/n=3 kold,knew
	 make/d/n=(str2num(nkpts)) kpt
	 do
	     FReadLine a, str
	     if(strlen(str)==0)
	         break
	     endif
	     if(stringmatch(str,"*k-points in units of 2pi/SCALE*")==1)
	         FReadLine a, str
	         i=0
	         t=0
	         do
	             fword=stringfromlist(i,str," ")
	             if (stringmatch(fword,"")!=1)
	                 t=t+1
	                 if(t==1)
	                     kold[0]=str2num(fword)
	                 elseif(t==2)
	                     kold[1]=str2num(fword)
	                 elseif(t==3)
	                     kold[2]=str2num(fword)
	                 endif 
	             endif
	             i=i+1
	         while(t<3)
	         kpt[0]=0
	         for(i=1;i<str2num(nkpts);i++)
	             FReadLine a, str
	             k=0
	             t=0
	             do
	                 fword=stringfromlist(k,str," ")
	                 if (stringmatch(fword,"")!=1)
	                     t=t+1
	                     if(t==1)
	                         knew[0]=str2num(fword)
	                     elseif(t==2)
	                         knew[1]=str2num(fword)
	                     elseif(t==3)
	                         knew[2]=str2num(fword)
	                     endif
	                 endif 
	                 k=k+1
	             while(t<3)
	             if(mod(i,100)==0)
	                 kpt[i]=kpt[i-1]
	             else
	                 kpt[i]=kpt[i-1]+sqrt((knew[0]-kold[0])^2+(knew[1]-kold[1])^2+(knew[2]-kold[2])^2)
	             endif
	             kold=knew
	         endfor
	     endif
	 while(1)
	 killwaves kold,knew
	 close a
	 for(i=0;i<str2num(nbnds);i++)
	     if(i==0)
	         display $"wave"+num2str(i) vs kpt
	     else
	         appendtograph $"wave"+num2str(i) vs kpt
	     endif
	 endfor
end

function vaspbands_mbj(path1,fname1,path2,fname2,fermilevel)
    string path1,fname1,path2,fname2
    variable fermilevel  //fermilevel
    variable a,i,t,j,k
    variable cc=120
    string str,fword,nkpts,nbnds
    Open/R a path1 + ":" + fname1
    for(i=0;i<5;i++)
	     FReadLine a, str
	 endfor
	 FReadLine a, str
	 i=0
	 t=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        t=t+1
	        if(t==2)
	            nkpts=fword
	        endif
	        if(t==3)
	            nbnds=fword
	        endif
	     endif 
	     i=i+1
	 while(t<3)
	 make/d/n=(str2num(nkpts),str2num(nbnds)) w
	 for(i=0;i<str2num(nkpts);i++)
	     FReadLine a, str
	     FReadLine a, str
	     for(j=0;j<str2num(nbnds);j++)
	         FReadLine a, str
	          k=0
	          t=0
	          do
	              fword=stringfromlist(k,str," ")
	              if (stringmatch(fword,"")!=1)
	                  t=t+1
	                  if(t==2)
	                      w[i][j]=str2num(fword)
	                  endif
	              endif 
	              k=k+1
	          while(t<2)
	     endfor
	 endfor
	 for(i=0;i<str2num(nbnds);i++)
	     make/d/n=(str2num(nkpts)) tmp
	     tmp=w[p][i]-fermilevel
	     duplicate tmp $"wave"+num2str(i)
	     killwaves tmp
	 endfor
	 killwaves w
	 close a
	 Open/R a path2 + ":" + fname2
	 make/d/n=3 kold,knew
	 make/d/n=(str2num(nkpts)) kpt
	 do
	     FReadLine a, str
	     if(strlen(str)==0)
	         break
	     endif
	     if(stringmatch(str,"*k-points in units of 2pi/SCALE*")==1)
	         FReadLine a, str
	         i=0
	         t=0
	         do
	             fword=stringfromlist(i,str," ")
	             if (stringmatch(fword,"")!=1)
	                 t=t+1
	                 if(t==1)
	                     kold[0]=str2num(fword)
	                 elseif(t==2)
	                     kold[1]=str2num(fword)
	                 elseif(t==3)
	                     kold[2]=str2num(fword)
	                 endif 
	             endif
	             i=i+1
	         while(t<3)
	         kpt[0]=0
	         for(i=1;i<str2num(nkpts);i++)
	             FReadLine a, str
	             k=0
	             t=0
	             do
	                 fword=stringfromlist(k,str," ")
	                 if (stringmatch(fword,"")!=1)
	                     t=t+1
	                     if(t==1)
	                         knew[0]=str2num(fword)
	                     elseif(t==2)
	                         knew[1]=str2num(fword)
	                     elseif(t==3)
	                         knew[2]=str2num(fword)
	                     endif
	                 endif 
	                 k=k+1
	             while(t<3)
	             if(mod(i,100)==0)
	                 kpt[i]=kpt[i-1]
	             else
	                 kpt[i]=kpt[i-1]+sqrt((knew[0]-kold[0])^2+(knew[1]-kold[1])^2+(knew[2]-kold[2])^2)
	             endif
	             kold=knew
	         endfor
	     endif
	 while(1)
	 killwaves kold,knew
	 close a
	 for(i=0;i<str2num(nbnds);i++)
	     DeletePoints 0,cc, $"wave"+num2str(i)
	 endfor
	 DeletePoints 0,cc,kpt
	 for(i=0;i<str2num(nbnds);i++)
	     if(i==0)
	         display $"wave"+num2str(i) vs kpt
	     else
	         appendtograph $"wave"+num2str(i) vs kpt
	     endif
	 endfor
end


function splitdos(path1,fname1,path2,fname2) //fname1=DOSCAR,fname2=POSCAR
    string path1,fname1,path2,fname2
    variable a,b,i,t,j,k
    string str,fword,natms,nspin
    Open/R a path1 + ":" + fname1
	 FReadLine a, str
	 i=0
	 t=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        t=t+1
	        if(t==1)
	            natms=fword
	        endif
	        if(t==3)
	            nspin=fword
	        endif
	     endif 
	     i=i+1
	 while(t<3)
	 for(i=0;i<4;i++)
	     FReadLine a, str
	 endfor
	 printf "Number of atoms: %d\r  Number of spin: %d\r" str2num(natms),str2num(nspin)
	 Open/R b path2 + ":" + fname2
	 for(i=0;i<5;i++)
	     FReadLine b, str
	 endfor
	 FReadLine b, str
	 i=0
	 variable/g nspec=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        nspec=nspec+1
	     endif 
	     i=i+1
	 while(i<strlen(str))
	 make/t/n=(nspec)/o atmnam
	 i=0
	 t=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        t=t+1
	        if(t==nspec)
	            variable memory=strlen(fword)
	            string lastnm
	            sscanf fword[0,memory-1],"%s",lastnm
	            atmnam[t-1]=lastnm
	        else
	            atmnam[t-1]=cleanupname(fword,0)
	        endif	        
	     endif 
	     i=i+1
	 while(t<nspec)
	 make/d/n=(nspec)/o atmnum
	 FReadLine b, str
	 i=0
	 t=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        t=t+1
	        atmnum[t-1]=str2num(fword)
	     endif 
	     i=i+1
	 while(t<nspec)
	 close b
	 printf "Number of species: %d\r" nspec
	 variable temp=0
	 for(i=0;i<nspec;i++)
	     temp+=atmnum[i]
	 endfor
	 if(str2num(natms)!=temp)
	     printf "DOSCAR info & POSCAR does not match!\r"
	     close a
	     return -1
	 endif
    FReadLine a, str
    i=0
    t=0    
    do
        fword=stringfromlist(i,str," ",32)
        if (stringmatch(fword,"")!=1)
	        t=t+1
	        if(t==1)
	            variable/g nedos=str2num(fword)
	        endif
	        if(t==2)
	            variable/g efermi=str2num(fword)
	        endif
	     endif 
	     i=i+1
	 while(t<2)
	 for(i=0;i<nedos;i++)
	     FReadLine a, str
	     if(i==0)
	         j=0
	         variable tl=0
	         do
	             fword=stringfromlist(j,str," ")
	             if (stringmatch(fword,"")!=1)
	                  tl=tl+1
	             endif 
	             j=j+1
	         while(j<strlen(str))
	         make/o/n=(nedos,tl)/d pdos_tot
	     endif
	     j=0
	     t=0
	     do
	         fword=stringfromlist(j,str," ")
	         if (stringmatch(fword,"")!=1)
	              t=t+1
	              pdos_tot[i][t-1]=str2num(fword)
	         endif 
	         j=j+1
	     while(t<tl)
	 endfor  
	 for(i=0;i<nspec;i++)
	     for(j=0;j<atmnum[i];j++)
	         FReadLine a, str
	         for(k=0;k<nedos;k++)
	             FReadLine a, str
	             if(k==0)
	                 variable in=0
	                 tl=0
	                 do
	                     fword=stringfromlist(in,str," ")
	                     if (stringmatch(fword,"")!=1)
	                          tl=tl+1
	                     endif 
	                     in=in+1
	                 while(in<strlen(str))
	                 make/o/n=(nedos,tl)/d tempwave
	             endif
	             in=0
	             t=0
	             do
	                 fword=stringfromlist(in,str," ")
	                 if (stringmatch(fword,"")!=1)
	                     t=t+1
	                     tempwave[k][t-1]=str2num(fword)
	                 endif 
	                 in=in+1
	             while(t<tl)
	         endfor
	         duplicate/o tempwave, $"pdos_"+atmnam[i]+"_"+num2str(j+1)
	     endfor
	 endfor
	 killwaves tempwave
end

function splitdosif(path1,fname1,path2,fname2)
    string path1,fname1,path2,fname2
    variable a,b,i,t,j,k
    string str,fword,natms,nspin
    Open/R a path1 + ":" + fname1
	 FReadLine a, str
	 i=0
	 t=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        t=t+1
	        if(t==1)
	            natms=fword
	        endif
	        if(t==3)
	            nspin=fword
	        endif
	     endif 
	     i=i+1
	 while(t<3)
	 for(i=0;i<4;i++)
	     FReadLine a, str
	 endfor
	 printf "Number of atoms: %d\r  Number of spin: %d\r" str2num(natms),str2num(nspin)
	 Open/R b path2 + ":" + fname2
	 for(i=0;i<5;i++)
	     FReadLine b, str
	 endfor
	 FReadLine b, str
	 i=0
	 variable/g nspec=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        nspec=nspec+1
	     endif 
	     i=i+1
	 while(i<strlen(str))
	 make/t/n=(nspec)/o atmnam
	 i=0
	 t=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        t=t+1
	        if(t==nspec)
	            variable memory=strlen(fword)
	            string lastnm
	            sscanf fword[0,memory-1],"%s",lastnm
	            atmnam[t-1]=lastnm
	        else
	            atmnam[t-1]=cleanupname(fword,0)
	        endif	        
	     endif 
	     i=i+1
	 while(t<nspec)
	 make/d/n=(nspec)/o atmnum
	 FReadLine b, str
	 i=0
	 t=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        t=t+1
	        atmnum[t-1]=str2num(fword)
	     endif 
	     i=i+1
	 while(t<nspec)
	 close b
	 printf "Number of species: %d\r" nspec
	 variable temp=0
	 for(i=0;i<nspec;i++)
	     temp+=atmnum[i]
	 endfor
	 if(str2num(natms)!=temp)
	     printf "DOSCAR info & POSCAR does not match!\r"
	     close a
	     return -1
	 endif
    FReadLine a, str
    i=0
    t=0    
    do
        fword=stringfromlist(i,str," ",32)
        if (stringmatch(fword,"")!=1)
	        t=t+1
	        if(t==1)
	            variable/g nedos=str2num(fword)
	        endif
	        if(t==2)
	            variable/g efermi=str2num(fword)
	        endif
	     endif 
	     i=i+1
	 while(t<2)
	 for(i=0;i<nedos;i++)
	     FReadLine a, str
	     if(i==0)
	         j=0
	         variable tl=0
	         do
	             fword=stringfromlist(j,str," ")
	             if (stringmatch(fword,"")!=1)
	                  tl=tl+1
	             endif 
	             j=j+1
	         while(j<strlen(str))
	         make/o/n=(nedos,tl)/d pdos_tot
	     endif
	     j=0
	     t=0
	     do
	         fword=stringfromlist(j,str," ")
	         if (stringmatch(fword,"")!=1)
	              t=t+1
	              pdos_tot[i][t-1]=str2num(fword)
	         endif 
	         j=j+1
	     while(t<tl)
	 endfor  
	 for(i=0;i<nspec;i++)
	     for(j=0;j<atmnum[i];j++)
	         FReadLine a, str
	         for(k=0;k<(2*nedos);k++)
	             FReadLine a, str
	             if(k==0)
	                 variable in=0
	                 tl=0
	                 do
	                     fword=stringfromlist(in,str," ")
	                     if (stringmatch(fword,"")!=1)
	                          tl=tl+1
	                     endif 
	                     in=in+1
	                 while(in<strlen(str))
	                 make/o/n=(nedos,tl)/d tempwave
	             endif
	             if(k==1)
	                 in=0
	                 variable tll=0
	                 do
	                     fword=stringfromlist(in,str," ")
	                     if (stringmatch(fword,"")!=1)
	                          tll=tll+1
	                     endif 
	                     in=in+1
	                 while(in<strlen(str))
	                 redimension/n=(nedos,(tl+tll))/d tempwave
	             endif
	             in=0
	             t=0
	             if(mod(k,2)==0)
	                 do
	                     fword=stringfromlist(in,str," ")
	                     if (stringmatch(fword,"")!=1)
	                         t=t+1
	                         tempwave[(k/2)][t-1]=str2num(fword)
	                     endif 
	                     in=in+1
	                 while(t<tl)
	             else
	                 do
	                     fword=stringfromlist(in,str," ")
	                     if (stringmatch(fword,"")!=1)
	                         t=t+1
	                         tempwave[floor(k/2)][tl+t-1]=str2num(fword)
	                     endif 
	                     in=in+1
	                 while(t<tll)
	             endif
	         endfor
	         duplicate/o tempwave, $"pdos_"+atmnam[i]+"_"+num2str(j+1)
	     endfor
	 endfor
	 killwaves tempwave
end

function sumdos()
    variable i,j
    variable/g nspec,nedos	 
    wave atmnum
    wave/t atmnam
	 for(i=0;i<nspec;i++)
	     for(j=0;j<atmnum[i];j++)
	         if(j==0)
	             duplicate/o $"pdos_"+atmnam[i]+"_"+num2str(j+1),tempwave
	             duplicate/o/r=[][0] $"pdos_"+atmnam[i]+"_"+num2str(j+1),energywave
	         else
	             duplicate/o $"pdos_"+atmnam[i]+"_"+num2str(j+1),tempwave2
	             tempwave+=tempwave2
	             killwaves tempwave2
	         endif
	     endfor
	     variable k
	     for(k=0;k<nedos;k++)
	         tempwave[k][0]=energywave[k]
	     endfor
	     duplicate/o tempwave $"pdos_"+atmnam[i]+"_tot"
	 endfor
	 killwaves tempwave,energywave
end

function plotdosif()
variable i
variable/g nspec
wave/t atmnam
for(i=0;i<nspec;i++)
    variable j
    for(j=0;j<65;j++)
        if(j==1)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" $"pdos_"+atmnam[i]+"_tot_s"
        endif
        if(j==5) 
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_p
        endif
        if(j==9)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_p_t
            temp_p+=temp_p_t
        endif
        if(j==13)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_p_t
            temp_p+=temp_p_t
            duplicate/o temp_p,$"pdos_"+atmnam[i]+"_tot_p"
            killwaves temp_p_t,temp_p
        endif
        if(j==17) 
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_d
        endif
        if(j==21)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_d_t
            temp_d+=temp_d_t
        endif
        if(j==25)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_d_t
            temp_d+=temp_d_t
        endif
        if(j==29)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_d_t
            temp_d+=temp_d_t
        endif
        if(j==33)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_d_t
            temp_d+=temp_d_t
            duplicate/o temp_d,$"pdos_"+atmnam[i]+"_tot_d"
            killwaves temp_d_t,temp_d
        endif
        if(j==37) 
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_f
        endif
        if(j==41)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_f_t
            temp_f+=temp_f_t
        endif
        if(j==45)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_f_t
            temp_f+=temp_f_t
        endif
        if(j==49)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_f_t
            temp_f+=temp_f_t
        endif
        if(j==53)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_f_t
            temp_f+=temp_f_t
        endif
        if(j==57)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_f_t
            temp_f+=temp_f_t
        endif
        if(j==61)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_f_t
            temp_f+=temp_f_t
            duplicate/o temp_f,$"pdos_"+atmnam[i]+"_tot_f"
            killwaves temp_f_t,temp_f
        endif
    endfor
endfor
for(i=0;i<nspec;i++)
    if(i==0)
        display $"pdos_"+atmnam[i]+"_tot_s" vs $"pdos_"+atmnam[i]+"_tot"[][0]
    else
        appendtograph $"pdos_"+atmnam[i]+"_tot_s" vs $"pdos_"+atmnam[i]+"_tot"[][0]
    endif
    appendtograph $"pdos_"+atmnam[i]+"_tot_p" vs $"pdos_"+atmnam[i]+"_tot"[][0]
    appendtograph $"pdos_"+atmnam[i]+"_tot_d" vs $"pdos_"+atmnam[i]+"_tot"[][0]
    appendtograph $"pdos_"+atmnam[i]+"_tot_f" vs $"pdos_"+atmnam[i]+"_tot"[][0]
endfor
end

function plotdoslf()
variable i
variable/g nspec
wave/t atmnam
for(i=0;i<nspec;i++)
    variable j
    for(j=0;j<65;j++)
        if(j==1)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" $"pdos_"+atmnam[i]+"_tot_s"
        endif
        if(j==5) 
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_p
        endif
        if(j==9)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_p_t
            temp_p+=temp_p_t
        endif
        if(j==13)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_p_t
            temp_p+=temp_p_t
            duplicate/o temp_p,$"pdos_"+atmnam[i]+"_tot_p"
            killwaves temp_p_t,temp_p
        endif
        if(j==17) 
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_d
        endif
        if(j==21)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_d_t
            temp_d+=temp_d_t
        endif
        if(j==25)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_d_t
            temp_d+=temp_d_t
        endif
        if(j==29)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_d_t
            temp_d+=temp_d_t
        endif
        if(j==33)
            duplicate/o/r=[][j] $"pdos_"+atmnam[i]+"_tot" temp_d_t
            temp_d+=temp_d_t
            duplicate/o temp_d,$"pdos_"+atmnam[i]+"_tot_d"
            killwaves temp_d_t,temp_d
        endif
    endfor
endfor
for(i=0;i<nspec;i++)
    if(i==0)
        display $"pdos_"+atmnam[i]+"_tot_s" vs $"pdos_"+atmnam[i]+"_tot"[][0]
    else
        appendtograph $"pdos_"+atmnam[i]+"_tot_s" vs $"pdos_"+atmnam[i]+"_tot"[][0]
    endif
    appendtograph $"pdos_"+atmnam[i]+"_tot_p" vs $"pdos_"+atmnam[i]+"_tot"[][0]
    appendtograph $"pdos_"+atmnam[i]+"_tot_d" vs $"pdos_"+atmnam[i]+"_tot"[][0]
endfor
end

function Findbands(numbnds,efermi)
variable numbnds,efermi
variable i
make/o/n=(numbnds) mini,maxm
for(i=0;i<numbnds;i++)
loadwave/a/o/d/g/L={0,21+1030302*i,1030301,0,0} "C:\Users\Lenovo\Desktop\wannier90.bxsf"
endfor
for(i=0;i<numbnds;i++)
wavestats $"wave"+num2str(i)
mini[i]=V_min
maxm[i]=V_max
killwaves $"wave"+num2str(i)
endfor
for(i=0;i<numbnds;i++)
    if((efermi>mini[i])&&(efermi<maxm[i]))
        print i+1
    endif
endfor
end


function extract_fs(path1,fname1,path2,fname2,nstart,nend) //fname1 read;fname2 write
    string path1,fname1,path2,fname2
    variable nstart,nend
    variable a,b,i,t,j,k
    string str,temp,fword
    variable nx,ny,nz
    Open/R a path1 + ":" + fname1
    Open b path2 + ":" + fname2
    for(i=0;i<14;i++)
	     FReadLine a, str
	     temp=str[0,strlen(str)-2]
	     fprintf b,temp
	     fprintf b,"\n"
	 endfor
	 
	 FReadLine a, str
	 i=0
	 t=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        t=t+1
	        if(t==1)
	            temp=fword[0,strlen(fword)-2]
	        endif
	     endif 
	     i=i+1
	 while(t<1)
	 
	 if((nend<nstart)||(str2num(temp)<nend))
	     fprintf b,"Wrong indices,exit...\n"
	     close a
	     close b
	     return -1
	 endif
	 
	 fprintf b,"%15d\n",nend-nstart+1
	 
	 FReadLine a, str
	 temp=str[0,strlen(str)-2]
	 fprintf b,temp
	 fprintf b,"\n"
	 i=0
	 t=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        t=t+1
	        if(t==1)
	            temp=fword[0,strlen(fword)-1]
	            nx=str2num(temp)
	        endif
	        if(t==2)
	            temp=fword[0,strlen(fword)-1]
	            ny=str2num(temp)
	        endif
	        if(t==3)
	            temp=fword[0,strlen(fword)-2]
	            nz=str2num(temp)
	        endif
	     endif 
	     i=i+1
	 while(t<3)
	 
	 for(i=0;i<4;i++)
	     FReadLine a, str
	     temp=str[0,strlen(str)-2]
	     fprintf b,temp
	     fprintf b,"\n"
	 endfor
	 
	 for(i=1;i<nstart;i++)
	     for(j=0;j<(nx*ny*nz+1);j++)
	         FReadLine a, str
	     endfor
	 endfor
	 
	 for(i=0;i<(nend-nstart+1);i++)
	     FReadLine a, str
	     fprintf b,"BAND:%12d\n",i+1
	     for(j=0;j<(nx*ny*nz);j++)
	         FReadLine a, str
	         temp=str[0,strlen(str)-2]
	         fprintf b,temp
	         fprintf b,"\n"
	     endfor
	 endfor
	 
    fprintf b," END_BANDGRID_3D\n"
    fprintf b,"  END_BLOCK_BANDGRID_3D\n"
    
    close a
    close b
end


function vaspbands_proj(path1,fname1,atoms,orbitals) //read procar non-soc
    wave atoms
    wave orbitals
    string path1,fname1
    variable a,i,t,j,k,u
    variable s
    variable inner,np,ccc
    string str,fword,nkpts,nbnds,nions
    Open/R a path1 + ":" + fname1
	 FReadLine a, str
	 FReadLine a, str
	 i=0
	 t=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        t=t+1
	        if(t==4)
	            nkpts=fword
	        endif
	        if(t==8)
	            nbnds=fword
	        endif
	        if(t==12)
	            nions=fword
	        endif
	     endif 
	     i=i+1
	 while(t<12)
	 make/o/d/n=(str2num(nkpts),str2num(nbnds)) tem
	 for(u=0;u<str2num(nkpts);u++)
	     for(i=0;i<3;i++)
	         FReadLine a, str
	     endfor
	     for(k=0;k<str2num(nbnds);k++)
	         for(i=0;i<3;i++)
	             FReadLine a, str
	         endfor
	         s=0
	         
	         for(np=0;np<numpnts(atoms);np++)
	           if(np==0)
	             if(atoms[0]==1)
	                 FReadLine a, str
	                 j=0
	                 t=0
	                 do
	                     fword=stringfromlist(j,str," ")
	                     if (stringmatch(fword,"")!=1)
	                        t=t+1
	                        for(ccc=0;ccc<numpnts(orbitals);ccc++)
	                          if(t==orbitals[ccc])
	                            s+=str2num(fword)
	                          endif
	                        endfor
	                     endif
	                     j=j+1
	                 while(t<orbitals[numpnts(orbitals)-1])
	             endif
	             if(atoms[0]>1) 
	                 for(inner=0;inner<(atoms[0]-1);inner++)
	                     FReadLine a, str
	                 endfor   
	                 FReadLine a, str
	                 j=0
	                 t=0
	                 do
	                     fword=stringfromlist(j,str," ")
	                     if (stringmatch(fword,"")!=1)
	                        t=t+1
	                        for(ccc=0;ccc<numpnts(orbitals);ccc++)
	                          if(t==orbitals[ccc])
	                            s+=str2num(fword)
	                          endif
	                        endfor
	                     endif
	                     j=j+1
	                 while(t<orbitals[numpnts(orbitals)-1])
	             endif
	           else
	             if((atoms[np]-atoms[np-1])==1)
	                 FReadLine a, str
	                 j=0
	                 t=0
	                 do
	                     fword=stringfromlist(j,str," ")
	                     if (stringmatch(fword,"")!=1)
	                        t=t+1
	                        for(ccc=0;ccc<numpnts(orbitals);ccc++)
	                          if(t==orbitals[ccc])
	                            s+=str2num(fword)
	                          endif
	                        endfor
	                     endif
	                     j=j+1
	                 while(t<orbitals[numpnts(orbitals)-1])
	             endif
	             if((atoms[np]-atoms[np-1])>1)
	                 for(inner=0;inner<(atoms[np]-atoms[np-1]-1);inner++)
	                     FReadLine a, str
	                 endfor   
	                 FReadLine a, str
	                 j=0
	                 t=0
	                 do
	                     fword=stringfromlist(j,str," ")
	                     if (stringmatch(fword,"")!=1)
	                        t=t+1
	                        for(ccc=0;ccc<numpnts(orbitals);ccc++)
	                          if(t==orbitals[ccc])
	                            s+=str2num(fword)
	                          endif
	                        endfor
	                     endif
	                     j=j+1
	                 while(t<orbitals[numpnts(orbitals)-1])
	             endif
	           endif
	         endfor
            
            if(str2num(nions)==atoms[numpnts(atoms)-1])
	             FReadLine a, str
	             FReadLine a, str
	         else
	             for(i=0;i<(str2num(nions)-atoms[numpnts(atoms)-1]);i++)
	                 FReadLine a, str
	             endfor
	             FReadLine a, str
	             FReadLine a, str
	         endif
	         
	         
	              tem[u][k]=s
	         
	     endfor
	 endfor
	 for(i=0;i<str2num(nbnds);i++)
	     duplicate/o/r=[0,str2num(nkpts)-1][i,i] tem $"weight"+num2str(i)
	 endfor
	 close a
end


function vaspbands_projsoc(path1,fname1,atoms,orbitals) //read procar soc
    wave atoms
    wave orbitals
    string path1,fname1
    variable a,i,t,j,k,u
    variable s
    variable inner,np,ccc
    string str,fword,nkpts,nbnds,nions
    Open/R a path1 + ":" + fname1
	 FReadLine a, str
	 FReadLine a, str
	 i=0
	 t=0
	 do
	     fword=stringfromlist(i,str," ")
	     if (stringmatch(fword,"")!=1)
	        t=t+1
	        if(t==4)
	            nkpts=fword
	        endif
	        if(t==8)
	            nbnds=fword
	        endif
	        if(t==12)
	            nions=fword
	        endif
	     endif 
	     i=i+1
	 while(t<12)
	 make/o/d/n=(str2num(nkpts),str2num(nbnds)) tem
	 for(u=0;u<str2num(nkpts);u++)
	     for(i=0;i<3;i++)
	         FReadLine a, str
	     endfor
	     for(k=0;k<str2num(nbnds);k++)
	         for(i=0;i<3;i++)
	             FReadLine a, str
	         endfor
	         s=0
	         
	         for(np=0;np<numpnts(atoms);np++)
	           if(np==0)
	             if(atoms[0]==1)
	                 FReadLine a, str
	                 j=0
	                 t=0
	                 do
	                     fword=stringfromlist(j,str," ")
	                     if (stringmatch(fword,"")!=1)
	                        t=t+1
	                        for(ccc=0;ccc<numpnts(orbitals);ccc++)
	                          if(t==orbitals[ccc])
	                            s+=str2num(fword)
	                          endif
	                        endfor
	                     endif
	                     j=j+1
	                 while(t<orbitals[numpnts(orbitals)-1])
	             endif
	             if(atoms[0]>1) 
	                 for(inner=0;inner<(atoms[0]-1);inner++)
	                     FReadLine a, str
	                 endfor   
	                 FReadLine a, str
	                 j=0
	                 t=0
	                 do
	                     fword=stringfromlist(j,str," ")
	                     if (stringmatch(fword,"")!=1)
	                        t=t+1
	                        for(ccc=0;ccc<numpnts(orbitals);ccc++)
	                          if(t==orbitals[ccc])
	                            s+=str2num(fword)
	                          endif
	                        endfor
	                     endif
	                     j=j+1
	                 while(t<orbitals[numpnts(orbitals)-1])
	             endif
	           else
	             if((atoms[np]-atoms[np-1])==1)
	                 FReadLine a, str
	                 j=0
	                 t=0
	                 do
	                     fword=stringfromlist(j,str," ")
	                     if (stringmatch(fword,"")!=1)
	                        t=t+1
	                        for(ccc=0;ccc<numpnts(orbitals);ccc++)
	                          if(t==orbitals[ccc])
	                            s+=str2num(fword)
	                          endif
	                        endfor
	                     endif
	                     j=j+1
	                 while(t<orbitals[numpnts(orbitals)-1])
	             endif
	             if((atoms[np]-atoms[np-1])>1)
	                 for(inner=0;inner<(atoms[np]-atoms[np-1]-1);inner++)
	                     FReadLine a, str
	                 endfor   
	                 FReadLine a, str
	                 j=0
	                 t=0
	                 do
	                     fword=stringfromlist(j,str," ")
	                     if (stringmatch(fword,"")!=1)
	                        t=t+1
	                        for(ccc=0;ccc<numpnts(orbitals);ccc++)
	                          if(t==orbitals[ccc])
	                            s+=str2num(fword)
	                          endif
	                        endfor
	                     endif
	                     j=j+1
	                 while(t<orbitals[numpnts(orbitals)-1])
	             endif
	           endif
	         endfor
            
            variable jjj
            for(jjj=0;jjj<(3*(str2num(nions)+1+1));jjj++)
               FReadLine a, str
            endfor
            
            if(str2num(nions)==atoms[numpnts(atoms)-1])
	             FReadLine a, str
	             FReadLine a, str
	             FReadLine a, str
	         else
	             for(i=0;i<(str2num(nions)-atoms[numpnts(atoms)-1]);i++)
	                 FReadLine a, str
	             endfor
	             FReadLine a, str
	             FReadLine a, str
	             FReadLine a, str
	         endif
	         
	        
	              tem[u][k]=s
	         
	     endfor
	 endfor
	 for(i=0;i<str2num(nbnds);i++)
	     duplicate/o/r=[0,str2num(nkpts)-1][i,i] tem $"weight"+num2str(i)
	 endfor
	 close a
end

function projbulkbnds(m,n,p) //projected bulk bands plot.m:the number of points between two kpoints;
                             //n:number of different kzs;p:numberof bands.
    variable m,n,p
    variable i,j,k
    wave kpt
    make/n=(2*m) refer
    for(i=0;i<(2*m);i++)
        refer[i]=kpt[i]
    endfor
    make/n=(2*m) tem1
    for(i=0;i<p;i++)
        duplicate $"wave"+num2str(i),tem2 
        for(j=i;j<i+p*(n-1)+1;j=j+p)
            for(k=0;k<(2*m);k++)
                tem1[k]=tem2[k]
            endfor
            duplicate tem1,$"w"+num2str(j)
            if(j==0)
                display $"w"+num2str(j) vs refer
            else
                appendtograph $"w"+num2str(j) vs refer
            endif
            DeletePoints 0,3*m, tem2
       endfor
       killwaves tem2
    endfor
    killwaves tem1
end

function difkzplot(nbnds,nkz,ymin,ymax,j)
variable nbnds
variable nkz
variable ymin,ymax //display range
variable j  //j can take value 0-20,corresponding to kz=j/(nkz-1)*(gamma-z)        
variable kz=j/(nkz-1)
wave xwave
variable i
for(i=0;i<nbnds;i++)
     if(i==0)
        display $"w"+num2str(j*nbnds) vs xwave
        TextBox/C/N=text0/F=0/A=MC num2str(kz)+"*G-Z"
        SetAxis left ymin,ymax
     else 
        appendtograph $"w"+num2str(j*nbnds+i) vs xwave
     endif
endfor
end

function fcc111()  //for writing fcc 111 KPOINTS
variable a,b,c
a=    5.429
make/o/d/n=3 a1={0,a/2,a/2}
make/o/d/n=3 a2={a/2,0,a/2}
make/o/d/n=3 a3={a/2,a/2,0}
cross a2,a3
variable vprim
wave W_Cross
vprim=matrixDot(a1,W_Cross)
make/o/d/n=3 b1,b2,b3
b1=2*pi*W_Cross/vprim
cross a3,a1
b2=2*pi*W_Cross/vprim
cross a1,a2
b3=2*pi*W_Cross/vprim
Concatenate/O {b1,b2,b3},primbasis	

make/o/d/n=3 aa1={-a/2,a/2,0}
make/o/d/n=3 aa2={0,-a/2,a/2}
make/o/d/n=3 aa3={a,a,a}
cross aa2,aa3
variable vconv
vconv=matrixDot(aa1,W_Cross)
make/o/d/n=3 bb1,bb2,bb3
bb1=2*pi*W_Cross/vconv
cross aa3,aa1
bb2=2*pi*W_Cross/vconv

bb3=1/2*(b1+b2+b3)
Concatenate/O {bb1,bb2,bb3},convbasis

matrixinverse primbasis
wave M_inverse
matrixop/o matC=M_inverse x convbasis

print vprim
print vprim/vconv
cross b2,b3
variable kvprim
kvprim=matrixDot(b1,W_Cross)
cross bb2,bb3
variable kvconv
kvconv=matrixDot(bb1,W_Cross)
print kvprim/kvconv
end

function simplecubic111()  //for writing simple cubic 111 KPOINTS
variable a,b,c
a=    2.3537117117709037*2
make/o/d/n=3 a1={a,0,0}
make/o/d/n=3 a2={0,a,0}
make/o/d/n=3 a3={0,0,a}
cross a2,a3
variable vprim
wave W_Cross
vprim=matrixDot(a1,W_Cross)
make/o/d/n=3 b1,b2,b3
b1=2*pi*W_Cross/vprim
cross a3,a1
b2=2*pi*W_Cross/vprim
cross a1,a2
b3=2*pi*W_Cross/vprim
Concatenate/O {b1,b2,b3},primbasis	

make/o/d/n=3 aa1={a,-a,0}
make/o/d/n=3 aa2={0,a,-a}
make/o/d/n=3 aa3={a,a,a}
cross aa2,aa3
variable vconv
vconv=matrixDot(aa1,W_Cross)
make/o/d/n=3 bb1,bb2,bb3
bb1=2*pi*W_Cross/vconv
cross aa3,aa1
bb2=2*pi*W_Cross/vconv

bb3=1/2*(b1+b2+b3)
Concatenate/O {bb1,bb2,bb3},convbasis

matrixinverse primbasis
wave M_inverse
matrixop/o matC=M_inverse x convbasis

print vprim/vconv
cross b2,b3
variable kvprim
kvprim=matrixDot(b1,W_Cross)
cross bb2,bb3
variable kvconv
kvconv=matrixDot(bb1,W_Cross)
print kvprim/kvconv
end

function hr111()  //for writing hr 111 KPOINTS
variable a,c
a=    3.6281/sqrt(3)
c=26.233/3
make/o/d/n=3 a1={-a/2,sqrt(3)/2*a,c}
make/o/d/n=3 a2={-a/2,-sqrt(3)/2*a,c}
make/o/d/n=3 a3={a,0,c}
cross a2,a3
variable vprim
wave W_Cross
vprim=matrixDot(a1,W_Cross)
make/o/d/n=3 b1,b2,b3
b1=2*pi*W_Cross/vprim
cross a3,a1
b2=2*pi*W_Cross/vprim
cross a1,a2
b3=2*pi*W_Cross/vprim
Concatenate/O {b1,b2,b3},primbasis	

make/o/d/n=3 aa1=a2-a3
make/o/d/n=3 aa2=a3-a1
make/o/d/n=3 aa3=a1+a2+a3
cross aa2,aa3
variable vconv
wave W_cross
vconv=matrixDot(aa1,W_Cross)
make/o/d/n=3 bb1,bb2,bb3
bb1=2*pi*W_Cross/vconv
cross aa3,aa1
bb2=2*pi*W_Cross/vconv

bb3=1/2*(b1+b2+b3)
Concatenate/O {bb1,bb2,bb3},convbasis

matrixinverse primbasis
wave M_inverse
matrixop/o matC=M_inverse x convbasis

print vprim
print vprim/vconv
cross b2,b3
variable kvprim
kvprim=matrixDot(b1,W_Cross)
cross bb2,bb3
variable kvconv
kvconv=matrixDot(bb1,W_Cross)
print kvprim/kvconv
end


function changecoord() //for KPOINTS coordinate transformation
variable x,y,z
variable m,n,l
wave matC
variable i
variable k=0
for(i=0;i<21;i++)
  x=1/2;y=0;z=i/20 // M bar point
  m=matC[0][0]*x+matC[0][1]*y+matC[0][2]*z
  n=matC[1][0]*x+matC[1][1]*y+matC[1][2]*z
  l=matC[2][0]*x+matC[2][1]*y+matC[2][2]*z
  if(i==0)
    printf "%.12f %.12f %.12f\r" m, n, l
  else
    printf "%.12f %.12f %.12f\r" m, n, l
    printf "%.12f %.12f %.12f\r" m, n, l
  endif
  x=0;y=0;z=i/20 //gamma bar point
  m=matC[0][0]*x+matC[0][1]*y+matC[0][2]*z
  n=matC[1][0]*x+matC[1][1]*y+matC[1][2]*z
  l=matC[2][0]*x+matC[2][1]*y+matC[2][2]*z
  printf "%.12f %.12f %.12f\r" m, n, l
  printf "%.12f %.12f %.12f\r" m, n, l
  x=1/3;y=1/3;z=i/20 //K bar point
  m=matC[0][0]*x+matC[0][1]*y+matC[0][2]*z
  n=matC[1][0]*x+matC[1][1]*y+matC[1][2]*z
  l=matC[2][0]*x+matC[2][1]*y+matC[2][2]*z
  if(i==20)
    printf "%.12f %.12f %.12f\r" m, n, l
  else
    printf "%.12f %.12f %.12f\r" m, n, l
    printf "%.12f %.12f %.12f\r" m, n, l
  endif
endfor
end

function fcc111slab(nlayer,a) //for writing fcc 111 slab POSCAR
    variable nlayer,a
    make/o/d matA={{-1/2,1/2,0},{0,-1/2,1/2},{1,1,1}}
    matrixinverse matA
    wave M_inverse
    make/o/d matB={{0,1/2,1/2},{1/2,0,1/2},{1/2,1/2,0}}
    matrixop/o matC=M_inverse x matB
    make/o/d/n=(3,3) Cefilm
    variable x,y,z,m,n,l,i
        for(i=0;i<3;i++)
            x=0;y=0;z=i
            m=matC[0][0]*x+matC[0][1]*y+matC[0][2]*z
            n=matC[1][0]*x+matC[1][1]*y+matC[1][2]*z
            l=matC[2][0]*x+matC[2][1]*y+matC[2][2]*z 
            do
                if(m<0)
                    m=m+1
                elseif((m>1)||(m==1))
                    m=m-1
                endif
            while((m<0)||(m>1)||(m==1))
            do
                if(n<0)
                    n=n+1
                elseif((n>1)||(n==1))
                    n=n-1
                endif
            while((n<0)||(n>1)||(n==1))
            do
                if(l<0)
                    l=l+1
                elseif((l>1)||(l==1))
                    l=l-1
                endif
            while((l<0)||(l>1)||(l==1))
            Cefilm[i][0]=m ;Cefilm[i][1]=n ;Cefilm[i][2]=l
        endfor
        bubble(Cefilm,3)
    redimension/n=(nlayer,3) Cefilm
    for(i=3;i<nlayer;i++)
        Cefilm[i][0]=Cefilm[i-3][0]
        Cefilm[i][1]=Cefilm[i-3][1]
        Cefilm[i][2]=Cefilm[i-3][2]+1
    endfor
    for(i=0;i<nlayer;i++)
    	 printf "%.12f %.12f %.12f\r",Cefilm[i][0],Cefilm[i][1], (Cefilm[i][2]*a*sqrt(3)/((Cefilm[nlayer-1][2]-Cefilm[0][2])*a*sqrt(3)+18))
    endfor
    print "\r"
    printf "%.12f\r" (Cefilm[nlayer-1][2]-Cefilm[0][2])*a*sqrt(3)+18
end

function bubble(w,n)
    wave w
    variable n
    variable i,j,k,t1,t2,t3
    for(i=1;i<n;i++)
        k=0
        for(j=0;j<(n-i);j++)
            if(w[j][2]>w[j+1][2])
                t1=w[j][0];w[j][0]=w[j+1][0];w[j+1][0]=t1
                t2=w[j][1];w[j][1]=w[j+1][1];w[j+1][1]=t2
                t3=w[j][2];w[j][2]=w[j+1][2];w[j+1][2]=t3
            else
                k++
            endif
        endfor
        if(k==(n-i))
            break
        endif
    endfor
end      
        
function xcoordi()
wave b1,b2
make/o/d/n=200 xwave
variable i
for(i=0;i<100;i++)
    xwave[i]=1/2*sqrt(b1[0]^2+b1[1]^2+b1[2]^2)/99*(i-99)
endfor
for(i=100;i<200;i++)
    xwave[i]=1/3*sqrt((b1[0]+b2[0])^2+(b1[1]+b2[1])^2+(b1[2]+b2[2])^2)/99*(i-100)
endfor
end
