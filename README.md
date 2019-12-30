# Moving-file-with-R
本專案利用R批次整理系統檔案  

我們學校(NCHU)的線上課程系統：ilearning，有提供已繳交作業的「批次下載」功能。  
下載回來的檔案會放單一資料夾內的不同目錄下，如 圖1. 所示：  
  
        
  

![image](https://github.com/YTHsieh/Moving-file-with-R/blob/master/diagram.png)    
                   圖1. 本專案流程圖    
  
    


 



  
  
  
  
下載回來的檔案被分別放在兩層的結構之下，不便於助教與老師事後整理、查閱。  
這個專案利用R code將這些不同目錄下的檔案放到同一個「整理」資料夾下。  
使用前需將各同學的基本資料填入附件"member_format.csv"中的對應欄位，並另存成檔名"member.csv"。

**使用方法**：
