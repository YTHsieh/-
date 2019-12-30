###檔案搬家小幫手

##----------Set parameters---------------------------##
HWname = "作業二_XXXXXXXXXXXXXXXX"

datdir = "D:/工作區/檔案整理小工具_v1/hw_13540/"
datdir2 = "D:/工作區/檔案整理小工具_v1/" 
setwd(datdir); getwd()
member_list = read.csv(paste(datdir2, "member.csv", sep = ""))
#創立資料夾，儲存整理後的檔案
dir.create("整理")
##---------------------------------------------------##

file = list.files(pattern = NULL, all.files = FALSE,
                  full.names = FALSE, recursive =FALSE,
                  ignore.case = FALSE, include.dirs =FALSE, no.. = FALSE)
file = file[-length(file)]


for (i in 1:(length(file)-1)) {
  #Fine file path
  dat1 = paste(datdir, file[i], sep = "")
  target_path = paste(dat1, "/attach/", sep = "")
  
    #判斷是否有複數個檔案，若有，存為一vector。
  if (length(list.files(path = target_path))==1){
    #Get file path
    target_file = paste(target_path, list.files(path = target_path)[1], sep = "")
  
    #Get file name_end
    fileend = substr(target_file, regexpr("\\.", target_file)[1], nchar(target_file))
  
    #Remane the file
    newName = paste(file[i], member_list[which(member_list$帳號 == file[i]), 3], sep ="_")
    newName = paste(newName, HWname, sep = "_")
    newName = paste(target_path, newName, sep = "")
    newName = paste(newName, fileend, sep = "")
    file.rename(target_file, newName)
  
    #copy the file to new direction
    file.copy(newName, paste(datdir, "整理", sep =""), overwrite = TRUE, recursive = FALSE,
              copy.mode = TRUE, copy.date = TRUE)
    
  }else{
    innerlist = c()
    comp_df = data.frame()
    for (j in 1:length(list.files(path = target_path))) {
      target_file = paste(target_path, list.files(path = target_path)[j], sep = "")
      innerlist = c(innerlist, target_file)
      temp = file.info(path = innerlist[j])
      temp$fileend[1] = substr(innerlist[j], regexpr("\\.", innerlist[j])[1], nchar(innerlist[j]))
      comp_df = rbind(comp_df, temp)
    }
    #重新排序data.frame
    comp_df = comp_df[order(comp_df$mtime),]
    
    #Remane the file
    newnamelist = c()
    for (k in 1:length(comp_df$size)) {
      newName = paste(file[i], member_list[which(member_list$帳號 == file[i]), 3], sep ="_")
      newName = paste(newName, HWname, sep = "_")
      newName = paste(target_path, newName, sep = "")
      newName = paste(newName, k, sep = "_")
      newName = paste(newName, comp_df$fileend[k], sep = "")
      file.rename(row.names(comp_df)[k], newName)
      newnamelist = c(newnamelist, newName)
      }
    #copy files to new direction
    file.copy(newnamelist, paste(datdir, "整理", sep =""), overwrite = TRUE, recursive = FALSE,
              copy.mode = TRUE, copy.date = TRUE)
  }
  
  #print processing
  cat('now is handling',i,'-th file, (still',((length(file)-1)-i),'to go!!)', '\n')
}

#Check cp results
length(list.files(path = paste(datdir, "整理", sep =""), pattern = NULL, all.files = FALSE,
           full.names = FALSE, recursive =FALSE,
           ignore.case = FALSE, include.dirs =FALSE, no.. = FALSE))

